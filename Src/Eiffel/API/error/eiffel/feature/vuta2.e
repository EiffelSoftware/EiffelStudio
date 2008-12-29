note
	description: "Error in Object_call which target is not attached"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VUTA2

inherit
	VUTA
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; t: like target_type; l: LOCATION_AS)
			-- Create error object for Object_call target
			-- of type `t' at location `l' in the context `c'.
		require
			c_attached: c /= Void
			t_attached: t /= Void
			l_attached: l /= Void
		do
			c.init_error (Current)
			target_type := t
			set_location (l)
		ensure
			target_type_set: target_type = t
		end

feature -- Error properties

	subcode: INTEGER = 2
			-- Subcode of error

feature {NONE} -- Access

	target_type: TYPE_A
			-- Target typel

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			Precursor (a_text_formatter)
			a_text_formatter.add ("Type: ")
			target_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

note
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
