indexing
	description : "Objects that represent a cell"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_CELL

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			deactivate
		end

create
	default_create,
	make_with_text

feature -- Query

	deactivate is
		local
			old_text: STRING
		do
			old_text := text
			Precursor
			set_text (old_text)
		end
		
end
