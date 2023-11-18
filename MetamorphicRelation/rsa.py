import os
import config
import random, secrets
import copy
from MT4V import simulation
from MetamorphicRelation import project

class RSA(project.Project):
    def __init__(self) -> None:
        self.name = "rsa"
        self.mutant_num = 101
        self.proj_dir = os.path.join(config.MUTANT_DIR, "rsa")
        self.source_files = [
            "RSA.srcs/sources_1/new/control.v",
            "RSA.srcs/sources_1/new/dff.v",
            "RSA.srcs/sources_1/new/divider.v",
            "RSA.srcs/sources_1/new/inverter.v",
            "RSA.srcs/sources_1/new/mod_exp.v",
            "RSA.srcs/sources_1/new/mod.v",
            "RSA.srcs/sources_1/new/mux.v"]
        self.include_dirs = []
        self.testbench_template = os.path.join(config.TESTBENCH_TEMPLATE_DIR, "rsa_tb.v")
        self.clock_cycle = 10
        self.output_file = "output.txt"

        self.source_tests = [
            {"time":10, "p1": "128'd113680897410347", "q1": "128'd7999808077935876437321", "p2": "128'd113680897410347", "q2": "128'd7999808077935876437321", "encrypt_decrypt": "0", "msg_in": "256'h00262d806a3e18f03ab37b2857e7e149"},
            {"time":20, "p1": "128'd7999808077935876437321", "q1": "128'd113680897410347", "p2": "128'd7999808077935876437321", "q2": "128'd113680897410347", "encrypt_decrypt": "0", "msg_in": "256'h00262d806a3e18f03ab37b2857e7e149"},
            {"time":30, "p1": "128'd8475698667747010771", "q1": "128'd11297384090418420749", "p2": "128'd8475698667747010771", "q2": "128'd11297384090418420749", "encrypt_decrypt": "0", "msg_in": "256'h08e2a11b5e2b4d0e3f7795ebe2596d9d"},
            {"time":40, "p1": "128'd8786194473250302299", "q1": "128'd1974551434103086991", "p2": "128'd8786194473250302299", "q2": "128'd1974551434103086991", "encrypt_decrypt": "0", "msg_in": "256'h0000b3ca6ffcf8a314c5e21a9c2dc611"},
            {"time":50, "p1": "128'd9005980475000482739", "q1": "128'd2627021771666544701", "p2": "128'd9005980475000482739", "q2": "128'd2627021771666544701", "encrypt_decrypt": "0", "msg_in": "256'h09d7c61830b9d7db4f384cdd1607481a"},
            {"time":60, "p1": "128'd7298496856312456933", "q1": "128'd9319994081162235169", "p2": "128'd7298496856312456933", "q2": "128'd9319994081162235169", "encrypt_decrypt": "0", "msg_in": "256'h0f6c1e0a32716c128c62c5f1f6ab3c00"},
        ]

        self.primes = [6058812904605765019, 1625661933897756947, 8053249406176721611, 723002822394932533, 8236267094071028197,
                       3352128258314992487, 1762947551549938687, 149772151147396549, 5199021763688633929, 5236458650167879367,
                       5901573392758652471, 5081119196561416721, 1630704555822188069, 2566010139466782013, 4501895371870227259,
                       8397385621705949177, 8348170468167298049, 5039863843767638777, 6074671901189753933, 7052916985954704521,
                       4168477127725284707, 5547677036345998583, 2596866756792670493, 2327008541046941639, 8410097243616129877,
                       3947980351778683117, 7717918989579486361, 5530397342098975271, 5726527775103176599, 2500197781325741561,
                       2886384458741334197, 6955334281986206537, 8217786248652052763, 1630533472316219747, 402559895086399273,
                       9013936569470562827, 3724365086753200909, 4062964908930584621, 6435446840325261287, 7224681115034497063]

        self.metamorphic_relations = {
            "plaintext_change": (self.plaintext_change_input, self.plaintext_change_output),
            "encryption_key_change": (self.encryption_key_change_input, self.encryption_key_change_output),
            "encrypt_decrypt_checking_plaintext_change": (self.encrypt_decrypt_checking_plaintext_change_input, self.encrypt_decrypt_checking_plaintext_change_output),
            "encrypt_decrypt_checking_decryption_change": (self.encrypt_decrypt_checking_decryption_change_input, self.encrypt_decrypt_checking_decryption_change_output),
            "substring_checking": (self.substring_checking_input, self.substring_checking_output),
            "timing_checking": (self.timing_checking_input, self.timing_checking_output)
            }
    
    def get_record_indicator(self, tests):
        return [[1], [1]]   # mod_exp_finish, mod_exp_finish2
    
    def generate_testbench(self, testbench_str, tests):
        time_stamp = 0
        test_inputs = ""
        for test in tests:
            test_inputs += "#{};\n".format(test["time"]-time_stamp)
            time_stamp = test["time"]
            for key in ["p1", "q1", "encrypt_decrypt", "msg_in"]:
                test_inputs += "{}={};\n".format(key,test[key])
            test_inputs += "#10 reset_inverter1=1;\n"
            test_inputs += "#10 reset_inverter1=0;\n"
            test_inputs += "while (!inverter_finish)    @(posedge clk);\n"
            test_inputs += "reset_mod_exp1=1;\n"
            test_inputs += "#10 reset_mod_exp1=0;\n"
            test_inputs += "while (!mod_exp_finish)    @(posedge clk);\n"

            for key in ["p2", "q2"]:
                test_inputs += "{}={};\n".format(key,test[key])
            test_inputs += "#10 reset_inverter2=1;\n"
            test_inputs += "#10 reset_inverter2=0;\n"
            test_inputs += "while (!inverter_finish2)    @(posedge clk);\n"
            test_inputs += "reset_mod_exp2=1;\n"
            test_inputs += "#10 reset_mod_exp2=0;\n"
            test_inputs += "while (!mod_exp_finish2)    @(posedge clk);\n"
        input_index = testbench_str.index("// input test data\n") + len("// input test data\n")
        testbench_str = testbench_str[:input_index] + test_inputs + testbench_str[input_index:]
        return testbench_str

    # MR-1
    def plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_rsa_input():
                nonlocal followup_input
                random_number = secrets.randbits(127)
                rsa_input = "256'h" + format(random_number, "016X")
                followup_input["msg_in"] = rsa_input
            
            random_rsa_input()
            while inputs[i]["msg_in"] == followup_input["msg_in"]:
                random_rsa_input()
        return followup_inputs
    
    def plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "mod_exp_finish", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "mod_exp_finish", followup_record_indicator[0])
        failure_cases = []

        if "msg_out" not in target_source_output or "msg_out" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["msg_out"]) != len(target_followup_output["msg_out"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["msg_out"]), len(target_followup_output["msg_out"]))+1, len(self.source_tests)+1)])
        for i, (rsaOut_source_output, rsaOut_followup_output) in enumerate(zip(target_source_output["msg_out"], target_followup_output["msg_out"])):
            if rsaOut_source_output == rsaOut_followup_output:
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
                followup_input["p1"] = random.choice(self.primes)
                followup_input["q1"] = random.choice(self.primes)
            
            random_key_input()
            while inputs[i]["p1"] == followup_input["p1"] and inputs[i]["q1"] == followup_input["q1"]:
                random_key_input()
        return followup_inputs
    
    def encryption_key_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "mod_exp_finish", source_record_indicator[0])
        target_followup_output = simulation.process_output(followup_output_file, "mod_exp_finish", followup_record_indicator[0])
        failure_cases = []

        if "msg_out" not in target_source_output or "msg_out" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["msg_out"]) != len(target_followup_output["msg_out"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["msg_out"]), len(target_followup_output["msg_out"]))+1, len(self.source_tests)+1)])
        for i, (rsaOut_source_output, rsaOut_followup_output) in enumerate(zip(target_source_output["msg_out"], target_followup_output["msg_out"])):
            if rsaOut_source_output == rsaOut_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-3
    def encrypt_decrypt_checking_plaintext_change_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def random_rsa_input():
                nonlocal followup_input
                random_number = secrets.randbits(127)
                rsa_input = "256'h" + format(random_number, "016X")
                followup_input["msg_in"] = rsa_input
            
            random_rsa_input()
            while inputs[i]["msg_in"] == followup_input["msg_in"]:
                random_rsa_input()
        return followup_inputs
    
    def encrypt_decrypt_checking_plaintext_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "mod_exp_finish2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "mod_exp_finish2", followup_record_indicator[1])
        failure_cases = []

        if "msg_out2" not in target_source_output or "msg_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["msg_out2"]) != len(target_followup_output["msg_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["msg_out2"]), len(target_followup_output["msg_out2"]))+1, len(self.source_tests)+1)])
        for i, (rsaOut2_source_output, rsaOut2_followup_output) in enumerate(zip(target_source_output["msg_out2"], target_followup_output["msg_out2"])):
            if rsaOut2_source_output == rsaOut2_followup_output:
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
                followup_input["p2"] = random.choice(self.primes)
                followup_input["q2"] = random.choice(self.primes)
            
            random_key_input()
            while followup_input["p2"] == followup_input["p1"] and followup_input["q2"] == followup_input["q1"]:
                random_key_input()
        return followup_inputs
    
    def encrypt_decrypt_checking_decryption_change_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "mod_exp_finish2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "mod_exp_finish2", followup_record_indicator[1])
        failure_cases = []

        if "msg_out2" not in target_source_output or "msg_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["msg_out2"]) != len(target_followup_output["msg_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["msg_out2"]), len(target_followup_output["msg_out2"]))+1, len(self.source_tests)+1)])
        for i, (rsaOut2_source_output, rsaOut2_followup_output) in enumerate(zip(target_source_output["msg_out2"], target_followup_output["msg_out2"])):
            if rsaOut2_source_output == rsaOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases
    
    # MR-5
    def substring_checking_input(self, inputs):
        followup_inputs = copy.deepcopy(inputs)
        for i, followup_input in enumerate(followup_inputs):

            def subbit_rsa_input():
                nonlocal followup_input
                rsa_input = followup_input["msg_in"][5:]
                start_index = random.choice(range(0, len(rsa_input), 2))
                end_index = random.choice(range(start_index+2, len(rsa_input)+2, 2))
                sub_rsa_input = "00" * (start_index // 2) + rsa_input[start_index:end_index] + "00" * ((len(rsa_input) - end_index) // 2)
                followup_input["msg_in"] = "256'h" + sub_rsa_input
            
            subbit_rsa_input()
            while inputs[i]["msg_in"] == followup_input["msg_in"] and inputs[i]["msg_in"] != "256'h0000000000000000000000000000000000000000000000000000000000000000":
                subbit_rsa_input()
        return followup_inputs
    
    def substring_checking_output(self, source_outputs, followup_outputs):
        source_record_indicator, source_output_file = source_outputs
        followup_record_indicator, followup_output_file = followup_outputs
        target_source_output = simulation.process_output(source_output_file, "mod_exp_finish2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "mod_exp_finish2", followup_record_indicator[1])
        failure_cases = []

        if "msg_out2" not in target_source_output or "msg_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["msg_out2"]) != len(target_followup_output["msg_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["msg_out2"]), len(target_followup_output["msg_out2"]))+1, len(self.source_tests)+1)])
        for i, (rsaOut2_source_output, rsaOut2_followup_output) in enumerate(zip(target_source_output["msg_out2"], target_followup_output["msg_out2"])):
            if rsaOut2_source_output == "256'h0000000000000000000000000000000000000000000000000000000000000000":
                if rsaOut2_source_output != rsaOut2_followup_output:
                    failure_cases.append(i+1)
            else:
                sub_followup_output = rsaOut2_followup_output
                while sub_followup_output.startswith("00"):
                    sub_followup_output = sub_followup_output[2:]
                while sub_followup_output.endswith("00"):
                    sub_followup_output = sub_followup_output[:-2]
                if not (sub_followup_output in rsaOut2_source_output):
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
        target_source_output = simulation.process_output(source_output_file, "mod_exp_finish2", source_record_indicator[1])
        target_followup_output = simulation.process_output(followup_output_file, "mod_exp_finish2", followup_record_indicator[1])
        failure_cases = []

        if "msg_out2" not in target_source_output or "msg_out2" not in target_followup_output:
            failure_cases = [i for i in range(1, len(self.source_tests)+1)]
            return False, len(failure_cases), failure_cases
        
        if len(target_source_output["msg_out2"]) != len(target_followup_output["msg_out2"]):
            failure_cases.extend([i for i in range(min(len(target_source_output["msg_out2"]), len(target_followup_output["msg_out2"]))+1, len(self.source_tests)+1)])
        for i, (rsaOut2_source_output, rsaOut2_followup_output) in enumerate(zip(target_source_output["msg_out2"], target_followup_output["msg_out2"])):
            if rsaOut2_source_output != rsaOut2_followup_output:
                failure_cases.append(i+1)
        if len(failure_cases) > 0:
            return False, len(failure_cases), failure_cases
        return True, len(failure_cases), failure_cases