note
	description: "[
					Object that can display a tooltip of any form in a region
					Inherit this class to implement your own tooltipable widget.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GENERAL_TOOLTIPABLE

inherit
	ANY

	EVS_GENERAL_TOOLTIP_UTILITY
		export
			{NONE} all
		end

	EVS_SETTING_CHANGE_ACTIONS
		export
			{NONE} all
		end

feature -- Access

	veto_tooltip_display_functions: LINKED_LIST [FUNCTION [ANY, TUPLE, BOOLEAN]]
			-- Functions used to determine whether or not to display tooltip when other condition
			-- such as `is_tooltip_enabled', pointer on owner are all satisfied.
			-- A True value returned by a function indicates that tooltip should be displayed,
			-- a False value indicates that tooltip should not be displayed.
			-- So if any function in the list returns False, tooltip display is vetoed.
			-- This is useful for example when you want tooltip to display only when certain keys
			-- are pressed.
		do
			if veto_tooltip_display_functions_internal = Void then
				create veto_tooltip_display_functions_internal.make
			end
			Result := veto_tooltip_display_functions_internal
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	tooltip_remain_delay_time: INTEGER
			-- Time (in milliseconds) for tooltip to remain displayed when pointer is out of owner
			-- Default value is 0, meaning tooltip will disappear once pointer leaves owner region.

	tooltip_background_color: EV_COLOR
			-- Background color of tooltip window	

	force_tooltip_disappear_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Function used to determine whether or not to hide tooltip when other condition
			-- are all satisfied.
			-- This is useful for example when you want tooltip to disappear right away when certain keys
			-- are not pressed.

feature -- Element change

	set_tooltip_remain_delay_time (a_delay: INTEGER)
			-- Set `tooltip_remain_delay_time' with `a_delay' (in milliseconds).
		require
			a_delay_non_negative: a_delay >= 0
		do
			tooltip_remain_delay_time := a_delay
		ensure
			tooltip_remain_time_delay_set: tooltip_remain_delay_time = a_delay
		end

	set_tooltip_background_color (a_color: EV_COLOR)
			-- Set `tooltip_background_color' with `a_color'.
		require
			a_color_attached: a_color /= Void
		do
			lock_update
			tooltip_background_color := a_color
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_background_color_set: tooltip_background_color = a_color
		end

	set_tooltip_maximum_width (a_width: INTEGER)
			-- Set `maximum_width' with `a_width'.
		require
			a_width_non_negative: a_width >= 0
		do
			lock_update
			max_tooltip_width := a_width
			unlock_update
			try_call_setting_change_actions
		ensure
			max_tooltip_width_set: max_tooltip_width = a_width
		end

	set_tooltip_maximum_height (a_height: INTEGER)
			-- Set `maximum_height' with `a_height'.
		require
			a_height_non_negative: a_height >= 0
		do
			lock_update
			max_tooltip_height := a_height
			unlock_update
			try_call_setting_change_actions
		ensure
			max_tooltip_height_set: max_tooltip_height = a_height
		end

	set_tooltip_maximum_size (a_width: INTEGER; a_height: INTEGER)
			-- Set `maximum_width' with `a_width' and `maximum_height' with `a_height'.
		require
			a_width_non_negative: a_width >= 0
			a_height_non_negative: a_height >= 0
		do
			lock_update
			max_tooltip_width := a_width
			max_tooltip_height := a_height
			unlock_update
			try_call_setting_change_actions
		ensure
			max_tooltip_width_set: max_tooltip_width = a_width
			max_tooltip_height_set: max_tooltip_height = a_height
		end

	set_force_tooltip_disappear_function (a_veto_function: like force_tooltip_disappear_function)
			-- Set `force_tooltip_disappear_function' with `a_veto_function'.
		do
			force_tooltip_disappear_function := a_veto_function
		ensure
			force_tooltip_disappear_function_set: force_tooltip_disappear_function = a_veto_function
		end

