note
	description: "Implementation of I18N_FILE_HANDLER that knows how to handle .mo files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_MO_HANDLER

inherit
	I18N_FILE_HANDLER
		redefine
			file
		end

feature -- Interface

	can_handle (a_path:STRING_32) :BOOLEAN
			-- will handle this _if_  it has a file name ending in .mo
			-- extend later, maybe, to check the magic number.
		do
				-- Check file  name
			if a_path.substring (a_path.count-2, a_path.count).is_equal (".mo") then
				Result := True
			end
		end

	extract_dictionary (a_path:STRING_32): I18N_DICTIONARY
		local
			i: INTEGER
			temp: I18N_DICTIONARY_ENTRY
			original_singular, translated_singular, original_plural: STRING_32
			translated_plurals: ARRAY[STRING_32]
			l_file: like file
			l_pt: detachable ARRAY [STRING_32]
		do
			create l_file.make (a_path)
			l_file.open
			if l_file.opened then
				create {I18N_BINARY_SEARCH_ARRAY_DICTIONARY} Result.make(l_file.plural_form)
				from
					i := 1
				until
					i > l_file.entry_count
				loop
					original_singular := l_file.original_singular_string (i)
					translated_singular := l_file.translated_singular_string (i)
					if l_file.entry_has_plurals (i) then
						original_plural := l_file.original_plural_string (i)
						translated_plurals := l_file.translated_plural_strings (i)
						create temp.make_with_plural(original_singular, translated_singular, original_plural)
						l_pt := temp.plural_translations
						check l_pt /= Void end -- Implied from invariants in {I18N_DICTIONARY_ENTRY}
						l_pt.copy(translated_plurals)
					else
						create temp.make (original_singular, translated_singular)
					end
					Result.extend (temp)
					i := i + 1
				end
				l_file.close
			else
				create {I18N_DUMMY_DICTIONARY} Result.make (0)
			end
		end

	extract_scope (a_path: STRING_32): detachable I18N_FILE_SCOPE_INFORMATION
			-- Not much scope information we can extract from the file itself. All we have to go on is the name.
			-- NOTE: Void indicates unknown scope, not a bug
		local
			locale: I18N_LOCALE_ID
			l_file: like file
		do
			create l_file.make (a_path)
			l_file.open
			if l_file.opened then
				-- let a locale object do the parsing for us
				if attached l_file.locale as l_locale then
					if l_locale.has ('_') or l_locale.has('-') then
						create locale.make_from_string (l_locale)
						create Result.make_with_locale (locale)
					else
						create Result.make_with_language (create {I18N_LANGUAGE_ID}.make (l_locale))
					end
				end
				l_file.close
			end
		end

feature -- File

	file: detachable I18N_MO_FILE;

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
