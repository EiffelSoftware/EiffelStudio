

class UNDOABLE_CMD 

inherit

	PREDEF_CMD
		redefine
			eiffel_inherit_text,
			eiffel_body_text,
			eiffel_creation_text
		end

creation

	make

feature 

	eiffel_type: STRING is "BUILD_UNDOABLE_CMD";

	label: STRING is "Undoable Command";

	identifier: INTEGER is
		do
			Result := - undoable_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is 
		once 
			!! Result.make 
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		once
			!!Result.make;
		end;

	eiffel_inherit_text: STRING is
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

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is 
		do 
			!!Result.make (0) 
		end;

end
