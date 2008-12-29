note
	description:
		"A delayed action operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DELAYED_ACTION

create
	make,
	make_in_non_kamikazed_mode

feature {NONE} -- Initialization

	make (	a_delayed_action: like delayed_action;
			a_delay: like delay
			)
			-- Initialize Current with `a_delayed_action' and `a_delay'.
			-- Current is in kamikazed mode by default (See `enable_kamikazed' for more information).
		require
			a_delayed_action_attached: a_delayed_action /= Void
			a_delay_non_negative: a_delay >= 0
		do
			delayed_action := a_delayed_action
			delay := a_delay
			reset_timer_on_request := True
			enable_kamikazed
		ensure
			delayed_action_set: delayed_action = a_delayed_action
			delay_set: delay = a_delay
			kamikazed_enabled: is_kamikazed
		end

	make_in_non_kamikazed_mode ( a_delayed_action: like delayed_action;
							 a_delay: like delay;
							 a_interval: like interval)
			-- Initialze Current in non-kamikazed mode.
		require
			a_delayed_action /= Void
			a_delay_non_negative: a_delay >= 0
			a_interval_positive: a_interval > 0
		do
			make (a_delayed_action, a_delay)
			set_interval (a_interval)
			disable_kamikazed
		ensure
			delayed_action_set: delayed_action = a_delayed_action
			delay_set: delay = a_delay
			interval_set: interval = a_interval
			kamikazed_disabled: not is_kamikazed
		end

feature -- Changes

	set_delayed_action (v: like delayed_action)
			-- Change the `delayed_action'
		do
			delayed_action := v
		end

	set_delay (d: like delay)
			-- Change the `delay'
		do
			delay := d
		end

	set_on_request_start_action (v: like on_request_start_action)
			-- Change the `on_request_start_action'
		do
			on_request_start_action := v
		end

	set_on_request_end_action (v: like on_request_end_action)
			-- Change the `on_request_end_action'
		do
			on_request_end_action := v
		end

	set_interval (a_interval: INTEGER)
			-- Set `interval' with `a_interval'.
		require
			a_interval_positive: a_interval > 0
		do
			interval := a_interval
		ensure
			interval_set: interval = a_interval
		end

	enable_reset_timer_on_request
			-- Enable reset_timer_on_request
		do
			reset_timer_on_request := True
		end

	disable_reset_timer_on_request
			-- Disable reset_timer_on_request
		do
			reset_timer_on_request := False
		end

	enable_kamikazed
			-- Ensure `delayed_action' will be invoked in kamikazed mode.
			-- Has effects the next time when `requrest_call' is called.
		do
			is_kamikazed := True
		ensure
			is_kamikazed_set: is_kamikazed
		end

	disable_kamikazed
			-- Ensure `delayed_action' will be invoked in non-kamikazed mode.
			-- Has effects the next time when `request_call' is called.
		do
			is_kamikazed := False
		ensure
			is_kamikazed_set: not is_kamikazed
		end

feature -- Properties

	delay: INTEGER
			-- Number of milliseconds waited before calling calling action

	reset_timer_on_request: BOOLEAN
			-- Reset the timer interval if a request occurs while a request is running ?
			-- default: True

	is_kamikazed: BOOLEAN
			-- Is `delayed_action' kamikazed?
			-- e.g., should `delayed_action' only be called once?
			-- default: True

	interval: INTEGER
			-- Time between calls to `delayed_action' in milliseconds.
			-- If 0, then `actions' are disabled.
			-- Have effect only when `is_kamikazed' is True

feature -- Delayed action access

	delayed_action_exists: BOOLEAN
			-- Is there any delayed_action set ?
		do
			Result := delayed_action /= Void
		end

	call
			-- Directly call the action (no delay)
		require
			delayed_action_exists: delayed_action_exists
		do
			cancel_request
			if is_kamikazed then
				delayed_action.call (Void)
			else
				repeat_call
			end
		end

	repeat_call
			-- Call `delayed_action' continuously every `internal' milliseconds.
		do
			if action_timer = Void then
				create action_timer.make_with_interval (interval)
			else
				action_timer.actions.wipe_out
				action_timer.set_interval (interval)
			end
			action_timer.actions.extend (delayed_action)
		end

	request_call
			-- Request evaluation of `delayed_action' after `delay'
		require
			delayed_action_exists: delayed_action_exists
		do
			dispose_action_timer
			if delay = 0 then
				call
			else
				if on_request_start_action /= Void then
					on_request_start_action.call (Void)
				end
				if delayed_action_timer = Void then
					create delayed_action_timer.make_with_interval (delay)
					delayed_action_timer.actions.extend (agent call)
				elseif reset_timer_on_request then
					delayed_action_timer.set_interval (delay)
				end
			end
		ensure
			delayed_action_timer_created: delay > 0 implies delayed_action_timer /= Void
		end

	cancel_request
			-- Cancel request
		require
			delayed_action_exists: delayed_action_exists
		do
			if delayed_action_timer /= Void then
				delayed_action_timer.actions.wipe_out
				delayed_action_timer.destroy
				delayed_action_timer := Void
				dispose_action_timer
				if on_request_end_action /= Void then
					on_request_end_action.call (Void)
				end
			end
		ensure
			delayed_action_timer_destroyed: delayed_action_timer = Void
		end

	destroy
			-- Destroy current
		do
			on_request_start_action := Void
			on_request_end_action := Void --| avoid calling end action when cancelling request
			cancel_request
			delayed_action := Void
		ensure
			destroyed: 	on_request_start_action = Void and then
						on_request_end_action = Void and then
						delayed_action = Void and then
						action_timer = Void and then
						delayed_action_timer = Void
		end

feature {NONE} -- Delayed cleaning implementation

	on_request_start_action: PROCEDURE [ANY, TUPLE]
			-- Action to be called on request

	on_request_end_action: PROCEDURE [ANY, TUPLE]
			-- Action to be called on cancelling
			-- or after the request is completed (so just before the delayed_action)

	delayed_action: PROCEDURE [ANY, TUPLE]
			-- Action to be called

	delayed_action_timer: EV_TIMEOUT
			-- Timer used to process the delay

	action_timer: EV_TIMEOUT;
			-- Timer used to call `delayed_action' continuously

	dispose_action_timer
			-- Dispose `action_timer'.
		do
			if action_timer /= Void then
				action_timer.actions.wipe_out
				action_timer.destroy
				action_timer := Void
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
