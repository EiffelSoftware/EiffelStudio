
class BEHAVIOR 

inherit

	FUNCTION
		export 
			{CONTEXT} drop_pair
		redefine
			func_editor, 
			input_data, output_data
		end

	WINDOWS

creation

	make

feature {NONE}

	make is
		do
			!!input_list.make
			!!output_list.make
			int_generator.next
			identifier := int_generator.value
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end

	help_file_name: STRING is
		do
			Result := Help_const.behavior_help_fn
		end
	
feature 

	input_data: EVENT

	output_data: CMD_INSTANCE

	func_editor: BEHAVIOR_EDITOR

feature -- Query

	has_command (cmd: CMD): BOOLEAN is
		local
			old_pos: INTEGER
		do
			old_pos := output_list.index
			from
				output_list.start
			until
				output_list.after or else Result
			loop
				Result := output_list.item.associated_command = cmd
				output_list.forth
			end
			output_list.go_i_th (old_pos)
		end

feature -- Copying

    copy_contents (func: like Current) is
        local
            il: like input_list
            ol: like output_list
        do
            il := func.input_list
            ol := func.output_list
            from
                il.start
                ol.start
            until
                ol.after
            loop
                add (il.item, ol.item)
                il.forth
                ol.forth
            end
        end

feature -- Command labels

	labels: LINKED_LIST [CMD_LABEL] is
			-- Command labels contained in Current
			-- behavior
		local
			old_pos: INTEGER
			sublist: LINKED_LIST [CMD_LABEL]	
		do
			!!Result.make
			from
				old_pos := output_list.index
				output_list.start
			until
				output_list.after
			loop
				sublist := output_list.item.labels
				from
					sublist.start
				until
					sublist.after
				loop
					Result.put_right (sublist.item)
					sublist.forth
				end
				output_list.forth
			end
			output_list.go_i_th (old_pos)
		end

	set_internal_name (s: STRING) is
		do
			if s.empty then
				namer.next
				set_label (namer.value)
			else
				set_label (s)
			end
		end
	
feature {NONE}

	int_generator: INT_GENERATOR is
		once
			!!Result
		end

	namer: NAMER is
			-- Unique strings generator
		once
			!!Result.make ("Behavior")
		end

feature  -- Editing features

	label: STRING

	context: CONTEXT
			-- Context associated with the behavior

	set_context (c: CONTEXT_STONE) is
			-- Set context to `c'.
		do
			context := c.data
		end

	set_label (s: STRING) is
		do
			label := s
		end

feature -- Datum features

	identifier: INTEGER

	data: BEHAVIOR is
		do
			Result := Current
		end

feature {FUNC_DROP, FUNC_CUT} -- Adding and removing commands on the interface.

	interface_command: INTERNAL_META_COMMAND is
			-- Return an instanciated command corresponding
			-- to `ouput_data'.
		require
			command_not_void: output_data /= Void
		do
			if corresponding_internal_meta_command = Void then
				!! Result.make 
				if func_editor /= Void then
					Result.add_command (func_editor.current_state, output_data.instantiated_command)
				else
					Result.add_command (main_panel.current_state, output_data.instantiated_command)
				end
				corresponding_internal_meta_command := Result
			else
				Result := corresponding_internal_meta_command
			end
		end

	add_interface_command (a_command: COMMAND) is
			-- Add `a_command' to `context' on interface.
		require
			event_not_void: input_data /= Void
		do
			input_data.add_interface_command (context, a_command)
		end

	remove_interface_command (a_command: COMMAND) is
			-- Remove command corresponding to `output_data' on
			-- the context `context' on the interface.
		require
			context_not_void: context /= Void
			event_not_void: input_data /= Void
		do
			input_data.remove_interface_command (context, a_command)
		end

feature {NONE} -- Attribute

	corresponding_internal_meta_command: INTERNAL_META_COMMAND
			-- Internal meta command added to the interface

feature {STATE} -- Interface command

	add_interface_command_from_storage (a_context: CONTEXT a_state: STATE) is
			-- Add the command corresponding to `output_data'
			-- on the widget corresponding to `a_context'.
		require
			event_list_not_empty: not input_list.empty
			command_instance_list_not_empty: not output_list.empty
		local
			a_command: INTERNAL_META_COMMAND
		do
			!! a_command.make 
			a_command.add_command (a_state, output_list.first.instantiated_command)
			corresponding_internal_meta_command := a_command
			input_list.first.add_interface_command (context, a_command)
		end

end