feature {EVS_GENERAL_TOOLTIP_WINDOW} -- Element change

	set_is_pointer_on_tooltip (b: BOOLEAN)
			-- Set `is_pointer_on_tooltip' with `b'.
		do
			if is_pointer_on_tooltip_enabled then
				is_pointer_on_tooltip := b
			end
		ensure
			is_pointer_on_tooltip_set: is_pointer_on_tooltip_enabled implies is_pointer_on_tooltip = b
		end

	set_is_tooltip_pined (b: BOOLEAN)
			-- Set `is_tooltip_pined' with `b'.
		do
			is_tooltip_pined := b
		ensure
			is_tooltip_pined_set: is_tooltip_pined = b
		end

	set_pointer_on_tooltip (b: BOOLEAN)
			-- Set `is_pointer_on_tooltip' with `b'.
		do
			is_pointer_on_tooltip := b
		ensure
			is_pointer_on_tooltip_set: is_pointer_on_tooltip = b
		end

	set_picking_from_tooltip (b: BOOLEAN)
			-- Set `is_picking_from_tooltip' with `b'.
		do
			is_picking_from_tooltip := b
		ensure
			is_picking_from_tooltip_set: is_picking_from_tooltip = b
		end

	setup_timer (timeout: INTEGER; a_agent: detachable PROCEDURE [ANY, TUPLE])
			-- Setup `timer' with `timeout' and `a_agent'.
			-- Used to start `timer' or stop it (when `timeout' is 0 and `a_agent' is Void)
		require
			timeout_non_negative: timeout >= 0
		do
			timer.actions.wipe_out
			if a_agent /= Void then
				timer.actions.extend (a_agent)
			end
			timer.set_interval (timeout)
		ensure
			timer_set: timer.interval = timeout and a_agent /= Void implies timer.actions.has (a_agent)
		end

feature -- Status setting

	enable_tooltip
			-- Enable tooltip.
		do
			safe_register_agent (pointer_enter_agent, owner_pointer_enter_actions)
			safe_register_agent (pointer_leave_agent, owner_pointer_leave_actions)
			if attached owner_select_actions as l_actions then
				safe_register_agent (select_agent, l_actions)
			end
			is_tooltip_enabled := True
		ensure
			tooltip_enabled: is_tooltip_enabled
			agents_registered:
				owner_pointer_enter_actions.has (pointer_enter_agent) and
				owner_pointer_leave_actions.has (pointer_leave_agent) and
				owner_select_actions /= Void implies owner_select_actions.has (select_agent)
		end

	disable_tooltip
			-- Disable tooltip.
		do
			if is_tooltip_enabled then
				if is_my_tooltip then
					if is_my_tooltip_displayed then
						tooltip_window.hide_tooltip
					end
					tooltip_window.detach_owner
				end
				setup_timer (0, Void)
				safe_remove_agent (pointer_enter_agent, owner_pointer_enter_actions)
				safe_remove_agent (pointer_leave_agent, owner_pointer_leave_actions)
				if owner_select_actions /= Void then
					safe_remove_agent (select_agent, owner_select_actions)
				end
				is_tooltip_enabled := False
			end
		ensure
			my_tooltip_do_not_exist: not is_my_tooltip
			tooltip_enabled: not is_tooltip_enabled
			agents_removed:
				not owner_pointer_enter_actions.has (pointer_enter_agent) and
				not owner_pointer_leave_actions.has (pointer_leave_agent) and
				owner_select_actions /= Void implies not owner_select_actions.has (select_agent)
		end

	enable_pointer_on_tooltip
			-- Enable that tooltip will remain displayed when pointer is on tooltip region,
			-- even pointer is not on owner region.
		do
			is_pointer_on_tooltip_enabled := True
		ensure
			pointer_on_tooltip_enabled: is_pointer_on_tooltip_enabled
		end

	disable_pointer_on_tooltip
			-- Make sure that tooltip will disappear once pointer is out of owner region.
		do
			is_pointer_on_tooltip_enabled := False
			is_pointer_on_tooltip := False
		ensure
			pointer_on_tooltip_disabled: not is_pointer_on_tooltip_enabled
		end

	enable_tooltip_shadow
			-- Enable shadow of pop-up tooltip window.
		do
			lock_update
			is_tooltip_shadow_enabled := True
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_shadow_enabled: is_tooltip_shadow_enabled
		end

	disable_tooltip_shadow
			-- Disable shadow of pop-up tooltip window.
		do
			lock_update
			is_tooltip_shadow_enabled := False
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_shadow_disabled: not is_tooltip_shadow_enabled
		end

	enable_repeat_tooltip_display
			-- Enable that tooltip will be displayed repeatedly when pointer is on tooltip region,
			-- even pointer is not on owner region.
		do
			is_repeat_tooltip_display_enabled := True
		ensure
			repeat_tooltip_display_enabled: is_repeat_tooltip_display_enabled
		end

	disable_repeat_tooltip_display
			-- Make sure that tooltip will be displayed once when pointer is out of owner region.
		do
			is_repeat_tooltip_display_enabled := False
		ensure
			repeat_tooltip_display_disabled: not is_repeat_tooltip_display_enabled
		end

