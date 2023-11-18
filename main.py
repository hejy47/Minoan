import argparse, sys, os
import config
from Utils import file_util
from MetamorphicRelation import project_factory
from MT4V import tests_process, simulation

def metamorphic_test(duv, source_tests, metamorphic_relation, mutant_id):
    followup_tests = tests_process.generate_followup_test(source_tests, metamorphic_relation)
    source_record_indicators = duv.get_record_indicator(source_tests)
    source_output_file = simulation.simulate_and_record(duv, mutant_id, source_tests)
    rename_source_output_file = os.path.join(os.path.dirname(source_output_file), "source_" + os.path.basename(source_output_file))
    file_util.backup_file(source_output_file, rename_source_output_file)
    file_util.remove_file(source_output_file)
    source_outputs = (source_record_indicators, rename_source_output_file)

    followup_record_indicators = duv.get_record_indicator(followup_tests)
    followup_output_file = simulation.simulate_and_record(duv, mutant_id, followup_tests)
    rename_followup_output_file = os.path.join(os.path.dirname(followup_output_file), "followup_" + os.path.basename(followup_output_file))
    file_util.backup_file(followup_output_file, rename_followup_output_file)
    file_util.remove_file(followup_output_file)
    followup_outputs = (followup_record_indicators, rename_followup_output_file)

    test_result = tests_process.verify_outputs(source_outputs, followup_outputs, metamorphic_relation)
    return test_result

def metamorphic_test_all_mutants(duv, source_tests, metamorphic_relation_tuples):
    test_results = {}
    for metamorphic_relation_tuple in metamorphic_relation_tuples:
        test_results[metamorphic_relation_tuple[0]] = {}
        for mutant_id in range(1, duv.get_mutant_num()+1):
            test_results[metamorphic_relation_tuple[0]]["{}_{}".format(duv.get_name(), mutant_id)] = []
            for _ in range(1):
                result, failure_num, failure_cases = metamorphic_test(duv, source_tests, metamorphic_relation_tuple[1], mutant_id)
                print("Testing mutant {} of {} with metamorphic relation {}: {}".format(mutant_id, duv.get_name(), metamorphic_relation_tuple[0], result))
                test_results[metamorphic_relation_tuple[0]]["{}_{}".format(duv.get_name(), mutant_id)].append(result)
                file_util.write_str_to_file(
                    "{} {}_{} {} {} {}\n".format(metamorphic_relation_tuple[0], duv.get_name(), mutant_id, result, failure_num, failure_cases), \
                        os.path.join(config.OUTPUT_DIR, "{}.txt".format(duv.get_name())), True)
    
    # record result
    # file_util.write_json_file(test_results, os.path.join(config.OUTPUT_DIR, "{}.json".format(duv.get_name())))

if __name__ == "__main__":
    aparser = argparse.ArgumentParser()
    aparser.add_argument("-p", "--project", help="project")
    aparser.add_argument("-mr", "--metamorphic_relations", help="Metamorphic Relations")

    args = aparser.parse_args()
    if args.project == None:
        print("No project.")
        sys.exit(0)
    project = project_factory.get_project(args.project)
    if project == None:
        print("No project.")
        sys.exit(0)
    metamorphic_relations = project.get_metamorhpic_relations(args.metamorphic_relations)
    if metamorphic_relations == []:
        print("No metamorphic relations ({}) in this project ({}).".format(args.metamorphic_relations, args.project))
        sys.exit(0)
    source_tests = project.get_source_tests()
    metamorphic_test_all_mutants(project, source_tests, metamorphic_relations)
    