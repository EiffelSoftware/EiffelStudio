
class BASIC_EWB_LOOP

inherit

	EWB_CMD
		rename
			name as loop_cmd_name,
			help_message as loop_help,
			abbreviation as loop_abb
		end;

feature

	execute is
		do
			init_project;
			if not error_occurred then
				if project_is_new then
					make_new_project;
						-- The user will have to specify the Ace file
					Lace.set_file_name (Void);
				else
					retrieve_project
				end
			end;
			if not error_occurred then
				ewb_iterate				
			end;
		end;

feature -- Initialization

	command_list: EWB_MENU;

	main_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD;
		once
			!!Result.make (1, 4);
			Result.set_is_main;

			!EWB_STRING! ewb_cmd.make (class_cmd_name, class_help, class_abb, class_menu);
			Result.add_entry (ewb_cmd)
	
			!EWB_STRING! ewb_cmd.make (compile_cmd_name, compile_help, compile_abb, compile_menu);
			Result.add_entry (ewb_cmd)
	
			!EWB_STRING! ewb_cmd.make (feature_cmd_name, feature_help, feature_abb, feature_menu);
			Result.add_entry (ewb_cmd)
	
			!EWB_STRING! ewb_cmd.make (system_cmd_name, system_help, system_abb, system_menu);
			Result.add_entry (ewb_cmd)
		end;

	System_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD;
		once
			!!Result.make (1, 3)

			!EWB_ACE! ewb_cmd;
			Result.add_entry (ewb_cmd)
			
			!EWB_CLUSTERS! ewb_cmd;
			Result.add_entry (ewb_cmd)

			!EWB_EDIT_ACE! ewb_cmd;
			Result.add_entry (ewb_cmd)
		end;

	class_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD;
		once
			!!Result.make (1, 14)
			
			!EWB_ANCESTORS! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_ATTRIBUTES! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_CLIENTS! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_DEFERRED! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_DESCENDANTS! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_EDIT_CLASS! ewb_cmd;
			Result.add_entry (ewb_cmd)

			!EWB_EXTERNALS! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_FLAT! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_FS! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_ONCE! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_ROUTINES! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_SHORT! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_SUPPLIERS! ewb_cmd.null;
			Result.add_entry (ewb_cmd)

			!EWB_TEXT! ewb_cmd.null;
			Result.add_entry (ewb_cmd)
		end;

	feature_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD;
		once
			!!Result.make (1, 6)

			!EWB_PAST! ewb_cmd.null;
			Result.add_entry  (ewb_cmd);

			!EWB_SENDERS! ewb_cmd.null;
			Result.add_entry  (ewb_cmd);

			!EWB_FUTURE! ewb_cmd.null;
			Result.add_entry  (ewb_cmd);

			!EWB_R_FLAT! ewb_cmd.null;
			Result.add_entry  (ewb_cmd);

			!EWB_HISTORY! ewb_cmd.null;
			Result.add_entry  (ewb_cmd);

			!EWB_R_TEXT! ewb_cmd.null;
			Result.add_entry  (ewb_cmd);
		end;

	compile_menu: EWB_MENU is
		once
			Result := c_menu
		end;

	c_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD;
		do
			!!Result.make (1, 2);

			!EWB_COMP! ewb_cmd;
			Result.add_entry  (ewb_cmd);

			!EWB_RUN! ewb_cmd;
			Result.add_entry  (ewb_cmd);
		end;

	commands: ARRAY [EWB_MENU] is
		once
			!!Result.make (1, 5);
	
			Result.put (main_menu, 1);

			Result.put (system_menu, 2);

			Result.put (class_menu, 3)

			Result.put (feature_menu, 4);

			Result.put (compile_menu, 5);
		end

	display_header is
		do
			io.putstring ("==== ISE Eiffel3 - Interactive Batch Version (v");
			io.putstring (Version_number);
			io.putstring (") ====%N%N");
		end;

	display_commands is
		do
			command_list.print_help
		end;

	save_to_disk is
		local
			s: STRING;
			file_w: FILE_WINDOW;
			done: BOOLEAN;
		do
			s := yank_window.stored_output;
			if s.empty then
				io.error.putstring ("There is no output to save.%N");
			else
				from
				until
					done
				loop
					if no_more_arguments then
						io.putstring ("--> File name: ");
						get_name;
					end;
					get_last_input;
					if not last_input.empty then
						!!file_w.make (last_input);
						if file_w.exists then
							io.putstring ("File already exists.%N");
						else
							file_w.open_file;
							if file_w.exists then
								file_w.put_string (s);
								file_w.close;
								done := True
							end;
						end;
					else
							-- Exit on empty string
						done := True;
					end;
				end;
			end;
		end;

	last_request_abb: CHARACTER;

	last_request_cmd: EWB_CMD;

	get_user_request is
		local
			done: BOOLEAN
		do
			from
			until
				done
			loop
				io.putstring ("Command => ");
				get_name;
				get_last_input;
				if last_input.empty then
					-- do nothing
				else
					last_input.to_lower;
					process_request (last_input)
					if last_request_abb = quit_abb then
						done := True;
					elseif last_request_cmd /= Void then
						done := True;
					end;
				end;
			end;
		end;

	prev: EWB_MENU;

	process_request (req: STRING) is
		local
			next_cmd: EWB_CMD;
			menu, option : STRING
			dot_place: INTEGER
			main_menu_option : EWB_STRING
			menu_abb : CHARACTER
		
		do
			last_request_cmd := Void
			if req.has ('.') then
				dot_place := req.search_character ('.', 1)
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
				elseif menu.empty then
					menu := "M"
					menu_abb := main_abb	
			 	end
				option := req.substring (dot_place+1, req.count)
				next_cmd := main_menu.option_item (menu)
				if next_cmd /= Void
				then
					prev := command_list
					main_menu_option ?= next_cmd
					command_list := main_menu_option.sub_menu
					if not option.empty then
						process_request (option)
					end
				else
					if menu.is_equal (quit_cmd_name) or menu_abb = quit_abb then
						last_request_abb := quit_abb
					elseif menu.is_equal (yank_cmd_name) or menu_abb = yank_abb then
						save_to_disk;
					elseif menu.is_equal (help_cmd_name) or menu_abb = help_abb or menu_abb = '?' then
						display_commands;
					elseif menu.is_equal (main_cmd_name) or menu_abb = main_abb then
						prev := command_list
						command_list := main_menu
						if not option.empty then
							process_request (option)
						end					
					else
						io.putstring ("Unknown menu ")
						io.putstring (menu)
						io.putstring (".%N")
					end
				end
			else
				next_cmd := command_list.option_item(req)
				if req.count = 1 then
					menu_abb := req.item(1)
				end
				if next_cmd /= Void then
					if command_list = Main_menu then
						prev := command_list
						main_menu_option ?= next_cmd
						command_list := main_menu_option.sub_menu
						display_commands
					else
						last_request_cmd := next_cmd
					end
				else
					if req.is_equal (quit_cmd_name) or menu_abb = quit_abb then
						last_request_abb := quit_abb
					elseif req.is_equal (yank_cmd_name) or menu_abb = yank_abb then
						save_to_disk;
					elseif req.is_equal (help_cmd_name) or menu_abb = help_abb or menu_abb = '?' then
						display_commands;
					elseif req.is_equal (main_cmd_name) or menu_abb = main_abb 
					then
						prev := command_list
						command_list := Main_menu
						display_commands
					else
						io.putstring ("Unknown option ")
						io.putstring (req)
						io.putstring (".%N")
					end
				end		
			end
		end

feature -- Command loop

	ewb_iterate is
		local
			done: BOOLEAN;
			cmd: EWB_CMD
		do
			from
				if commands = Void then end;
				command_list := commands.item (1)
				display_header
				display_commands
			until
				done
			loop
				get_user_request;
				if last_request_abb = quit_abb then
					done := True;
				elseif last_request_cmd /= Void then
					licence.alive;
					if
						licence.is_alive
					or else successfull_reconnection then
						yank_window.reset_output;
						last_request_cmd.set_output_window (yank_window);
						last_request_cmd.loop_execute;
					else
						io.putstring ("You have lost your licence.%N");
					end;
				end;
			end;
		end;

	successfull_reconnection: BOOLEAN is
		do
			licence.register;
			if licence.registered then
				licence.open_licence;
				if licence.licenced then
					licence.alive;
					Result := licence.is_alive
				end;
			end;
		end;

end
