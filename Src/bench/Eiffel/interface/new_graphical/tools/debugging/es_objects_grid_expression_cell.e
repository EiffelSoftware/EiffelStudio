indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_EXPRESSION_CELL

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			activate_action
		end

create
	make_with_text

feature -- Query

	new_text: STRING is
		do
			Result := text_field.text
		end

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			Precursor (popup_window)
			text_field.select_all
		end

end
