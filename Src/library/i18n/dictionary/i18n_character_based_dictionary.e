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

	make(a_plural_form:INTEGER)
			-- create the datastructure
		do
			Precursor(a_plural_form)
			create singular_char_tree
			create plural_char_tree
		end

feature -- Manipulation
		-- this should be restricted

	extend (a_entry : I18N_DICTIONARY_ENTRY)
			-- add a_entry in the datastructure
		do
			if not a_entry.has_plural then
					-- entry has no plurals
				singular_char_tree.insert (a_entry, a_entry.original_singular)
			else
					-- entry has plurasl
				plural_char_tree.insert (a_entry, a_entry.original_singular)
			end
			count := count + 1
		ensure then
			item_extended:
				has (a_entry.original_singular) or else
				((attached a_entry.original_plural as l_plural) and then
				has_plural (a_entry.original_singular, l_plural, 1))
		end

feature -- Access

	has (original : STRING_GENERAL) : BOOLEAN
			-- is there an entry with original?
		do
			Result := singular_char_tree.get_item_with_key (original.as_string_32) /= Void
			if not Result then
				Result := plural_char_tree.get_item_with_key (original.as_string_32) /= Void
			end
		end

	has_plural (original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): BOOLEAN
			--
		local
			l_trans: detachable ARRAY [STRING_32]
		do
			if attached plural_char_tree.get_item_with_key (original_singular.as_string_32) as entry then
				if entry.has_plural then
					l_trans := entry.plural_translations
					check l_trans /= Void end -- Implied by `entry.has_plural'
					Result := l_trans.item(reduce (plural_number)) /= Void
				end
			end
		end

	singular (original: STRING_GENERAL): STRING_32
			-- get the translation of `original'
			-- in the singular form
		local
			t_entry: detachable I18N_DICTIONARY_ENTRY
			l_result: detachable STRING_32
		do
			t_entry := singular_char_tree.get_item_with_key (original.as_string_32)
			if t_entry /= Void then
				l_result := t_entry.singular_translation
			else -- because of the precondition it has to be in the plural_char_tree
				t_entry := plural_char_tree.get (original.as_string_32)
				check t_entry /= Void end -- Implied from precondition
				l_result := t_entry.singular_translation
			end
			check l_result /= Void end -- Implied from precondition
			Result := l_result
		end

	plural (original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): STRING_32
			-- get the translation of `original_singular'
			-- in the given plural form
		local
			l_result: detachable STRING_32
			l_entry: detachable I18N_DICTIONARY_ENTRY
			l_trans: detachable ARRAY [STRING_32]
		do
			l_entry := plural_char_tree.get(original_singular.as_string_32)
			check l_entry /= Void end -- Implied from precondition
			l_trans := l_entry.plural_translations
			check l_trans /= Void end -- Implied from precondition
			l_result := l_trans.item(reduce (plural_number))
			check l_result /= Void end -- Implied from precondition
			Result := l_result
		end

feature --Information

	count: INTEGER
		-- number of entries in the dictionary

feature {NONE}  -- Implementation

	singular_char_tree: CHARACTER_TREE [I18N_DICTIONARY_ENTRY]
			-- tree that contains all entries without plurals

	plural_char_tree: CHARACTER_TREE [I18N_DICTIONARY_ENTRY];
			-- tree that contains all entries with plurals

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