feature -- Advanced operations

	force_enter
			-- Force `pointer_enter_agent' to be called.
		do
			if is_tooltip_enabled then
				pointer_enter_agent.call (Void)
			end
		end

	force_leave
			-- Force `pointer_leave_agent' to be called.
		do
			if is_tooltip_enabled then
				pointer_leave_agent.call (Void)
			end
		end

feature -- Status report

	is_tooltip_enabled: BOOLEAN
			-- Is tooltip of current enabled?
			-- Default: False

	is_pointer_on_tooltip_enabled: BOOLEAN
			-- Is tooltip remain display enabled on pointer is on tooltip region?
			-- Default: False			

	is_picking_from_tooltip: BOOLEAN
			-- Is picking under going from displayed tooltip window?			

	is_pointer_on_tooltip: BOOLEAN
			-- Is pointer on tooltip?

	is_pointer_on_owner: BOOLEAN
			-- Is pointer on owner region?

	is_tooltip_shadow_enabled: BOOLEAN
			-- Is there a shadow displayed under pop-up tooltip window?
			-- Default: False
			-- |Fixme: Implement later.

	is_tooltip_pined: BOOLEAN
			-- Is current displayed tooltip pined?
			-- e.g. it should not disappear even pointer is out of its region and its owner's region
			-- for any given time.

	is_repeat_tooltip_display_enabled: BOOLEAN
			-- Will tooltip be displayed repeatedly when pointer on owner's region?
			-- If disabled, once a tooltip disappears, you have to move your pointer out of owner's region,
			-- and then move it back to reactivate the tooltip again.
			-- Default: False		

feature {NONE} -- Status report

	is_my_tooltip_displayed: BOOLEAN
			-- Is tooltip for current displayed?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.owner = Current and then tooltip_window.is_displayed
		ensure
			good_result: Result implies (tooltip_window.is_displayed and then tooltip_window.owner = Current)
		end

	is_others_tooltip_displayed: BOOLEAN
			-- Is tooltip for others displayed?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.owner /= Current and then tooltip_window.is_displayed
		ensure
			good_result: Result implies (tooltip_window.is_displayed and then tooltip_window.owner /= Current)
		end

	is_tooltip_displayed: BOOLEAN
			-- Is tooltip displayed, no mater whether it's mine or other's?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.is_displayed
		ensure
			good_result: Result implies tooltip_window.is_displayed
		end

	is_my_tooltip: BOOLEAN
			-- Does tooltip belong to current?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.has_owner and then tooltip_window.owner = Current
		ensure
			good_result: Result implies (tooltip_window.has_owner and then tooltip_window.owner = Current)
		end

	is_pointer_in_current_app: BOOLEAN
			-- If pointer in current application process area?
		local
			l_screen: EV_SCREEN
		do
			create l_screen
			Result := l_screen.widget_at_mouse_pointer /= Void
		end

feature -- Measure

	max_tooltip_width: INTEGER
			-- Max width in pixel allowed for tooltip

	max_tooltip_height: INTEGER
			-- Max height in pixel allowed for tooltip

	required_tooltip_width: INTEGER
			-- Required width in pixel to display tooltip
			-- If `max_tooltip_width' is larger than this, `max_tooltip_width' will be used when
			-- tooltip is displayed.
		require
			tooltip_enabled: is_tooltip_enabled
		deferred
		ensure
			result_non_negative: Result >= 0
		end

	required_tooltip_height: INTEGER
			-- Required height in pixel to display tooltip
			-- If `max_tooltip_height' is larger than this, `max_tooltip_height' will be used when
			-- tooltip is displayed.
		require
			tooltip_enabled: is_tooltip_enabled
		deferred
		ensure
			result_non_negative: Result >= 0
		end

	pointer_offset: INTEGER = 20
			-- y offset to display tooltip window
			-- This is the offset for tooltip window to be displayed below or in some cases above pointer.

feature {EVS_GENERAL_TOOLTIP_WINDOW} -- Status report

	is_owner_destroyed: BOOLEAN
			-- If owner destroyed
			-- Attach this to owner's `is_destroyed'.
		deferred
		end

	tooltip_widget: EV_WIDGET
			-- Widget of tooltip
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Actions

	before_display_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed just before current tooltip is displayed
		do
			if before_display_actions_internal = Void then
				create before_display_actions_internal
			end
			Result := before_display_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Owner actions

	owner_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer enter actions of owner of current tooltip
			-- Attach this to owner's `pointer_enter_actions'.
		deferred
		ensure
			result_attached: Result /= Void
		end

	owner_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer leave actions of owner of current tooltip
			-- Attach this to owner's `pointer_leave_actions'.			
		deferred
		ensure
			result_attached: Result /= Void
		end

	owner_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions of owner of current tooltip
			-- Attach this to owner's `select_actions'.
		deferred
		end

