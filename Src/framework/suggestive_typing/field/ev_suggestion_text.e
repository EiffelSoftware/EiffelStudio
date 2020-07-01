note
	description: "Descendant of EV_TEXT equipped with suggestive typing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SUGGESTION_TEXT

inherit
	EV_TEXT
		redefine
			create_interface_objects,
			initialize,
			set_default_key_processing_handler,
			remove_default_key_processing_handler
		end

	EV_ABSTRACT_SUGGESTION_TEXT_COMPONENT
		rename
			displayed_text as text,
			set_displayed_text as set_text
		undefine
			searched_text
		redefine
			create_interface_objects,
			is_default_key_processing_enabled,
			insert_suggestion
		end

	EV_SUGGESTION_TEXTABLE_FIELD_BY_RANGE_HELPER
		rename
			displayed_text as text
		undefine
			default_create, copy
		end

create
	make,
	make_with_settings

feature {NONE} -- Initialization

	make (a_provider: like suggestion_provider)
			-- Initialize current using suggestion provider `a_provider'.
			-- If `a_provider.is_concurrent', then Current might create a new thread
			-- of control to perform the query.
		do
			suggestion_provider := a_provider
			default_create
		ensure
			suggestion_provider_set: suggestion_provider = a_provider
		end

	make_with_settings (a_provider: like suggestion_provider; a_settings: like settings)
			-- Initialize current using suggestion provider `a_provider' and associated `a_settings' settings.
			-- If `a_provider.is_concurrent', then Current might create a new thread
			-- of control to perform the query.
		do
			suggestion_provider := a_provider
			internal_settings := a_settings
			default_create
		ensure
			suggestion_provider_set: suggestion_provider = a_provider
			settings_set: internal_settings = a_settings
		end

	create_interface_objects
			-- <Precursor>
		do
			Precursor {EV_ABSTRACT_SUGGESTION_TEXT_COMPONENT}
			Precursor {EV_TEXT}
		end

	initialize
			-- Initialize current.
		do
			Precursor
			initialize_suggestion_field
		end

feature -- Status setting

	set_default_key_processing_handler (a_handler: like default_key_processing_handler)
			-- Set `default_key_processing_handler' with `new_default_key_processing_handler'.
			-- Set `old_default_key_processing_handler' with `a_handler' if different from
			-- `new_default_key_processing_handler'.
		do
			if a_handler /= new_default_key_processing_handler then
				old_default_key_processing_handler := a_handler
			end
			if default_key_processing_handler /= new_default_key_processing_handler then
				Precursor (new_default_key_processing_handler)
			end
		ensure then
			handler_set: default_key_processing_handler = new_default_key_processing_handler
			a_handler_preserved: a_handler /= new_default_key_processing_handler implies old_default_key_processing_handler = a_handler
		end

	remove_default_key_processing_handler
			-- Ensure `old_default_key_processing_handler' is Void while preserving our own handler.
		do
			old_default_key_processing_handler := Void
		ensure then
			default_handler_preserved: default_key_processing_handler = new_default_key_processing_handler
		end

feature {EV_SUGGESTION_WINDOW} -- Interact with suggestion window.		

	insert_suggestion (a_selected_item: attached like last_suggestion)
			-- Insert associated text of `a_selected_item' in Current if valid,
			-- move caret to the end and update `last_suggestion' with `a_selected_item'.
		local
			l_text: READABLE_STRING_GENERAL
		do
			selected_suggestion := a_selected_item
			l_text := a_selected_item.text
			if not l_text.is_empty and not l_text.has_code (('%R').natural_32_code) then
				insert_suggestion_text (l_text)
			end
			refresh
		end

feature {EV_SUGGESTION_WINDOW} -- Interact with suggestion window.		

	is_default_key_processing_enabled (a_key: EV_KEY): BOOLEAN
			-- Will `a_key' be processed by underlying implementation.
		do
			if
				is_suggesting and
				(
					a_key.code = {EV_KEY_CONSTANTS}.key_up or
					a_key.code = {EV_KEY_CONSTANTS}.key_down or
					a_key.code = {EV_KEY_CONSTANTS}.key_page_up or
					a_key.code = {EV_KEY_CONSTANTS}.key_page_down or
					a_key.code = {EV_KEY_CONSTANTS}.key_home or
					a_key.code = {EV_KEY_CONSTANTS}.key_end
				)
			then
				Result := False
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				Result := not is_suggesting
				if is_suggesting then
					ev_application.add_idle_action_kamikaze (agent delete_previous_new_line)
				end
			else
				Result := Precursor (a_key)
			end
		end

	delete_previous_new_line
		local
			l_text: like text
		do
			l_text := text
			if l_text [caret_position - 1] = '%N' then
				set_selection (caret_position - 1, caret_position)
				delete_selection
			end
		end


note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
