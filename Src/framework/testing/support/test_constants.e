indexing
	description: "[
		Object containing test related constants.
	]"
	author: ""
	date: "$Date$"
	doc: "wiki://Testing Tool (Specification)"

class
	TEST_CONSTANTS

feature -- Access

	common_test_class_ancestor_name: !STRING = "EQA_TEST_SET"
	system_level_test_ancestor_name: !STRING = "EQA_SYSTEM_LEVEL_TEST_SET"

	indexing_clause_tag_name: !STRING = "testing"
	prepare_routine_name: !STRING = "on_prepare"
	clean_routine_name: !STRING = "on_clean"

feature -- Access: tags

	outcome_fail_tag: !STRING = "outcome/fails"
	outcome_pass_tag: !STRING = "outcome/passes"
	outcome_unresolved_tag: !STRING = "outcome/unresolved"

end
