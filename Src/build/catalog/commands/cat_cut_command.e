
class CAT_CUT_COMMAND 

inherit

	CAT_CUT_ELEMENT
		redefine
			element,
			page
		end;

	WINDOWS
		export
			{NONE} all
		end

feature {NONE}

	catalog: CMD_CATALOG is
		do
			Result := command_catalog
		end;

	element: CMD;

	page: COMMAND_PAGE;

end
