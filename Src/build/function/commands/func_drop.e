
class FUNC_DROP 

inherit

	FUNC_COMMAND
	
feature {NONE}

	input_stone, output_stone: STONE;

	c_name: STRING is
		do
			Result := Command_names.func_drop_cmd_name
		end;

	redo_work is
		do
			if not edited_function.has_input (input_stone) then
				edited_function.add (input_stone, output_stone)
			end;
		end; -- redo

	undo_work is
		do
			edited_function.remove_element_line (input_stone, False)
		end; -- undo

	function_work is
		do
			edited_function.finish;
			output_stone := edited_function.output;
			input_stone := edited_function.input;
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
