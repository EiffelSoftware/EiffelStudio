indexing
	description: "Main interface to the i18n library. Provides access to translations and formatting objects for a given locale."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LOCALE

create
	make

feature -- Basic Operations

	make (a_dictionary: I18N_DICTIONARY; a_locale_info: I18N_LOCALE_INFO) is
			--assign info and dictionary with input values
		do
			info:=a_locale_info
			dictionary:=a_dictionary
			create date_formatter.make (a_locale_info)
			create string_formatter.default_create
			create value_formatter.make (a_locale_info)
			create currency_formatter.make (a_locale_info)
		end


	translate (original: STRING_GENERAL): STRING_32 is
			-- translate `original' if it exists
			-- otherwise `original' is returned
		require
			original_exists: original /= Void

		do
			if dictionary.has (original)then
				Result := dictionary.get_singular (original)
			else
				Result := original
			end
		ensure
			result_exists: Result /= Void
		end

	translate_plural (original_singular, original_plural: STRING_GENERAL; plural_form : INTEGER): STRING_32 is
			-- translate 'original_plural' if it exists
			-- otherwise 'original_plural' is returned
		require
			original_singular_exists: original_singular /= Void
			original_plural_exists: original_plural /= Void
		do
			if dictionary.has_plural (original_singular, original_plural, plural_form) then
				Result := dictionary.get_plural (original_singular, original_plural, plural_form)
			else
				if plural_form = 1 then
					Result := original_singular
				else
					Result := original_plural
				end
			end
		ensure
			result_exists: Result /= Void
		end

	format_string (original: STRING_GENERAL; token_values: TUPLE[ANY]): STRING_32 is
			-- replace tokens in the result of
			-- translate_plural (original)
		require
			original_exists: original /= Void
		do
			Result := string_formatter.format_string (original, token_values)
		ensure
			result_exists: Result /= Void
		end

feature -- Formatters

	date_formatter:		I18N_DATE_FORMATTER
	value_formatter:	I18N_VALUE_FORMATTER
	currency_formatter: I18N_CURRENCY_FORMATTER

feature -- Implementation

	info : I18N_LOCALE_INFO
		-- specific information about the locale

	dictionary:		I18N_DICTIONARY

	string_formatter:	I18N_STRING_FORMATTER;

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
