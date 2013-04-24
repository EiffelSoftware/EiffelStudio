note
	description: "Abstract description of the interface to a data source for translations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_DATASOURCE_MANAGER

feature {NONE} -- Initialization

	make (a_uri : READABLE_STRING_GENERAL)
			-- Initialize datasource manager with given URI.
			--
			-- Note: Implementations should redefine this and parse URI
		require
			a_uri_not_void: a_uri /= Void
		do
			create uri.make_from_string_general (a_uri)
		ensure
			uri_set: uri.same_string_general(a_uri)
		end

feature -- Access

	dictionary (a_locale: I18N_LOCALE_ID): I18N_DICTIONARY
			-- Dictionary for locale `a_locale'
			--
			-- `a_locale': Locale ID to lookup dictionary
			-- `Result': Dictionary with translations for `a_locale'
		require
			a_locale_not_void: a_locale /= Void
			a_locale_present: has_locale (a_locale) or has_language (a_locale.language_id)
		deferred
		ensure
			dictionary_not_void: Result /= Void
		end

	 available_locales: LINEAR [I18N_LOCALE_ID]
			-- List of the available locales
		deferred
		ensure
			result_exists: Result /= Void
		end

	available_languages: LINEAR [I18N_LANGUAGE_ID]
			-- List of the available languages
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	has_locale (a_locale_id: I18N_LOCALE_ID): BOOLEAN
			-- Is `a_locale_id' available?
		require
			a_locale_id_exists: a_locale_id /= Void
		do
			Result := available_locales.has (a_locale_id)
		ensure
			correct_result: Result = available_locales.has (a_locale_id)
		end

	has_language (a_language_id: I18N_LANGUAGE_ID): BOOLEAN
			-- Is `a_language_id' available?
		require
			a_language_id_exists: a_language_id /= Void
		do
			Result := available_languages.has (a_language_id)
		ensure
			correct_result: Result = available_languages.has (a_language_id)
		end

feature {NONE} -- Implementation

	uri: STRING_32;
			-- URI of data

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
