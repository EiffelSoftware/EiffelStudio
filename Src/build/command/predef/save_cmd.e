

class SAVE_CMD 

inherit

	PREDEF_CMD

creation

	make

	
feature 

	eiffel_type: STRING is "BUILD_SAVE";

	label: STRING is "Save";

	identifier: INTEGER is
		do
			Result := - save_cmd_id
		end;

	arguments: EB_LINKED_LIST [ARG] is
		local
			arg: ARG
		once
			!! Result.make
			!! arg.session_init (context_catalog.text_type)
			arguments.extend (arg)
		end

	labels: EB_LINKED_LIST [CMD_LABEL] is
		local
			lab: CMD_LABEL
		once
			!! Result.make;
			!!lab.make ("save");
			labels.extend (lab);
			!!lab.make ("cancel");
			labels.extend (lab);
		end;

end
