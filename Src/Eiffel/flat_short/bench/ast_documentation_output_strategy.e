note
	description: "Output strategy for documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DOCUMENTATION_OUTPUT_STRATEGY

inherit
	AST_DECORATED_OUTPUT_STRATEGY
		rename
			make as make_old
		redefine
			process_class_as
		end

create
	make

feature {NONE} -- Initialization

	make (a_text_formatter: like text_formatter_decorator; a_doc: like documentation)
			-- Format `a_node' in `a_text_formatter' in `a_is_simple' mode.
		require
			a_text_not_void: a_text_formatter /= Void
			a_doc_not_void: a_doc /= Void
		do
			make_old (a_text_formatter)
			documentation := a_doc
		end

feature -- Process

	process_class_as (l_as: CLASS_AS)
		do
			text_formatter_decorator.process_filter_item (f_class_declaration, true)

			text_formatter_decorator.process_filter_item (f_menu_bar, true)
			documentation.insert_class_menu_bar (text_formatter_decorator, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (current_class.name).as_lower)
			text_formatter_decorator.process_filter_item (f_menu_bar, false)

			share_class_processing (l_as)

			text_formatter_decorator.process_filter_item (f_menu_bar, true)
			documentation.insert_class_menu_bar (text_formatter_decorator, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (current_class.name).as_lower)
			text_formatter_decorator.process_filter_item (f_menu_bar, false)
			text_formatter_decorator.process_filter_item (f_class_declaration, false)
			text_formatter_decorator.put_new_line
		end

feature {NONE} -- Implementation

	documentation: DOCUMENTATION_ROUTINES;
			-- For documentation

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
