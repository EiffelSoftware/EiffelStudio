
class FUNC_DROP 

inherit

	FUNC_COMMAND
	
feature {NONE}

	input_data, output_data: DATA;

	c_name: STRING is
		do
			Result := Command_names.func_drop_cmd_name
		end;

	redo_work is
		do
			if not edited_function.has_input (input_data) then
				edited_function.add (input_data, output_data)
			end;
		end; -- redo

	undo_work is
		do
			edited_function.remove_element_line (input_data, False)
		end; -- undo

	function_work is
		do
			edited_function.finish;
			output_data := edited_function.output;
			input_data := edited_function.input;
			update_history;
			update_interface;
		end; -- function_work

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (input_data.label);
			Result.append (" and ");
			Result.append (output_data.label);
		end; -- worked_on

end
