indexing
	description: "Objects that represents a debugger evaluation error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	fixme: "use MULTI_ERROR_MANAGER"

class
	DBG_ERROR

feature -- Access

	code: INTEGER assign set_code
			-- Integer value representing Current Error

	tag: STRING_32 assign set_tag
			-- One line description for Current Error
			--| can be Void

	msg: STRING_32 assign set_message
			-- Text description for Current Error
			--| can be Void

feature -- Element change

	set_code (v: like code)
			-- Set `code' to `v'
		require
			code_positive: v > 0
		do
			code := v
		end

	set_tag (v: like tag)
			-- Set `tag' to `v'
		do
			tag := v
		end

	set_message (v: like msg)
			-- Set `msg' to `v'
		do
			msg := v
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
