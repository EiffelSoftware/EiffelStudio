
class FUNC_CUT 

inherit

	FUNC_COMMAND
	
feature {NONE}

	position: INTEGER;
			-- Position of the removed element

	input_data, output_data: DATA;
			-- Input and output datum removed from box

	c_name: STRING is
		do
			Result := Command_names.func_cut_elements_cmd_name
		end;

	redo_work is
		do
			edited_function.remove_element_line (input_data, False)
		end; -- redo

	undo_work is
		do
			edited_function.add_element_line (position, input_data,
							output_data);
		end; -- undo

	function_work is
		local
			input_list, output_list: EB_LINKED_LIST [DATA]
		do
			input_list := edited_function.input_list;
			output_list := edited_function.output_list;
			position := input_list.index;
			input_data := input_list.item;
			output_data := output_list.item;
			update_history
		end; -- function_work

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (input_data.label);
			Result.append (" and ");
			Result.append (output_data.label);
		end; -- worked_on

end
