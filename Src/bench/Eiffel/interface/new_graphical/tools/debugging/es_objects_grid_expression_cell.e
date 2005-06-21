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

	new_text: STRING is
		do
			Result := text_field.text
		end

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			Precursor (popup_window)
			text_field.key_press_actions.extend (agent on_key_pressed)
			if text_field.text_length > 0 then
				text_field.select_all				
			end
		end
		
feature {NONE} -- Actions Impl

	on_key_pressed (k: EV_KEY) is
		do
			if 
				k /= Void 
				and then k.code = {EV_KEY_CONSTANTS}.Key_escape
			then
				text_field.set_text (text)
				deactivate
			end
		end

end
