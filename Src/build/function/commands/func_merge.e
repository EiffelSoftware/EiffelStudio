
class FUNC_MERGE 

inherit

	FUNC_COMMAND

feature

	c_name: STRING is
		do
			Result := Command_names.func_merge_cmd_name
		end;

	set_old_lists (input_l, output_l: like input_list) is
		do
			if
				not input_l.empty
			then
				old_input_list := input_l.duplicate;
				old_output_list := output_l.duplicate;
			else
				!!old_input_list.make;
				!!old_output_list.make;
			end;
		end;

feature {NONE}

	input_list, output_list: EB_LINKED_LIST [STONE];

	old_input_list, old_output_list:  EB_LINKED_LIST [STONE];

	redo_work is
		do
			edited_function.set (input_list, output_list)
		end; -- redo

	undo_work is
		do
			edited_function.set (old_input_list, old_output_list)
		end; -- undo

	function_work is
		local
			il, ol: like input_list
		do
			il := edited_function.input_list;
			ol := edited_function.output_list;
			if
				not il.empty
			then
				input_list := il.duplicate;
				output_list := ol.duplicate;
				update_history
			end
		end; -- function_work

	worked_on: STRING is
		do
		end; -- worked_on

end
