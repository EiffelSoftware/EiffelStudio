indexing
	description: "Text label that may be interactively edited by the user"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_EDITABLE_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			activate_action,
			deactivate
		end

feature -- Element change
	
	set_text_validation_agent (a_validation_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]) is
			-- Set the agent that validates the text of `text_field' on `deactivate'.
		require
			validation_agent_not_void: a_validation_agent /= Void
		do
			validation_agent := a_validation_agent
		ensure
			validation_agent_set: validation_agent = a_validation_agent
		end

feature -- Access

	validation_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]
		-- Agent used to validate `text_field' text.

feature {NONE} -- Implementation
		
	text_field: EV_TEXT_FIELD
		-- Text field used to edit `Current' on `activate'.

	activate_action (popup_window: EV_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			create text_field
			text_field.set_text (text)
			text_field.select_all
			popup_window.extend (text_field)
			text_field.return_actions.extend (agent deactivate)
			popup_window.show
		end

	deactivate is
			-- Cleanup from previous call to activate.
		do
			Precursor {EV_GRID_LABEL_ITEM}
			if text_field /= Void then
				if validation_agent = Void or else validation_agent.item ([text_field.text]) then
					set_text (text_field.text)
				end
				text_field.destroy
				text_field := Void
			end
		end

end
