

class UNDOABLE_CMD 

inherit

	PREDEF_CMD_IDENTIFIERS;
	PREDEF_CMD
		redefine
			eiffel_inherit_text,
			eiffel_body_text,
			eiffel_creation_text
		end;
	WINDOWS

creation

	make

	
feature 

	identifier: INTEGER is
		do
			Result := - undoable_cmd_id
		end;

	eiffel_type: STRING is "Undoable_cmd";

	make is
		do
			set_symbol (Pixmaps.command_pixmap);
			set_label (eiffel_type);
			predefined_command_table.put (Current, identifier * -1)
		end;

	arguments: EB_LINKED_LIST [ARG] is do !!Result.make end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		do 
			!!Result.make;
		end;

	eiffel_inherit_text (rl: LINKED_LIST [STRING]): STRING is
		local
			temp: STRING;
		do
			!!Result.make (0);
				temp := clone (eiffel_type);
				temp.to_upper;
			Result.append (temp);
		end;

	eiffel_body_text: STRING is
		local
			temp: STRING;
		do
			!!Result.make (0);
			Result.append ("%Texecute is%N%T%Tdo%N%T%Tend; -- execute%N%N");
			Result.append ("%Tundo is%N%T%Tdo%N%T%Tend; -- undo%N%N");
			Result.append ("%Tredo is%N%T%Tdo%N%T%Tend; -- redo%N%N");
		end;

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is do !!Result.make (0) end;

end
