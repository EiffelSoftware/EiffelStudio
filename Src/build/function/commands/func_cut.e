
class FUNC_CUT 

inherit

	FUNC_COMMAND
	
feature {NONE}

	do_not_record: BOOLEAN;
			-- Record Current command in history list?

	position: INTEGER;
			-- Position of the removed element

	input_data, output_data: DATA;
			-- Input and output datum removed from box

	c_name: STRING is
		do
			Result := Command_names.func_cut_elements_cmd_name
		end;

	redo_work is
		local
			edited_behavior: BEHAVIOR
			an_event: EVENT
		do
			edited_function.remove_element_line (input_data, False)
		end; -- redo

	undo_work is
		local
			edited_behavior: BEHAVIOR
			an_event: EVENT
		do
			edited_function.add_element_line (position, input_data,
							output_data);
		end; -- undo

	function_work is
		local
			input_list, output_list: EB_LINKED_LIST [DATA]
			edited_behavior: BEHAVIOR
			an_event: EVENT
		do
			input_list := edited_function.input_list;
			output_list := edited_function.output_list;
			position := input_list.index;
			input_data := input_list.item;
			output_data := output_list.item;
			edited_function.set_input_data (input_data)
			edited_function.set_output_data (output_data)
			edited_function.reset_input_data
			edited_function.reset_output_data
			if not do_not_record then
				history.record (Current);
			end;
		end; -- function_work

	worked_on: STRING is
		do
			!!Result.make (0);
			if input_data /= Void then
				Result.append (input_data.label);
			end
			Result.append (" -> ");
			if output_data /= Void then
				Result.append (output_data.label);
			end
		end; -- worked_on

feature {BUILD_STATE}

	set_not_record is
		do
			do_not_record := True
		end;

end
