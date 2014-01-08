note
	description: "Implementation of DICTIONARY using a CHARACTER_TREE to store the entries"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_CHARACTER_BASED_DICTIONARY

inherit

	I18N_DICTIONARY
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_plural_form: INTEGER)
			-- create the datastructure
		do
			Precursor (a_plural_form)
			create singular_char_tree
			create plural_char_tree
		end

feature -- Manipulation
		-- this should be restricted

	extend (a_entry: I18N_DICTIONARY_ENTRY)
			-- add a_entry in the datastructure
		do
			if not a_entry.has_plural then
					-- entry has no plurals
				singular_char_tree.insert (a_entry, a_entry.identifier)
			else
					-- entry has plurasl
				plural_char_tree.insert (a_entry, a_entry.identifier)
			end
			count := count + 1
		ensure then
			item_extended:
				has (a_entry.identifier) or else
				((attached a_entry.original_plural as l_plural) and then
				has_plural (a_entry.identifier, l_plural, 1))
		end

feature -- Access

	has_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- is there an entry with original?
		local
			l_id: like id_from_original_and_context
		do
			l_id := id_from_original_and_context (original, a_context)
			Result := singular_char_tree.get_item_with_key (l_id) /= Void
			if not Result then
				Result := plural_char_tree.get_item_with_key (l_id) /= Void
			end
		end

	singular_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- get the translation of `original'
			-- in the singular form
		local
			l_id: like id_from_original_and_context
		do
			l_id := id_from_original_and_context (original, a_context)
			if attached singular_char_tree.get_item_with_key (l_id) as l_entry then
				Result := l_entry.singular_translation
			elseif attached plural_char_tree.get_item_with_key (l_id) as l_entry then
				Result := l_entry.singular_translation
			end
		end

	plural_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- get the translation of `original_singular'
			-- in the given plural form
		do
			if attached plural_char_tree.get_item_with_key (id_from_original_and_context (original_singular, a_context)) as l_entry and then l_entry.has_plural then
				Result := l_entry.plural_translations.item (reduce (plural_number))
			end
		end

feature --Information

	count: INTEGER
			-- number of entries in the dictionary

feature {NONE} -- Implementation

	singular_char_tree: CHARACTER_TREE [I18N_DICTIONARY_ENTRY]
			-- tree that contains all entries without plurals

	plural_char_tree: CHARACTER_TREE [I18N_DICTIONARY_ENTRY];
			-- tree that contains all entries with plurals

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
