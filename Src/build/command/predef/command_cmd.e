

class COMMAND_CMD 

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

	eiffel_type: STRING is "CMD";

	label: STRING is
		do
			Result := "Cmd"
		end;

	identifier: INTEGER is
		do
			Result := - command_cmd_id
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
		end;

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is 
		do 
			!!Result.make (0) 
		end;

end
