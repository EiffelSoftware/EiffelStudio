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
			activate_action,
			deactivate
		end

create
	default_create,
	make_with_text

feature -- Query

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			Precursor (popup_window)
			text_field.select_all
			text_field.disable_edit
		end

	deactivate is
		local
			old_text: STRING
		do
			old_text := text
			Precursor
			set_text (old_text)
		end
		
end
