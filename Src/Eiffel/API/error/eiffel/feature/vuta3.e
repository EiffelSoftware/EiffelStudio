note
	description: "Error in Object_call which separate target is uncontrolled."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VUTA3

inherit
	VUTA
		rename
			make as make_vuta
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; t: like target_type; m: detachable STRING_32; l: LOCATION_AS)
			-- Create error object for Object_call target
			-- of type `t' at location `l' in the context `c'.
		require
			c_attached: c /= Void
			t_attached: t /= Void
			l_attached: l /= Void
		do
			make_vuta (c, t, l)
			message := m
		ensure
			target_type_set: target_type = t
			message = m
		end

feature -- Error properties

	subcode: INTEGER = 3
			-- Subcode of error

feature {NONE} -- Access

	message: detachable STRING_32
			-- Feature called on a separate target.

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			Precursor (t)
			if attached message as m then
				t.add ("Called feature: ")
				t.add (m)
				t.add_new_line
			end
		end

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
