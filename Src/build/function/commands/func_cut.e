indexing
	description: "Delete a function."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class FUNC_CUT

inherit
	FUNC_COMMAND

feature {NONE}

	position: INTEGER
			-- Position of the removed element

	input_data, output_data: PND_DATA
			-- Input and output datum removed from box

	name: STRING is
		do
			Result := Command_names.func_cut_elements_cmd_name
		end

	redo_work is
		do
			edited_function.remove_element_line (input_data, False)
		end

	undo_work is
		do
			edited_function.add_element_line (position, input_data, output_data)
		end

	work is
		local
			input_list, output_list: EB_LINKED_LIST [like input_data]
		do
			input_list := edited_function.input_list
			output_list := edited_function.output_list
			position := input_list.index
			input_data := input_list.item
			output_data := output_list.item
			edited_function.set_input_data (input_data)
			edited_function.set_output_data (output_data)
			edited_function.reset_input_data
			edited_function.reset_output_data
			update_history
		end

	worked_on: STRING is
		do
			create Result.make (0)
			if input_data /= Void then
				Result.append (input_data.label)
			end
			Result.append (" -> ")
			if output_data /= Void then
				Result.append (output_data.label)
			end
		end

feature {BUILD_STATE}

	set_not_record is
		do
			failed := True
		end

end -- class FUNC_CUT

