indexing
	description: "Represents the command Build_reset_to_zero %
				% that reset to zero a scale."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	RESET_TO_ZERO_CMD

inherit

	PREDEF_CMD

creation
	make

feature 

	eiffel_type: STRING is "Build_reset_to_zero"

	label: STRING is
		do
			Result := "Reset to zero"
		end;

	identifier: INTEGER is
		do
			Result := - reset_to_zero_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.scale_type)
			Result.extend (arg)
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make
			!! lab.make ("reset scale")
			Result.extend (lab)
		end


end -- class RESET_TO_ZERO_CMD
