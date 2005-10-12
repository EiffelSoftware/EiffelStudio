indexing
	description : "Objects that represent an expression"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_EXPRESSION_CELL

inherit
	ES_OBJECTS_GRID_CELL
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
			text_field.enable_edit
			if text_field.text_length > 0 then
				text_field.select_all				
			end
		end
		
end
