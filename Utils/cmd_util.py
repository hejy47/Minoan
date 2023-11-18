import os, subprocess
import logging, time
from Utils import file_util

def run_cmd(cmd, cwd=None, timeout=None, logger=None):
    if logger == None:
        logger = logging.getLogger()
        logger.setLevel(logging.INFO)
    start_time = time.time()
    logger.info("cmd to run: {}".format(cmd))
    # # format for windows
    # cmd = cmd.replace("\\", "/")
    stdout_file = os.path.join(cwd, "stdout.txt")
    stderr_file = os.path.join(cwd, "stderr.txt")
    try:
        with open(stdout_file, "w") as f1, open(stderr_file, "w") as f2:
            p = subprocess.run(cmd, shell=True, stdout=f1, stderr=f2, cwd=cwd, timeout=timeout)
    except subprocess.TimeoutExpired:
        return "Timeout reached"
    # try:
    #     output = p.stdout.decode("utf-8")
    # except UnicodeDecodeError:
    #     logger.warn("cmd UnicodeDecoderError")
    #     output = p.stdout.decode("unicode_escape")
    output = file_util.read_file_to_str(stdout_file)
    file_util.remove_file(stdout_file)
    file_util.remove_file(stderr_file)

    return output