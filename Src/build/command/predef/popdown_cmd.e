

class POPDOWN_CMD 

inherit

	PREDEF_CMD

creation

	make

feature 

	eiffel_type: STRING is "Build_popdown_cmd";

	label: STRING is
		do
			Result := "Popdown"
		end;

	identifier: INTEGER is
		do
			Result := - popdown_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.temp_wind_type)
			Result.extend (arg)
		end

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make;
			!! lab.make ("popdown");
			Result.extend (lab);
		end;

end
