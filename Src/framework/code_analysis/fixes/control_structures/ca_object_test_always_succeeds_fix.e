note
	description: "Fixes violations of rule #29 ('Object test or non-Void test always succeeds')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_OBJECT_TEST_ALWAYS_SUCCEEDS_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_bin_eq_or_object_test

feature {NONE} -- Initialization

	make_with_bin_eq_or_object_test (a_class: attached CLASS_C; a_expr: attached EXPR_AS)
			-- Initializes `Current' with class `a_class'. `a_expr' is either the
			-- BIN_NE_AS or OBJECT_TEST_AS to be changed.
		do
			make (ca_names.object_test_succeeds_fix, a_class)
			if attached {BIN_NE_AS} a_expr as l_bin_ne then
				bin_ne_to_change := l_bin_ne
			elseif attached {OBJECT_TEST_AS} a_expr as l_object_test then
				object_test_to_change := l_object_test
			end
		end

feature {NONE} -- Implementation

	bin_ne_to_change: detachable BIN_NE_AS
		-- The '/=' operation to be changed.

	object_test_to_change: detachable OBJECT_TEST_AS
		-- The object test to be changed.

feature {NONE} -- Visitor

	execute
			-- <Precursor>
		do
			if attached bin_ne_to_change then
				bin_ne_to_change.replace_text ("True", match_list)
			else
				object_test_to_change.replace_text ("True", match_list)
			end
		end
end
