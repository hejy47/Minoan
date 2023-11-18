import os

class Project:
    def __init__(self) -> None:
        self.mutant_num = 0
        self.proj_dir = None
        self.name = None
        self.source_files = []
        self.include_dirs = []
        self.testbench_template = None
        self.output_file = None
        self.source_tests = []
    
    def get_name(self):
        return self.name

    def get_mutant_num(self):
        return self.mutant_num

    def get_testbench_template(self):
        return self.testbench_template
    
    def get_proj_dir(self, mutant_id):
        return os.path.join(self.proj_dir, str(mutant_id))

    def get_duv_info(self, mutant_id):
        source_files = []
        for source_file in self.source_files:
            source_files.append(os.path.join(self.proj_dir, str(mutant_id), source_file))
        inc_dirs = []
        for inc_dir in self.include_dirs:
            inc_dirs.append(os.path.join(self.proj_dir, str(mutant_id), inc_dir))
        output_file = os.path.join(self.proj_dir, str(mutant_id), self.output_file)
        return source_files, inc_dirs, output_file
    
    def get_source_tests(self):
        return self.source_tests
    
    def get_record_indicator(self, tests):
        pass
    
    def generate_testbench(self, testbench_str, tests):
        pass
    
    def get_metamorhpic_relations(self, metamorphic_relation_name):
        if metamorphic_relation_name == None or metamorphic_relation_name.lower() == "all":
            ret_mr = []
            for k,v in self.metamorphic_relations.items():
                ret_mr.append((k, v))
            return ret_mr
        elif metamorphic_relation_name in self.metamorphic_relations:
            return [(metamorphic_relation_name, self.metamorphic_relations[metamorphic_relation_name])]
        return []