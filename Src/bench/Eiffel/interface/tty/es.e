class ES

inherit

	BASIC_ES
		redefine
			add_usage_special_cmds, add_help_special_cmds,
			loop_cmd, is_precompiled_option,
			process_special_options
		end

creation

	make

feature

	add_usage_special_cmds is
		do
			io.putstring ("-freeze|-finalize [-keep]|-precompile|%N%T");
		end;

	add_help_special_cmds is
		do
			help_messages.put (freeze_help, freeze_cmd_name);
			help_messages.put (precompile_help, precompile_cmd_name);
			help_messages.put (finalize_help, finalize_cmd_name);
		end;

	loop_cmd: BASIC_EWB_LOOP is
		do
			!EWB_LOOP!Result
		end;

	is_precompiled_option: BOOLEAN is
		do
			Result := option.is_equal ("-precompile")
		end;

	process_special_options is
		local
			keep: BOOLEAN
		do
			if option.is_equal ("-freeze") then
				if command /= Void then
					option_error := True
				else
					!EWB_FREEZE!command
				end
			elseif option.is_equal ("-finalize") then
				if command /= Void then
					option_error := True
				else
					if current_option < (argument_count - 1) then
						if argument (current_option + 1).is_equal ("-keep") then
							current_option := current_option + 1;
							keep := True;
						end;
					end;
					!EWB_FINALIZE!command.make (keep);
				end
			else
				option_error := True
			end;
		end;

end
