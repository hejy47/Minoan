import os
import config
import random, secrets
import copy
from MT4V import simulation
from MetamorphicRelation import project

class DES3(project.Project):
    def __init__(self) -> None:
        self.name = "des3"
        self.mutant_num = 101
        self.proj_dir = os.path.join(config.MUTANT_DIR, "des3")
        self.source_files = [
            "rtl/verilog/common/crp.v",
            "rtl/verilog/common/sbox1.v",
            "rtl/verilog/common/sbox2.v",
            "rtl/verilog/common/sbox3.v",
            "rtl/verilog/common/sbox4.v",
            "rtl/verilog/common/sbox5.v",
            "rtl/verilog/common/sbox6.v",
            "rtl/verilog/common/sbox7.v",
            "rtl/verilog/common/sbox8.v",
            "rtl/verilog/perf_opt/des.v",
            "rtl/verilog/perf_opt/des3.v",
            "rtl/verilog/perf_opt/key_sel.v"]
        self.include_dirs = []
        self.testbench_template = os.path.join(config.TESTBENCH_TEMPLATE_DIR, "des3_po_tb.v")
        self.clock_cycle = 4
        self.output_file = "output.txt"

        self.source_tests = [
            {"time":2, "key1_e": "64'h0101010101010101", "key2_e": "64'h0101010101010101", "key3_e": "64'h0101010101010101", "key1_d": "64'h0101010101010101", "key2_d": "64'h0101010101010101", "key3_d": "64'h0101010101010101", "des_in": "64'h95F8A5E5DD31D900", "decrypt": "0"},
            {"time":6, "key1_e": "64'h0101010101010101", "key2_e": "64'h0101010101010101", "key3_e": "64'h0101010101010101", "key1_d": "64'h0101010101010101", "key2_d": "64'h0101010101010101", "key3_d": "64'h0101010101010101", "des_in": "64'h9D64555A9A10B852", "decrypt": "0"},
            {"time":10, "key1_e": "64'h3849674C2602319E", "key2_e": "64'h3849674C2602319E", "key3_e": "64'h3849674C2602319E", "key1_d": "64'h3849674C2602319E", "key2_d": "64'h3849674C2602319E", "key3_d": "64'h3849674C2602319E", "des_in": "64'h51454B582DDF440A", "decrypt": "0"},
            {"time":14, "key1_e": "64'h04B915BA43FEB5B6", "key2_e": "64'h04B915BA43FEB5B6", "key3_e": "64'h04B915BA43FEB5B6", "key1_d": "64'h04B915BA43FEB5B6", "key2_d": "64'h04B915BA43FEB5B6", "key3_d": "64'h04B915BA43FEB5B6", "des_in": "64'h42FD443059577FA2", "decrypt": "0"},
            {"time":18, "key1_e": "64'h0123456789ABCDEF", "key2_e": "64'h0123456789ABCDEF", "key3_e": "64'h0123456789ABCDEF", "key1_d": "64'h0123456789ABCDEF", "key2_d": "64'h0123456789ABCDEF", "key3_d": "64'h0123456789ABCDEF", "des_in": "64'h736F6D6564617461", "decrypt": "0"},
            {"time":22, "key1_e": "64'h0123456789ABCDEF", "key2_e": "64'h5555555555555555", "key3_e": "64'h0123456789ABCDEF", "key1_d": "64'h0123456789ABCDEF", "key2_d": "64'h5555555555555555", "key3_d": "64'h0123456789ABCDEF", "des_in": "64'h736F6D6564617461", "decrypt": "0"},
            {"time":26, "key1_e": "64'h0123456789ABCDEF", "key2_e": "64'h5555555555555555", "key3_e": "64'hFEDCBA9876543210", "key1_d": "64'h0123456789ABCDEF", "key2_d": "64'h5555555555555555", "key3_d": "64'hFEDCBA9876543210", "des_in": "64'h736F6D6564617461", "decrypt": "0"},
            {"time":30, "key1_e": "64'h0352020767208217", "key2_e": "64'h8602876659082198", "key3_e": "64'h64056ABDFEA93457", "key1_d": "64'h0352020767208217", "key2_d": "64'h8602876659082198", "key3_d": "64'h64056ABDFEA93457", "des_in": "64'h7371756967676C65", "decrypt": "0"},
            {"time":34, "key1_e": "64'h0101010101010101", "key2_e": "64'h8001010101010101", "key3_e": "64'h0101010101010102", "key1_d": "64'h0101010101010101", "key2_d": "64'h8001010101010101", "key3_d": "64'h0101010101010102", "des_in": "64'h0000000000000000", "decrypt": "0"},
            {"time":38, "key1_e": "64'h1046103489988020", "key2_e": "64'h9107D01589190101", "key3_e": "64'h19079210981A0101", "key1_d": "64'h1046103489988020", "key2_d": "64'h9107D01589190101", "key3_d": "64'h19079210981A0101", "des_in": "64'h0000000000000000", "decrypt": "0"},
        ]

        self.metamorphic_relations = {
            "plaintext_change": (self.plaintext_change_input, self.plaintext_change_output),
            "encryption_key_change": (self.encryption_key_change_input, self.encryption_key_change_output),
            "encrypt_decrypt_checking_plaintext_change": (self.encrypt_decrypt_checking_plaintext_change_input, self.encrypt_decrypt_checking_plaintext_change_output),
            "encrypt_decrypt_checking_decryption_change": (self.encrypt_decrypt_checking_decryption_change_input, self.encrypt_decrypt_checking_decryption_change_output),
            "substring_checking": (self.substring_checking_input, self.substring_checking_output),
            "timing_checking": (self.timing_checking_input, self.timing_checking_output)
            }
    
    def get_record_indicator(self, tests):
        record_timestamps_0 = []
        record_timestamps_1 = []
        for test in tests:
            record_timestamps_0.append(test["time"] + self.clock_cycle * (51) + self.clock_cycle)
            record_timestamps_1.append(test["time"] + self.clock_cycle * (51*2) + self.clock_cycle)
        return [record_timestamps_0, record_timestamps_1]
    
    def generate_testbench(self, testbench_str, tests):
        time_stamp = 0
        test_inputs = ""
        for test in tests:
            test_inputs += "#{};\n".format(test["time"]-time_stamp)
            time_stamp = test["time"]
            for key,value in test.items():
                if key == "time": continue
                test_inputs += "{}={};\n".format(key,value)
        input_index = testbench_str.index("// input test data\n") + len("// input test data\n")
        testbench_str = testbench_str[:input_index] + test_inputs + testbench_str[input_index:]
        return testbench_str

    # MR-1
    def plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_des_input():
                nonlocal followup_input
                random_number = secrets.randbits(64)
                des_input = "64'h" + format(random_number, "016X")
                followup_input["des_in"] = des_input
            
            random_des_input()
            while inputs[i]["des_in"] == followup_input["des_in"]:
                random_des_input()
        return followup_inputs
    
    def plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "time", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "time", followup_record_indicator[0])
        failure_cases = []

        if "desOut" not in target_source_output or "desOut" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["desOut"]) != len(target_followup_output["desOut"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["desOut"]), len(target_followup_output["desOut"]))+1, len(self.source_tests)+1)])
        for i, (desOut_source_output, desOut_followup_output) in enumerate(zip(target_source_output["desOut"], target_followup_output["desOut"])):
            if desOut_source_output == desOut_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-2
    def encryption_key_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_key_input():
                nonlocal followup_input
                random_number = secrets.randbits(64)
                key_input = "64'h" + format(random_number, "016X")
                followup_input["key1_e"] = key_input
                followup_input["key1_d"] = key_input
            
            random_key_input()
            while inputs[i]["key1_e"] == followup_input["key1_e"]:
                random_key_input()
        return followup_inputs
    
    def encryption_key_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "time", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "time", followup_record_indicator[0])
        failure_cases = []

        if "desOut" not in target_source_output or "desOut" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["desOut"]) != len(target_followup_output["desOut"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["desOut"]), len(target_followup_output["desOut"]))+1, len(self.source_tests)+1)])
        for i, (desOut_source_output, desOut_followup_output) in enumerate(zip(target_source_output["desOut"], target_followup_output["desOut"])):
            if desOut_source_output == desOut_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-3
    def encrypt_decrypt_checking_plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_des_input():
                nonlocal followup_input
                random_number = secrets.randbits(64)
                des_input = "64'h" + format(random_number, "016X")
                followup_input["des_in"] = des_input
            
            random_des_input()
            while inputs[i]["des_in"] == followup_input["des_in"]:
                random_des_input()
        return followup_inputs
    
    def encrypt_decrypt_checking_plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "time", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "time", followup_record_indicator[1])
        failure_cases = []

        if "desOut2" not in target_source_output or "desOut2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["desOut2"]) != len(target_followup_output["desOut2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["desOut2"]), len(target_followup_output["desOut2"]))+1, len(self.source_tests)+1)])
        for i, (desOut2_source_output, desOut2_followup_output) in enumerate(zip(target_source_output["desOut2"], target_followup_output["desOut2"])):
            if desOut2_source_output == desOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-4
    def encrypt_decrypt_checking_decryption_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_key_input():
                nonlocal followup_input
                random_number = secrets.randbits(64)
                key_input = "64'h" + format(random_number, "016X")
                followup_input["key1_d"] = key_input
            
            random_key_input()
            while followup_input["key1_d"] == followup_input["key1_e"]:
                random_key_input()
        return followup_inputs
    
    def encrypt_decrypt_checking_decryption_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "time", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "time", followup_record_indicator[1])
        failure_cases = []

        if "desOut2" not in target_source_output or "desOut2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["desOut2"]) != len(target_followup_output["desOut2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["desOut2"]), len(target_followup_output["desOut2"]))+1, len(self.source_tests)+1)])
        for i, (desOut2_source_output, desOut2_followup_output) in enumerate(zip(target_source_output["desOut2"], target_followup_output["desOut2"])):
            if desOut2_source_output == desOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-5
    def substring_checking_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def subbit_des_input():
                nonlocal followup_input
                des_input = followup_input["des_in"][4:]
                start_index = random.choice(range(0, len(des_input), 2))
                end_index = random.choice(range(start_index+2, len(des_input)+2, 2))
                sub_des_input = "00" * (start_index // 2) + des_input[start_index:end_index] + "00" * ((len(des_input) - end_index) // 2)
                followup_input["des_in"] = "64'h" + sub_des_input
            
            subbit_des_input()
            while inputs[i]["des_in"] == followup_input["des_in"] and inputs[i]["des_in"] != "64'h0000000000000000":
                subbit_des_input()
        return followup_inputs
    
    def substring_checking_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "time", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "time", followup_record_indicator[1])
        failure_cases = []

        if "desOut2" not in target_source_output or "desOut2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["desOut2"]) != len(target_followup_output["desOut2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["desOut2"]), len(target_followup_output["desOut2"]))+1, len(self.source_tests)+1)])
        for i, (desOut2_source_output, desOut2_followup_output) in enumerate(zip(target_source_output["desOut2"], target_followup_output["desOut2"])):
            if desOut2_source_output == "64'h0000000000000000":
                if desOut2_source_output != desOut2_followup_output:
                    failure_cases.append(i+1)
            else:
                sub_followup_output = desOut2_followup_output
                while sub_followup_output.startswith("00"):
                    sub_followup_output = sub_followup_output[2:]
                while sub_followup_output.endswith("00"):
                    sub_followup_output = sub_followup_output[:-2]
                if not (sub_followup_output in desOut2_source_output):
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
                while followup_input["time"] <= followup_inputs[i-1]["time"]:
                    random_time_input()
        return followup_inputs

    def timing_checking_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "time", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "time", followup_record_indicator[1])
        failure_cases = []

        if "desOut2" not in target_source_output or "desOut2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["desOut2"]) != len(target_followup_output["desOut2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["desOut2"]), len(target_followup_output["desOut2"]))+1, len(self.source_tests)+1)])
        for i, (desOut2_source_output, desOut2_followup_output) in enumerate(zip(target_source_output["desOut2"], target_followup_output["desOut2"])):
            if desOut2_source_output != desOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases