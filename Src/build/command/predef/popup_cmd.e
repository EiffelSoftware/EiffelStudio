

class POPUP_CMD 

inherit

	PREDEF_CMD

creation

	make

feature 

	eiffel_type: STRING is "Build_popup_cmd";

	label: STRING is "Popup";

	identifier: INTEGER is
		do
			Result := - popup_cmd_id
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
			!! lab.make ("popup");
			Result.extend (lab);
		end

end
