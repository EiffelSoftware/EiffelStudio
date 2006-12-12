indexing
	description: "Implementation of I18N_FILE_HANDLER that knows how to handle .mo files"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
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

		can_handle (a_path:STRING_32) :BOOLEAN is
				-- will handle this _if_  it has a file name ending in .mo
				-- extend later, maybe, to check the magic number.
			do
				-- Check file  name
				if a_path.substring (a_path.count-2, a_path.count).is_equal (".mo") then
					Result := True
				end
			end

		extract_dictionary (a_path:STRING_32): I18N_DICTIONARY is
			local
				i: INTEGER
				temp: I18N_DICTIONARY_ENTRY
				original_singular, translated_singular, original_plural: STRING_32
				translated_plurals: ARRAY[STRING_32]
			do
				create file.make (a_path)
				file.open
				if file.opened then
					create {I18N_BINARY_SEARCH_ARRAY_DICTIONARY} Result.make(file.plural_form)
					from
						i := 1
					until
						i > file.entry_count
					loop
						original_singular := file.original_singular_string (i)
						translated_singular := file.translated_singular_string (i)
						if file.entry_has_plurals (i) then
							original_plural := file.original_plural_string (i)
							translated_plurals := file.translated_plural_strings (i)
							create temp.make_with_plural(original_singular, translated_singular, original_plural)
							temp.plural_translations.copy(translated_plurals)
						else
							create temp.make (original_singular, translated_singular)
						end
						Result.extend (temp)
						i := i + 1
					end
				else
					create {I18N_DUMMY_DICTIONARY} Result.make (0)
				end
			end

	extract_scope (a_path: STRING_32): I18N_FILE_SCOPE_INFORMATION is
			-- Not much scope information we can extract from the file itself. All we have to go on is the name.
			-- NOTE: Void indicates unknown scope, not a bug
			local
				locale: I18N_LOCALE_ID
			do
				create file.make (a_path)
				file.open
				if file.opened then
					-- let a locale object do the parsing for us
					if file.locale.has ('_') or file.locale.has('-') then
						create locale.make_from_string (file.locale)
						create Result.make_with_locale (locale)
					else
						create Result.make_with_language (create {I18N_LANGUAGE_ID}.make (file.locale))
					end
				end
			end

feature -- File

		file: I18N_MO_FILE

end
