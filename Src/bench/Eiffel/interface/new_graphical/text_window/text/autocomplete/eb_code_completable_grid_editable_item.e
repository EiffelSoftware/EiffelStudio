indexing
	description: "Editable grid item that contains code completable text field."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CODE_COMPLETABLE_GRID_EDITABLE_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			text_field,
			activate_action
		end

feature -- Access

	text_field: EB_CODE_COMPLETABLE_TEXT_FIELD
		-- Text field used to edit `Current' on `activate'.
		-- Void when `Current' isn't being activated.

	completion_possibilities_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER

feature -- Element change

	set_completion_possibilities_provider (a_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER) is
			-- Set `completion_possibilities_provider'.
		require
			a_provider_not_void: a_provider /= Void
		do
			completion_possibilities_provider := a_provider
		ensure
			completion_possibilities_provider_not_void: completion_possibilities_provider /= Void
		end

feature {NONE} -- Implementation

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			create text_field.make
				-- Hide the border of the text field.
			text_field.set_completion_possibilities_provider (completion_possibilities_provider)
			if completion_possibilities_provider /= Void then
				completion_possibilities_provider.set_code_completable (text_field)
			end
			text_field.implementation.hide_border
			if font /= Void then
				text_field.set_font (font)
			end

			text_field.set_text (text)

			text_field.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			text_field.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (text_field)
				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
		end

invariant
	invariant_clause: True -- Your invariant here

end
