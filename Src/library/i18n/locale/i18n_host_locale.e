note
	description: "[
					Deferred class that specifies the interface for formatting information access. 
					Effective descendants are normally platform-specific.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_HOST_LOCALE

feature -- Initialization

	create_locale_info_from_user_locale: I18N_LOCALE_INFO
			-- create locale form the user locale
		deferred
		end

	create_locale_info (a_locale_id : I18N_LOCALE_ID): I18N_LOCALE_INFO
			-- Create locale with a_locale_id
		require
			a_locale_not_void: a_locale_id /= Void
			a_locale_exists: is_available(a_locale_id)
		deferred
		end

feature -- Informations

	is_available (a_locale_id : I18N_LOCALE_ID) : BOOLEAN
			-- is 'a_locale' avaiable?
		require
			a_locale_id_exists: a_locale_id /= Void
		deferred
		end

	available_locales : LINEAR[I18N_LOCALE_ID]
			-- list af all available locales
		deferred
		ensure
			result_exists: Result /= Void
		end

	default_locale_id: I18N_LOCALE_ID
			-- default locale id
		deferred
		end

	system_locale_id: I18N_LOCALE_ID
			-- system locale id
		deferred
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
