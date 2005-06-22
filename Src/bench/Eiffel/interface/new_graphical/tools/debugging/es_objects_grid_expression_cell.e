indexing
	description : "Objects that represent an expression"
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
	default_create,
	make_with_text

feature -- Query

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			Precursor (popup_window)
			if text_field.text_length > 0 then
				text_field.select_all				
			end
			text_field.set_focus
		end
		
end
