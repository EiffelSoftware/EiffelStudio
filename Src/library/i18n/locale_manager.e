indexing
	description: "Class that presents information about available locales and generates I18N_LOCALE objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LOCALE_MANAGER

inherit
	SHARED_I18N_URI_PARSER
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_uri: STRING_GENERAL) is
			-- Creation procedure
		require
			a_uri_exists: a_uri /= Void
		do
			datasource_manager := Parser.parse_uri (a_uri)
			create {I18N_HOST_LOCALE_IMP} host_locale
		end

feature -- Access

	get_locale (a_locale_id: I18N_LOCALE_ID): I18N_LOCALE is
			-- Get locale object that corresponds to `a_locale_id'
		require
			a_locale_id_exists: a_locale_id /= Void
		local
			l_locale_info: I18N_LOCALE_INFO
			l_dictionary: I18N_DICTIONARY
		do
			if has_translations (a_locale_id) then
				l_dictionary := datasource_manager.get_dictionary (a_locale_id)
			else
				create {I18N_DUMMY_DICTIONARY}	l_dictionary.make(0)
			end
			if has_formatting_info (a_locale_id) then
				l_locale_info := host_locale.create_locale_info (a_locale_id)
			else
				create l_locale_info.make -- will have default values	
			end
			create Result.make (l_dictionary, l_locale_info)
		ensure
			get_locale_not_void: Result /= Void
		end

	get_system_locale : I18N_LOCALE is
			-- Get the default locale in the system
		do
			Result := get_locale(host_locale.system_locale_id)
		ensure
			get_system_locale_not_void: Result /= Void
		end

feature -- Status report

	available_locales : LIST[I18N_LOCALE_ID] is
			-- list of available locales
		local
			temp: LINEAR[I18N_LOCALE_ID]
		do
			create {LINKED_LIST[I18N_LOCALE_ID]} Result.make
			Result.fill(host_locale.available_locales)
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

	has_translations (a_locale_id: I18N_LOCALE_ID): BOOLEAN is
			-- Are there translations for locale `a_locale_id'?
		do
			Result := datasource_manager.has_locale (a_locale_id) or
					 datasource_manager.has_language (a_locale_id.language_id)
		end

	has_localised_translations (a_locale_id: I18N_LOCALE_ID): BOOLEAN is
			-- Are there localized translations for locale `a_locale_id'?
		do
			Result := datasource_manager.has_locale (a_locale_id)
		end

	has_formatting_info (a_locale_id: I18N_LOCALE_ID): BOOLEAN is
			-- Are there informations on formatting for locale `a_locale_id'
		do
			Result:= host_locale.is_available (a_locale_id)
		end

	has_locale (a_locale_id: I18N_LOCALE_ID): BOOLEAN is
			--
		do
			Result := host_locale.is_available(a_locale_id) or
					( datasource_manager.has_locale (a_locale_id) or
					datasource_manager.has_language(a_locale_id.language_id) )
		end

feature {NONE} -- Implementation

	datasource_manager: I18N_DATASOURCE_MANAGER
	host_locale: I18N_HOST_LOCALE;

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
