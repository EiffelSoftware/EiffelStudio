indexing
	description: "Represents the predefined command Build_minimize_cmd."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	MINIMIZE_WINDOW_CMD

inherit
	PREDEF_CMD

creation

	make

feature 

	eiffel_type: STRING is "BUILD_MINIMIZE_CMD";

	label: STRING is "Minimize";

	identifier: INTEGER is
		do
			Result := - minimize_window_cmd_id
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
			!! lab.make ("minimize window");
			Result.extend (lab);
		end

end -- class MINIMIZE_WINDOW_CMD
