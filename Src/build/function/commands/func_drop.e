
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
		local
			edited_behavior: BEHAVIOR
			an_event: EVENT
		do
			if not edited_function.has_input (input_data) then
				edited_function.add (input_data, output_data)
			end;
		end; -- redo

	undo_work is
		local
			edited_behavior: BEHAVIOR
			an_event: EVENT
		do
			edited_function.remove_element_line (input_data, False)
		end; -- undo

	function_work is
		local
			behavior_editor: BEHAVIOR_EDITOR
			edited_behavior: BEHAVIOR
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
			if input_data /= Void then
				Result.append (input_data.label);
			end
			Result.append (" and ");
			if output_data /= Void then
				Result.append (output_data.label);
			end
		end; -- worked_on

end
