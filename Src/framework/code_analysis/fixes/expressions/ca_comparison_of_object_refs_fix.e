note
	description: "Fixes violations of rule #49 ('Comparison of object references')."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CA_COMPARISON_OF_OBJECT_REFS_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_bin_eq

feature {NONE} -- Initialization
	make_with_bin_eq (a_class: attached CLASS_C; a_bin_eq_as: attached BIN_EQ_AS)
			-- Initializes `Current' with class `a_class'. `a_bin_eq_as' is the '='
			-- operation comparing object references.
		do
			make (ca_names.comparison_of_object_refs_fix, a_class)
			bin_eq_to_change := a_bin_eq_as
		end

feature {NONE} -- Implementation

	bin_eq_to_change: BIN_EQ_AS
		-- The '=' operation comparing object references.

feature {NONE} -- Visitor

	execute (a_class: attached CLASS_AS)
		do
			bin_eq_to_change.replace_text (bin_eq_to_change.left.text_32 (matchlist) + " - " + bin_eq_to_change.right.text_32 (matchlist), matchlist)
		end
end
