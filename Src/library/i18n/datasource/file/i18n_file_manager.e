indexing
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

feature	-- Creation

	make (an_uri: STRING_GENERAL) is
		do
			Precursor (an_uri)
				-- Initialize chain-of-responsability
			create {I18N_MO_HANDLER} chain
				-- There is no next element for now
			create directory.make (an_uri.to_string_8)
			populate_file_lists
		ensure then
			at_least_one_handler: chain /= Void
			directory_created: directory /= Void
			file_lists_created: locale_file_list /= Void and language_file_list /= Void
		end

feature	-- Access

	dictionary (a_locale: I18N_LOCALE_ID): I18N_DICTIONARY is
			-- return appropriate dictionary
		do
			if available_locales.has (a_locale) then
				Result := chain.get_file_dictionary (locale_file_list.item (a_locale))
			elseif available_languages.has (a_locale.language_id) then
				Result := chain.get_file_dictionary (
					language_file_list.item (a_locale.language_id))
			else
				create {I18N_DUMMY_DICTIONARY} Result.make(0)
			end
		end

	available_locales: LINEAR[I18N_LOCALE_ID] is
			-- return locales for which there is a locale-specific translation
		do
			create {ARRAYED_LIST[I18N_LOCALE_ID]} Result.make_from_array (locale_list)
			Result.compare_objects
		end

	available_languages: LINEAR[I18N_LANGUAGE_ID] is
			-- return languages for which there is a generic translation
		do
			create {ARRAYED_LIST[I18N_LANGUAGE_ID]} Result.make_from_array (language_list)
			Result.compare_objects
		end

feature {NONE} -- Internal data

	locale_file_list: HASH_TABLE[STRING_8, I18N_LOCALE_ID]
	locale_list: ARRAYED_LIST[I18N_LOCALE_ID]
	language_file_list: HASH_TABLE[STRING_8, I18N_LANGUAGE_ID]
	language_list: ARRAYED_LIST[I18N_LANGUAGE_ID]

feature {NONE} --Implementation

	directory: DIRECTORY
	chain: I18N_FILE_HANDLER

	populate_file_lists is
			-- add to file lists all locales and langugaes
			-- that are available in `directory'
		require
			directory_not_void: directory /= Void
		local
			temp: LIST[STRING_8]
			scope: I18N_FILE_SCOPE_INFORMATION
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
				temp := directory.linear_representation
				from
					temp.start
				until
					temp.after
				loop
					scope := chain.file_scope (
							uri + Operating_environment.directory_separator.out + temp.item)

					if scope /= Void then
						if scope.scope = scope.scope_locale_specific then
								--have we already encountered this locale?
								--policy on duplicate locales: ignore the second one.
							locale_file_list.put(
									uri+Operating_environment.directory_separator.out+
									temp.item,scope.get_locale)
							if  locale_file_list.inserted then
								locale_list.extend(scope.get_locale)
							end
						elseif scope.scope = scope.scope_language_specific then
								-- policy on duplicate languages: ignore
							language_file_list.put (
									uri+Operating_environment.directory_separator.out+
									temp.item,scope.get_language)
							if language_file_list.inserted then
								language_list.extend(scope.get_language)
							end
						end
					end -- end scope /= void
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

indexing
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
