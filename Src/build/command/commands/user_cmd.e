indexing
	description: "General notion of user command i.e. editable command."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class USER_CMD 

inherit

	CMD
		redefine
			set_editor, data,
			set_eiffel_text
		end
	NAMABLE
	ERROR_POPUPER

creation

	make, session_init, storage_init

feature -- Creation

	make is
			-- Initialize current user
			-- command.
		do
			int_generator.next
			identifier := int_generator.value
			!! arguments.make
			!! labels.make
			initialize_values
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.user_command_pixmap
		end

	help_file_name: STRING is
		do
			Result := Help_const.user_command_help_fn
		end

	session_init is
			-- Intialize current user command
			-- for a session.
		do
			!! arguments.make
			!! labels.make
			initialize_values
		end

	storage_init (a: like arguments; l: like labels;
			s: STRING; p: CMD; in,vn: STRING) is
			-- Intialize current user command
			-- for storage.
		do
			arguments := a
			labels := l
			eiffel_text := s
			set_parent_type (p)
			set_internal_name (in)
			visual_name := clone (vn)	
			initialize_values
		end

	initialize_values is
			-- Temporary
		do
			labels.compare_objects
		end
feature -- Stone

	data: USER_CMD is
		do
			Result := Current
		end

	identifier: INTEGER
			-- Unique identifier for storage
			-- and retrieval

	eiffel_type: STRING
			-- Name of the Eiffel class 
			-- representing Current user 
			-- command

	arguments: EB_LINKED_LIST [ARG]
			-- Arguments of Current command
			-- (Defined in current or introduced
			-- from a parent)

	labels: EB_LINKED_LIST [CMD_LABEL]
			-- Labels of Current command.
			-- (Defined in current or introduced
			-- from a parent)

	eiffel_text: STRING
			-- Eiffel class text associated with
			-- Current user command.

	label: STRING is
		do
			if  visual_name /= Void then
				Result := visual_name
			else
				Result := eiffel_type
			end
		end

feature -- Namable

	visual_name: STRING

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
			else
				visual_name := clone (s)
			end
			update_instance_names
			update_text
			if edited then
			 	command_editor.update_title
			end
			command_catalog.update_icon_stone (Current)
		end

	update_instance_names is
			-- Update the instances name
			-- Does Current have instances?
		local
			s: STATE
			b: BEHAVIOR
			found: BOOLEAN
			command_tools: LINKED_LIST [COMMAND_TOOL]
			ed: COMMAND_TOOL
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off
			loop
				s ?= Shared_app_graph.key_for_iteration
				if s /= Void then
					from
						s.start
					until
						s.after 
					loop
						found := False
						b := s.output.data
						from
							b.start
						until
							b.after or else found
						loop
							found := b.output.associated_command 
										= Current	
							b.forth
						end
						if found then
							s.input.update_instance_name_in_editor
						end
						s.forth
					end
				end
				Shared_app_graph.forth
			end
			command_tools := associated_command_tools
			from
				command_tools.start
			until
				command_tools.after
			loop
				ed := command_tools.item
				ed.update_title
				command_tools.forth
			end
		end

feature -- Editor

	set_editor (ed: like command_editor) is
		do
			command_editor := ed
			old_template := template
		end

