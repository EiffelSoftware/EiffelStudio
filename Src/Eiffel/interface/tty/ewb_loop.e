note

	description:
		"Batch compiler invoked by the -loop option.%
		%Does not show C compilation options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EWB_LOOP

inherit
	EWB_CMD
		rename
			name as loop_cmd_name,
			help_message as loop_help,
			abbreviation as loop_abb
		redefine
			executable
		end

	SYSTEM_CONSTANTS

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Properties

	yank_window: YANK_WINDOW
			-- Output window to be saved to a file
		once
			create Result.make
		end

	menu_command_list: EWB_MENU
			-- List of commands for menu

	last_request_abb: CHARACTER
			-- Last character option

	last_request_cmd: EWB_CMD
			-- Last command selected from menu

feature -- Initialization

	main_menu: EWB_MENU
			-- Main menu options
		local
			i: INTEGER
		once
			i := 6
			if {EWB_TESTING}.is_available then
				i := i + 1
			end
			create Result.make (1, i)
			Result.set_is_main

			Result.add_entry (create {EWB_STRING}.make (class_cmd_name, class_help, class_abb, class_menu))
			Result.add_entry (create {EWB_STRING}.make (compile_cmd_name, compile_help, compile_abb, compile_menu))
			Result.add_entry (create {EWB_STRING}.make (feature_cmd_name, feature_help, feature_abb, feature_menu))
			Result.add_entry (create {EWB_STRING}.make (system_cmd_name, system_help, system_abb, system_menu))

			if {EWB_TESTING}.is_available then
				Result.add_entry (create {EWB_TESTING}.make)
			end

			Result.add_entry (create {EWB_STRING}.make (profile_cmd_name, profile_help, profile_abb, profile_menu))
			Result.add_entry (create {EWB_STRING}.make (documentation_cmd_name, documentation_help, documentation_abb, documentation_menu))
		ensure
			main_menu_not_void: Result /= Void
		end

	Documentation_menu: EWB_MENU
			-- Documentation menu options
		once
			create Result.make (1, 4)
			Result.add_entry (create {EWB_DOCUMENTATION}.make_flat_short (Void, False))
			Result.add_entry (create {EWB_DOCUMENTATION}.make_short (Void, False))
			Result.add_entry (create {EWB_DOCUMENTATION}.make_flat (Void, False))
			Result.add_entry (create {EWB_DOCUMENTATION}.make_text (Void))
		ensure
			documentation_menu_not_void: Result /= Void
		end

	System_menu: EWB_MENU
			-- System menu options
		once
			create Result.make (1, 8)
			Result.set_parent (Main_menu)
			Result.add_entry (create {EWB_ACE})
			Result.add_entry (create {EWB_CLASS_LIST})
			Result.add_entry (create {EWB_CLUSTER_HIERARCHY})
			Result.add_entry (create {EWB_CLUSTERS})
			Result.add_entry (create {EWB_EDIT_ACE})
			Result.add_entry (create {EWB_INDEXING})
			Result.add_entry (create {EWB_MODIFIED})
			Result.add_entry (create {EWB_STATISTICS})
		ensure
			system_menu_not_void: Result /= Void
		end

	profile_menu: EWB_MENU
			-- Profile menu options.
		once
			create Result.make (1, 7)
			Result.set_parent (Main_menu)
			Result.add_entry (
				create {EWB_SWITCHES_CMD}.make_without_help (switches_cmd_name, switches_abb, switches_menu))
			Result.add_entry (
				create {EWB_STRING}.make (queries_cmd_name, queries_help, queries_abb, queries_menu))
			Result.add_entry (create {EWB_INPUT}.make_loop)
			Result.add_entry (create {EWB_LANGUAGE}.make_loop)
			Result.add_entry (create {EWB_RUN_PROF})
			Result.add_entry (create {EWB_GENERATE})
			Result.add_entry (create {EWB_DEFAULTS}.make_loop (Current))
		ensure
			profile_menu_not_void: Result /= Void
		end

	class_menu: EWB_MENU
			-- Class menu options
		once
			create Result.make (1, 18)
			Result.set_parent (Main_menu)
			Result.add_entry (create {EWB_ANCESTORS})
			Result.add_entry (create {EWB_ATTRIBUTES})
			Result.add_entry (create {EWB_CLIENTS})
			Result.add_entry (create {EWB_DEFERRED})
			Result.add_entry (create {EWB_DESCENDANTS})
			Result.add_entry (create {EWB_EDIT_CLASS})
			Result.add_entry (create {EWB_EXPORTED})
			Result.add_entry (create {EWB_EXTERNALS})
			Result.add_entry (create {EWB_FLAT})
			Result.add_entry (create {EWB_FS})
			Result.add_entry (create {EWB_ONCE})
			Result.add_entry (create {EWB_ROUTINES})
			Result.add_entry (create {EWB_INVARIANTS})
			Result.add_entry (create {EWB_CREATORS})
			Result.add_entry (create {EWB_SHORT})
			Result.add_entry (create {EWB_SUPPLIERS})
			Result.add_entry (create {EWB_TEXT})
			Result.add_entry (create {EWB_SHOW_FILE_PATH})
		ensure
			class_menu_not_void: Result /= Void
		end

	feature_menu: EWB_MENU
			-- Feature menu options
		once
			create Result.make (1, 8)
			Result.set_parent (Main_menu)
			Result.add_entry (create {EWB_PAST})
			Result.add_entry (create {EWB_SENDERS})
			Result.add_entry (create {EWB_CALLEES})
			Result.add_entry (create {EWB_FUTURE})
			Result.add_entry (create {EWB_R_FLAT})
			Result.add_entry (create {EWB_HOMONYMS})
			Result.add_entry (create {EWB_HISTORY})
			Result.add_entry (create {EWB_R_TEXT})
		ensure
			feature_menu_not_void: Result /= Void
		end

	compile_menu: EWB_MENU
			-- Menu options for compilation
		once
			Result := c_menu
		end

	c_menu: EWB_MENU
			-- Menu options for execution
		do
			create Result.make (1,9)
			Result.add_entry (create {EWB_ARGS})
			Result.add_entry (create {EWB_F_COMPILE})
			Result.add_entry (create {EWB_FINALIZE}.make (False))
			Result.add_entry (create {EWB_FREEZE})
			Result.add_entry (create {EWB_COMP})
			Result.add_entry (create {EWB_QUICK_MELT})
			Result.add_entry (create {EWB_DEBUG})
			Result.add_entry (create {EWB_RUN})
			Result.add_entry (create {EWB_W_COMPILE})
		ensure
			c_menu_not_void: Result /= Void
		end

	menu_commands: ARRAYED_LIST [EWB_MENU]
			-- Menu commands
		once
			create Result.make (8)
			Result.force (main_menu)
			Result.force (system_menu)
			Result.force (class_menu)
			Result.force (feature_menu)
			Result.force (compile_menu)
			Result.force (profile_menu)
			Result.force (documentation_menu)
			Result.force (switches_menu)
		ensure
			menu_commands_not_void: menu_commands /= Void
		end

	switches_menu: EWB_MENU
			-- Menu containing output switches
		once
			create Result.make (1, 6)
			Result.set_parent (profile_menu)
			Result.add_entry (create {EWB_NUMBER_OF_CALLS}.make_loop)
			Result.add_entry (create {EWB_FEATURENAME}.make_loop)
			Result.add_entry (create {EWB_TOTAL_SEC})
			Result.add_entry (create {EWB_SELF_SEC})
			Result.add_entry (create {EWB_DESCENDANTS_SEC})
			Result.add_entry (create {EWB_PERCENTAGE})
		ensure
			switches_menu_not_void: Result /= Void
		end

	queries_menu: EWB_MENU
			-- Sub-menu containing commands to manipulate queries.
		once
			create Result.make (1,5)
			Result.set_parent (profile_menu)
			Result.add_entry (create {EWB_ADD_SUBQUERY})
			Result.add_entry (create {EWB_INACTIVATE_SUBQUERY})
			Result.add_entry (create {EWB_REACTIVATE_SUBQUERY})
			Result.add_entry (create {EWB_CHANGE_OPERATOR})
			Result.add_entry (create {EWB_SHOW_SUBQUERIES})
		ensure
			queries_menu_not_void: Result /= Void
		end

