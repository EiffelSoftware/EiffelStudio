indexing
	description: "Implementation of DICTIONARY that stores no strings at all. Used if no translation is found"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_DUMMY_DICTIONARY

	inherit
		I18N_DICTIONARY

create
	make


feature -- Reporting

	count: INTEGER is 0


feature -- Entries

	extend (entry: I18N_DICTIONARY_ENTRY) is
			-- Doesn't in fact extend the dictionary
		do
		end

	has (original_singular: STRING_32):BOOLEAN is
			-- Always False, as we don't have any entries
		do
			Result := False -- Let's be very clear on this..
		end

	has_plural(original_singular, original_plural: STRING_32; plural_number: INTEGER): BOOLEAN is
			-- Always False, as we don't have any entries
		do
			Result := False
		end

feature -- Retrieval

	get_singular (original_singular: STRING_32): STRING_32 is
			-- This should never be called because we garantee the precondition is false
		do
			Result := ""
		end

	get_plural(original_singular, original_plural: STRING_32; plural_number: INTEGER): STRING_32 is
			-- This should never be called because we garantee the precondition is false
		do
			Result := ""
		end






end
