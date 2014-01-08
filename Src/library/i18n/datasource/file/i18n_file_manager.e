note
	description: "Implementation of DATASOURCE_MANAGER that uses message catalog files as a data source."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_FILE_MANAGER

inherit
	I18N_DATASOURCE_MANAGER
		redefine
			make
		end

create
	make

feature	{NONE} -- Creation

	make (an_uri: READABLE_STRING_GENERAL)
		do
			Precursor (an_uri)
				-- Initialize chain-of-responsability
			create {I18N_MO_HANDLER} chain
				-- There is no next element for now
			create directory.make (an_uri)
			populate_file_lists
		ensure then
			at_least_one_handler: chain /= Void
			directory_created: directory /= Void
			file_lists_created: locale_file_list /= Void and language_file_list /= Void
		end

feature	-- Access

	dictionary (a_locale: I18N_LOCALE_ID): I18N_DICTIONARY
			-- return appropriate dictionary
		local
			l_result: detachable I18N_DICTIONARY
		do
			if available_locales.has (a_locale) and then attached locale_file_list.item (a_locale) as l_locale then
				l_result := chain.get_file_dictionary (l_locale)
			elseif available_languages.has (a_locale.language_id) and then attached language_file_list.item (a_locale.language_id) as l_language_locale then
				l_result := chain.get_file_dictionary (l_language_locale)
			end
			if l_result = Void then
				create {I18N_DUMMY_DICTIONARY}l_result.make (0)
			end
			Result := l_result
		end

	available_locales: LINEAR [I18N_LOCALE_ID]
			-- return locales for which there is a locale-specific translation
		do
			Result := locale_list
		end

	available_languages: LINEAR [I18N_LANGUAGE_ID]
			-- return languages for which there is a generic translation
		do
			Result := language_list
		end

feature {NONE} -- Internal data

	locale_file_list: HASH_TABLE [READABLE_STRING_GENERAL, I18N_LOCALE_ID]
	locale_list: ARRAYED_LIST [I18N_LOCALE_ID]
	language_file_list: HASH_TABLE [READABLE_STRING_GENERAL, I18N_LANGUAGE_ID]
	language_list: ARRAYED_LIST [I18N_LANGUAGE_ID]

feature {NONE} --Implementation

	directory: DIRECTORY
	chain: I18N_FILE_HANDLER

	populate_file_lists
			-- add to file lists all locales and langugaes
			-- that are available in `directory'
		require
			directory_not_void: directory /= Void
		local
			temp: like directory.entries
			scope: detachable I18N_FILE_SCOPE_INFORMATION
			l_fn: IMMUTABLE_STRING_32
			l_path: PATH
		do
			create locale_file_list.make(16)
			create locale_list.make(16)
			create language_file_list.make(16)
			create language_list.make(16)
			locale_file_list.compare_objects
			locale_list.compare_objects
			language_file_list.compare_objects
			language_list.compare_objects
			if directory.exists and then directory.is_readable then
				directory.open_read
				temp := directory.entries
				from
					l_path := directory.path
					temp.start
				until
					temp.after
				loop
					if not temp.item.is_parent_symbol and then not temp.item.is_current_symbol then
						l_fn := l_path.extended_path (temp.item).name
						scope := chain.file_scope (l_fn)
						if scope /= Void then
							if attached scope.locale as l_locale then
									--have we already encountered this locale?
									--policy on duplicate locales: ignore the second one.
								locale_file_list.put (l_fn, l_locale)
								if locale_file_list.inserted then
									locale_list.extend (l_locale)
								end
							elseif attached scope.language as l_language then
									-- policy on duplicate languages: ignore
								language_file_list.put (l_fn, l_language)
								if language_file_list.inserted then
									language_list.extend (l_language)
								end
							end
						end -- end scope /= void
					end
					temp.forth
				end -- end loop
			end -- end directory.exists and directory.is_readable
		end

invariant
	directory_exists: directory /= Void
	locale_file_list_exists: locale_file_list /= Void
	locale_list_exists: locale_list /= Void
	language_file_list_exists: language_file_list /= Void
	language_list_exists: language_list /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
