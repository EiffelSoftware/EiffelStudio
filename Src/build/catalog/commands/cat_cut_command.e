indexing
	description: "Undoable command to remove a command from %
				%the command catalog."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class CAT_CUT_COMMAND 

inherit

	CAT_CUT_ELEMENT
		redefine
			execute,
			element,
			page,
			undo, redo
		end

	WINDOWS

feature {NONE}

	catalog: COMMAND_CATALOG is
		do
			Result := command_catalog
		end

	element: USER_CMD

	page: COMMAND_PAGE

	parent_type: USER_CMD

	execute (arg: EV_ARGUMENT2 [like element, like page]; event_data: EV_EVENT_DATA) is
			-- Do not call `update_history'.
		do
			{CAT_CUT_ELEMENT} Precursor (arg, event_data)
			parent_type ?= element.parent_type
			element.remove_class
			if parent_type /= Void then
				parent_type.remove_descendent (element)
			end
		end

feature

	redo is
		do
			{CAT_CUT_ELEMENT} Precursor
			element.remove_class
			if parent_type /= Void then
				parent_type.remove_descendent (element)
			end
		end

	undo is
		do
			if parent_type /= Void then
				parent_type.add_descendent (element)
			end
			{CAT_CUT_ELEMENT} Precursor
			element.recreate_class
		end
			
end -- class CAT_CUT_COMMAND

