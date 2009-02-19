note
	description: "Class used for encapsulating translations of a string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_DICTIONARY_ENTRY

inherit
	COMPARABLE

create
	make,
	make_with_plural

feature --creation

	make (an_original_singular, a_translated_singular: STRING_GENERAL)
			-- create the entry for a singular-form string
		require
			singular_not_void: an_original_singular /= Void
			translated_singular_not_void: a_translated_singular /= Void
		do
			original_singular := an_original_singular.to_string_32
			singular_translation := a_translated_singular.to_string_32
		ensure
			original_singular_set: original_singular.is_equal (an_original_singular.as_string_32)
			singular_translation_set: singular_translation.is_equal (a_translated_singular.as_string_32)
		end

	make_with_plural(an_original_singular, a_translated_singular, an_original_plural: STRING_GENERAL)
			-- create the entry for a string with both plural and singular forms
			-- the actual plural translations will have to be added by hand!
		require
			singular_not_void: an_original_singular /= Void
			translated_singular_not_void: a_translated_singular /= Void
		do
			make(an_original_singular, a_translated_singular)
			original_plural := an_original_plural.to_string_32
			create plural_translations.make (0,3) -- there are at most 4 forms, INDEX IS 0-BASED!!!!!!!!!!!!
			has_plural := True
		ensure
			original_singular_set: original_singular.is_equal (an_original_singular.as_string_32)
			singular_translation_set: singular_translation.is_equal (a_translated_singular.as_string_32)
			original_plural_set: original_plural.is_equal (an_original_plural.as_string_32)
			plural_translations_array_exists: plural_translations /= Void
			has_plural: has_plural
		end

feature	-- Contents

	original_singular: STRING_32
	original_plural: STRING_32
	singular_translation: STRING_32
	plural_translations: ARRAY[STRING_32]
	has_plural: BOOLEAN

feature -- Order definition

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := original_singular < other.original_singular
		end

invariant
	no_plural_translations_if_no_plural: not has_plural implies plural_translations = Void
	plural_translations_if_plural: has_plural implies plural_translations /= Void

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
