note
	description: "Manifest array explicit type is not a class type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VWMA_NO_CLASS_TYPE

inherit
	VWMA
		rename
			make as make_parent
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; t: TYPE_A; l: LOCATION_AS)
			-- Initialize error object for invalid type `t`
			-- at location `l' in the context `c'.
		require
			c_attached: attached c
			t_attached: attached t
			l_attached: attached l
		do
			make_parent (c, l)
			type := t
		ensure
			type_set: type = t
		end

feature {NONE} -- Access

	type: TYPE_A
			-- Specified manifest array type.

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			trace_single_line (t)
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Manifest array type {1} is not a class type.", "compiler.error"),
				<<agent type.append_to>>)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
