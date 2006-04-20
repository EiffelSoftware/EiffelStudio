indexing

	description:
		"Batch compiler invoked by the -loop option.%
		%Does not show C compilation options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EWB_LOOP

inherit

	EWB_CMD
		rename
			name as loop_cmd_name,
			help_message as loop_help,
			abbreviation as loop_abb
		end

	EIFFEL_ENV

feature -- Properties

	yank_window: YANK_WINDOW is
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

	main_menu: EWB_MENU is
			-- Main menu options
		local
			i: INTEGER
		once
			i := 2
			if Has_profiler then
				i := i + 1
			end
			if Has_documentation_generation then
				i := i + 3
			end
			create Result.make (1, i)
			Result.set_is_main

			if Has_documentation_generation then
				Result.add_entry (
					create {EWB_STRING}.make (class_cmd_name, class_help, class_abb, class_menu))
			end

			Result.add_entry (
				create {EWB_STRING}.make (compile_cmd_name, compile_help, compile_abb, compile_menu))

			if Has_documentation_generation then
				Result.add_entry (
					create {EWB_STRING}.make (feature_cmd_name, feature_help, feature_abb, feature_menu))
			end

			Result.add_entry (create {EWB_STRING}.make (system_cmd_name, system_help, system_abb, system_menu))
			if has_profiler then
				Result.add_entry (
					create {EWB_STRING}.make (profile_cmd_name, profile_help, profile_abb, profile_menu))
			end
			if has_documentation_generation then
				Result.add_entry (
					create {EWB_STRING}.make (documentation_cmd_name, documentation_help,
						documentation_abb, documentation_menu))
			end
		ensure
			main_menu_not_void: Result /= Void
		end

	Documentation_menu: EWB_MENU is
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

	System_menu: EWB_MENU is
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

	profile_menu: EWB_MENU is
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

	class_menu: EWB_MENU is
			-- Class menu options
		once
			create Result.make (1, 17)
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
		ensure
			class_menu_not_void: Result /= Void
		end

	feature_menu: EWB_MENU is
			-- Feature menu options
		once
			create Result.make (1, 7)
			Result.set_parent (Main_menu)
			Result.add_entry (create {EWB_PAST})
			Result.add_entry (create {EWB_SENDERS})
			Result.add_entry (create {EWB_FUTURE})
			Result.add_entry (create {EWB_R_FLAT})
			Result.add_entry (create {EWB_HOMONYMS})
			Result.add_entry (create {EWB_HISTORY})
			Result.add_entry (create {EWB_R_TEXT})
		ensure
			feature_menu_not_void: Result /= Void
		end

	compile_menu: EWB_MENU is
			-- Menu options for compilation
		once
			Result := c_menu
		end

	c_menu: EWB_MENU is
			-- Menu options for c compilations
		do
			create Result.make (1,8)
			Result.add_entry (create {EWB_ARGS})
			Result.add_entry (create {EWB_F_COMPILE})
			Result.add_entry (create {EWB_FINALIZE}.make (False))
			Result.add_entry (create {EWB_FREEZE})
			Result.add_entry (create {EWB_COMP})
			Result.add_entry (create {EWB_QUICK_MELT})
			Result.add_entry (create {EWB_RUN})
			Result.add_entry (create {EWB_W_COMPILE})
		ensure
			c_menu_not_void: Result /= Void
		end

	menu_commands: ARRAY [EWB_MENU] is
			-- Menu commands
		local
			i: INTEGER
		once
			i := 5
			if Has_profiler then
				i := i + 2
			end
			if Has_documentation_generation then
				i := i + 1
			end
			create Result.make (1, i)
			Result.put (main_menu, 1)
			Result.put (system_menu, 2)
			Result.put (class_menu, 3)
			Result.put (feature_menu, 4)
			Result.put (compile_menu, 5)
			i := 6
			if Has_profiler then
				Result.put (profile_menu, i)
				i := i + 1
			end
			if Has_documentation_generation then
				Result.put (documentation_menu, i)
				i := i + 1
			end
			if Has_profiler then
				Result.put (switches_menu, i)
				i := i + 1
			end
		ensure
			menu_commands_not_void: menu_commands /= Void
		end

	switches_menu: EWB_MENU is
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

	queries_menu: EWB_MENU is
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

