indexing
	description: "Implementation of DICTIONARY using a CHARACTER_TREE to store the entries"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
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

feature -- Initialization

	make(a_plural_form:INTEGER) is
			-- create the datastructure
		do
			Precursor(a_plural_form)
			create singular_char_tree
			create plural_char_tree
		end

feature  -- Manipulation

	-- this should be restricted

	extend (a_entry : I18N_DICTIONARY_ENTRY) is
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
		end

feature -- Access

	has (original : STRING_GENERAL) : BOOLEAN is
			-- is there an entry with original?
		do
			Result := singular_char_tree.get_item_with_key (original.as_string_32) /= Void
			if not Result then
				Result := plural_char_tree.get_item_with_key (original.as_string_32) /= Void
			end
		end

	has_plural (original_singular, original_plural : STRING_GENERAL; plural_number : INTEGER) : BOOLEAN is
			--
		local
			entry: I18N_DICTIONARY_ENTRY
		do
			entry := plural_char_tree.get_item_with_key (original_singular.as_string_32)
			if entry /= Void and then
			   entry.plural_translations.item(reduce (plural_number)) /= Void  then
				Result := True
			end
		end

	get_singular ( original : STRING_GENERAL) : STRING_32 is
			-- get the translation of `original'
			-- in the singular form
		local
			t_entry: I18N_DICTIONARY_ENTRY
		do
			t_entry := singular_char_tree.get_item_with_key (original.as_string_32)
			if t_entry /= Void then
				Result := t_entry.singular_translation
			else -- because of the precondition it has to be in the plural_char_tree
				Result := plural_char_tree.get (original.as_string_32).singular_translation
			end
		end

	get_plural (original_singular, original_plural : STRING_GENERAL; plural_number : INTEGER) : STRING_32 is
			-- get the translation of `original_singular'
			-- in the given plural form
		do
			Result := plural_char_tree.get(original_singular.as_string_32).plural_translations.item(reduce (plural_number))
		end

feature --Information


		count: INTEGER

			-- number of entries in the dictionary
feature {NONE}  -- Implementation

	singular_char_tree: CHARACTER_TREE[I18N_DICTIONARY_ENTRY]
			-- tree that contains all entries without plurals

	plural_char_tree: CHARACTER_TREE[I18N_DICTIONARY_ENTRY]
			-- tree that contains all entries with plurals

end
