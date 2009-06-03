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

	has (original_singular: STRING_GENERAL):BOOLEAN
			-- Always False, as we don't have any entries
		do
			Result := False -- Let's be very clear on this..
		end

	has_plural(original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): BOOLEAN
			-- Always False, as we don't have any entries
		do
			Result := False
		end

feature -- Retrieval

	singular (original_singular: STRING_GENERAL): STRING_32
			-- This should never be called because we garantee the precondition is false
		do
			Result := ""
		end

	plural(original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): STRING_32
			-- This should never be called because we garantee the precondition is false
		do
			Result := ""
		end

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
