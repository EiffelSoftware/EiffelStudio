note
	description: "[
		An internationalization formatter used by ESF.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_LOCALE_FORMATTER

inherit
	ANY

	SHARED_LOCALE
		export
			{NONE} all
		end

feature -- Basic operations

	translation (a_string: READABLE_STRING_GENERAL): attached STRING_32
			-- Translation of `a_string' in locale
			--
			-- `a_string': String to translate
			-- `Result': Translated string, or the original string if no translation is available
		require
			a_string_attached: a_string /= Void
		do
			if attached {STRING_32} locale.translation (a_string.as_string_8) as l_result then
				Result := l_result
			else
				check False end
				create Result.make_empty
			end
		end

	plural_translation (a_singular: READABLE_STRING_GENERAL; a_plural: READABLE_STRING_GENERAL; a_plural_number: INTEGER): attached STRING_32
			-- Translation of `a_singular' or `a_plural' in locale depending on `a_plural_number'
			--
			-- `a_singular': String to translate if singular is used
			-- `a_plural': String to translate if plural is used
			-- `a_plural_number': Plural number to use
			-- `Result': Translation of singular or plural string, or the original string if no translation is available
		require
			a_singular_attached: a_singular /= Void
			a_plural_attached: a_plural /= Void
			a_plural_number_non_negative: a_plural_number >= 0
		do
			if attached {STRING_32} locale.plural_translation (a_singular.as_string_8, a_plural.as_string_8, a_plural_number) as l_result then
				Result := l_result
			else
				check False end
				create Result.make_empty
			end
		end

	formatted_translation (a_string: READABLE_STRING_GENERAL; a_values: TUPLE): attached STRING_32
			-- String which has it's tokens replaced by given values
			--
			-- The string given can have token placeholders in the form of '$1'
			-- (dollar sign followed by token number). Each placeholder will be
			-- replaced with the tuple value indexed by the placeholder number.
			--
			-- Note: the escape token can be set in the string formatter, the
			-- dollar sign is the default value.
			--
			-- `a_string': Original string with possible token placeholders
			-- `a_values': Values which will be replaced in the placeholders
			-- `Result': String which has token placeholders replaced with values
		require
			a_string_attached: a_string /= Void
			a_values_attached: a_values /= Void
		do
			if attached {STRING_32} locale.formatted_string (a_string.as_string_8, a_values) as l_result then
				Result := l_result
			else
				check False end
				create Result.make_empty
			end
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
