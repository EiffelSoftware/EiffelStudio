indexing
	description: "[
		Object containing test related constants.
	]"
	author: ""
	date: "$Date$"
	doc: "wiki://Testing Tool (Specification)"

class
	SHARED_TEST_CONSTANTS

feature -- Access

	common_test_class_ancestor_name: STRING = "TEST_SET"

	test_routine_prefix: STRING = "test_"

	indexing_clause_tag_name: STRING = "testing"

feature -- Access: tags

	outcome_fail_tag: STRING = "outcome.fails"

	outcome_pass_tag: STRING = "outcome.passes"

	outcome_unresolved_tag: STRING = "outcome.unresolved"

end
