indexing
	description: "Create a function."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class FUNC_DROP

inherit
	FUNC_COMMAND

feature {NONE}

	input_data, output_data: PND_DATA

	name: STRING is
		do
			Result := Command_names.func_drop_cmd_name
		end

	redo_work is
		do
			if not edited_function.has_input (input_data) then
				edited_function.add (input_data, output_data)
			end
		end

	undo_work is
		do
			edited_function.remove_element_line (input_data, False)
		end

	work is
		do
			edited_function.finish
			output_data := edited_function.output
			input_data := edited_function.input
			update_history
			update_interface
		end

	worked_on: STRING is
		do
			!!Result.make (0)
			if input_data /= Void then
				Result.append (input_data.label)
			end
			Result.append (" and ")
			if output_data /= Void then
				Result.append (output_data.label)
			end
		end

end -- class FUNC_DROP

