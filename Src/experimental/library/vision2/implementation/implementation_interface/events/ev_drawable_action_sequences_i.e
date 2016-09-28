note
	description: "Action sequences for expose actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWABLE_ACTION_SEQUENCES_I

feature -- Event handling

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when an area needs to be redrawn.
		do
			if attached expose_actions_internal as l_result then
				Result := l_result
			else
				create Result
				init_expose_actions (Result)
				expose_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	expose_actions_internal: detachable EV_GEOMETRY_ACTION_SEQUENCE
			-- Implementation of once per object `expose_actions'.
		note
			option: stable
		attribute
		end;

	init_expose_actions (a_expose_actions: like expose_actions)
			-- Initialize `a_expose_actions' accordingly to the current widget.
		do
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end










