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

feature {NONE} -- Initialization

	make (a_dictionary: I18N_DICTIONARY; a_locale_info: I18N_LOCALE_INFO) is
			-- Initialize locale with dictionary and locale information.
			--
			-- `a_dictionary': Dictionary to use to translate strings
			-- `a_locale_info': Information about the locale
		require
			a_dictionary_not_void: a_dictionary /= Void
			a_locale_info_not_void: a_locale_info /= Void
		do
			info := a_locale_info
			dictionary := a_dictionary
			create date_formatter.make (a_locale_info)
			create string_formatter.default_create
			create value_formatter.make (a_locale_info)
			create currency_formatter.make (a_locale_info)
		ensure
			dictionary_set: dictionary = a_dictionary
			info_set: info = a_locale_info
		end

feature -- Access

	info: I18N_LOCALE_INFO
			-- Specific information about locale

feature -- Basic Operations

	translate (original: STRING_GENERAL): STRING_32 is
			-- Translation of `original' in locale
			--
			-- `original': String to translate
			-- `Result': Translated string, or the original string if no translation is available
		require
			original_not_void: original /= Void
		do
			if dictionary.has (original) then
				Result := dictionary.get_singular (original)
			else
				Result := original
			end
		ensure
			result_not_void: Result /= Void
		end

	translate_plural (original_singular, original_plural: STRING_GENERAL; plural_number: INTEGER): STRING_32 is
			-- Translation of `original_singular' or `original_plural' in locale depending on `plural_number'
			--
			-- `original_singular': String to translate if singular is used
			-- `original_plural': String to translate if plural is used
			-- `plural_number': Plural number to use
			-- `Result': Translation of singular or plural string, or the original string if no translation is available
		require
			original_singular_not_void: original_singular /= Void
			original_plural_not_void: original_plural /= Void
		do
			if dictionary.has_plural (original_singular, original_plural, plural_number) then
				Result := dictionary.get_plural (original_singular, original_plural, plural_number)
			else
				if plural_number = 1 then
					Result := original_singular
				else
					Result := original_plural
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	format_string (original: STRING_GENERAL; token_values: TUPLE[ANY]): STRING_32 is
			-- String which has it's tokens replaced by given values
			--
			-- The string given can have token placeholders in the form of '$1'
			-- (dollar sign followed by token number). Each placeholder will be
			-- replaced with the tuple value indexed by the placeholder number.
			--
			-- Note: the escape token can be set in the string formatter, the
			-- dollar sign is the default value.
			--
			-- `original': Original string with possible token placeholders
			-- `token_values': Values which will be replaced in the placeholders
			-- `Result': String which has token placeholders replaced with values
		require
			original_not_void: original /= Void
			token_values_not_void: token_values /= Void
			token_values_valid: string_formatter.valid_arguments (token_values)
			correct_number_of_tokens: string_formatter.required_arguments (original) = token_values.count
		do
			Result := string_formatter.format_string (original, token_values)
		ensure
			result_not_void: Result /= Void
		end

feature -- Formatters

	date_formatter: I18N_DATE_FORMATTER
			-- Formatter used to format locale-specific dates

	value_formatter: I18N_VALUE_FORMATTER
			-- Formatter used to format locale-specific values

	currency_formatter: I18N_CURRENCY_FORMATTER
			-- Formatter used to format locale-specific currencies

	string_formatter: I18N_STRING_FORMATTER
			-- Formatter used to format locale-specific strings

feature {NONE} -- Implementation

	dictionary:	I18N_DICTIONARY
			-- Dictionary which holds translated strings

invariant

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