feature -- Status report

	executable: BOOLEAN
			-- <Precursor>
		do
				-- No need for a compiled project.
			Result := True
		end

feature -- Execution

	execute
			-- Execute current menu option.
		do
			ewb_iterate
		end

feature -- Update

	save_to_disk
			-- Save last output to file.
		local
			s: STRING_32
			file_w: FILE_WINDOW
			l_name: READABLE_STRING_GENERAL
			done: BOOLEAN
		do
			s := yank_window.stored_output
			if s.is_empty then
				localized_print_error (ewb_names.thers_is_no_output_to_save)
			else
				from
				until
					done
				loop
					if not command_line_io.more_arguments then
						localized_print (ewb_names.arrow_file_name)
						command_line_io.get_name
					end
					command_line_io.get_last_input
					if not command_line_io.last_input.is_empty then
						l_name := command_line_io.last_input
						create file_w.make_with_name (l_name)
						if file_w.exists then
							localized_print (ewb_names.file_already_exists)
						else
							file_w.open_file
							if file_w.exists then
								save_string_in_file (file_w, s)
								file_w.close
								done := True
							else
								localized_print_error (ewb_names.cannot_create_file)
								localized_print_error (l_name)
								io.error.put_new_line
							end
						end
					else
							-- Exit on empty string
						done := True
					end
				end
			end
		end

	get_user_request
			-- Get user request.
		local
			done: BOOLEAN
			rq: STRING
		do
			from
			until
				done
			loop
				localized_print (ewb_names.command_arrow)
				command_line_io.get_name
				command_line_io.get_last_input
				rq := command_line_io.last_input
				if not rq.is_empty then
					rq.to_lower
					process_request (rq)
					if last_request_abb = quit_abb then
						done := True
					elseif last_request_cmd /= Void then
						done := True
					end
				end
			end
		end

	process_request (req: STRING)
			-- Process request `req'.
		local
			next_cmd: EWB_CMD
			menu, option : STRING
			dot_place: INTEGER
			menu_abb : CHARACTER
		do
			last_request_cmd := Void
			if req.has ('.') then
				dot_place := req.index_of ('.', 1)
				debug
					io.put_string ("Req :")
					io.put_string (req)
					io.put_string (": dot place")
					io.put_integer (dot_place)
					io.put_new_line
				end
				menu := req.substring (1,dot_place -1)
				if menu.count = 1 then
					menu_abb := menu.item (1)
				elseif menu.is_empty then
					menu := "M"
					menu_abb := main_abb
			 	end
				option := req.substring (dot_place+1, req.count)
				next_cmd := main_menu.option_item (menu)
				if not attached next_cmd then
					if menu.is_equal (quit_cmd_name) or menu_abb = quit_abb then
						last_request_abb := quit_abb
					elseif menu.is_equal (yank_cmd_name) or menu_abb = yank_abb then
						save_to_disk
					elseif menu.is_equal (help_cmd_name) or menu_abb = help_abb or menu_abb = '?' then
						display_commands
					elseif menu.is_equal (main_cmd_name) or menu_abb = main_abb then
						menu_command_list := main_menu
						if not option.is_empty then
							process_request (option)
						end
					elseif menu.is_equal (parent_cmd_name) or menu_abb = parent_abb then
						if not menu_command_list.is_main then
							menu_command_list := menu_command_list.parent
						end
						if not option.is_empty then
							process_request (option)
						end
					else
						localized_print (ewb_names.unknow_menu (menu))
					end
				elseif attached {EWB_STRING} next_cmd as main_menu_option then
					menu_command_list := main_menu_option.sub_menu
					if not option.is_empty then
						process_request (option)
					end
				end
			else
				next_cmd := menu_command_list.option_item(req)
				if req.count = 1 then
					menu_abb := req.item(1)
				end
				if next_cmd /= Void then
					if attached {EWB_STRING} next_cmd as main_menu_option then
							-- Since {EWB_STRING} are also commands, we execute them before displaying the menu.
						main_menu_option.loop_action
						menu_command_list := main_menu_option.sub_menu
						display_commands
					else
						last_request_cmd := next_cmd
					end
				else
					if req.is_equal (quit_cmd_name) or menu_abb = quit_abb then
						last_request_abb := quit_abb
					elseif req.is_equal (yank_cmd_name) or menu_abb = yank_abb then
						save_to_disk
					elseif req.is_equal (help_cmd_name) or menu_abb = help_abb or menu_abb = '?' then
						display_commands
					elseif req.is_equal (main_cmd_name) or menu_abb = main_abb
					then
						menu_command_list := Main_menu
						display_commands
					elseif req.is_equal (parent_cmd_name) or menu_abb = parent_abb then
						if not menu_command_list.is_main then
							menu_command_list := menu_command_list.parent
						end
						if menu_command_list = Void then
							menu_command_list := main_menu
						end
						display_commands
					else
						localized_print (ewb_names.unknow_option (req))
					end
				end
			end
		end

feature -- Output

	display_header
		do
			localized_print (ewb_names.ise_batch_version (Workbench_name, Version_number))
		end

	display_commands
		do
			menu_command_list.print_help
		end

feature -- Command loop

	ewb_iterate
		local
			done: BOOLEAN
		do
				-- Set the output window to yank_window
			command_line_io.set_output_window (yank_window)
			from
				menu_command_list := menu_commands.first
				display_header
				display_commands
			until
				done
			loop
				get_user_request
				if last_request_abb = quit_abb then
					done := True
				elseif last_request_cmd /= Void then
					yank_window.reset_output
					last_request_cmd.loop_action
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
