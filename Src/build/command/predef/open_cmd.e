

class OPEN_CMD 

inherit

	PREDEF_CMD

creation

	make

feature 

	eiffel_type: STRING is "Build_open";

	label: STRING is
		do
			Result := "Open"
		end;

	identifier: INTEGER is
		do
			Result := - open_cmd_id
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
			lab: CMD_LABEL;
		once
			!! Result.make;
			!! lab.make ("open");
			Result.extend (lab);
			!! lab.make ("cancel");
			Result.extend (lab);
		end;

end
