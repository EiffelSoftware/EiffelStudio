note
	description: "Fixes violations of rule #22 ('Unreachable code')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNREACHABLE_CODE_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_list_and_index

feature {NONE} -- Initialization
	make_with_list_and_index (a_class: attached CLASS_C; a_list: attached EIFFEL_LIST [INSTRUCTION_AS]; a_index: attached INTEGER)
			-- Initializes `Current' with class `a_class'. `a_list' is the list containing the dead instructions. `a_index' determines
			-- where the dead instructions start.
		do
			make (ca_names.unreachable_code_fix, a_class)
			list_to_change := a_list
			index_of_first_instruction_to_remove := a_index
		end

feature {NONE} -- Implementation

	list_to_change: EIFFEL_LIST [INSTRUCTION_AS]
		-- The list to remove the dead instructions from.

	index_of_first_instruction_to_remove: INTEGER
		-- The first instruction to be moved.

	execute
			-- <Precursor>
		do
			from
				list_to_change.go_i_th (index_of_first_instruction_to_remove)
			until
				list_to_change.after
			loop
				list_to_change.item.remove_text (match_list)
				list_to_change.forth
			end
		end

end
