

class OPEN_CMD 

inherit

	PREDEF_CMD_IDENTIFIERS
		export
			{NONE} all
		end;

	PREDEF_CMD;

	PIXMAPS
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end


creation

	make

	
feature 

	identifier: INTEGER is
		do
			Result := - open_cmd_id
		end;

	eiffel_type: STRING is "Open";

	make is
		local
			arg: ARG;
			lab: CMD_LABEL;
		do
			!!arguments.make;
			!!labels.make;
			!!lab.make ("open");
			labels.put_right (lab);
			!!lab.make ("cancel");
			labels.add (lab);
			!!arg.session_init (context_catalog.text_type);
			arguments.add (arg);
			set_symbol (File_pixmap);
			set_label (eiffel_type);
			predefined_command_table.put (Current, identifier * -1)
		end;

	arguments: EB_LINKED_LIST [ARG];

	labels: EB_LINKED_LIST [CMD_LABEL];

end
