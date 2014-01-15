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

	I18N_DICTIONARY_ID_BUILDER
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make,
	make_with_plural

feature {NONE} --creation

	make (an_original_singular, a_translated_singular: READABLE_STRING_GENERAL)
			-- create the entry for a singular-form string
		require
			singular_not_void: an_original_singular /= Void
			translated_singular_not_void: a_translated_singular /= Void
		do
			original_singular := an_original_singular.to_string_32
			singular_translation := a_translated_singular.to_string_32
			create plural_translations.make_filled ({STRING_32} "", 0, 3) -- there are at most 4 forms, INDEX IS 0-BASED!!!!!!!!!!!!			
		ensure
			original_singular_set: original_singular.is_equal (an_original_singular.as_string_32)
			singular_translation_set: singular_translation.is_equal (a_translated_singular.as_string_32)
		end

	make_with_plural (an_original_singular, a_translated_singular, an_original_plural: READABLE_STRING_GENERAL)
			-- create the entry for a string with both plural and singular forms
			-- the actual plural translations will have to be added by hand!
		require
			singular_not_void: an_original_singular /= Void
			translated_singular_not_void: a_translated_singular /= Void
		do
			make (an_original_singular, a_translated_singular)
			original_plural := an_original_plural.to_string_32
		ensure
			original_singular_set: original_singular.is_equal (an_original_singular.as_string_32)
			singular_translation_set: singular_translation.is_equal (a_translated_singular.as_string_32)
			original_plural_set: original_plural ~ (an_original_plural.as_string_32)
			plural_translations_array_exists: plural_translations /= Void
			has_plural: has_plural
		end

feature -- Element Change

	set_context (a_context: like context)
			-- Set `context' with `a_context'.
		do
			context := a_context
				-- Remove cached identifier to recompute.
			cached_identifier := Void
		ensure
			context_set: context = a_context
		end

feature -- Query

	has_plural: BOOLEAN
			-- Does entry has a plural?
		do
			Result := original_plural /= Void
		end

feature -- Access

	identifier: STRING_32
			-- Identifier of the entry
		do
			if attached cached_identifier as l_id then
				Result := l_id
			else
				Result := id_from_original_and_context (original_singular, context)
				cached_identifier := Result
			end
		end

feature -- Contents

	original_singular: STRING_32

	original_plural: detachable STRING_32

	singular_translation: STRING_32

	plural_translations: ARRAY [STRING_32]

	context: detachable STRING_32

feature -- Order definition

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := identifier < other.identifier
		end

feature {NONE} -- Implementation

	cached_identifier: detachable like identifier
			-- Cached identifier

invariant
	original_plural_set: has_plural implies original_plural /= Void

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
