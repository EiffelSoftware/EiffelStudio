note
	description:
		"Action sequence used for versioning calls"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords:
		"event, action"
	date:
		"$Date$"
	revision:
		"$Revision$"

class
	EV_LITE_ACTION_SEQUENCE [EVENT_DATA -> TUPLE create default_create end]

inherit
	ACTION_SEQUENCE [EVENT_DATA]
		redefine
			call
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, is_equal, copy
		end

	EV_ANY_HANDLER
		undefine
			default_create, is_equal, copy
		end

create
	default_create

create {EV_LITE_ACTION_SEQUENCE}
	make_filled

feature -- Basic operations

	call (event_data: detachable EVENT_DATA)
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		do
			if count > 0 then
					-- We need to update the global event counter.
				shared_environment.implementation.application_i.increase_action_sequence_call_counter
				Precursor (event_data)
			end
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end -- class EV_LITE_ACTION_SEQUENCE
