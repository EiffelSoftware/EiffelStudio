
class BASIC_EWB_LOOP

inherit

	EWB_CMD
		rename
			name as loop_cmd_name,
			help_message as loop_help
		end;

feature

	loop_execute is do end;

	execute is
		do
			init_project;
			if not error_occurred then
				if project_is_new then
					make_new_project
				else
					retrieve_project
				end
			end;
			if not error_occurred then
				ewb_iterate				
			end;
		end;

feature -- Initialization

	command_list: SORTED_TWO_WAY_LIST [EWB_CMD] is
		once
			!!Result.make
		end;

	commands: EXTEND_TABLE [EWB_CMD, STRING] is
		local
			ewb_cmd: EWB_CMD;
		once
			!! Result.make (14);

			!EWB_COMP! ewb_cmd;
			add_cmd (ewb_cmd);

			add_special_cmds;

			!EWB_ANCESTORS! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_CLIENTS! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_DESCENDANTS! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_FLAT! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_FS! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_FUTURE! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_HISTORY! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_PAST! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_SENDERS! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_SHORT! ewb_cmd.null;
			add_cmd (ewb_cmd);

			!EWB_SUPPLIERS! ewb_cmd.null;
			add_cmd (ewb_cmd);
		end;

	add_special_cmds is
		do
		end;

	add_cmd (a_cmd: EWB_CMD) is
		do
			commands.put (a_cmd, a_cmd.name);
			command_list.add (a_cmd);
		end;

	display_commands is
		local
			cmd: EWB_CMD
		do
-- FIXME

-- ADD -keep for finalize


			io.putstring ("==== ISE Eiffel3 - Interactive Batch Version (v");
			io.putstring (Version_number);
			io.putstring (") ====%N%N");
			from
				command_list.start
			until
				command_list.after
			loop
				cmd := command_list.item;
				print_one_help (cmd.name, cmd.help_message);
				command_list.forth
			end;
			io.new_line;
			print_one_help (loop_help_cmd_name, loop_help_help);
			print_one_help (quit_cmd_name, quit_help);
			io.neW_line;
		end;

	print_one_help (opt: STRING; txt: STRING) is
		do
			io.putchar ('%T');
			io.putstring (opt);
			io.putstring (": ");
			io.putstring (txt);
			io.putstring (".%N")
		end;

	last_request: STRING;

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
				if last_input.empty then
					done := False
				elseif commands.has (last_input) then
					last_request := last_input;
					done := True;
				elseif
					(last_input.is_equal (quit_cmd_name) or else
						((last_input.count = 1) and then
						 (last_input.item (1) = 'q')))
				then
					last_request := quit_cmd_name;
					done := True
				elseif
					(last_input.is_equal (loop_help_cmd_name) or else
						((last_input.count = 1) and then
						 (last_input.item (1) = 'h')))
				then
					last_request := loop_help_cmd_name;
					done := True
				else
					done := False;
					io.putstring ("Invalid command%N");
				end;
			end;
		end;

feature -- Command loop

	ewb_iterate is
		local
			done: BOOLEAN;
			cmd: EWB_CMD
		do
			from
				if commands = Void then end;
				display_commands
			until
				done
			loop
				get_user_request;
				if
					last_request.is_equal (quit_cmd_name)
				then
					done := True;
				elseif
					last_request.is_equal (loop_help_cmd_name)
				then
					display_commands
				else
					cmd := commands.item (last_request);
					if cmd /= Void then
						cmd.loop_execute;
					end;
				end;
			end;
		end;

end
