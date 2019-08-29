note
	description: "Fixes violations of various rules that need to move an instruction from a loop body in front of or after the loop."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MOVE_INSTRUCTION_WITHIN_LOOP_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_loop_and_instruction

feature {NONE} -- Initialization
	make_with_loop_and_instruction (a_class: attached CLASS_C; a_loop: attached LOOP_AS; a_instr: attached INSTRUCTION_AS; a_move_to_front: attached BOOLEAN)
			-- Initializes `Current' with class `a_class'. `a_loop' is the loop containing the creation instruction `a_instr'. `a_move_to_front' determines
			-- whether the instruction is to be moved in front or after the loop.
		do
			make (ca_names.move_instruction_within_loop_fix, a_class)
			loop_to_change := a_loop
			instruction_to_move := a_instr
			move_to_front := a_move_to_front
		end

feature {NONE} -- Implementation

	loop_to_change: LOOP_AS
		-- The loop to remove the instruction from.

	instruction_to_move: INSTRUCTION_AS
		-- The instruction to be moved.

	move_to_front: BOOLEAN
		-- Will the instruction be moved in front of the loop? (Instead of after the loop)

	execute
			-- <Precursor>
		local
			l_body: EIFFEL_LIST[INSTRUCTION_AS]
			l_new_string, l_indent, l_temp: STRING_32
		do
			l_body := loop_to_change.compound
			l_temp := loop_to_change.text_32 (match_list)

			-- Calculate the indentation of the loop. TODO: Refactor.
			l_temp := l_temp.substring (l_temp.substring_index (l_body.last.text_32 (match_list), 1), l_temp.count - 3)
			l_indent := l_temp.substring (l_temp.index_of ('%T', 1), l_temp.count)

			create l_new_string.make_empty

			l_temp := instruction_to_move.text_32 (match_list)
			instruction_to_move.remove_text (match_list)

			if move_to_front then
				l_new_string.append (l_temp + "%N")
				l_new_string.append (l_indent + loop_to_change.text_32 (match_list) + "%N")
			else
				l_new_string.append (loop_to_change.text_32 (match_list) + "%N")
				l_new_string.append (l_indent + l_temp + "%N")
			end

			loop_to_change.replace_text ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_new_string), match_list)
		end

end
