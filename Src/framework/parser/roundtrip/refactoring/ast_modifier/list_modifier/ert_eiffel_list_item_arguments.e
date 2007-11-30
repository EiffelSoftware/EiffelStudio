indexing
	description: "EIFFEL_LIST modification arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EIFFEL_LIST_ITEM_ARGUMENTS

feature -- Access		

	separator: STRING
			-- Separator used to separate items.
			-- Empty if no separator is needed.

	has_separator: BOOLEAN is
			-- Do we deal with separators?
		do
			Result := separator /= Void and then not separator.is_empty
		end

	leading_text: STRING
			-- Leading text to be added before every prepended/appended item

	trailing_text: STRING
			-- Trailing text to be added after every prepended/appended item

feature -- Setting

	set_separator (a_separator: STRING) is
			-- Set `separator' with `a_separator'.
			-- If `a_separator' is Void or empty, separators will not be processed.
		do
			if a_separator = Void then
				create separator.make (0)
			else
				separator := a_separator.twin
			end
		ensure
			separator_set: (a_separator = Void implies separator.is_empty) and
						   (a_separator /= Void implies separator.is_equal (a_separator))
		end

	set_leading_text (a_text: STRING) is
			-- Set `leading_text' with `a_text'.
		do
			if a_text = Void then
				leading_text := ""
			else
				leading_text := a_text.twin
			end
		ensure
			leading_text_set: (a_text = Void implies leading_text.is_empty) and (a_text /= Void implies leading_text.is_equal (a_text))
		end

	set_trailing_text (a_text: STRING) is
			-- Set `trailing_text' with `a_text'.
		do
			if a_text = Void then
				trailing_text := ""
			else
				trailing_text := a_text.twin
			end
		ensure
			trailing_text_set: (a_text = Void implies trailing_text.is_empty) and (a_text /= Void implies trailing_text.is_equal (a_text))
		end

	set_arguments (a_separator, a_leading_text, a_trailing_text: STRING) is
			-- Setup arguments.
		do
			set_separator (a_separator)
			set_leading_text (a_leading_text)
			set_trailing_text (a_trailing_text)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
