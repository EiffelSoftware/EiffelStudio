indexing
	description: "Class used to store the event element of a behavior."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class S_EVENT_ELMT

inherit
	SHARED_STORAGE_INFO

creation
	make

feature {NONE} -- Initialization

	make (other: EVENT) is
		do
			identifier := other.identifier
		end

	event: EVENT is
		do
			if identifier < 0 then
				Result := event_table.item (- identifier)
			else
				Result := translation_table.item (identifier)
			end
		end

feature {NONE} -- Implementation

	identifier: INTEGER

end -- class S_EVENT_ELMT

