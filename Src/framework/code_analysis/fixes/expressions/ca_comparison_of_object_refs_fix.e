note
	description: "Fixes violations of rule #49 ('Comparison of object references')."
	revised_by: "Alexander Kogtenkov"
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

	make_with_bin_eq (a_class: CLASS_C; a_bin_eq_as: BIN_EQ_AS)
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

	execute
			-- <Precursor>
		do
			bin_eq_to_change.replace_text (bin_eq_to_change.left.text (match_list) + " - " + bin_eq_to_change.right.text (match_list), match_list)
		end

end
