
deferred class CAT_COMMAND 

inherit

	EB_UNDOABLE
		redefine
			is_template, execute
		end;
	
feature {NONE}

	page: ICON_BOX [DATA];

	element: DATA;

	work (argument: ANY) is	
		do
		end;
	
feature 

	execute (argument: like page) is
		do
			page := argument;
			catalog_work	
		end;

	name: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" ");
			if element /= Void then
				Result.append (element.label);
			end
		end;

	
feature {NONE}

	catalog_work is
		deferred
		end;

	c_name: STRING is
			-- Name of the command
		deferred
		end;

	failed: BOOLEAN;

	
feature 

	is_template: BOOLEAN is True;

end
