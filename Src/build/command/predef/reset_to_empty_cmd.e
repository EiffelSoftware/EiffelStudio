indexing
	description: "Represents the command Build_reset_to_empty %
				% that clears a text field."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	RESET_TO_EMPTY_CMD

inherit

	PREDEF_CMD

creation
	make

feature 

	eiffel_type: STRING is "BUILD_RESET_TO_EMPTY"

	label: STRING is
		do
			Result := "Reset to empty"
		end;

	identifier: INTEGER is
		do
			Result := - reset_to_empty_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.text_field_type)
			Result.extend (arg)
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make
			!! lab.make ("reset to empty")
			Result.extend (lab)
		end

end -- class RESET_TO_EMPTY_CMD
