note
	description: "Implementation of DICTIONARY that stores no strings at all. Used if no translation is found"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_DUMMY_DICTIONARY

inherit

	I18N_DICTIONARY

create
	make

feature -- Reporting

	count: INTEGER = 0

feature -- Entries

	extend (entry: I18N_DICTIONARY_ENTRY)
			-- Doesn't in fact extend the dictionary
		do
		end

	has_in_context (original_singular: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Always False, as we don't have any entries
		do
			Result := False -- Let's be very clear on this..
		end

feature -- Retrieval

	singular_in_context (original_singular: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- This should never be called because we garantee the precondition is false
		do
		end

	plural_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- This should never be called because we garantee the precondition is false
		do
		end

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
