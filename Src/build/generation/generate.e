indexing
	description: "Command to generate Eiffel source code."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 

	GENERATE 

inherit

	SHARED_CONTEXT

	SHARED_APPLICATION

	COMMAND

	CALLBACK_GENE

	CONSTANTS

	WINDOWS

	ERROR_POPUPER

	EXCEPTIONS
		rename
			class_name as exceptions_class_name
		end

feature 

	rescued: BOOLEAN

	execute (argument: ANY) is
		do
			if main_panel.project_initialized then
				work (argument)
			end
		end

	work (argument: ANY) is
			-- Generate the Eiffel code.
		local
			mp: MOUSE_PTR
			temp: STRING
		do
			if not rescued then
				!!mp
				mp.set_watch_shape
				save_edited_commands
--				command_instantiator_generator.update_command
				generate_files	
				mp.restore
			else
				rescued := False
				if original_exception = Operating_system_exception and then
					original_tag_name /= Void
				then
					!! temp.make (0)
					temp.append ("Reason: ")
					temp.append (original_tag_name)
				else
					temp := Environment.classes_directory
				end
				error_box.popup (Current, 
					Messages.generate_er, temp)
			end
		rescue
			mp.restore
			rescued := True
			retry
		end

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

feature -- Command save

	save_edited_commands is
			-- Save every command currently edited in a command
			-- editor.
		local
			cmd_tool_list: LINKED_LIST [COMMAND_TOOL]
		do
			cmd_tool_list := window_mgr.command_tools
			from
				cmd_tool_list.start
			until
				cmd_tool_list.after
			loop
				if cmd_tool_list.item.command_editor_shown then
					cmd_tool_list.item.save_command
				end
				cmd_tool_list.forth
			end
		end
