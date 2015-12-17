note
	description: "Abstract class used by TRACE_MANAGER to dispatch tracing events to user using STRING data via an agent."
	legal: "See notice at end of class."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

class
	AGENT_TRACING_HANDLER

inherit
	STRING_TRACING_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_action: like action)
			-- Initialize Current with `a_action'
		require
			a_action_not_void: a_action /= Void
		do
			action := a_action
		ensure
			action_set: action = a_action
		end

feature -- Access

	action: PROCEDURE [TUPLE [type: TYPE [detachable ANY]; class_name, feature_name: detachable STRING; depth: INTEGER; is_entering: BOOLEAN]]
			-- Action being performed each time `trace' is called

feature -- Tracing

	trace (a_type: TYPE [detachable ANY]; a_class_name, a_feature_name: detachable STRING; a_depth: INTEGER; a_is_entering: BOOLEAN)
			-- <Precursor>
		do
			action.call ([a_type, a_class_name, a_feature_name, a_depth, a_is_entering])
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
