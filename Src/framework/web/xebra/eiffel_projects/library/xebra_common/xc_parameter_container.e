note
	description: "[
		Interface for objects that have one parameter
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_PARAMETER_CONTAINER


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create parameter.make_empty
		ensure then
			parameter_attached: parameter /= Void
		end

feature -- Access

	parameter: SETTABLE_STRING

	parameter_description: STRING
			-- The name of the parameter
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status Change

	set_parameter (a_parameter: STRING)
			-- Sets parameter.
		require
			a_parameter_attached: a_parameter /= Void
		do
			parameter := a_parameter
		ensure
			parameter_set: equal( parameter.value, a_parameter)
		end

invariant
	parameter_attached: parameter /= Void
note
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

