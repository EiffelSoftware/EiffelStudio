note
	description: "Simple implementation of DICTIONARY using a hash table to store entries"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_HASH_TABLE_DICTIONARY

inherit

	I18N_DICTIONARY
		redefine
			make
		end

create
	make

feature {NONE} --Creation

	make (a_plural_form: INTEGER)
			-- create the datastructure
		do
			Precursor (a_plural_form)
			create hash.make (default_number_of_entries)
		end

feature --Insertion

	extend (a_entry: I18N_DICTIONARY_ENTRY)
			-- add an entry
		do
			hash.extend (a_entry, a_entry.original_singular)
		end

feature --Access

	has (original: READABLE_STRING_GENERAL): BOOLEAN
			-- does the dictionary have this entry?
		do
			Result := hash.has (original.as_string_32)
		end

	has_plural (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER): BOOLEAN
			-- does the dictionary have an entry with `original_singular', `original_plural'
			-- and does this entry have the `plural_number'-th plural translation
		local
			entry: detachable I18N_DICTIONARY_ENTRY
			l_trans: detachable ARRAY [STRING_32]
		do
			if hash.has (original_singular.as_string_32) then
				entry := hash.item (original_singular.as_string_32)
				check entry /= Void end -- Implied from `hash.has (original_singular.as_string_32)'
				if entry.has_plural then
					l_trans := entry.plural_translations
					check l_trans /= Void end -- Implied by `entry.has_plural'
					Result := l_trans.item (reduce (plural_number)) /= Void
				end
			end
		end

	singular (original: READABLE_STRING_GENERAL): STRING_32
			-- get the singular translation of `original'
		local
			entry: detachable I18N_DICTIONARY_ENTRY
		do
			entry := hash.item (original.as_string_32)
			check entry /= Void end -- Implied from precondition
			Result := entry.singular_translation
		end

	plural (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER): STRING_32
			-- get the `plural_number'-th plural translation of entry
			-- with `original_singular' and `original_plural'
		local
			entry: detachable I18N_DICTIONARY_ENTRY
			l_trans: detachable ARRAY [STRING_32]
		do
			entry := hash.item (original_singular.as_string_32)
			check entry /= Void end -- Implied from precondition
			l_trans := entry.plural_translations
			check l_trans /= Void end -- Implied by `entry.has_plural'
			Result := l_trans.item (reduce (plural_number))
		end

feature --Information

	count: INTEGER
			-- number of items in hash table
		do
			Result := hash.count
		end

feature {NONE} --Implementation

	hash: HASH_TABLE [I18N_DICTIONARY_ENTRY, STRING_32]

	default_number_of_entries: INTEGER = 50;

note
	library: "Internationalization library"
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
