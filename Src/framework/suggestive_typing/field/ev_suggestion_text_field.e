note
	description: "Descendant of EV_TEXT_FIELD equipped with suggestive typing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SUGGESTION_TEXT_FIELD

inherit
	EV_TEXT_FIELD
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
		redefine
			create_interface_objects
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
			Precursor {EV_TEXT_FIELD}
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

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
