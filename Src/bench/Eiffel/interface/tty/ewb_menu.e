class EWB_MENU

inherit

	ARRAY [EWB_CMD];
	SHARED_EWB_HELP
		undefine twin end;
	SHARED_EWB_CMD_NAMES
		undefine twin end;
	SHARED_EWB_ABBREV
		undefine twin end;

creation

	make

feature

	is_main: BOOLEAN;

	add_entry (cmd: EWB_CMD) is
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper or else item (i) = Void
			loop
				i := i + 1
			end;
			put (cmd, i)
		end;

	abbrev_item (abb: CHARACTER): EWB_CMD is
		local
			i: INTEGER
			cmd: EWB_CMD
		do
			from
				i := lower
			until
				i > upper or else Result /= Void
			loop
				cmd := item (i);
				if cmd.abbreviation = abb then
					Result := cmd
				else
					i := i + 1
				end;
			end;
		end;

	cmd_name_item (cmd_name: STRING): EWB_CMD is
		local
			i: INTEGER
			cmd: EWB_CMD
			s : STRING
		do
			from
				s := clone (cmd_name)
				s.to_lower
				i := lower
			until
				i > upper or else Result /= Void
			loop
				cmd := item (i);
				if cmd.name.is_equal (s) then
					Result := cmd
				else
					i := i + 1
				end;
			end;
		end;

	option_item (cmd_name: STRING): EWB_CMD is
		do
			if cmd_name.count = 1 then
				Result := abbrev_item (cmd_name.item(1).lower)
			else
				Result := cmd_name_item (cmd_name)
			end
		end

	set_is_main is
		do
			is_main := True
		end;

	print_help is
		local
			cmd: EWB_CMD
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				cmd := item (i);
				print_one_help (cmd.name, cmd.help_message, cmd.abbreviation);
				i := i + 1
			end;
			io.new_line;
			print_one_help (loop_help_cmd_name, loop_help_help, help_abb);
			if not is_main then
				print_one_help (main_cmd_name, main_help, main_abb);
			end;
			print_one_help (quit_cmd_name, quit_help, quit_abb);
			print_one_help (yank_cmd_name, yank_help, yank_abb);
			io.new_line;
		end;

	print_one_help (opt: STRING; txt: STRING; abb: CHARACTER) is
		local
			i: INTEGER;
			s: STRING;
		do
				-- First letter in upper case
			s := opt.duplicate;
			s.put (s.item (1).upper, 1);

			io.putstring ("%T(");
			io.putchar (abb.upper);
			io.putstring (") ");
			io.putstring (s);
			from
				i := s.count+1
			until
				i > 13
			loop
				io.putchar (' ')
				i := i + 1;
			end;
			io.putstring (": ");
			io.putstring (txt);
			io.putstring (".%N")
		end;

	trace is
		do
			print_help
		end

end
