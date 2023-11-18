

def generate_followup_test(source_tests, metamorphic_relation):
    # followup_tests = []
    # for source_test in source_tests:
    #     followup_test = metamorphic_relation[0](source_test)
    #     followup_tests.append(followup_test)
    followup_tests = metamorphic_relation[0](source_tests)
    return followup_tests

def verify_outputs(source_outputs, followup_outputs, metamorphic_relation):
    return metamorphic_relation[1](source_outputs, followup_outputs)