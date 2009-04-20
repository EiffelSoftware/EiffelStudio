note
	description: "Layout for ec."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_EIFFEL_LAYOUT

inherit
	EIFFEL_ENV
		rename
			environment as environment_access
		redefine
			set_environment
		end

feature -- Access

	application_name: STRING = "ec"
			-- <Precursor>

feature {NONE} -- Helpers

	environment: SERVICE_CONSUMER [ENVIRONMENT_S]
			-- Shared access to the environment service
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Environment: Update

	set_environment (a_value: STRING; a_var: STRING)
			-- <Precursor>
		local
			l_env: like environment
		do
			l_env := environment
			if l_env.is_service_available then
				l_env.service.set_environment_variable (a_value, a_var)
			else
				Precursor {EIFFEL_ENV} (a_value, a_var)
			end
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
