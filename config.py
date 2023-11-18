import os

PROJECT_PATH = os.path.join(os.path.abspath(os.path.dirname(__file__)))

DATA_DIR = os.path.join(PROJECT_PATH, "Data")
PROJECT_DIR = os.path.join(DATA_DIR, "Projects")
TESTBENCH_DIR = os.path.join(DATA_DIR, "Testbenches")
TESTBENCH_TEMPLATE_DIR = os.path.join(TESTBENCH_DIR, "Templates")
MUTANT_DIR = os.path.join(DATA_DIR, "Mutants")
MUTANT_SOURCE_DIR = os.path.join(DATA_DIR, "Mutation_projects")

OUTPUT_DIR = os.path.join(PROJECT_PATH, "Output")