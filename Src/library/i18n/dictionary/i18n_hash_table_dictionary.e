indexing
	description: "Simple implementation of DICTIONARY using a hash table to store entries"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
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

feature --Creation

	make (a_plural_form: INTEGER) is
			-- create the datastructure
		do
			Precursor(a_plural_form)
			create hash.make(default_number_of_entries)
		end

feature --Insertion

	extend (a_entry: I18N_DICTIONARY_ENTRY) is
		-- add an entry
		do
			hash.extend (a_entry, a_entry.original_singular)
		end

feature --Access

	has (original: STRING_GENERAL):BOOLEAN is
			-- does the dictionary have this entry?
		do
			Result := hash.has (original.as_string_32)
		end

	has_plural(original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): BOOLEAN is
			-- does the dictionary have an entry with `original_singular', `original_plural'
			-- and does this entry have the `plural_number'-th plural translation
		local
			entry: I18N_DICTIONARY_ENTRY
		do
			if hash.has (original_singular.as_string_32) then
					entry := hash.item (original_singular.as_string_32)
					if entry.plural_translations.item(reduce (plural_number)) /= Void then
						Result := True
					end
			end
		end

	get_singular(original:STRING_GENERAL): STRING_32 is
			-- get the singular translation of `original'
		do
			Result := hash.item (original.as_string_32).singular_translation
		end

	get_plural(original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): STRING_32 is
			-- get the `plural_number'-th plural translation of entry
			-- with `original_singular' and `original_plural'
		do
			Result := hash.item(original_singular.as_string_32).plural_translations.item(reduce (plural_number))
		end



feature --Information

	count:INTEGER is
			-- number of items in hash table
		do
			Result := hash.count
		end


feature {NONE} --Implementation

		hash: HASH_TABLE[I18N_DICTIONARY_ENTRY, STRING_32]
		default_number_of_entries: INTEGER is 50

end
