note
	description: "Shared output signs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_OUTPUT_TOOLS

feature -- Access

	error_window: OUTPUT_WINDOW
			-- Error window that displays error message
		once
			Result := init_error_window
		end

feature {NONE} -- Implementation

	init_error_window: OUTPUT_WINDOW
			-- error window. this function is redefined for graphic mode
		do
			Result := term_window
		end

	term_window: TERM_WINDOW
			-- terminal output. Used in text mode
		local
-- Uncomment those lines when it is fully committed
--			l_service: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
		once
--			create l_service
--			check is_service_available: l_service.is_service_available end
--			Result := l_service.service.output ((create {OUTPUT_MANAGER_KINDS}).general).writer
			create Result
		end

note
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

end -- class EB_SHARED_OUTPUT_TOOLS
