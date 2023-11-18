import os
import config
import random, secrets
import copy
from MT4V import simulation
from MetamorphicRelation import project

class AES(project.Project):
    def __init__(self) -> None:
        self.name = "aes"
        self.mutant_num = 101
        self.proj_dir = os.path.join(config.MUTANT_DIR, "aes")
        self.source_files = [
            "rtl/verilog/aes_sbox.v",
            "rtl/verilog/aes_rcon.v",
            "rtl/verilog/aes_key_expand_128.v",
            "rtl/verilog/aes_cipher_top.v",
            "rtl/verilog/aes_inv_sbox.v",
            "rtl/verilog/aes_inv_cipher_top.v"]
        self.include_dirs = ["rtl/verilog/"]
        self.testbench_template = os.path.join(config.TESTBENCH_TEMPLATE_DIR, "aes_tb.v")
        self.clock_cycle = 10
        self.output_file = "output.txt"

        self.source_tests = [
            {"time":10, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'hf34481ec3cc627bacd5dc3fb08f273e6"},
            {"time":20, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'h9798c4640bad75c7c3227db910174e72"},
            {"time":30, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'h96ab5c2ff612d9dfaae8c31f30c42168"},
            {"time":40, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'h6a118a874519e64e9963798a503f1d35"},
            {"time":50, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'hcb9fceec81286ca3e989bd979b0cb284"},
            {"time":60, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'hb26aeb1874e47ca8358ff22378f09144"},
            {"time":70, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'h58c8e00b2631686d54eab84b91f0aca1"},
            {"time":80, "key1": "128'h10a58869d74be5a374cf867cfb473859", "key2": "128'h10a58869d74be5a374cf867cfb473859", "text_in": "128'h00000000000000000000000000000000"},
            {"time":90, "key1": "128'hcaea65cdbb75e9169ecd22ebe6e54675", "key2": "128'hcaea65cdbb75e9169ecd22ebe6e54675", "text_in": "128'h00000000000000000000000000000000"},
            {"time":100, "key1": "128'ha2e2fa9baf7d20822ca9f0542f764a41", "key2": "128'ha2e2fa9baf7d20822ca9f0542f764a41", "text_in": "128'h00000000000000000000000000000000"},
            {"time":110, "key1": "128'hb6364ac4e1de1e285eaf144a2415f7a0", "key2": "128'hb6364ac4e1de1e285eaf144a2415f7a0", "text_in": "128'h00000000000000000000000000000000"},
            {"time":120, "key1": "128'h64cf9c7abc50b888af65f49d521944b2", "key2": "128'h64cf9c7abc50b888af65f49d521944b2", "text_in": "128'h00000000000000000000000000000000"},
            {"time":130, "key1": "128'h47d6742eefcc0465dc96355e851b64d9", "key2": "128'h47d6742eefcc0465dc96355e851b64d9", "text_in": "128'h00000000000000000000000000000000"},
            {"time":140, "key1": "128'h3eb39790678c56bee34bbcdeccf6cdb5", "key2": "128'h3eb39790678c56bee34bbcdeccf6cdb5", "text_in": "128'h00000000000000000000000000000000"},
            {"time":150, "key1": "128'h64110a924f0743d500ccadae72c13427", "key2": "128'h64110a924f0743d500ccadae72c13427", "text_in": "128'h00000000000000000000000000000000"},
            {"time":160, "key1": "128'h18d8126516f8a12ab1a36d9f04d68e51", "key2": "128'h18d8126516f8a12ab1a36d9f04d68e51", "text_in": "128'h00000000000000000000000000000000"},
            {"time":170, "key1": "128'hfff00000000000000000000000000000", "key2": "128'hfff00000000000000000000000000000", "text_in": "128'h00000000000000000000000000000000"},
            {"time":180, "key1": "128'h00000000000000000000000000000000", "key2": "128'h00000000000000000000000000000000", "text_in": "128'hfffffffffffffffc0000000000000000"},
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
        return [[1], [1]]   # done, done2
    
    def generate_testbench(self, testbench_str, tests):
        time_stamp = 0
        test_inputs = ""
        for test in tests:
            test_inputs += "#{};\n".format(test["time"]-time_stamp)
            time_stamp = test["time"]
            test_inputs += "@(posedge clk);\n#1;\nkld 	= 1;\n"
            for key,value in test.items():
                if key == "time": continue
                test_inputs += "{}={};\n".format(key,value)
            test_inputs += "@(posedge clk);\n#1;\nkld 	= 0;\n"
            test_inputs += "while(!done)	@(posedge clk);\n"
            test_inputs += "while(!done2)	@(posedge clk);\n"
            test_inputs += "@(posedge clk);\n#1;\n"
        input_index = testbench_str.index("// input test data\n") + len("// input test data\n")
        testbench_str = testbench_str[:input_index] + test_inputs + testbench_str[input_index:]
        return testbench_str

    # MR-1
    def plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_aes_input():
                nonlocal followup_input
                random_number = secrets.randbits(128)
                aes_input = "128'h" + format(random_number, "016X")
                followup_input["text_in"] = aes_input
            
            random_aes_input()
            while inputs[i]["text_in"] == followup_input["text_in"]:
                random_aes_input()
        return followup_inputs
    
    def plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "done", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "done", followup_record_indicator[0])
        failure_cases = []

        if "text_out" not in target_source_output or "text_out" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["text_out"]) != len(target_followup_output["text_out"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["text_out"]), len(target_followup_output["text_out"]))+1, len(self.source_tests)+1)])
        for i, (aesOut_source_output, aesOut_followup_output) in enumerate(zip(target_source_output["text_out"], target_followup_output["text_out"])):
            if aesOut_source_output == aesOut_followup_output:
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
                random_number = secrets.randbits(128)
                key_input = "128'h" + format(random_number, "016X")
                followup_input["key1"] = key_input
                followup_input["key2"] = key_input
            
            random_key_input()
            while inputs[i]["key1"] == followup_input["key1"]:
                random_key_input()
        return followup_inputs
    
    def encryption_key_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "done", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "done", followup_record_indicator[0])
        failure_cases = []

        if "text_out" not in target_source_output or "text_out" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["text_out"]) != len(target_followup_output["text_out"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["text_out"]), len(target_followup_output["text_out"]))+1, len(self.source_tests)+1)])
        for i, (aesOut_source_output, aesOut_followup_output) in enumerate(zip(target_source_output["text_out"], target_followup_output["text_out"])):
            if aesOut_source_output == aesOut_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-3
    def encrypt_decrypt_checking_plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_aes_input():
                nonlocal followup_input
                random_number = secrets.randbits(128)
                aes_input = "128'h" + format(random_number, "016X")
                followup_input["text_in"] = aes_input
            
            random_aes_input()
            while inputs[i]["text_in"] == followup_input["text_in"]:
                random_aes_input()
        return followup_inputs
    
    def encrypt_decrypt_checking_plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "done2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "done2", followup_record_indicator[1])
        failure_cases = []

        if "text_out2" not in target_source_output or "text_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["text_out2"]) != len(target_followup_output["text_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["text_out2"]), len(target_followup_output["text_out2"]))+1, len(self.source_tests)+1)])
        for i, (aesOut2_source_output, aesOut2_followup_output) in enumerate(zip(target_source_output["text_out2"], target_followup_output["text_out2"])):
            if aesOut2_source_output == aesOut2_followup_output:
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
                random_number = secrets.randbits(128)
                key_input = "128'h" + format(random_number, "016X")
                followup_input["key2"] = key_input
            
            random_key_input()
            while followup_input["key2"] == followup_input["key1"]:
                random_key_input()
        return followup_inputs
    
    def encrypt_decrypt_checking_decryption_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "done2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "done2", followup_record_indicator[1])
        failure_cases = []

        if "text_out2" not in target_source_output or "text_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["text_out2"]) != len(target_followup_output["text_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["text_out2"]), len(target_followup_output["text_out2"]))+1, len(self.source_tests)+1)])
        for i, (aesOut2_source_output, aesOut2_followup_output) in enumerate(zip(target_source_output["text_out2"], target_followup_output["text_out2"])):
            if aesOut2_source_output == aesOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-5
    def substring_checking_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def subbit_aes_input():
                nonlocal followup_input
                aes_input = followup_input["text_in"][5:]
                start_index = random.choice(range(0, len(aes_input), 2))
                end_index = random.choice(range(start_index+2, len(aes_input)+2, 2))
                sub_aes_input = "00" * (start_index // 2) + aes_input[start_index:end_index] + "00" * ((len(aes_input) - end_index) // 2)
                followup_input["text_in"] = "128'h" + sub_aes_input
            
            subbit_aes_input()
            while inputs[i]["text_in"] == followup_input["text_in"] and inputs[i]["text_in"] != "128'h00000000000000000000000000000000":
                subbit_aes_input()
        return followup_inputs
    
    def substring_checking_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "done2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "done2", followup_record_indicator[1])
        failure_cases = []

        if "text_out2" not in target_source_output or "text_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["text_out2"]) != len(target_followup_output["text_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["text_out2"]), len(target_followup_output["text_out2"]))+1, len(self.source_tests)+1)])
        for i, (aesOut2_source_output, aesOut2_followup_output) in enumerate(zip(target_source_output["text_out2"], target_followup_output["text_out2"])):
            if aesOut2_source_output == "128'h00000000000000000000000000000000":
                if aesOut2_source_output != aesOut2_followup_output:
                    failure_cases.append(i+1)
            else:
                sub_followup_output = aesOut2_followup_output
                while sub_followup_output.startswith("00"):
                    sub_followup_output = sub_followup_output[2:]
                while sub_followup_output.endswith("00"):
                    sub_followup_output = sub_followup_output[:-2]
                if not (sub_followup_output in aesOut2_source_output):
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
        target_source_output = simulation.process_output(source_output_file, "done2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "done2", followup_record_indicator[1])
        failure_cases = []

        if "text_out2" not in target_source_output or "text_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["text_out2"]) != len(target_followup_output["text_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["text_out2"]), len(target_followup_output["text_out2"]))+1, len(self.source_tests)+1)])
        for i, (aesOut2_source_output, aesOut2_followup_output) in enumerate(zip(target_source_output["text_out2"], target_followup_output["text_out2"])):
            if aesOut2_source_output != aesOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases