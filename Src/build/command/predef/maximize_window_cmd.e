indexing
	description: "Represents the predefined command Build_maximize_cmd."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	MAXIMIZE_WINDOW_CMD

inherit
	PREDEF_CMD

creation

	make

feature 

	eiffel_type: STRING is "BUILD_MAXIMIZE_CMD";

	label: STRING is "Maximize";

	identifier: INTEGER is
		do
			Result := - maximize_window_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.perm_wind_type)
			Result.extend (arg)
		end

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make;
			!! lab.make ("maximize window");
			Result.extend (lab);
		end

end -- class MAXIMIZE_WINDOW_CMD
