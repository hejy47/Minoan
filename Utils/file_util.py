import os, json
import shutil
import logging

logger = logging.getLogger()

def read_file_to_str(file_path):
    assert os.path.exists(file_path)
    file_str = ""
    try:
        with open(file_path, 'r') as f:
            file_str = f.read()
    except:
        with open(file_path, 'r', encoding="ISO-8859-1") as f:
            file_str = f.read()
    return file_str

def read_file_to_lines(file_path):
    assert os.path.exists(file_path)
    file_lines = []
    try:
        with open(file_path, 'r') as f:
            file_lines = f.readlines()
    except:
        with open(file_path, 'r', encoding="ISO-8859-1") as f:
            file_lines = f.readlines()
    return file_lines

def remove_file(file_path):
    if os.path.exists(file_path):
        assert os.path.isfile(file_path)
        os.remove(file_path)

def remove_dir(dir_path):
    if os.path.exists(dir_path):
        assert os.path.isdir(dir_path)
        shutil.rmtree(dir_path)

def remove_dir_content(dir_path):
    if os.path.exists(dir_path):
        assert os.path.isdir(dir_path)
        shutil.rmtree(dir_path)
        mkdir(dir_path)

def mkdir(dir_path):
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)

def mkdir_from_file_path(file_path):
    dir_path = os.path.dirname(file_path)
    if not os.path.exists(dir_path):
        os.makedirs(dir_path, mode=0o777)

def cpdir(src_dir, dst_dir):
    if os.path.exists(src_dir):
        remove_dir(dst_dir)
        mkdir_from_file_path(dst_dir)
        shutil.copytree(src_dir, dst_dir)

def write_str_to_file(file_str, file_path, append=False):
    mkdir_from_file_path(file_path)
    mode = 'w'
    if append: mode = "a+"
    with open(file_path, mode) as f:
        f.write(file_str)

def backup_file(src_file, dst_file):
    assert os.path.isfile(src_file)
    remove_file(dst_file)
    mkdir_from_file_path(dst_file)
    shutil.copyfile(src_file, dst_file)

def move_file(src_file, dst_file):
    assert os.path.isfile(src_file)
    mkdir_from_file_path(dst_file)
    shutil.copyfile(src_file, dst_file)
    remove_file(src_file)

def read_json_file(file_path):
    return json.loads(read_file_to_str(file_path))

def write_json_file(json_dict, file_path):
    write_str_to_file(json.dumps(json_dict), file_path)