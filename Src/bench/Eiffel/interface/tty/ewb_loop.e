class EWB_LOOP

inherit

	BASIC_EWB_LOOP
		redefine
			add_special_cmds
		end

feature

	add_special_cmds is
		local
			ewb_cmd: EWB_CMD
		do
			!EWB_FREEZE! ewb_cmd;
			add_cmd (ewb_cmd);

			!EWB_FINALIZE! ewb_cmd.make (False);
			add_cmd (ewb_cmd);
		end

end
