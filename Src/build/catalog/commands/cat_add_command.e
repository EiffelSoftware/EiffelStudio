indexing
	description: "Command used to add a new kind of command %
				% in the command catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CAT_ADD_COMMAND 

inherit

	CAT_ADD_ELEMENT
		redefine
			undo, redo,
			element,
			page
		end

	WINDOWS
	
feature {NONE}

	element: CMD

	page: COMMAND_PAGE

	catalog: COMMAND_CATALOG is
		do
			Result := command_catalog
		end

	reset_element is
		do
			if element.command_editor /= Void then
				element.command_editor.clear
				element.reset
			end
		end

feature

	redo is
		do
			{CAT_ADD_ELEMENT} Precursor
			element.recreate_class
		end

	undo is
		do
			{CAT_ADD_ELEMENT} Precursor
			element.remove_class
		end
			
end -- class CAT_ADD_COMMAND

