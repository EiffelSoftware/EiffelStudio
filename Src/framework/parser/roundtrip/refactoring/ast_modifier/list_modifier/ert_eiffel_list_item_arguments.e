note
	description: "EIFFEL_LIST modification arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EIFFEL_LIST_ITEM_ARGUMENTS

inherit
	SHARED_ENCODING_CONVERTER

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access		

	separator: detachable  STRING
			-- Separator used to separate items.
			-- Empty if no separator is needed.

	has_separator: BOOLEAN
			-- Do we deal with separators?
		do
			Result := attached separator as l_sep and then not l_sep.is_empty
		end

	leading_text: detachable STRING
			-- Leading text to be added before every prepended/appended item

	trailing_text: detachable STRING
			-- Trailing text to be added after every prepended/appended item

feature -- Setting

	set_separator_32 (a_separator: detachable STRING_32)
			-- Set `separator' with `a_separator'.
			-- If `a_separator' is Void or empty, separators will not be processed.
			-- `a_separator' is in UTF-32.
		do
			if a_separator = Void then
				create separator.make (0)
			else
				separator := encoding_converter.utf32_to_utf8 (a_separator)
			end
		ensure
			separator_set: (a_separator = Void implies (attached separator as l_sep and then l_sep.is_empty)) and
						   (a_separator /= Void implies (attached separator as l_sep and then l_sep.same_string (encoding_converter.utf32_to_utf8 (a_separator))))
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Setting

	set_separator (a_separator: detachable STRING)
			-- Set `separator' with `a_separator'.
			-- If `a_separator' is Void or empty, separators will not be processed.
		do
			if a_separator = Void then
				create separator.make (0)
			else
				separator := a_separator.twin
			end
		ensure
			separator_set: (a_separator = Void implies (attached separator as l_sep and then l_sep.is_empty)) and
						   (a_separator /= Void implies (attached separator as l_sep and then l_sep.same_string (a_separator)))
		end

	set_leading_text (a_text: detachable STRING)
			-- Set `leading_text' with `a_text'.
		do
			if a_text = Void then
				leading_text := ""
			else
				leading_text := a_text.twin
			end
		ensure
			leading_text_set: (a_text = Void implies (attached leading_text as l_leading_text and then l_leading_text.is_empty)) and (a_text /= Void implies attached leading_text as l_leading_text and then l_leading_text.same_string (a_text))
		end

	set_trailing_text (a_text: detachable STRING)
			-- Set `trailing_text' with `a_text'.
		do
			if a_text = Void then
				trailing_text := ""
			else
				trailing_text := a_text.twin
			end
		ensure
			trailing_text_set: (a_text = Void implies (attached trailing_text as l_trailing_text and then l_trailing_text.is_empty)) and (a_text /= Void implies attached trailing_text as l_trailing_text and then l_trailing_text.same_string (a_text))
		end

	set_arguments (a_separator, a_leading_text, a_trailing_text: detachable STRING)
			-- Setup arguments.
		do
			set_separator (a_separator)
			set_leading_text (a_leading_text)
			set_trailing_text (a_trailing_text)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