feature {NONE} -- Actions

	on_pointer_enter
			-- Action to be performed when pointer enters current tooltip owner
		do
			is_pointer_on_owner := True
			if is_tooltip_enabled then
				if not is_my_tooltip_displayed then
					setup_timer (tooltip_delay_time, agent show_tooltip)
				end
			end
		ensure then
			pointer_on_owner: is_pointer_on_owner
		end

	on_pointer_leave
			-- Action to be performed when pointer leaves current tooltip owner
		do
			is_pointer_on_owner := False
			if is_tooltip_enabled and then is_my_tooltip_displayed and then not is_picking_from_tooltip then
				if tooltip_remain_delay_time > 0 then
					setup_timer (tooltip_remain_delay_time, agent safe_hide_tooltip)
				else
					setup_timer (0, Void)
					safe_hide_tooltip
				end
			else
				setup_timer (0, Void)
			end
		ensure then
			pointer_not_on_owner: not is_pointer_on_owner
		end

	on_selected
			-- Actions to be performed when tooltip owner is selected
		do
			if is_tooltip_enabled then
					-- User performed an action and is not expecting a tooltip for the default
					-- tooltip duration. We reset the timer
				restart_tooltip_timer
			end
		end

feature -- Basic operations

	restart_tooltip_timer
			-- Restarts tooltip timer so the timer must complete a full time out duration before being displayed
		require
			is_tooltip_enabled: is_tooltip_enabled
		local
			l_interval: INTEGER
		do
			l_interval := timer.interval
			timer.reset_count
			timer.set_interval (l_interval)
		end

feature {NONE} -- Tooltip show/hide

	show_tooltip
			-- Show tooltip.
		require
			tooltip_enabled: is_tooltip_enabled
			my_tooltip_not_displayed: not is_my_tooltip_displayed
		local
			l_window: like tooltip_window
			l_show: BOOLEAN
			l_need_change_owner: BOOLEAN
		do
			if is_pointer_in_current_app then
				l_window := tooltip_window
				if not is_my_tooltip then
					l_need_change_owner := True
						-- We only display tooltip of current if other's tooltip is not pined.					
					l_show := (l_window.has_owner and attached l_window.owner as o) implies (not o.is_tooltip_pined)
				elseif not is_my_tooltip_displayed then
					l_show := True
				end
				if l_show then
					if not before_display_actions.is_empty then
						before_display_actions.call (Void)
					end
					if not is_tooltip_display_vetoed then
						if is_tooltip_displayed then
							l_window.hide_tooltip
						end
						if l_need_change_owner then
							if l_window.has_owner then
								l_window.detach_owner
							end
							l_window.attach_owner (Current)
						end
						l_window.show_tooltip (screen.pointer_position.x, screen.pointer_position.y)
						setup_timer (tooltip_status_check_time, agent safe_hide_tooltip)
					end
				end
			end
		end

	hide_tooltip
			-- Hide tooltip.
		require
			tooltip_enabled: is_tooltip_enabled
			my_tooltip_displayed: is_my_tooltip_displayed
		local
			l_hide: BOOLEAN
		do
			if not is_tooltip_pined then
				if not is_picking_from_tooltip and then force_tooltip_disappear_function /= Void then
					force_tooltip_disappear_function.call (Void)
					l_hide := force_tooltip_disappear_function.last_result
				end
				if not l_hide and then not (is_pointer_on_tooltip_enabled and then is_pointer_on_tooltip) and not is_pointer_on_owner then
					l_hide := True
				end

				if not is_pointer_in_current_app then
					l_hide := True
				end

				if l_hide then
					setup_timer (0, Void)
					tooltip_window.hide_tooltip
					if is_repeat_tooltip_display_enabled and then is_pointer_on_owner then
						on_pointer_enter
					end
				end
			end
		ensure
			-- Tooltip should be hidden if the following satisfied:
			-- 	1. Tooltip is not pined and
			-- 	2. Pointer is not on tooltip while `is_pointer_on_tooltip_enabled' is True or tooltip is not on owner
			--  3. Not picking from tooltip and `force_tooltip_disppear_function' is attached and returns True.