feature -- Undoable and non-undoable

	undoable: BOOLEAN
			-- Is Command undoable?

	set_undoable (b: BOOLEAN) is
			-- Set undoable to `b'
		do
			undoable := b
		end

feature -- Inheritance

	has_parent: BOOLEAN is
			-- Does current command inherit
			-- from another command?
		do
			Result := parent_type /= Void
		end

	set_parent (cmd: CMD) is 
			-- Set parent of Current
			-- user command to `cmd'.
		local
			set_parent_command: CMD_SET_PARENT
			label_clash: STRING
			msg: STRING
		do 
			label_clash := label_name_clash (cmd)
			if label_clash /= Void then
				!! msg.make (0)
				msg.append ("Label name: ")
				msg.append (label_clash)
				msg.append (" from class ")
				msg.append (cmd.eiffel_type_to_upper)
				error_box.popup (Current,
					Messages.label_name_clash_er,
					msg)
			else
				!!set_parent_command
				if not (parent_type = Void) then
					set_parent_command.set_previous_parent (parent_type)
				end
				set_parent_command.set_parent_type (cmd)
				set_parent_command.execute (Current)
			end
		end

	remove_parent is
			-- Remove parent from Current.
		local
			cut_parent_command: CMD_CUT_PARENT
		do
			if parent_type /= Void then
				!!cut_parent_command
				cut_parent_command.execute (Current)
			end
		end

	refresh_parent is
			-- remove and redo parent with out recording it in the history.
		local
			refresh_parent_command: CMD_REFRESH_PARENT
		do
			if parent_type /= Void then
				!!refresh_parent_command
				refresh_parent_command.execute (Current)
			end
		end

	set_parent_type (c: CMD) is
			-- Set parent_type to `c'.
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= parent_type	
			if user_cmd /= Void then
				user_cmd.remove_descendent (Current)
			end
			parent_type := c
			user_cmd ?= c
			if user_cmd /= Void then
				user_cmd.add_descendent (Current)
			end
			if edited then
				command_editor.update_parent_symbol
			end
		end

	parent_type: CMD
			-- Parent type of Current user
			-- command

	descendents: LINKED_LIST [CMD]
			-- Descendents using Current command

	has_descendents: BOOLEAN is
		do
			Result := descendents /= Void and then
				not descendents.empty
		end

	remove_descendent (c: USER_CMD) is
		require
			has_c: descendents.has (c)
			valid_descendents: descendents /= Void
		do
			descendents.start
			descendents.prune (c)	
		ensure
			not_has_c: not descendents.has (c)
		end

	add_descendent (c: USER_CMD) is
		require
			not_has_c: descendents = Void or else  not descendents.has (c)
		do
			if descendents = Void then
				!! descendents.make
			end
			descendents.put_front (c)	
		ensure
			valid_descendents: descendents /= Void
			has_c: descendents.has (c)
		end

	label_name_clash (other: CMD): STRING is
			-- Do Current label names clash with `other'
			-- label names?
		local
			other_labels: like labels
		do
			other_labels := other.labels
			from
				other_labels.start
			until
				other_labels.after or else Result /= Void
			loop
				if label_exist (other_labels.item.label) then
					Result := other_labels.item.label
				end
				other_labels.forth
			end
		end

feature -- Naming

	set_internal_name (s: STRING) is
			-- Set internal name of
			-- current user command.
		do
			if s.empty then
				namer.next
				eiffel_type := namer.value
			else
				eiffel_type := s
			end
		end

	reset_name is
		do
			namer.reset
			int_generator.reset
		end

feature {NONE} -- Naming

	Command_seed: STRING is "Command"

	Command_seed_to_lower: STRING is  "command"

	arg_entity_namer: LOCAL_NAMER is
			-- Argument entities namer
		once
			!! Result.make ("argument")
		end

	arg_param_namer: LOCAL_NAMER is
			-- Argument parameters namer
		once
			!! Result.make ("arg")
		end

	int_generator: INT_GENERATOR is
			-- Generator of unique integers
		once
			!! Result
		end

	namer: NAMER is
			-- User command namer
		once
			!! Result.make (Command_seed)
		end

feature -- Editing

	set_eiffel_text (s: STRING) is
			-- Set the eiffel text to
			-- `s'.
		do
			eiffel_text := s
		end

	save is
			-- Save edited arguments, labels and
			-- eiffel text.
		require
			Editing: edited
		do
			save_arguments
			save_labels
			save_text
		end

	save_text is	
			-- Save text of Current command.
		require
			Editing: edited
		do
			if not eiffel_text.is_equal (command_editor.eiffel_text) then
				eiffel_text := clone (command_editor.eiffel_text)
				command_editor.set_unsaved_application
			end
		end

	overwrite_text is
		local
			file: PLAIN_TEXT_FILE
		do
			!! file.make (associated_file_name)
			file.open_write
			file.putstring (eiffel_text)
			file.close
		end

	save_to_disk is
			-- Save `eiffel_text' to disk.
		local
			file: PLAIN_TEXT_FILE
			fl_nm: STRING
		do
			!! file.make (associated_file_name)
			if file.exists and then file.is_readable then
				file.open_read
				file.readstream (file.count)
				file.close
				if not eiffel_text.is_equal (file.last_string) then
						-- Update if necessary
					file.open_write
					file.putstring (eiffel_text)
					file.close
				end
			else
				file.open_write
				file.putstring (eiffel_text)
				file.close
			end
		end

	set_arguments (args: like arguments) is
			-- Set arguments to `args'.
		require
			valid_arg: args /= Void
		do
			arguments := args
		end

	set_labels (l: like labels) is
			-- Set labels to `l'.
		require
			valid_labels: l /= Void
		do
			labels := l
		end

