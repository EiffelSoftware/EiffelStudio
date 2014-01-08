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
			hash.extend (a_entry, a_entry.identifier)
		end

feature --Access

	has_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- does the dictionary have this entry?
		do
			Result := hash.has (id_from_original_and_context (original, a_context))
		end

	singular_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- get the singular translation of `original'
		do
			if attached hash.item (id_from_original_and_context (original, a_context)) as l_entry then
				Result := l_entry.singular_translation
			end
		end

	plural_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- get the `plural_number'-th plural translation of entry
			-- with `original_singular' and `original_plural'
		do
				-- Per inherited precondition
			if attached hash.item (id_from_original_and_context (original_singular, a_context)) as l_entry and then l_entry.has_plural then
				Result := l_entry.plural_translations.item (reduce (plural_number))
			end
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
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
