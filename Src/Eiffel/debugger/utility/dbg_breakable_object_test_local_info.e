note
	description: "Summary description for {DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO

create
	make

feature {NONE} -- Initialization

	make (a_bp: like breakable_index; a_bpn: like breakable_nested_index)
			-- Instanciate Current
		do
			breakable_index := a_bp
			breakable_nested_index := a_bpn
		end

feature -- Access

	breakable_index: INTEGER
			-- break index

	breakable_nested_index: INTEGER
			-- nested break index

	name_id: detachable ID_AS assign set_name
			-- Object test local's name id

	type: detachable TYPE_AS assign set_type
			-- Object test local's type	

	expression: detachable EXPR_AS assign set_expression
			-- Object test local's expression	

feature -- Element change

	set_name (v: like name_id)
			-- Set `name_id' to `v'
		do
			name_id := v
		end

	set_type (v: like type)
			-- Set `type' to `v'
		do
			type := v
		end

	set_expression (v: like expression)
			-- Set `expression' to `v'
		do
			expression := v
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