feature {S_COMMAND} -- Update from storage

	update_inherited_label is
		require
			inherited: parent_type /= Void
		local
			inherited_labels: like labels
			inh_cmd_label, cmd_label: CMD_LABEL
			found: BOOLEAN
		do
			inherited_labels := parent_type.labels
			if not inherited_labels.empty then
				from
					labels.start
				until
					labels.after
				loop
					cmd_label := labels.item
					from
						inherited_labels.start
					until
						inherited_labels.after or else found
					loop
						inh_cmd_label := inherited_labels.item
						found := cmd_label.is_equal (inh_cmd_label)
						inherited_labels.forth
					end
					if found then
						cmd_label.set_parent (parent_type)
					end
					labels.forth
				end
			end
		end

feature {NONE}

	save_arguments is 
			-- Save arguments of Current command.
		require
			Editing: edited
		local
			l: EB_LINKED_LIST [ARG]
		do 
			from
				!!l.make
				arguments.start
			until
				arguments.after
			loop
				l.extend (arguments.item)
				arguments.forth
			end
			arguments := l
		end

	save_labels is 
			-- Save labels of Current command.
		require
			Editing: edited
		local
			l: EB_LINKED_LIST [CMD_LABEL]
		do 
			from
				!!l.make
				labels.start
			until
				labels.after
			loop
				l.extend (labels.item)
				labels.forth
			end
			labels := l
		end
	
