indexing
	description: "Wipe out a function from the list."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class FUNC_WIPE_OUT 

inherit
	FUNC_COMMAND
		
feature {NONE}

	input_list, output_list: EB_LINKED_LIST [PND_DATA]

    name: STRING is
        do
            Result := Command_names.func_wipe_out_cmd_name
        end
	
	redo_work is
		do
			edited_function.wipe_out
		end

	undo_work is
		do
			edited_function.set (input_list,
						output_list)
			duplicate_lists (input_list, output_list)
		end

	work is
		local
			c: INTEGER
			il, ol: like input_list
		do
			if
				not edited_function.empty
			then
				il := edited_function.input_list
				ol := edited_function.output_list
				duplicate_lists (il, ol)
				edited_function.wipe_out
				update_interface
				update_history
			end
		end

	duplicate_lists (input_l, output_l: like input_list) is
		do
			input_list := input_l.duplicate
			output_list := output_l.duplicate
		end

	worked_on: STRING is
		do
		end

end -- class FUNC_WIPE_OUT

