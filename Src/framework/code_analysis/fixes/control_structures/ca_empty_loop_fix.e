note
	description: "Fixes violations of rule #16 ('Empty loop')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_LOOP_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_loop

feature {NONE} -- Initialization

	make_with_loop (a_class: attached CLASS_C; a_loop_as: attached LOOP_AS)
			-- Initializes `Current' with class `a_class'. `a_loop' is the empty loop to be removed.
		do
			make(ca_names.empty_loop_fix, a_class)
			loop_to_be_removed := a_loop_as
		end

feature {NONE} -- Implementation

	loop_to_be_removed: LOOP_AS
		-- The loop to be removed.

feature {NONE} -- Visitor

	execute
			-- <Precursor>
		do
			loop_to_be_removed.remove_text (match_list)
		end

end
