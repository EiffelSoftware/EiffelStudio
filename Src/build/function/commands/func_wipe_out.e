
class FUNC_WIPE_OUT 

inherit

	FUNC_COMMAND
		
feature {NONE}

	input_list, output_list: EB_LINKED_LIST [DATA];

    c_name: STRING is
        do
            Result := Command_names.func_wipe_out_cmd_name
        end;
	
	redo_work is
		do
			edited_function.wipe_out
		end; -- redo

	undo_work is
		do
			edited_function.set (input_list,
						output_list);
			duplicate_lists (input_list, output_list);
		end; -- undo

	function_work is
		local
			c: INTEGER;
			il, ol: like input_list
		do
			if
				not edited_function.empty
			then
				il := edited_function.input_list;
				ol := edited_function.output_list;
				duplicate_lists (il, ol);
				edited_function.wipe_out;
				update_history
			end
		end; -- work

	duplicate_lists (input_l, output_l: like input_list) is
		do
			input_list := input_l.duplicate;
			output_list := output_l.duplicate;
		end; -- duplicate_lists

	worked_on: STRING is
		do
		end; -- worked_on

end
