indexing
	description: "Merge a function into another."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class FUNC_MERGE 

inherit
	FUNC_COMMAND

feature

	name: STRING is
		do
			Result := Command_names.func_merge_cmd_name
		end

	set_old_lists (input_l, output_l: like input_list) is
		do
			if
				not input_l.empty
			then
				old_input_list := input_l.duplicate
				old_output_list := output_l.duplicate
			else
				!!old_input_list.make
				!!old_output_list.make
			end
		end

feature {NONE}

	input_list, output_list: EB_LINKED_LIST [PND_DATA]

	old_input_list, old_output_list:  EB_LINKED_LIST [PND_DATA]

	redo_work is
		do
			edited_function.set (input_list, output_list)
		end

	undo_work is
		do
			edited_function.set (old_input_list, old_output_list)
		end

	work is
		local
			il, ol: like input_list
		do
			il := edited_function.input_list
			ol := edited_function.output_list
			if
				not il.empty
			then
				input_list := il.duplicate
				output_list := ol.duplicate
				update_history
			end
			update_interface
		end

	worked_on: STRING is
		do
		end

end -- class FUNC_MERGE

