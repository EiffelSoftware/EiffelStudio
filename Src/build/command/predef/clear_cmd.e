indexing
	description: "Represents the command Build_clear that clears a drawing box."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	CLEAR_CMD

inherit

	PREDEF_CMD

creation
	make

feature 

	eiffel_type: STRING is "BUILD_CLEAR"

	label: STRING is
		do
			Result := "Clear"
		end;

	identifier: INTEGER is
		do
			Result := - clear_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.drawing_area_type)
			Result.extend (arg)
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make
			!! lab.make ("clear")
			Result.extend (lab)
		end


end -- class CLEAR_CMD
