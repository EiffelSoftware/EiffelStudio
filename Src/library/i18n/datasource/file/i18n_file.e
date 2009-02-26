note
	description: "Abstract representation of a dictionary file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_FILE

inherit
	SHARED_I18N_PLURAL_TOOLS

feature {NONE}	-- creation

	make (path: STRING_GENERAL)
			-- Initialize file from `a_path'.
			--
			-- `a_path': File path of a valid mo file
		require
			string_exists: path /= Void
			string_not_empty: not path.is_empty
		deferred
		end

feature	-- Access

 	locale: detachable STRING_32
 			-- Locale of file
 			--
 			-- Note: This is a best guess and may not be accurate.
 		deferred
 		end

 	plural_form: INTEGER
 			-- Plural form used by the file
 			--
 			-- This may have exactly 10 values:
 			-- 0: unknown/unitialised/no plural support
 			-- 1: Only one form (Chinese, Japanese, Korean, Turkish etc..)
 			-- 2: Two forms, singular used for one only (Germanic languages: English uses this)
 			-- 3: Two forms, singular used for zero and one (Romanic languages)
 			-- 4: Three forms, special case for zero (Baltic languages, e.g Latvian)
 			-- 5: Three forms, special cases for one and two (Irish, Arabic, etc.)
 			-- 6: Three forms, special case for numbers ending in 1[2-9] (Lithuanian)
 			-- 7: Three forms, special cases for numbers ending in 1 and 2, 3, 4, except those ending in 1[1-4] (Slavic languages)
 			-- 8: Three forms, special case for one and some numbers ending in 2, 3, or 4 (Polish)
 			-- 9: Four forms, special case for one and all numbers ending in 02, 03, or 04 (Slovenian)	
 			-- See I18N_PLURAL_TOOLS for more information

	entry_count: INTEGER
			-- Number of entries in the file.

	original_singular_string (i: INTEGER): STRING_32
			-- Original singular string for ith entry
			--
			-- `i': Entry index
			-- `Result': Original singular string
		require
			file_open: opened
			i_valid_index: valid_index (i)
		deferred
		end

	translated_singular_string (i: INTEGER): STRING_32
			-- Translated singular string for ith entry
		require
			file_open: opened
			i_valid_index: valid_index (i)
		deferred
		end

	original_plural_string (i:INTEGER): STRING_32
			-- Original plural string for ith entry
			--
			-- `i': Entry index
			-- `Result': Original plural string, otherwise Void if there is none
		require
			file_open: opened
			i_valid_index: valid_index (i)
			plurals_exist: entry_has_plurals(i)
		deferred
		end

	translated_plural_strings (i: INTEGER): ARRAY [STRING_32]
			-- Translated plural strings for ith entry
			--
			-- Note: Result array is indexed exactly from 0 to 3
			--
			-- `i': Entry index
			-- `Result': Array containing plural translations, otherwise Void if there are no plural translations
		require
			file_open: opened
			i_valid_index: valid_index (i)
			plurals_exist: entry_has_plurals(i)
		deferred
		ensure
			result_exists: Result /= Void
			correct_lower_index: Result.lower = 0
			correct_upper_index: Result.upper = 3
		end

feature -- Status report

	entry_has_plurals (i: INTEGER): BOOLEAN
			-- Does this entry have any plurals?
		require
			file_open: opened
			i_valid_index: valid_index (i)
		deferred
		end

	valid_index(i:INTEGER):BOOLEAN
			-- Is this a valid index for an entry?
		require
			file_open: opened
		deferred
		end

	opened: BOOLEAN
			-- Is the file opened?

	valid: BOOLEAN
			-- Was file parsed correctly?
		deferred
		end

feature -- Basic operations

	close
			-- Close file.
		require
			file_open: opened
		deferred
		ensure
			closed: not opened
		end

	open
			-- Open file.
		require
			file_closed: not opened
		deferred
		end

feature {NONE} -- Implementation

	file: FILE
			-- File handle

invariant

	plural_form_correct: plural_form < 10 and plural_form >= 0
	opened_only_if_valid: opened implies valid
	opened_means_file_exists: opened implies file.exists

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
