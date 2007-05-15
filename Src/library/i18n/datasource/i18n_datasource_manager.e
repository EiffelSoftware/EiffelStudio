indexing
	description: "Abstract description of the interface to a data source for translations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_DATASOURCE_MANAGER

feature -- Initialization

	make (a_uri : STRING_GENERAL) is
			-- Creation procedure
			-- Implementations should redefine this
		require
			a_uri_exists: a_uri /= Void
		do
			uri := a_uri.to_string_32
		ensure
			uri_set: uri.is_equal(a_uri.as_string_32)
		end

feature -- Access

	get_dictionary (a_locale: I18N_LOCALE_ID): I18N_DICTIONARY is
			-- get dictionary datastructure for the locale `a_locale'
		require
			a_locale_exists: a_locale /= Void
			a_locale_present: has_locale(a_locale) or has_language(a_locale.language_id)
		deferred
		ensure
			dictionary_exists: Result /= Void
		end

feature -- Informations

	 available_locales: LINEAR[I18N_LOCALE_ID] is
			-- list of the available locales
		deferred
		ensure
			result_exists: Result /= Void
		end

	available_languages: LINEAR[I18N_LANGUAGE_ID] is
			-- list of the available languages
		deferred
		ensure
			result_exists: Result /= Void
		end

	has_locale ( a_locale_id: I18N_LOCALE_ID): BOOLEAN is
			-- is `a_locale_id'  available?
		require
			a_locale_id_exists: a_locale_id /= Void
		do
			Result := available_locales.has (a_locale_id)
		ensure
			correct_result: Result = available_locales.has (a_locale_id)
		end

	has_language ( a_language_id: I18N_LANGUAGE_ID): BOOLEAN is
			-- is `a_language_id' available?
		require
			a_language_id_exists: a_language_id /= Void
		do
			Result := available_languages.has (a_language_id)
		ensure
			correct_result: Result = available_languages.has (a_language_id)
		end

feature {NONE}

	uri: STRING_32;

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
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
