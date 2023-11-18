import os
import config
import random, secrets
import copy
import string
from MT4V import simulation
from MetamorphicRelation import project

class SHA3(project.Project):
    def __init__(self) -> None:
        self.name = "sha3"
        self.mutant_num = 101
        self.proj_dir = os.path.join(config.MUTANT_DIR, "sha3")
        self.source_files = [
            "low_throughput_core/rtl/keccak.v",
            "low_throughput_core/rtl/f_permutation.v",
            "low_throughput_core/rtl/padder.v",
            "low_throughput_core/rtl/padder1.v",
            "low_throughput_core/rtl/rconst.v",
            "low_throughput_core/rtl/round.v"]
        self.include_dirs = []
        self.testbench_template = os.path.join(config.TESTBENCH_TEMPLATE_DIR, "sha3_tb.v")
        self.clock_cycle = 20
        self.output_file = "output.txt"

        self.source_tests = [
            {"time":0, "in_str": "The quick brown fox jumps over the lazy dog"},
            {"time":20, "in_str": "The quick brown fox jumps over the lazy dog."},
            {"time":40, "in_str": "Hello, world!"},
            {"time":60, "in_str": "Hello, world"},
            {"time":80, "in_str": "Hello World"},
            {"time":100, "in_str": "This is a test message."},
            {"time":120, "in_str": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
            {"time":140, "in_str": "1234567890"},
            {"time":160, "in_str": "password123"},
            {"time":180, "in_str": "The quick brown fox jumps over the lazy dog."},
            {"time":200, "in_str": "Testing 1, 2, 3."},
            {"time":220, "in_str": "Today is a sunny day."},
            {"time":240, "in_str": "I love coding and programming."},
            {"time":260, "in_str": "The quick brown fox."},
        ]

        self.metamorphic_relations = {
            "plaintext_change": (self.plaintext_change_input, self.plaintext_change_output),
            "timing_checking": (self.timing_checking_input, self.timing_checking_output)
            }
    
    def get_record_indicator(self, tests):
        record_timestamps_1 = []
        for test in tests:
            tmp_record_timestamps_1 = []
            for i in range(len(test["in_str"])//4):
                # todo
                tmp_record_timestamps_1.append(test["time"] + self.clock_cycle * (i+1) * 4)
            record_timestamps_1.append(tmp_record_timestamps_1)
        return [[1], record_timestamps_1]   # out_ready, internal encrytion text record timestamps

    def generate_testbench(self, testbench_str, tests):
        time_stamp = 0
        test_inputs = ""
        for test in tests:
            test_inputs += "#{};\n".format(test["time"]-time_stamp)
            time_stamp = test["time"]
            test_inputs += "reset = 1; #(`P); reset = 0;\n"
            test_inputs += "in_ready = 1; is_last = 0;\n"
            for key,value in test.items():
                if key != "in_str": continue
                for start_index in range(0, len(value), 4):
                    end_index = start_index + 4
                    if end_index > len(value):
                        end_index = len(value)
                        tmp_in = value[start_index:end_index].ljust(4)
                        test_inputs += 'in = "{}"; byte_num = {}; is_last = 1; #(`P);\n'.format(tmp_in, end_index - start_index)
                    elif end_index == len(value):
                        tmp_in = value[start_index:end_index]
                        test_inputs += 'in = "{}"; #(`P);\n'.format(tmp_in)
                        test_inputs += 'in = 0; byte_num = 0; is_last = 1; #(`P);\n'
                    else:
                        tmp_in = value[start_index:end_index]
                        test_inputs += 'in = "{}"; #(`P);\n'.format(tmp_in)
            test_inputs += "in_ready = 0; is_last = 0;\n"
            test_inputs += "while (out_ready !== 1)\n    #(`P);\n"
        input_index = testbench_str.index("// input test data\n") + len("// input test data\n")
        testbench_str = testbench_str[:input_index] + test_inputs + testbench_str[input_index:]
        return testbench_str

    # MR-1
    def plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_sha3_input():
                nonlocal followup_input
                letters = string.ascii_letters + string.digits + string.punctuation.replace('"', '').replace("'", "").replace("\\", "")
                random_string = ''.join(random.choice(letters) for _ in range(random.randint(1,70)))
                followup_input["in_str"] = random_string
            
            random_sha3_input()
            while inputs[i]["in_str"] == followup_input["in_str"]:
                random_sha3_input()
        return followup_inputs
    
    def plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "out_ready", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "out_ready", followup_record_indicator[0])
        failure_cases = []

        if "out" not in target_source_output or "out" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["out"]) != len(target_followup_output["out"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["out"]), len(target_followup_output["out"]))+1, len(self.source_tests)+1)])
        for i, (sha3Out_source_output, sha3Out_followup_output) in enumerate(zip(target_source_output["out"], target_followup_output["out"])):
            if sha3Out_source_output == sha3Out_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-6
    def timing_checking_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_time_input():
                nonlocal followup_input
                if random.random() < 0.5:
                    followup_input["time"] -= self.clock_cycle * random.randint(0,9)
                else:
                    followup_input["time"] += self.clock_cycle * random.randint(0,9)
            
            random_time_input()
            if i == 0:
                while followup_input["time"] < 2:
                    random_time_input()
            else:
                while followup_input["time"] < followup_inputs[i-1]["time"]:
                    random_time_input()
        return followup_inputs

    def timing_checking_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "out_ready", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "out_ready", followup_record_indicator[0])
        failure_cases = []

        if "out" not in target_source_output or "out" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["out"]) != len(target_followup_output["out"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["out"]), len(target_followup_output["out"]))+1, len(self.source_tests)+1)])
        for i, (sha3Out_source_output, sha3Out_followup_output) in enumerate(zip(target_source_output["out"], target_followup_output["out"])):
            if sha3Out_source_output != sha3Out_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases