class EWB_LOOP

inherit

	BASIC_EWB_LOOP
		redefine
			c_menu
		end

feature

	c_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD
		do
			!!Result.make (1,4)

			!EWB_FINALIZE! ewb_cmd.make (False);
			Result.add_entry (ewb_cmd)

			!EWB_FREEZE! ewb_cmd;
			Result.add_entry (ewb_cmd)

			!EWB_COMP! ewb_cmd;
			Result.add_entry (ewb_cmd)

			!EWB_RUN! ewb_cmd;
			Result.add_entry  (ewb_cmd);
		end

end
