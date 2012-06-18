note
	description: "Handler used for propagating event loop for EV_APPLICATION from another processor if needed."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EV_APPLICATION_HANDLER

inherit
	EV_ANY_HANDLER

create {EV_APPLICATION}
	default_create

feature {EV_APPLICATION}

	is_application_i_set: BOOLEAN
			-- Has `application_i' been set by application object?
		do
			Result := application_i /= Void
		end

	set_application (a_app_i: separate EV_APPLICATION_I)
			-- Set `application_i' to `a_app_i'.
		require
			application_not_set: not is_application_i_set
		do
			application_i := a_app_i
		end

	launch
			-- Execute event loop on `application_i'.
		require
			application_i_set: is_application_i_set
		local
			l_application_i: like application_i
		do
			if application_i /= Void then
					-- This is implied by the precondition.
				from
					l_application_i := application_i
				until
					is_application_destroyed (l_application_i)
				loop
					process_application_event_queue (l_application_i)
				end
			end
		end

feature {NONE} -- SCOOP handling.

	process_application_event_queue (a_app_i: attached like application_i)
			-- Run a single event iteration on `a_app'.
		do
			a_app_i.process_event_queue (True)
		end

	is_application_destroyed (a_app_i: attached like application_i): BOOLEAN
			-- Has `a_app' been destroyed?
		do
			Result := a_app_i.is_destroyed
		end

feature {NONE} -- Access

	application_i: detachable separate EV_APPLICATION_I note option: stable attribute end;
		-- Application implementation object from which to propagate event loop.

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
