note
	description: "Flags for IDispatch.Invoke"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_IDISPATCH_INVOKE_CONSTANTS

feature -- Access

		-- Ref: http://msdn.microsoft.com/en-us/library/cc237569%28v=prot.13%29.aspx
	dispatch_method: INTEGER = 0x1
	dispatch_propertyget: INTEGER = 0x2
	dispatch_propertyput: INTEGER = 0x4
	dispatch_propertyputref: INTEGER = 0x8

feature -- Query

	valid_type (a_type: INTEGER): BOOLEAN
			-- Is `a_type' valid?
		do
			Result :=
				a_type = dispatch_method or
				a_type = dispatch_propertyget or
				a_type = dispatch_propertyput or
				a_type = dispatch_propertyputref
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
