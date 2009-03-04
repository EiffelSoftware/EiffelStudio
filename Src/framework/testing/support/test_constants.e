note
	description: "[
		Object containing test related constants.
	]"
	author: ""
	date: "$Date$"
	doc: "wiki://Testing Tool (Specification)"

class
	TEST_CONSTANTS

feature -- Access

	common_test_class_ancestor_name: attached STRING = "EQA_TEST_SET"
	system_level_test_ancestor_name: attached STRING = "EQA_SYSTEM_LEVEL_TEST_SET"

	indexing_clause_tag_name: attached STRING = "testing"
	prepare_routine_name: attached STRING = "on_prepare"
	clean_routine_name: attached STRING = "on_clean"

feature -- Access: tags

	outcome_fail_tag: attached STRING = "outcome/fails"
	outcome_pass_tag: attached STRING = "outcome/passes"
	outcome_unresolved_tag: attached STRING = "outcome/unresolved"

end