--			my_tooltip_hiden:
--				 (not is_tooltip_pined and then
--				 (not (is_pointer_on_tooltip_enabled and then is_pointer_on_tooltip) and
--				 not is_pointer_on_owner)) implies not is_my_tooltip_displayed
		end

	force_hide_tooltip
			-- Force to hide tooltip, don't care about other conditions at all.
		require
			tooltip_enabled: is_tooltip_enabled
		do
			if is_my_tooltip_displayed then
				setup_timer (0, Void)
				tooltip_window.hide_tooltip
				if is_repeat_tooltip_display_enabled and then is_pointer_on_owner then
					on_pointer_enter
				end
			end
		ensure
			tooltip_hidden: not is_my_tooltip_displayed
		end

	safe_hide_tooltip
			-- Hide tooltip if it's displayed.
		require
			tooltip_enabled: is_tooltip_enabled
		do
			if is_my_tooltip_displayed then
				hide_tooltip
			end
		end

feature{NONE} -- Implementation

	timer: EV_TIMEOUT
			-- Timer used to simulate tooltip delay time
		do
			if timer_internal = Void then
				create timer_internal
			end
			Result := timer_internal
		ensure
			result_attached: Result /= Void
		end

	timer_internal: EV_TIMEOUT
			-- Internal timer used to simulate tooltip delay time

	pointer_enter_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to wrap `on_pointer_enter'
		do
			Result := pointer_enter_agent_internal
			if Result = Void then
				Result := agent on_pointer_enter
				pointer_enter_agent_internal := Result
			end
		ensure
			result_attached: Result /= Void
		end

	pointer_leave_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to wrap `on_pointer_leave'
		do
			Result := pointer_leave_agent_internal
			if Result = Void then
				Result := agent on_pointer_leave
				pointer_leave_agent_internal := Result
			end
		ensure
			result_attached: Result /= Void
		end

	select_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to wrap `on_selected'
		do
			Result := select_agent_internal
			if Result = Void then
				Result := agent on_selected
				select_agent_internal := Result
			end
		ensure
			result_attached: Result /= Void
		end

	pointer_enter_agent_internal: like pointer_enter_agent
			-- Implementation of once per object  `pointer_enter_agent'

	pointer_leave_agent_internal: like pointer_leave_agent
			-- Implementation of once per object `pointer_leave_agent'

	select_agent_internal: like select_agent
			-- Implementation of once per object `select_agent'

	before_display_actions_internal: like before_display_actions
			-- Implementation of `before_display_actions'

	actual_tooltip_background_color: EV_COLOR
			-- Actual border line color used to draw border line
		do
			if tooltip_background_color = Void then
				Result := tooltip_background_color_internal
			else
				Result := tooltip_background_color
			end
		ensure
			result_attached: Result /= Void
		end

	tooltip_background_color_internal: EV_COLOR
			-- Internal `tooltip_background_color'
		local
			l_style: EVS_TOOLTIP_STYLE
		do
			create l_style.make
			Result := l_style.tooltip_background_color
		ensure
			result_attached: Result /= Void
		end

	tooltip_status_check_time: INTEGER = 100
			-- Time interval in milliseconds to check tooltip status		

	veto_tooltip_display_functions_internal: like veto_tooltip_display_functions
			-- Implementation of once per object `veto_tooltip_display_functions'

	is_tooltip_display_vetoed: BOOLEAN
			-- Is tooltip display vetoed according to `veto_tooltip_display_functions'?
			-- If any function in `veto_tooltip_display_functions' returns True,
			-- tooltip display is vetoed.
		local
			l_func: like veto_tooltip_display_functions
			l_cursor: CURSOR
		do
			l_func := veto_tooltip_display_functions
			if not l_func.is_empty then
				l_cursor := l_func.cursor
				from
					l_func.start
				until
					l_func.after or Result
				loop
					Result := not l_func.item.item (Void)
					l_func.forth
				end
				if l_cursor /= Void then
					l_func.go_to (l_cursor)
				end
			end
		end

invariant
	tooltip_background_color_internal_attached: tooltip_background_color_internal /= Void
	actual_background_color_attached: actual_tooltip_background_color /= Void
	timer_attached: timer /= Void
	tooltip_window_attached: tooltip_window /= Void
	pointer_enter_agent_attached: pointer_enter_agent /= Void
	pointer_leave_agent_attached: pointer_leave_agent /= Void

note
        copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end
