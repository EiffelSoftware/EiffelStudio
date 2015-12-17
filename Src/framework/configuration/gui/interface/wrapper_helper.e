note
	description: "Some helper wrappers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPPER_HELPER

feature {NONE} -- Wrappers

	change_no_argument_boolean_wrapper (a_dummy: BOOLEAN; a_call: PROCEDURE)
			-- Wrapper that allows to plugin in an agent without arguments on a change call (e.g. to refresh inheritance information).
		require
			a_call_not_void: a_call /= Void
		do
			a_call.call (Void)
		end

	change_no_argument_wrapper (a_dummy: ANY; a_call: PROCEDURE)
			-- Wrapper that allows to plugin in an agent without arguments on a change call (e.g. to refresh inheritance information).
		require
			a_call_not_void: a_call /= Void
		do
			a_call.call (Void)
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
