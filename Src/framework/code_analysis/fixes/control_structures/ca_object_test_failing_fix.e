note
	description: "Fixes violations of rule #07 ('Object test always failing')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_OBJECT_TEST_FAILING_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_ot

feature {NONE} -- Initialization
	make_with_ot (a_class: attached CLASS_C; a_ot: attached OBJECT_TEST_AS)
		-- Initializes `Current' with class `a_class'. `a_ot' is the object test statement containing the violation.
		do
			make (ca_names.object_test_failing_fix, a_class)
			ot_to_change := a_ot
		end

feature {NONE} -- Implementation

	execute
			-- <Precursor>
		do
			ot_to_change.replace_text ("False", match_list)
		end

	ot_to_change: OBJECT_TEST_AS
			-- The Object Test node this fix will change.

end
