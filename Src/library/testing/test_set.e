indexing
	description: "Sets of related testing operations."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SET

obsolete

	"Use EQA_TEST_SET instead."

inherit
	EQA_TEST_SET
		rename
			on_prepare as setup,
			on_clean as tear_down
		end


end
