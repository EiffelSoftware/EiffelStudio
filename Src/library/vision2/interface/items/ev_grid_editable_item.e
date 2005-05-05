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

create
	default_create,
	make_with_text

feature -- Element change
	
	set_text_validation_agent (a_validation_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]) is
			-- Set the agent that validates the text of `text_field' on `deactivate'.
			-- If `a_validation_agent' is Void then no validation is performed before setting `text'.
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

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		local
			x_offset: INTEGER
			a_width: INTEGER
		do
				-- Account for position of text relative to pixmap.
			x_offset := left_border
			if pixmap /= Void then
				x_offset := x_offset + pixmap.width + spacing
			end
			a_width := popup_window.width - x_offset

			popup_window.set_width (a_width)
			popup_window.set_x_position (x_offset + popup_window.x_position)
			popup_window.set_height (text_height)


			create text_field
				-- Hide the border of the text field.
			text_field.implementation.hide_border
			if font /= Void then
				text_field.set_font (font)
			end
			fixme ("Add handling for Void colors and potential column, row and grid colors")
			if background_color /= Void then
				text_field.set_background_color (background_color)
			end	
			if foreground_color /= Void then
				text_field.set_foreground_color (foreground_color)
			end
			text_field.set_text (text)
			popup_window.extend (text_field)
			popup_window.show_actions.extend (agent text_field.set_focus)
			text_field.return_actions.extend (agent deactivate)
			text_field.focus_out_actions.extend (agent deactivate)
		end

	deactivate is
			-- Cleanup from previous call to activate.
		do
			if text_field /= Void then
				text_field.focus_out_actions.wipe_out
				Precursor {EV_GRID_LABEL_ITEM}
				if validation_agent = Void or else validation_agent.item ([text_field.text]) then
					set_text (text_field.text)
				end
				text_field.destroy
				text_field := Void
			end
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
