
class FUNC_CUT 

inherit

	FUNC_CMD_NAMES
		rename
			Func_cut_elements_cmd_name as c_name
		export
			{NONE} all
		end;

	FUNC_COMMAND
	
feature {NONE}

	position: INTEGER;
			-- Position of the removed element

	input_stone, output_stone: STONE;
			-- Input and output stones removed from box

	redo_work is
		do
			edited_function.remove_element_line (input_stone, False)
		end; -- redo

	undo_work is
		do
			edited_function.add_element_line (position, input_stone,
							output_stone);
		end; -- undo

	function_work is
		local
			input_list, output_list: EB_LINKED_LIST [STONE]
		do
			input_list := edited_function.input_list;
			output_list := edited_function.output_list;
			position := input_list.index;
			input_stone := input_list.item.original_stone;
			output_stone := output_list.item.original_stone;
			update_history
		end; -- function_work

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (input_stone.label);
			Result.append (" and ");
			Result.append (output_stone.label);
		end; -- worked_on

end
