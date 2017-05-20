note
	description: "Class that presents information about available locales and generates I18N_LOCALE objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LOCALE_MANAGER

inherit
	ANY

	SHARED_I18N_URI_PARSER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_uri: READABLE_STRING_GENERAL)
			-- Initialize manager from given URI.
			--
			-- Note: At the moment only file resources are available. Thus
			-- the given URI will be interpreted as a directory. The directory
			-- needs to contain 'mo' files named after the language and region
			-- they represent.
			--
			-- `a_uri': The URI which is used to look up translations.
		require
			a_uri_exists: a_uri /= Void
		do
			datasource_manager := Parser.parse_uri (a_uri)
			create {I18N_HOST_LOCALE_IMP} host_locale
		end

feature -- Access

	locale (a_locale_id: I18N_LOCALE_ID): I18N_LOCALE
			-- Locale object that corresponds to `a_locale_id'
			--
			-- `a_locale_id': Locale ID for which the locale object is returned
			-- `Result': Locale object corresponding to `a_locale_id'
		require
			a_locale_id_exists: a_locale_id /= Void
		local
			l_locale_info: I18N_LOCALE_INFO
			l_dictionary: I18N_DICTIONARY
		do
			if has_translations (a_locale_id) then
				l_dictionary := datasource_manager.dictionary (a_locale_id)
			else
				create {I18N_DUMMY_DICTIONARY}	l_dictionary.make (0)
			end
			if has_formatting_info (a_locale_id) then
				l_locale_info := host_locale.create_locale_info (a_locale_id)
			else
					-- No formatting info available from host system.
					-- Set default value
				create l_locale_info.make
			end
			create Result.make (l_dictionary, l_locale_info)
		ensure
			locale_not_void: Result /= Void
		end

	system_locale: I18N_LOCALE
			-- Default locale in system
		do
			Result := locale (host_locale.system_locale_id)
		ensure
			system_locale_not_void: Result /= Void
		end

	available_locales: LIST [I18N_LOCALE_ID]
			-- List of available locales
		local
			temp: LINEAR [I18N_LOCALE_ID]
		do
			create {LINKED_LIST [I18N_LOCALE_ID]} Result.make
			Result.compare_objects
			Result.fill (host_locale.available_locales)
			temp := datasource_manager.available_locales
			from
				temp.start
			until
				temp.after
			loop
				if not Result.has (temp.item) then
					Result.extend (temp.item)
				end
				temp.forth
			end
		ensure
			available_locales_not_void: Result /= Void
		end

feature -- Status report

	has_translations (a_locale_id: I18N_LOCALE_ID): BOOLEAN
			-- Are there translations for locale `a_locale_id'?
			--
			-- This checks the datasource for the locale with and without region information.
		require
			a_locale_id_not_void: a_locale_id /= Void
		do
			Result := datasource_manager.has_locale (a_locale_id) or
					 datasource_manager.has_language (a_locale_id.language_id)
		end

	has_localised_translations (a_locale_id: I18N_LOCALE_ID): BOOLEAN
			-- Are there localized translations for locale `a_locale_id'?
			--
			-- This checks the datasource for the locale with region information.
		require
			a_locale_id_not_void: a_locale_id /= Void
		do
			Result := datasource_manager.has_locale (a_locale_id)
		end

	has_formatting_info (a_locale_id: I18N_LOCALE_ID): BOOLEAN
			-- Are there informations on formatting for locale `a_locale_id'
		require
			a_locale_id_not_void: a_locale_id /= Void
		do
			Result:= host_locale.is_available (a_locale_id)
		end

	has_locale (a_locale_id: I18N_LOCALE_ID): BOOLEAN
			-- Is locale `a_locale_id' available?
		require
			a_locale_id_not_void: a_locale_id /= Void
		do
			Result := host_locale.is_available(a_locale_id) or
					( datasource_manager.has_locale (a_locale_id) or
					datasource_manager.has_language(a_locale_id.language_id) )
		end

feature {NONE} -- Implementation

	datasource_manager: I18N_DATASOURCE_MANAGER
			-- Manages internationalization files

	host_locale: I18N_HOST_LOCALE;
			-- Locale of host machine

invariant

	datasource_manager_not_void: datasource_manager /= Void
	host_locale_not_void: host_locale /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
