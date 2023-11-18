import os
from Utils import file_util, cmd_util

def generate_testbench(duv, mutant_id, tests):
    testbench = duv.get_testbench_template()
    
    # write tests to testbench
    # time_stamp = 0
    # test_inputs = ""
    # for test in tests:
    #     test_inputs += "#{};\n".format(test["time"]-time_stamp)
    #     time_stamp = test["time"]
    #     for key,value in test.items():
    #         if key == "time": continue
    #         test_inputs += "{}={};\n".format(key,value)
    testbench_str = file_util.read_file_to_str(testbench)
    # input_index = testbench_str.index("// input test data\n") + len("// input test data\n")
    # testbench_str = testbench_str[:input_index] + test_inputs + testbench_str[input_index:]
    testbench_str = duv.generate_testbench(testbench_str, tests)

    testbench_path = os.path.join(duv.get_proj_dir(mutant_id), "{}_{}_metamorphictesting_tb.v".format(duv.get_name(), mutant_id))
    file_util.write_str_to_file(testbench_str, testbench_path)
    return testbench_path

def process_output(output_file, record_indicator, record_indicator_values):
    output_data = {}
    output_lines = file_util.read_file_to_lines(output_file)
    headers = output_lines[0].strip().split(",")
    record_indicator_index = headers.index(record_indicator)

    record_flag = True
    for output_line in output_lines[1:]:
        tmp_data = output_line.strip().split(",")
        if len(tmp_data) != len(headers):
            continue
        if 'x' in tmp_data[record_indicator_index]:
            continue
        tmp_record_indicator = int(tmp_data[record_indicator_index])
        if tmp_record_indicator in record_indicator_values:
            if record_indicator == "time" or record_flag:
                for i,tmp_data_i in enumerate(tmp_data):
                    if headers[i] not in output_data:
                        output_data[headers[i]] = []
                    output_data[headers[i]].append(tmp_data_i)
            record_flag = False
        else:
            record_flag = True
    return output_data

def simulate_and_record(duv, mutant_id, tests):
    file_util.remove_dir(os.path.join(duv.get_proj_dir(mutant_id), "csrc"))
    file_util.remove_dir(os.path.join(duv.get_proj_dir(mutant_id), "simv.daidir"))

    source_files, inc_dirs, output_file = duv.get_duv_info(mutant_id)
    testbench = generate_testbench(duv, mutant_id, tests)
    inc_dir_cmds = []
    for inc_dir in inc_dirs:
        inc_dir_cmds.append("+incdir+"+inc_dir)
    cmd = "vcs -sverilog +vc -Mupdate -line -full64 {} {} {} -o simv -R -LDFLAGS -Wl,--no-as-needed".format(testbench, " ".join(source_files), " ".join(inc_dir_cmds))
    cmd_util.run_cmd(cmd, cwd=duv.get_proj_dir(mutant_id), timeout=5)
    assert os.path.exists(output_file)
    return output_file