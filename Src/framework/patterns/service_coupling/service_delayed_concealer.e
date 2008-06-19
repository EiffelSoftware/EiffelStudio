indexing
	description: "[
		Encapsulates a service object so that the services is created, through an activator function,
		when requested for the first time.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SERVICE_DELAYED_CONCEALER

inherit
	SERVICE_CONCEALER_I

create {SERVICE_CONTAINER_I}
	make

feature {NONE} -- Initialization

	make (a_activator: !like activator)
			-- Initialize concealer with activator function `activator'
			--
			-- `a_activator': A function used to retrieve a service object, when the service is requested
			--                for the first time.
		do
			activator := a_activator
		ensure
			activator_set: activator = a_activator
		end

feature -- Access

	service: ?SERVICE_I
			-- <Precursor>
		local
			l_activator: ?like activator
		do
			Result := internal_service
			if Result = Void then
				l_activator := activator
				if l_activator /= Void then
					Result := activator.item (Void)
					if Result /= Void then
							-- Detach activator as it is no longer required
						activator := Void
					end
					internal_service := Result
				end
			end
		ensure then
			internal_service_set: internal_service = Result
			activator_detached: Result /= Void implies activator = Void
		end

feature {NONE} -- Access

	activator: ?FUNCTION [ANY, TUPLE, ?SERVICE_I]
			-- The function use to delay-active a service.
			-- Note: Once the service has been activated the function will not long be available.

feature {NONE} -- Implementation: Internal cache

	internal_service: ?like service
			-- Cached version of `service'.
			-- Note: Do not use directly!

invariant
	activator_attached: internal_service = Void implies activator /= Void
	activator_detached: internal_service /= Void implies activator = Void

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {SERVICE_DELAYED_CONCEALER}
