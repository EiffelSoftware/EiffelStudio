

class POPDOWN_CMD 

inherit

	PREDEF_CMD_IDENTIFIERS;
	PREDEF_CMD;
	WINDOWS

creation

	make

	
feature 

	identifier: INTEGER is
		do
			Result := - popdown_cmd_id
		end;

	eiffel_type: STRING is "Popdown_cmd";

	make is
		local
			arg: ARG;
			lab: CMD_LABEL
		do
			!!arguments.make;
			!!labels.make;
			!!lab.make ("popdown");
			labels.extend (lab);
			!!arg.session_init (context_catalog.temp_wind_type);
			arguments.extend (arg);
			set_symbol (Pixmaps.windows_pixmap);
			set_label (eiffel_type);
			predefined_command_table.put (Current, identifier * -1)
		end;

	arguments: EB_LINKED_LIST [ARG];

	labels: EB_LINKED_LIST [CMD_LABEL];

end
