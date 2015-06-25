note
	description: "[
		Before SCOOP appeared, the event loop of a graphical application would run in the main thread
		after creating the initial graphical objects. That thread would enter an event loop to process
		new events. That thread was also called the GUI thread.
		
		In SCOOP mode this doesn't work because a processor stuck in a loop cannot process any logged
		calls. In other words, it means that you cannot perform calls on a separate widget `my_widget'
		as they will be logged but only applied after the processor has completed its event loop and
		exited its current application of a call.

		To circumvent this, we require the following guidelines. A GUI processor is created, this is
		where the EV_APPLICATION object and all GUI objects are created. The GUI processor is similar
		to the GUI thread in non-SCOOP mode. However we require the GUI processor to not do anything
		else after calling {EV_APPLICATION}.launch so that it enters the idle mode of SCOOP processors.

		Internally when calling `launch' from the EV_APPLICATION instance, we will create a separate
		instance of EV_APPLICATION_HANDLER which will continuously log calls to process events on the
		GUI processor. Since the GUI processor is idle, it will be able to log and apply calls coming
		from any other separate processors that wants to interact with the GUI.
		]"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EV_APPLICATION_HANDLER

inherit
	EV_ANY_HANDLER

create {EV_APPLICATION}
	make

feature {NONE} -- Initialization

	make (an_app: separate EV_APPLICATION)
			-- Initialize Current with `an_app'.
		do
			application_i := an_app.implementation
		ensure
			application_i_set: application_i = an_app.implementation
		end

feature {EV_APPLICATION}

	launch
			-- Execute event loop on `application_i'.
		local
			l_application_i: like application_i
		do
			from
				l_application_i := application_i
			until
				is_application_destroyed (l_application_i)
			loop
				process_application_event_queue (l_application_i)
			end
		end

feature {NONE} -- SCOOP handling.

	process_application_event_queue (a_app_i: like application_i)
			-- Run a single event iteration on `a_app'.
		do
			a_app_i.process_event_queue (True)
		end

	is_application_destroyed (a_app_i: like application_i): BOOLEAN
			-- Has `a_app' been destroyed?
		do
			Result := a_app_i.is_destroyed
		end

feature {NONE} -- Access

	application_i: separate EV_APPLICATION_I
		-- Application implementation object from which to propagate event loop.

invariant

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