feature  -- Generation 

	template: STRING is
			-- Template of the Eiffel
			-- command.
		local
			parent_name: STRING
			inherited_args: LINKED_LIST [STRING]
			found: BOOLEAN
		do
			!!Result.make (0)
			Result.append ("class ")
			Result.append (eiffel_type_to_upper)
			Result.append ("%N%Ninherit%N%N%T")
			if (parent_type = Void) then
				if undoable then
					Result.append ("BUILD_UNDOABLE_CMD")
				else
					Result.append ("BUILD_NON_UNDOABLE_CMD")
				end
			else
				Result.append (parent_type.eiffel_inherit_text)
			end
			Result.append ("%N%Ncreation%N%N%Tmake")
			Result.append ("%N%Nfeature%N%N")
			from
				labels.start
			until
				labels.after
			loop
				if (labels.item.parent_type = Void) then
					Result.append ("%T")
					Result.append (labels.item.label)
					Result.append ("_label: STRING is %"")
					Result.append (labels.item.label)
					Result.append ("%"%N%N")
				end
				labels.forth
			end
			from
				arg_entity_namer.reset
				arguments.start
			until
				arguments.after
			loop
				if (arguments.item.parent_type = Void) then
					Result.append ("%T")
					arg_entity_namer.next
					Result.append (arg_entity_namer.value)
					Result.append (": ")
					Result.append (arguments.item.data.eiffel_type)
					Result.append ("%N%N")
				end
				arguments.forth
			end
			if (parent_type = Void) then
				Result.append ("%Texecute is%N%T%Tdo%N")
				if not labels.empty then
					from
						labels.start
					until
						labels.after or found
					loop
						if (labels.item.parent_type = Void) then
							Result.append ("%T%T%Tset_transition_label (")
							Result.append (labels.item.label)
							Result.append ("_label)%N")
							found := True
						end
					end
				end
				Result.append ("%T%Tend")
			else
				Result.append (parent_type.eiffel_body_text)
			end
			Result.append ("%N%N%Tmake")
			if
				not arguments.empty
			then
				Result.append (" (")
				from
					arguments.start
					arg_param_namer.reset
				until
					arguments.after
				loop
					arg_param_namer.next
					Result.append (arg_param_namer.value)
					Result.append (": ")
					Result.append (arguments.item.data.eiffel_type)
					arguments.forth
					if not arguments.after then
						Result.append ("%N%T%T")
					end
				end
				Result.append (")")
			end
			Result.append (" is%N%T%Tdo")
			from
				arguments.start
				arg_param_namer.reset
				arg_entity_namer.reset
				!!inherited_args.make
			until
				arguments.after
			loop
				arg_param_namer.next
				if (arguments.item.parent_type = Void) then
					arg_entity_namer.next
					Result.append ("%N%T%T%T")
					Result.append (arg_entity_namer.value)
					Result.append (" := ")
					Result.append (arg_param_namer.value)	
					Result.append ("")
				else
					inherited_args.extend (arg_param_namer.value)
				end
				arguments.forth
			end
			Result.append ("%N")
			if not (parent_type = Void) then
				Result.append (parent_type.eiffel_creation_text (inherited_args))
			end
			Result.append ("%T%Tend%N%N")
			if undoable then
				Result.append ("%Tundo is%N%T%Tdo%N%T%Tend%N%N")
				Result.append ("%Tredo is%N%T%Tdo%N%T%Tend%N%N")
			end
			Result.append ("end%N")
		end

feature -- Arguments 

-- 	add_argument (ts: TYPE_STONE) is
-- 			-- Add an argument to Current command.
-- 		require
-- 			Edited: edited
-- 		local
-- 			new_argument: ARG
-- 			add_argument_cmd: CMD_ADD_ARGUMENT
-- 		do
-- 			!! new_argument.session_init (ts)
-- 			!! add_argument_cmd
-- 			add_argument_cmd.set_element (new_argument)
-- 			add_argument_cmd.execute (Current)
-- 		end
 
-- 	remove_argument (a: ARG) is
-- 			-- Remove `a' from the list of arguments
-- 			-- from current command.
-- 		require
-- 			Edited: edited
-- 		local
-- 			remove_argument_cmd: CMD_CUT_ARGUMENT
-- 		do
-- 			arguments.start
-- 			arguments.search (a)
-- 			if not arguments.after then
-- 				if arguments.item.inherited then
-- 					Error_box.popup (Current,
-- 						Messages.Cannot_remove_argument_er,
-- 						arguments.item.label)	
-- 				else
-- 					!! remove_argument_cmd
-- 					remove_argument_cmd.set_index (arguments.index)
-- 					remove_argument_cmd.execute (Current)
-- 				end
-- 			end
-- 		end

	index_of_argument (a: ARG): INTEGER is
			-- Index of `a' in `arguments'.
		do
			Result := arguments.index_of (a, 1)
		end

feature -- labels {CMD_EDITOR}

	add_label (l: STRING) is
			-- Add a label to current command.
		require
			Edited: edited
		local
			lab: CMD_LABEL
			add_label_cmd: CMD_ADD_LABEL
		do
			if not label_exist (l) then
				!!lab.make (l)
				!!add_label_cmd
				add_label_cmd.set_element (lab)
				add_label_cmd.execute (Current)
			end
		end

	label_exist (l: STRING): BOOLEAN is
		require
			lable_not_void: l /= Void
		local
			temp_label: STRING
			exist_label: STRING
		do
			temp_label := clone (l)
			temp_label.to_lower
			from 
				labels.start
			until
				labels.after
			loop
				exist_label := clone (labels.item.label)
				exist_label.to_lower
				Result := temp_label.is_equal (exist_label)
				if Result then
					labels.finish
				end
				labels.forth
			end
		end

	remove_label (l: CMD_LABEL) is
			-- Remove `l' from the list of labels
			-- from current command.
		require
			Edited: edited
		local
			remove_label_cmd: CMD_CUT_LABEL
		do
			labels.start
			labels.search (l)
			if not labels.after then
				if labels.item.inherited then
					Error_box.popup (Current,
						Messages.Cannot_remove_label_er,
						labels.item.label)	
				else
					!!remove_label_cmd
					remove_label_cmd.set_index (labels.index)
					remove_label_cmd.execute (Current)
				end
			end
		end

feature -- Text generation

	old_template: STRING

	base_file_name_without_dot_e: FILE_NAME is
			-- Base file name for Current Command without
			-- the `.e' extension
		local
			tmp: STRING
		do
			tmp := eiffel_type_to_lower
			tmp.replace_substring_all (Command_seed_to_lower, 
						Resources.command_file_name)
			!! Result.make_from_string (tmp)
		end

	base_file_name: FILE_NAME is
			-- Base file name for Current Command
		do
			Result := base_file_name_without_dot_e
			Result.add_extension ("e")
		end

	associated_file_name: FILE_NAME is
			-- File name path for Current Command 
			-- in Generated commands directory
		local
			tmp: STRING
			tmp_to_lower: STRING
		do
			!! Result.make_from_string (Environment.commands_directory)
			Result.set_file_name (base_file_name)
		end

	update_text_if_modified is
		local
			file: PLAIN_TEXT_FILE
			fl_nm: STRING
		do
			!! file.make (associated_file_name)
			if file.exists and then file.is_readable and then
				not file.empty
			then
				file.open_read
				file.readstream (file.count)
				file.close
				if not eiffel_text.is_equal (file.last_string) then
						-- Update text
					perform_diff
				end
			else
				file.open_write
				file.putstring (eiffel_text)
				file.close
			end
		end

	update_text is
			-- Update edited eiffel text by applying
			-- a `diff3' between the current edited text
			-- the previous template and the new template.
			-- Then update class text
		do
			if edited then
				eiffel_text := command_editor.text_editor.text
			end
				-- Save user file content
			save_to_disk
			perform_diff
		end

	perform_diff is
			-- Perform diff and update the class file
			-- if there is a difference.
		local
			mp: MOUSE_PTR
			merger: MERGER
			temp: STRING
			file: PLAIN_TEXT_FILE
			old_template_file: FILE_NAME
			new_template: STRING
			tmp_eiffel_text: STRING
			pos: INTEGER
			fname: FILE_NAME
		do
			!!mp
			mp.set_watch_shape
			!!merger
			if old_template = Void then
				save_old_template
			end
			fname := associated_file_name
			if fname.is_valid then
				new_template := template
				if edited then
					merger.set_command_caller (command_editor)
				end
				merger.integrate_command (associated_file_name, 
						old_template, new_template)
				if not merger.error then
					!! tmp_eiffel_text.make (merger.merge_result.count)
					if visual_name /= Void then
						!! temp.make (0)
						temp.append ("indexing%N%Tvisual_name: %"")
						temp.append (visual_name)
						temp.append ("%"%N%N")
						tmp_eiffel_text.append (temp)
					end
					tmp_eiffel_text.append (merger.merge_result)
					old_template := Void
					if not tmp_eiffel_text.is_equal (eiffel_text) then
				   		-- Now save to disk if necessary
						eiffel_text := tmp_eiffel_text
						if edited then
							pos := command_editor.text_editor.top_character_position
							command_editor.text_editor.set_text (eiffel_text)
							if pos > eiffel_text.count then
								pos := eiffel_text.count
							end
							command_editor.text_editor.set_top_character_position (pos)
						end
							-- Update the user file content
			   			!! file.make (associated_file_name)
						file.open_write
			   			file.putstring (eiffel_text)
			   			file.close
							-- Update the template file content for
							-- further diffs when user modifies
							-- outside the ebuild environment.
						!! old_template_file.make_from_string (Environment.templates_directory)
						old_template_file.set_file_name (base_file_name_without_dot_e)
			   			!! file.make (old_template_file)
						file.open_write
			   			file.putstring (new_template)
			   			file.close
					end
				end
				mp.restore
			else
				error_box.popup (Current,
					Messages.Invalid_file_name_er,
					fname)	
			end
		end

	retrieve_text_from_disk is
			-- Retrieve `eiffel_text' from disk, if possible,
			-- otherwise save `eiffel_text' to disk.
		local
			file: PLAIN_TEXT_FILE
			disk_file: STRING
			doc: EB_DOCUMENT
			error: BOOLEAN
		do
			!! file.make (associated_file_name)
			if file.exists then
				file.open_read
				file.readstream (file.count)
				file.close
				disk_file := file.last_string
				if not disk_file.is_equal (eiffel_text) then
					disk_file := clone (disk_file)
					!! doc
					doc.set_directory_name (Environment.commands_directory)
					doc.set_document_name (base_file_name_without_dot_e)
					if doc.is_file_name_valid then
						doc.update (template)
						error := doc.error
					else
						error := True
						error_box.popup (Current,
							Messages.Invalid_file_name_er,
							doc.document_file_name)	
					end
				end
				if not error then
					file.open_read
					file.readstream (file.count)
					file.close
					set_eiffel_text (clone (file.last_string))
				end
			else
				file.open_write
				file.put_string (eiffel_text)
				file.close
			end
		end

	save_old_template is
			-- Set old_template to template.
		do
			old_template := template
		end

	remove_class is	
		local
			class_file: PLAIN_TEXT_FILE
		do
			!!class_file.make (associated_file_name)
			if class_file.exists then
				class_file.delete
			end
		end

	recreate_class is		
		local
			class_file: PLAIN_TEXT_FILE
		do
			!!class_file.make (associated_file_name)
			if not class_file.exists then
				class_file.open_write
				class_file.putstring (eiffel_text)
				class_file.close
			end
		end

end -- class USER_CMD
