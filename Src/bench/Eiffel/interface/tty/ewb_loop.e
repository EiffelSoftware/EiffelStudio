indexing

	description: 
		"Batch compiler from invoking the -loop. Displays%
		%C compilation options.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_LOOP

inherit

	BASIC_EWB_LOOP
		redefine
			c_menu
		end

feature -- Properties

	c_menu: EWB_MENU is
		local
			ewb_cmd: EWB_CMD
		do
			!!Result.make (1,8)

			!EWB_ARGS! ewb_cmd;
			Result.add_entry (ewb_cmd);
			!EWB_F_COMPILE! ewb_cmd;
			Result.add_entry (ewb_cmd)
			!EWB_FINALIZE! ewb_cmd.make (False);
			Result.add_entry (ewb_cmd)
			!EWB_FREEZE! ewb_cmd;
			Result.add_entry (ewb_cmd)
			!EWB_COMP! ewb_cmd;
			Result.add_entry (ewb_cmd)
			!EWB_QUICK_MELT! ewb_cmd;
			Result.add_entry (ewb_cmd)
			!EWB_RUN! ewb_cmd;
			Result.add_entry (ewb_cmd);
			!EWB_W_COMPILE! ewb_cmd;
			Result.add_entry (ewb_cmd);
		end

end -- class EWB_LOOP
