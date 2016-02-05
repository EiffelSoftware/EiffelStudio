note
	description: "Fixes violations of rule #45 ('Comparison of {REAL}.nan')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_REAL_NAN_COMPARISON_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_bin_eq

feature {NONE} -- Initialization
	make_with_bin_eq (a_class: attached CLASS_C; a_bin: attached BIN_EQ_AS; a_is_right: attached BOOLEAN)
			-- Initializes `Current' with class `a_class'. `a_bin' is the binary equation containing the violation.
			-- `a_is_right' tells us whether the call to '.nan' is on the right hand sider or not.
		do
			make (ca_names.real_nan_comparison_fix, a_class)
			bin_eq_to_change := a_bin
			is_on_right_side := a_is_right
		end

feature {NONE} -- Implementation

	bin_eq_to_change: BIN_EQ_AS
		-- The binary equation this fix changes.

	is_on_right_side: BOOLEAN
		-- Is the call to '.nan' on the right side of the equation?

	execute (a_class: CLASS_AS)
		local
			l_new: STRING
		do
			if is_on_right_side then
				l_new := bin_eq_to_change.left.text_32 (matchlist)
			else
				l_new := bin_eq_to_change.right.text_32 (matchlist)
			end

			bin_eq_to_change.replace_text (l_new + ".is_nan", matchlist)
		end

end
