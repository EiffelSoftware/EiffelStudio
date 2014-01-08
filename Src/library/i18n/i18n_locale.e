note
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

	make (a_dictionary: I18N_DICTIONARY; a_locale_info: I18N_LOCALE_INFO)
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

	translation (original: READABLE_STRING_GENERAL): STRING_32
			-- Translation of `original' in locale
			--
			-- `original': String to translate
			-- `Result': Translated string, or the original string if no translation is available
		require
			original_not_void: original /= Void
		do
			Result := translation_in_context (original, Void)
		ensure
			result_attached: Result /= Void
		end

	plural_translation (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER): STRING_32
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
			Result := plural_translation_in_context (original_singular, original_plural, Void, plural_number)
		ensure
			result_attached: Result /= Void
		end

	translation_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): STRING_32
			-- Translation of `original' in locale
			--
			-- `original': String to translate
			-- `a_context': Context stringg of current message
			-- `Result': Translated string, or the original string if no translation is available
		require
			original_not_void: original /= Void
		do
			if attached dictionary.singular_in_context (original, a_context) as l_singular then
				Result := l_singular
			else
				Result := original.as_string_32
			end
		ensure
			result_attached: Result /= Void
		end

	plural_translation_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL; plural_number: INTEGER): STRING_32
			-- Translation of `original_singular' or `original_plural' in locale depending on `plural_number'
			--
			-- `original_singular': String to translate if singular is used
			-- `original_plural': String to translate if plural is used
			-- `a_context': Context stringg of current message
			-- `plural_number': Plural number to use
			-- `Result': Translation of singular or plural string, or the original string if no translation is available
		require
			original_singular_not_void: original_singular /= Void
			original_plural_not_void: original_plural /= Void
		do
			if attached dictionary.plural_in_context (original_singular, original_plural, plural_number, a_context) as l_plural then
				Result := l_plural
			else
				if plural_number = 1 then
					Result := original_singular.as_string_32
				else
					Result := original_plural.as_string_32
				end
			end
		ensure
			result_attached: Result /= Void
		end

	formatted_string (original: READABLE_STRING_GENERAL; token_values: TUPLE): STRING_32
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
		do
			Result := string_formatter.formatted_string (original, token_values)
		ensure
			result_attached: Result /= Void
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

	info_not_void: info /= Void
	date_formatter_not_void: date_formatter /= Void
	value_formatter_not_void: value_formatter /= Void
	currency_formatter_not_void: currency_formatter /= Void
	string_formatter_not_void: string_formatter /= Void
	dictionary_not_void: dictionary /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
