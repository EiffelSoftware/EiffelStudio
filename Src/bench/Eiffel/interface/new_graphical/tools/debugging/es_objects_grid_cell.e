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
			initialize_actions
		end

create
	default_create,
	make_with_text

feature -- Query

	initialize_actions is
		do
			Precursor
			text_field.disable_edit
			if text_field.text_length > 0 then
				text_field.select_all
			end
		end
		
end