feature -- Code generation

	generate_files is
		local
			current_cursor, old_cursor: CURSOR
			temp: STRING
			doc: EB_DOCUMENT
			cmd: USER_CMD
			group: GROUP
			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]]
			cmd_list: LINKED_LIST [USER_CMD]
			error: BOOLEAN
			translate_fn: FILE_NAME
			type, translate_content: STRING
			window_c: WINDOW_C
		do
				-- ==========================
				-- Widget classes generation.
				-- ==========================
			callback_generator.update
			Environment.create_ace_file
			Environment.create_generated_directories
			from
				!! translate_content.make (0)
				old_cursor := Shared_window_list.cursor
				Shared_window_list.start
			until
				Shared_window_list.after or else error
			loop
				current_cursor := Shared_window_list.cursor
				window_c := Shared_window_list.item
				!!doc
				doc.set_directory_name (Environment.context_directory)
				doc.set_document_name (window_c.base_file_name_without_dot_e)
				if doc.is_file_name_valid then
					temp := window_c.eiffel_text
					doc.update (temp)
					error := doc.error
					doc := Void
					translate_content.append (window_c.base_file_name_without_dot_e)
					translate_content.append (".e")
					translate_content.append (":  ")
					translate_content.append (window_c.label)
					translate_content.extend ('%N')
				else
					error := True
					display_file_name_error (doc.document_file_name)
				end
				Shared_window_list.go_to (current_cursor)
				Shared_window_list.forth
			end
			if not translate_content.empty then
					-- Update the translate file is necessary
				!! translate_fn.make_from_string (Environment.context_directory)
				translate_fn.set_file_name (Environment.translate_name)
				save_translation (translate_fn, translate_content)
			end
			Shared_window_list.go_to (old_cursor)
			callback_generator.clear_all

				-- ===========================
				-- Group classes generation.
				-- ===========================
			from
				old_cursor := Shared_group_list.cursor
				Shared_group_list.start
			until
				Shared_group_list.after or else error
			loop
				group := Shared_group_list.item
				!!doc
				doc.set_directory_name (Environment.groups_directory)
				doc.set_document_name (group.entity_name)
				if doc.is_file_name_valid then
					current_cursor := Shared_group_list.cursor
					doc.update (group.updated_eiffel_text)
					error := doc.error
					doc := Void
					Shared_group_list.go_to (current_cursor)
				else
					error := True
					display_file_name_error (doc.document_file_name)
				end
				Shared_group_list.forth
			end
			Shared_group_list.go_to (old_cursor)
				
				-- ===========================
				-- Command classes generation.
				-- ===========================
				-- Now done from command editor
				-- every time the command is changed
				-- Save may be necessary if `.e' has been
				-- removed or changed just before generation.
			from
				translate_content.wipe_out
				user_cmds := command_catalog.user_commands
				user_cmds.start
			until
				user_cmds.after or else error
			loop
				cmd_list := user_cmds.item
				from
					cmd_list.start
				until
					cmd_list.after
				loop
					cmd := cmd_list.item
					cmd.update_text_if_modified
					translate_content.append (cmd.base_file_name)
					translate_content.append (":  ")
					translate_content.append (cmd.label)
					translate_content.extend ('%N')
					cmd_list.forth
				end
				user_cmds.forth
			end
			if not translate_content.empty then
					-- Update the translate file is necessary
				!! translate_fn.make_from_string (Environment.commands_directory)
				translate_fn.set_file_name (Environment.translate_name)
				save_translation (translate_fn, translate_content)
			end
				
				-- =========================
				-- Windows class generation.
				-- =========================
			if not error then
				!!doc
				doc.set_directory_name (Environment.windows_directory)
				doc.set_document_name (Environment.windows_file_name)
				temp := windows_text
				doc.update (temp)
				error := doc.error
				doc := Void
			end

				-- =========================
				-- States class generation.
				-- =========================
			if not error then
				!!doc
				doc.set_directory_name (Environment.state_directory)
				doc.set_document_name (Environment.states_file_name)
				temp := states_text
				doc.update (temp)
				error := doc.error
				doc := Void
			end

				-- ============================
				-- Application class generation
				-- ============================
			if not error then
				!!doc
				doc.set_directory_name (Environment.application_directory)
				doc.set_document_name (Environment.application_file_name)
				temp := Shared_app_graph.eiffel_text
				if temp.item (temp.count) /= '%N' then
					temp.append ("%N")
				end
				doc.update (temp)
				error := doc.error
				doc := Void
			end

				-- ===============================
				-- Shared control class generation
				-- ===============================

			if not error then
				!!doc
				doc.set_directory_name (Environment.application_directory)
				doc.set_document_name (Environment.shared_control_file_name)
				temp := shared_control_text
				doc.update (temp)
				doc := Void
			end
		end

	
feature {NONE}

	states_text: STRING is
		local
			state_list: LINKED_LIST [BUILD_STATE]
			counter: INTEGER
		do
			!!Result.make (0)
			Result.append ("class STATES%N%Nfeature%N")
			Result.append ("%N%TExit_from_application: INTEGER is -2%N")
			Result.append ("%N%TReturn_to_previous: INTEGER is -1%N")
			from
				state_list := Shared_app_graph.states
				state_list.start
				counter := 1
			until
				state_list.after
			loop
				Result.append ("%N%T")
				Result.append (state_list.item.label)
				Result.append (": INTEGER is ")
				Result.append (counter.out)
				Result.append ("")
				if not (state_list.item.visual_name = Void) then
					Result.append ("%T-- ")
					Result.append (state_list.item.visual_name)
				end
				Result.append ("%N")		
				state_list.forth
				counter := counter + 1
			end
			Result.append ("%Nend%N")
		end

	windows_text: STRING is
		local
			class_name: STRING
			old_cursor: CURSOR
			window_context: WINDOW_C
		do
			!!Result.make (3000)	
			Result.append ("class WINDOWS%N%N")
			Result.append ("inherit%N%N%TGRAPHICS%N%T%Tredefine%N%T%T%Tinit_toolkit%N%T%Tend%N%N")
			Result.append ("feature%N%N")	
			Result.append ("%Tapplication_screen: SCREEN is%N%T%Tonce%N%T%T%T!!Result.make (%"%")%N%T%Tend%N%N")
			Result.append ("%Tinit_toolkit: TOOLKIT_IMP")
			Result.append (" is%N%T%Tonce%N%T%T%T!!Result.make (%"%")%N%T%Tend%N%N")
			Result.append ("%Tinit_windowing is%N%T%Tdo%N%
					%%T%T%Tif (init_toolkit = Void) then end%N%
					%%T%T%Tif (toolkit = Void) then end%N")
			from
				old_cursor := Shared_window_list.cursor
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_context := Shared_window_list.item
				if not window_context.start_hidden then
					Result.append ("%T%T%T")
					Result.append (window_context.entity_name)
					Result.append (".realize%N")
					if not window_context.is_perm_window then
						Result.append ("%T%T%T")
						Result.append (window_context.entity_name)
						Result.append (".popup%N")
					end
				elseif not window_context.is_perm_window then
					Result.append ("%T%T%T")
					Result.append (window_context.entity_name)
					Result.append (".realize%N")
				end
				Shared_window_list.forth
			end
			Shared_window_list.go_to (old_cursor)
			Result.append ("%T%T%Titerate%N%T%Tend%N%N")
			from
				old_cursor := Shared_window_list.cursor
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_context := Shared_window_list.item
				Result.append ("%T")
				Result.append (window_context.entity_name)
				Result.append (": ")
					!!class_name.make (10)
					class_name := window_context.entity_name
					class_name := clone (class_name)
					class_name.to_upper
				Result.append (class_name)
				Result.append (" is%N%T%Tonce%N%T%T%T!!Result.make (%"")
				Result.append (window_context.entity_name)
				Result.append ("%", ") 
				if window_context.is_perm_window then
					Result.append ("application_screen") 
				else
					Result.append (window_context.parent.entity_name)
				end
				Result.append (")%N%T%Tend%N%N") 
				Shared_window_list.forth
			end
			Shared_window_list.go_to (old_cursor)
			Result.append ("end%N")
		end	

	shared_control_text: STRING is
		do
			!!Result.make (0)
			Result.append ("class SHARED_CONTROL%N%Nfeature%N%N")
			Result.append ("%Tcontrol: CONTROL is%N%T%Tonce%N%T%T%T!!Result.make (")
			Result.append_integer (Shared_app_graph.count)
			Result.append (")%N%T%Tend%N%Nend%N")
		end


feature {NONE} -- Error display

	display_file_name_error (fn: STRING) is
			-- Display file name error for `fn'.
		do
			error_box.popup (Current, 
					Messages.Invalid_file_name_er, 
					fn)
		end

feature {NONE} -- Writing out the translate file

	save_translation (translate_fn: FILE_NAME; translate_content: STRING) is
		require
			valid_translate_fn: translate_fn /= Void
			valid_translate_content: translate_content /= Void
		local
			translate_file: PLAIN_TEXT_FILE
		do
			!! translate_file.make (translate_fn)
			if translate_file.exists and then 
				translate_file.is_readable 
			then
				translate_file.open_read
				translate_file.read_stream (translate_file.count)
				translate_file.close
				if not translate_file.last_string.is_equal 
						(translate_content) 
				then
					translate_file.open_write
					translate_file.put_string (translate_content)
					translate_file.close
				end
			else
				translate_file.open_write
				translate_file.put_string (translate_content)
				translate_file.close
			end
		end

end
