
class FUNC_DROP 

inherit

	FUNC_COMMAND
	MODE_CONSTANTS
	
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
					--| Add the command to the interface if `edited_function'
					--| is a BEHAVIOR.
				edited_behavior ?= edited_function
				if edited_behavior /= Void then
					an_event ?= input_data
					an_event.add_interface_command (edited_behavior.context, added_command)
				end
			end;
		end; -- redo

	undo_work is
		local
			edited_behavior: BEHAVIOR
			an_event: EVENT
		do
			edited_function.remove_element_line (input_data, False)
				--| Remove the command from the interface if `edited_function'
				--| is a BEHAVIOR.
			edited_behavior ?= edited_function
			if edited_behavior /= Void then
				an_event ?= input_data
				an_event.remove_interface_command (edited_behavior.context, added_command)
			end
		end; -- undo

	function_work is
		local
			behavior_editor: BEHAVIOR_EDITOR
			edited_behavior: BEHAVIOR
		do
			edited_function.finish;
			output_data := edited_function.output;
			input_data := edited_function.input;
				--| Add the command to the interface if `edited_function'
				--| is a BEHAVIOR.
			edited_behavior ?= edited_function
			if edited_behavior /= Void then
				added_command := edited_behavior.interface_command
				edited_behavior.add_interface_command (added_command)
			end
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

feature -- Added command

	added_command: INTERNAL_META_COMMAND
			-- Command added to the interface
end
