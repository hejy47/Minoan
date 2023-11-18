import os
import config
import random, secrets
import copy
from MT4V import simulation
from MetamorphicRelation import project

class DES(project.Project):
    def __init__(self) -> None:
        self.name = "des"
        self.mutant_num = 101
        self.proj_dir = os.path.join(config.MUTANT_DIR, "des")
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
            "rtl/verilog/perf_opt/key_sel.v"]
        self.include_dirs = []
        self.testbench_template = os.path.join(config.TESTBENCH_TEMPLATE_DIR, "des_po_tb.v")
        self.clock_cycle = 4
        self.output_file = "output.txt"

        self.source_tests = [
            {"time":2, "key1": "64'h10316E028C8F3B4A", "key2": "64'h10316E028C8F3B4A", "des_in": "64'h0000000000000000", "decrypt": "0"},
            {"time":6, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h95F8A5E5DD31D900", "decrypt": "0"},
            {"time":10, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hDD7F121CA5015619", "decrypt": "0"},
            {"time":14, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h2E8653104F3834EA", "decrypt": "0"},
            {"time":18, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h4BD388FF6CD81D4F", "decrypt": "0"},
            {"time":22, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h20B9E767B2FB1456", "decrypt": "0"},
            {"time":26, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h55579380D77138EF", "decrypt": "0"},
            {"time":30, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h6CC5DEFAAF04512F", "decrypt": "0"},
            {"time":34, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h0D9F279BA5D87260", "decrypt": "0"},
            {"time":38, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hD9031B0271BD5A0A", "decrypt": "0"},
            {"time":42, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'h424250B37C3DD951", "decrypt": "0"},
            {"time":46, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hB8061B7ECD9A21E5", "decrypt": "0"},
            {"time":50, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hF15D0F286B65BD28", "decrypt": "0"},
            {"time":54, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hADD0CC8D6E5DEBA1", "decrypt": "0"},
            {"time":58, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hE6D5F82752AD63D1", "decrypt": "0"},
            {"time":62, "key1": "64'h0101010101010101", "key2": "64'h0101010101010101", "des_in": "64'hECBFE3BD3F591A5E", "decrypt": "0"},
            {"time":66, "key1": "64'h7CA110454A1A6E57", "key2": "64'h7CA110454A1A6E57", "des_in": "64'h01A1D6D039776742", "decrypt": "0"},
            {"time":70, "key1": "64'h0131D9619DC1376E", "key2": "64'h0131D9619DC1376E", "des_in": "64'h5CD54CA83DEF57DA", "decrypt": "0"},
            {"time":74, "key1": "64'h07A1133E4A0B2686", "key2": "64'h07A1133E4A0B2686", "des_in": "64'h0248D43806F67172", "decrypt": "0"},
            {"time":78, "key1": "64'h3849674C2602319E", "key2": "64'h3849674C2602319E", "des_in": "64'h51454B582DDF440A", "decrypt": "0"},
            {"time":82, "key1": "64'h04B915BA43FEB5B6", "key2": "64'h04B915BA43FEB5B6", "des_in": "64'h42FD443059577FA2", "decrypt": "0"},
            {"time":86, "key1": "64'h0113B970FD34F2CE", "key2": "64'h0113B970FD34F2CE", "des_in": "64'h059B5E0851CF143A", "decrypt": "0"},
            {"time":90, "key1": "64'h0170F175468FB5E6", "key2": "64'h0170F175468FB5E6", "des_in": "64'h0756D8E0774761D2", "decrypt": "0"},
            {"time":94, "key1": "64'h43297FAD38E373FE", "key2": "64'h43297FAD38E373FE", "des_in": "64'h762514B829BF486A", "decrypt": "0"},
            {"time":98, "key1": "64'h07A7137045DA2A16", "key2": "64'h07A7137045DA2A16", "des_in": "64'h3BDD119049372802", "decrypt": "0"},
            {"time":102, "key1": "64'h04689104C2FD3B2F", "key2": "64'h04689104C2FD3B2F", "des_in": "64'h26955F6835AF609A", "decrypt": "0"},
            {"time":106, "key1": "64'h37D06BB516CB7546", "key2": "64'h37D06BB516CB7546", "des_in": "64'h164D5E404F275232", "decrypt": "0"},
            {"time":110, "key1": "64'h1F08260D1AC2465E", "key2": "64'h1F08260D1AC2465E", "des_in": "64'h6B056E18759F5CCA", "decrypt": "0"},
            {"time":114, "key1": "64'h584023641ABA6176", "key2": "64'h584023641ABA6176", "des_in": "64'h004BD6EF09176062", "decrypt": "0"},
            {"time":118, "key1": "64'h025816164629B007", "key2": "64'h025816164629B007", "des_in": "64'h480D39006EE762F2", "decrypt": "0"},
            {"time":122, "key1": "64'h49793EBC79B3258F", "key2": "64'h49793EBC79B3258F", "des_in": "64'h437540C8698F3CFA", "decrypt": "0"},
            {"time":126, "key1": "64'h4FB05E1515AB73A7", "key2": "64'h4FB05E1515AB73A7", "des_in": "64'h072D43A077075292", "decrypt": "0"},
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
            record_timestamps_0.append(test["time"] + self.clock_cycle * (17) + self.clock_cycle)
            record_timestamps_1.append(test["time"] + self.clock_cycle * (17*2) + self.clock_cycle)
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
                followup_input["key1"] = key_input
                followup_input["key2"] = key_input
            
            random_key_input()
            while inputs[i]["key1"] == followup_input["key1"]:
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
                followup_input["key2"] = key_input
            
            random_key_input()
            while followup_input["key2"] == followup_input["key1"]:
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