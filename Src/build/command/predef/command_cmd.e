

class COMMAND_CMD 

inherit

	PREDEF_CMD_IDENTIFIERS
		export
			{NONE} all
		end;

	PREDEF_CMD
		redefine
			eiffel_inherit_text,
			eiffel_body_text,
			eiffel_creation_text
		end;

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
			Result := - command_cmd_id
		end;

	eiffel_type: STRING is "Cmd";

	make is
		do
			set_symbol (Command_pixmap);
			set_label (eiffel_type);
			predefined_command_table.put (Current, identifier * -1)
		end;

	arguments: EB_LINKED_LIST [ARG] is do !!Result.make end;

	labels: EB_LINKED_LIST [CMD_LABEL] is do !!Result.make end;

	eiffel_inherit_text: STRING is
		local
			temp: STRING;
		do
			!!Result.make (0);
				temp := eiffel_type.duplicate;
				temp.to_upper;
			Result.append (temp);
		end;

	eiffel_body_text: STRING is
		local
			temp: STRING;
		do
			!!Result.make (0);
			Result.append ("%Texecute is%N%T%Tdo%N%T%Tend; -- execute%N%N");
		end;

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is do !!Result.make (0) end;

end
