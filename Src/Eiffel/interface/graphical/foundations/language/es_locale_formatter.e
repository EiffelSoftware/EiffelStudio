indexing
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
	SHARED_LOCALE
		export
			{NONE} all
		end

feature -- Basic operations

	translation (a_string: !STRING_GENERAL): !STRING_32
			-- Translation of `a_string' in locale
			--
			-- `a_string': String to translate
			-- `Result': Translated string, or the original string if no translation is available
		do
			if {l_result: !STRING_32} locale.translation (a_string) then
				Result := l_result
			else
				check False end
				create Result.make_empty
			end
		end

	plural_translation (a_singular, a_plural: !STRING_GENERAL; a_plural_number: INTEGER): !STRING_32
			-- Translation of `a_singular' or `a_plural' in locale depending on `a_plural_number'
			--
			-- `a_singular': String to translate if singular is used
			-- `a_plural': String to translate if plural is used
			-- `a_plural_number': Plural number to use
			-- `Result': Translation of singular or plural string, or the original string if no translation is available
		require
			a_plural_number_non_negative: a_plural_number >= 0
		do
			if {l_result: !STRING_32} locale.plural_translation (a_singular, a_plural, a_plural_number) then
				Result := l_result
			else
				check False end
				create Result.make_empty
			end
		end

	formatted_string (a_string: !STRING_GENERAL; a_values: !TUPLE): !STRING_32
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
		do
			if {l_result: STRING_32} locale.formatted_string (a_string, a_values) then
				Result := l_result
			else
				check False end
				create Result.make_empty
			end
		end


;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
