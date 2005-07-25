indexing
	description : "Objects that represent an expression"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			activate_action, deactivate, make_with_text,
			initialize_actions
		end

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
		do
			empty_text := a_text
			Precursor (empty_text)
			create apply_actions
		end
		
	empty_text: STRING
		
feature -- Query

	use_text: STRING

	activate_with_string (a_text: STRING) is
		do
			use_text := a_text
			activate
		end

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			if use_text /= Void then
				set_text (use_text)
			else
				remove_text
			end
			Precursor (popup_window)
		end

	deactivate is
		do
			Precursor
			if not user_cancelled_activation and then not text.is_empty then
				apply_actions.call ([text])
			end
			set_text (empty_text)
		end
		
	apply_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Action to perform when applying the changes

	initialize_actions is
		do
			Precursor
			if use_text /= Void then
				text_field.set_caret_position (use_text.count + 1)
			end
			use_text := Void
		end

end
