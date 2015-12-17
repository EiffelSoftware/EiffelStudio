note
	description:
		"A delayed action operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DELAYED_ACTION_ARGS [G -> detachable TUPLE create default_create end]

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
		require
			v_attached: v /= Void
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

	call (args: like last_args)
			-- Directly call the action (no delay)
		do
			cancel_request
			last_args := args
			real_call
		end

	real_call
		do
			if is_kamikazed then
				if delayed_action.valid_operands (last_args) then
					delayed_action.call (last_args)
				end
				last_args := ({G}).default_detachable_value
			else
				repeat_call
			end
		end

	repeat_call
			-- Call `delayed_action' continuously every `internal' milliseconds.
		local
			l_timer: like action_timer
		do
			l_timer := action_timer
			if l_timer = Void then
				create l_timer.make_with_interval (interval)
				action_timer := l_timer
			else
				l_timer.actions.wipe_out
				l_timer.set_interval (interval)
			end
			l_timer.actions.extend (agent delayed_action.call (last_args))
		end

	request_call (args: G)
			-- Request evaluation of `delayed_action' after `delay'
		local
			l_timer: like delayed_action_timer
		do
			last_args := args
			dispose_action_timer
			if delay = 0 then
				call (last_args)
			else
				if attached on_request_start_action as l_on_request_start_action then
					l_on_request_start_action.call (Void)
				end
				l_timer := delayed_action_timer
				if l_timer = Void then
					create l_timer.make_with_interval (delay)
					delayed_action_timer := l_timer
					l_timer.actions.extend (agent real_call)
				elseif reset_timer_on_request then
					l_timer.set_interval (delay)
				end
			end
		ensure
			delayed_action_timer_created: delay > 0 implies delayed_action_timer /= Void
		end

	cancel_request
			-- Cancel request
		do
			if attached delayed_action_timer as dat then
				dat.actions.wipe_out
				dat.destroy
				delayed_action_timer := Void
				dispose_action_timer
				if attached on_request_end_action as a then
					a.call (Void)
				end
			end
			last_args := ({G}).default_detachable_value
		ensure
			delayed_action_timer_destroyed: delayed_action_timer = Void
		end

feature {NONE} -- Delayed cleaning implementation

	last_args: detachable G

	on_request_start_action: detachable PROCEDURE
			-- Action to be called on request

	on_request_end_action: detachable PROCEDURE
			-- Action to be called on cancelling
			-- or after the request is completed (so just before the delayed_action)

	delayed_action: PROCEDURE [G]
			-- Action to be called

	delayed_action_timer: detachable EV_TIMEOUT
			-- Timer used to process the delay

	action_timer: detachable EV_TIMEOUT;
			-- Timer used to call `delayed_action' continuously

	dispose_action_timer
			-- Dispose `action_timer'.
		do
			if attached action_timer as t then
				t.actions.wipe_out
				t.destroy
				action_timer := Void
			end
		end

invariant

	delayed_action_exists: delayed_action /= Void

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
