
deferred class CAT_COMMAND 

inherit

	UNDOABLE
		redefine
			is_template, execute
		end;

	WINDOWS
		export
			{NONE} all
		end
		
	
feature {NONE}

	page: ICON_BOX [STONE];

	element: STONE;

	work (argument: ANY) is	
		do
		end;
	
feature 

	execute (argument: like page) is
		do
			page := argument;
			catalog_work	
		end;

	n_ame: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" ");
			Result.append (element.label);
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

	history: HISTORY_WND is
        once
            Result := history_window;
        end;

end
