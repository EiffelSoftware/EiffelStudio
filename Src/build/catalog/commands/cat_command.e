indexing
	description: "Abstract undoable command to add or remove a new %
				%command in the command catalog."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class CAT_COMMAND 

inherit

	EB_UNDOABLE_COMMAND
	
feature -- Access

	comment: STRING is
		do
			create Result.make (0)
			if element /= Void then
				Result.append (element.label)
			end
		end

feature {NONE} -- Implementation

	failed: BOOLEAN

	element: EV_PND_DATA

	page: CATALOG_PAGE

end -- class CAT_COMMAND

