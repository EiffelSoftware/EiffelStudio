indexing
	description: "Represents the command Build_new that clears a scrolled text."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	NEW_CMD
inherit

	PREDEF_CMD

creation
	make

feature 

	eiffel_type: STRING is "BUILD_NEW"

	label: STRING is
		do
			Result := "New"
		end;

	identifier: INTEGER is
		do
			Result := - new_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.text_type)
			Result.extend (arg)
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make
			!! lab.make ("new file")
			Result.extend (lab)
		end

end -- class NEW_CMD
