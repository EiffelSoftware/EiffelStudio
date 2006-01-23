indexing
	description: "Allows non GUI threads to add idle actions to GUI thread%
					%Protect all access to idle actions list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_APPLICATION_IMP

inherit
	EV_APPLICATION_IMP
		redefine
			make,
			add_idle_action,
			message_loop,
			process_events_until_stopped,
			idle_actions
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create mutex and call precursor.
		do
			create idle_action_mutex
			Precursor {EV_APPLICATION_IMP} (an_interface)
		end

feature -- Event Handling

	add_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Extend `idle_actions' with `a_idle_action'.
			-- Thread safe
		do
			idle_action_mutex.lock
			idle_actions.extend (a_idle_action)
			idle_action_mutex.unlock
		end

feature -- Event handling

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when the application is otherwise idle.
		do
			idle_action_mutex.lock
			Result := Precursor {EV_APPLICATION_IMP}
			idle_action_mutex.unlock
		end

feature {NONE} -- Implementation

	message_loop is
			-- Windows message loop.
		local
			msg: WEL_MSG
		do
			from
				create msg.make
			until
				quit_requested
			loop
				msg.peek_all
				if msg.last_boolean_result then
					process_message (msg)
				else
					idle_action_mutex.lock
					if not internal_idle_actions.is_empty then
						internal_idle_actions.call (Void)
						idle_action_mutex.unlock
					elseif idle_actions_internal /= Void and then not idle_actions_internal.is_empty then
						idle_actions_internal.call (Void)
						idle_action_mutex.unlock
					else
						idle_action_mutex.unlock
						msg.wait
					end
				end
			end
		end

	process_events_until_stopped is
			-- Process all events until 'stop_processing' is called.
		local
			msg: WEL_MSG
		do
			from
				create msg.make
				msg.peek_all
			until
				msg.message = stop_processing_requested_msg
			loop
				if msg.last_boolean_result then
					process_message (msg)
				else
					idle_action_mutex.lock
					if not internal_idle_actions.is_empty then
						internal_idle_actions.call (Void)
						idle_action_mutex.unlock
					elseif idle_actions_internal /= Void and then not idle_actions_internal.is_empty then
						idle_actions_internal.call (Void)
						idle_action_mutex.unlock
					else
						idle_action_mutex.unlock
						msg.wait
					end
				end
				msg.peek_all
			end
		end

	idle_action_mutex: MUTEX;
			-- Mutex used to access `idle_actions'

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_THREAD_APPLICATION_IMP
