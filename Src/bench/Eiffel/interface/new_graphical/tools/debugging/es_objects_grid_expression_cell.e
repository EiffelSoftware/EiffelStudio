indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_EXPRESSION_CELL

inherit
	EV_GRID_EDITABLE_ITEM

create
	make_with_text

feature -- Query

	new_text: STRING is
		do
			Result := text_field.text
		end

end