feature -- Execution

	execute is
			-- Execute current menu option.
		require else
			no_need_for_compiled_project: True
		do
				--| At this stage we have the project directory
			if Eiffel_project.project_directory.project_epr_file = Void then
				-- The user will have to specify the Ace file
				-- since it is a new project
				Eiffel_ace.set_file_name (Void)
			end
			ewb_iterate
		end

feature -- Update

	save_to_disk is
			-- Save last output to file.
		local
			s: STRING
			file_w: FILE_WINDOW
			done: BOOLEAN
		do
			s := yank_window.stored_output
			if s.is_empty then
				io.error.put_string ("There is no output to save.%N")
			else
				from
				until
					done
				loop
					if not command_line_io.more_arguments then
						io.put_string ("--> File name: ")
						command_line_io.get_name
					end
					command_line_io.get_last_input
					if not command_line_io.last_input.is_empty then
						create file_w.make (command_line_io.last_input)
						if file_w.exists then
							io.put_string ("File already exists.%N")
						else
							file_w.open_file
							if file_w.exists then
								file_w.put_string (s)
								file_w.close
								done := True
							else
								io.error.put_string ("Cannot create file: ")
								io.error.put_string (file_w.name)
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

	get_user_request is
			-- Get user request.
		local
			done: BOOLEAN
			rq: STRING
		do
			from
			until
				done
			loop
				io.put_string ("Command => ")
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

	process_request (req: STRING) is
			-- Process request `req'.
		local
			next_cmd: EWB_CMD
			menu, option : STRING
			dot_place: INTEGER
			main_menu_option: EWB_STRING
			menu_abb : CHARACTER
			prev: like menu_command_list
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
				if next_cmd /= Void then
					prev := menu_command_list
					main_menu_option ?= next_cmd
					menu_command_list := main_menu_option.sub_menu
					if not option.is_empty then
						process_request (option)
					end
				else
					if menu.is_equal (quit_cmd_name) or menu_abb = quit_abb then
						last_request_abb := quit_abb
					elseif menu.is_equal (yank_cmd_name) or menu_abb = yank_abb then
						save_to_disk
					elseif menu.is_equal (help_cmd_name) or menu_abb = help_abb or menu_abb = '?' then
						display_commands
					elseif menu.is_equal (main_cmd_name) or menu_abb = main_abb then
						prev := menu_command_list
						menu_command_list := main_menu
						if not option.is_empty then
							process_request (option)
						end
					elseif menu.is_equal (parent_cmd_name) or menu_abb = parent_abb then
						if not menu_command_list.is_main then
							prev := menu_command_list
							menu_command_list := menu_command_list.parent
						end
						if not option.is_empty then
							process_request (option)
						end
					else
						io.put_string ("Unknown menu ")
						io.put_string (menu)
						io.put_string (".%N")
					end
				end
			else
				next_cmd := menu_command_list.option_item(req)
				if req.count = 1 then
					menu_abb := req.item(1)
				end
				if next_cmd /= Void then
					main_menu_option ?= next_cmd
					if main_menu_option /= Void then
						prev := menu_command_list
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
						prev := menu_command_list
						menu_command_list := Main_menu
						display_commands
					elseif req.is_equal (parent_cmd_name) or menu_abb = parent_abb then
						if not menu_command_list.is_main then
							prev := menu_command_list
							menu_command_list := menu_command_list.parent
						end
						if menu_command_list = Void then
							menu_command_list := main_menu
						end
						display_commands
					else
						io.put_string ("Unknown option ")
						io.put_string (req)
						io.put_string (".%N")
					end
				end
			end
		end

feature -- Output

	display_header is
		do
			io.put_string ("==== ISE " + Workbench_name + " - Interactive Batch Version (v")
			io.put_string (Version_number)
			io.put_string (") ====%N%N")
		end

	display_commands is
		do
			menu_command_list.print_help
		end

feature -- Command loop

	ewb_iterate is
		local
			done: BOOLEAN
		do
				-- Set the output window to yank_window
			set_output_window (yank_window)
			from
				if menu_commands = Void then end
				menu_command_list := menu_commands.item (1)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EWB_LOOP
