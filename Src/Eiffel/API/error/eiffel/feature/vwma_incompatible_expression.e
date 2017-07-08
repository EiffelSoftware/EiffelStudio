note
	description: "A type of a manifest array element is not compatible with the type of the array."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VWMA_INCOMPATIBLE_EXPRESSION

inherit
	VWMA
		rename
			make as make_parent
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; t, e: TYPE_A; i: INTEGER; l: LOCATION_AS)
			-- Initialize error object for expression type `t`at index `i`
			-- incompatible with expected element type `e`
			-- at location `l' in the context `c'.
		require
			c_attached: attached c
			t_attached: attached t
			e_attached: attached e
			l_attached: attached l
		do
			make_parent (c, l)
			expression_type := t
			element_type := e
			index := i
		ensure
			expression_type_set: expression_type = t
			element_type_set: element_type = e
			index_set: index = i
		end

feature {NONE} -- Access

	index: INTEGER
			-- Index of the invalid element.

	expression_type: TYPE_A
			-- Actual type of an expression.

	element_type: TYPE_A
			-- Expected element type.

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format (t, locale.translation_in_context ("Manifest array element at index {1} has type {2} incompatible with declared element type {3}.", "compiler.error"),
				<<
					agent {TEXT_FORMATTER}.add_int (index),
					agent expression_type.append_to,
					agent element_type.append_to
				>>)
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format (t, locale.translation_in_context ("Array element at index {1} has type {2} incompatible with {3}.", "compiler.error"),
				<<
					agent {TEXT_FORMATTER}.add_int (index),
					agent expression_type.append_to,
					agent element_type.append_to
				>>)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
