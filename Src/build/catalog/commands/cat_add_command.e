
class CAT_ADD_COMMAND 

inherit

	CAT_ADD_ELEMENT
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

	reset_element is
		do
			if
				not (element.command_editor = Void)
			then
				element.command_editor.clear;
				element.reset
			end
		end

end
