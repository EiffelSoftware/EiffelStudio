indexing

	description: 
		"Batch compiler invoked by the -loop option.%
		%Does not show C compilation options."
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
		
	COMMAND_LINE_PROJECT
		undefine
			Warning_messages
		end

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
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 6)
			Result.set_is_main

			create {EWB_STRING} ewb_cmd.make (class_cmd_name, class_help, class_abb, class_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_STRING} ewb_cmd.make (compile_cmd_name, compile_help, compile_abb, compile_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_STRING} ewb_cmd.make (feature_cmd_name, feature_help, feature_abb, feature_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_STRING} ewb_cmd.make (system_cmd_name, system_help, system_abb, system_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_STRING} ewb_cmd.make (profile_cmd_name, profile_help, profile_abb, profile_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_STRING} ewb_cmd.make (documentation_cmd_name, documentation_help, documentation_abb, documentation_menu)
			Result.add_entry (ewb_cmd)
		end

	Documentation_menu: EWB_MENU is
			-- Documentation menu options
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 4)

			create {EWB_DOCUMENTATION} ewb_cmd.make_flat_short (Void, false)
			Result.add_entry (ewb_cmd)
			create {EWB_DOCUMENTATION} ewb_cmd.make_short (Void, false)
			Result.add_entry (ewb_cmd)
			create {EWB_DOCUMENTATION} ewb_cmd.make_flat (Void, false)
			Result.add_entry (ewb_cmd)
			create {EWB_DOCUMENTATION} ewb_cmd.make_text (Void)
			Result.add_entry (ewb_cmd)
		end

	System_menu: EWB_MENU is
			-- System menu options
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 8)
			Result.set_parent (Main_menu)

			create {EWB_ACE} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_CLASS_LIST} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_CLUSTER_HIERARCHY} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_CLUSTERS} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_EDIT_ACE} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_INDEXING} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_MODIFIED} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_STATISTICS} ewb_cmd
			Result.add_entry (ewb_cmd)
		end

	profile_menu: EWB_MENU is
			-- Profile menu options.
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 7)
			Result.set_parent (Main_menu)

			create {EWB_SWITCHES_CMD} ewb_cmd.make_without_help (switches_cmd_name, switches_abb, switches_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_STRING} ewb_cmd.make (queries_cmd_name, queries_help, queries_abb, queries_menu)
			Result.add_entry (ewb_cmd)
			create {EWB_INPUT} ewb_cmd.make_loop
			Result.add_entry (ewb_cmd)
			create {EWB_LANGUAGE} ewb_cmd.make_loop
			Result.add_entry (ewb_cmd)
			create {EWB_RUN_PROF} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_GENERATE} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_DEFAULTS} ewb_cmd.make_loop (Current)
			Result.add_entry (ewb_cmd)
		end

	class_menu: EWB_MENU is
			-- Class menu options
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 15)
			Result.set_parent (Main_menu)

			create {EWB_ANCESTORS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_ATTRIBUTES} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_CLIENTS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_DEFERRED} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_DESCENDANTS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_EDIT_CLASS} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_EXPORTED} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_EXTERNALS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_FLAT} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_FS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_ONCE} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_ROUTINES} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_SHORT} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_SUPPLIERS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_TEXT} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
		end

	feature_menu: EWB_MENU is
			-- Feature menu options
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 7)
			Result.set_parent (Main_menu)
			create {EWB_PAST} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_SENDERS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_FUTURE} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_R_FLAT} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_HOMONYMS} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_HISTORY} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
			create {EWB_R_TEXT} ewb_cmd.do_nothing
			Result.add_entry (ewb_cmd)
		end

	compile_menu: EWB_MENU is
			-- Menu options for compilation
		once
			Result := c_menu
		end

	c_menu: EWB_MENU is
			-- Menu options for c compilations
		local
			ewb_cmd: EWB_CMD
		do
			create Result.make (1,8)

			create {EWB_ARGS} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_F_COMPILE} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_FINALIZE} ewb_cmd.make (False)
			Result.add_entry (ewb_cmd)
			create {EWB_FREEZE} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_COMP} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_QUICK_MELT} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_RUN} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_W_COMPILE} ewb_cmd
			Result.add_entry (ewb_cmd)
		end

	menu_commands: ARRAY [EWB_MENU] is
			-- Menu commands
		once
			create Result.make (1, 8)
			Result.put (main_menu, 1)
			Result.put (system_menu, 2)
			Result.put (class_menu, 3)
			Result.put (feature_menu, 4)
			Result.put (compile_menu, 5)
			Result.put (profile_menu, 6)
			Result.put (documentation_menu, 7)
			Result.put (switches_menu, 8)
		end

	switches_menu: EWB_MENU is
			-- Menu containing output switches
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1, 6)
			Result.set_parent (profile_menu)

			create {EWB_NUMBER_OF_CALLS} ewb_cmd.make_loop
			Result.add_entry (ewb_cmd)
			create {EWB_FEATURENAME} ewb_cmd.make_loop
			Result.add_entry (ewb_cmd)
			create {EWB_TOTAL_SEC} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_SELF_SEC} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_DESCENDANTS_SEC} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_PERCENTAGE} ewb_cmd
			Result.add_entry (ewb_cmd)
		end
			
	queries_menu: EWB_MENU is
			-- Sub-menu containing commands to manipulate queries.
		local
			ewb_cmd: EWB_CMD
		once
			create Result.make (1,5)
			Result.set_parent (profile_menu)

			create {EWB_ADD_SUBQUERY} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_INACTIVATE_SUBQUERY} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_REACTIVATE_SUBQUERY} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_CHANGE_OPERATOR} ewb_cmd
			Result.add_entry (ewb_cmd)
			create {EWB_SHOW_SUBQUERIES} ewb_cmd
			Result.add_entry (ewb_cmd)
		end

feature -- Execution

	execute is
			-- Execute current menu option.
		do
				--| At this stage we have the project directory
			if Eiffel_project.project_directory.project_eif_file = Void then
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
				io.error.putstring ("There is no output to save.%N")
			else
				from
				until
					done
				loop
					if not command_line_io.more_arguments then
						io.putstring ("--> File name: ")
						command_line_io.get_name
					end
					command_line_io.get_last_input
					if not command_line_io.last_input.is_empty then
						create file_w.make (command_line_io.last_input)
						if file_w.exists then
							io.putstring ("File already exists.%N")
						else
							file_w.open_file
							if file_w.exists then
								file_w.put_string (s)
								file_w.close
								done := True
							else
								io.error.putstring ("Cannot create file: ")
								io.error.putstring (file_w.name)
								io.error.new_line
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
				io.putstring ("Command => ")
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
					io.putstring ("Req :")
					io.putstring (req)
					io.putstring (": dot place")
					io.putint (dot_place)
					io.new_line
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
						io.putstring ("Unknown menu ")
						io.putstring (menu)
						io.putstring (".%N")
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
						io.putstring ("Unknown option ")
						io.putstring (req)
						io.putstring (".%N")
					end
				end		
			end
		end

feature -- Output

	display_header is
		do
			io.putstring ("==== ISE " + Workbench_name + " - Interactive Batch Version (v")
			io.putstring (Version_number)
			io.putstring (") ====%N%N")
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
					if license.alive then
						yank_window.reset_output
						last_request_cmd.loop_action
					else
						io.putstring ("You have lost your license.%N")
					end
				end
			end
		end

end -- class EWB_LOOP
