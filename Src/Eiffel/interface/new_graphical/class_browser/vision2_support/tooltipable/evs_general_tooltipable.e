indexing
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
	EVS_GENERAL_TOOLTIP_UTILITY

	EVS_SETTING_CHANGE_ACTIONS

feature -- Setting

	enable_tooltip is
			-- Enable tooltip.
		do
			safe_register_agent (pointer_enter_agent, owner_pointer_enter_actions)
			safe_register_agent (pointer_leave_agent, owner_pointer_leave_actions)
			is_tooltip_enabled := True
		ensure
			tooltip_enabled: is_tooltip_enabled
			agents_registered:
				owner_pointer_enter_actions.has (pointer_enter_agent) and
				owner_pointer_leave_actions.has (pointer_leave_agent)
		end

	disable_tooltip is
			-- Enable tooltip.
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
				is_tooltip_enabled := False
			end
		ensure
			my_tooltip_do_not_exist: not is_my_tooltip
			tooltip_enabled: not is_tooltip_enabled
			agents_removed:
				not owner_pointer_enter_actions.has (pointer_enter_agent) and
				not owner_pointer_leave_actions.has (pointer_leave_agent)
		end

	enable_pointer_on_tooltip is
			-- Enable that tooltip will remain displayed when pointer is on tooltip region,
			-- even pointer is not on owner region.
		do
			is_pointer_on_tooltip_enabled := True
		ensure
			pointer_on_tooltip_enabled: is_pointer_on_tooltip_enabled
		end

	disable_pointer_on_tooltip is
			-- Make sure that tooltip will disappear once pointer is out of owner region.
		do
			is_pointer_on_tooltip_enabled := False
			is_pointer_on_tooltip := False
		ensure
			pointer_on_tooltip_disabled: not is_pointer_on_tooltip_enabled
		end

	enable_tooltip_shadow is
			-- Enable shadow of pop-up tooltip window.
		do
			lock_update
			is_tooltip_shadow_enabled := True
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_shadow_enabled: is_tooltip_shadow_enabled
		end

	disable_tooltip_shadow is
			-- Disable shadow of pop-up tooltip window.
		do
			lock_update
			is_tooltip_shadow_enabled := False
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_shadow_disabled: not is_tooltip_shadow_enabled
		end

	enable_repeat_tooltip_display is
			-- Enable that tooltip will be displayed repeatedly when pointer is on tooltip region,
			-- even pointer is not on owner region.
		do
			is_repeat_tooltip_display_enabled := True
		ensure
			repeat_tooltip_display_enabled: is_repeat_tooltip_display_enabled
		end

	disable_repeat_tooltip_display is
			-- Make sure that tooltip will be displayed once when pointer is out of owner region.
		do
			is_repeat_tooltip_display_enabled := False
		ensure
			repeat_tooltip_display_disabled: not is_repeat_tooltip_display_enabled
		end

	set_tooltip_remain_delay_time (a_delay: INTEGER) is
			-- Set `tooltip_remain_delay_time' with `a_delay' (in milliseconds).
		require
			a_delay_non_negative: a_delay >= 0
		do
			tooltip_remain_delay_time := a_delay
		ensure
			tooltip_remain_time_delay_set: tooltip_remain_delay_time = a_delay
		end

	set_tooltip_background_color (a_color: EV_COLOR) is
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

	set_tooltip_maximum_width (a_width: INTEGER) is
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

	set_tooltip_maximum_height (a_height: INTEGER) is
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

	set_tooltip_maximum_size (a_width: INTEGER; a_height: INTEGER) is
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

	set_force_tooltip_disappear_function (a_veto_function: like force_tooltip_disappear_function) is
			-- Set `force_tooltip_disappear_function' with `a_veto_function'.
		do
			force_tooltip_disappear_function := a_veto_function
		ensure
			force_tooltip_disappear_function_set: force_tooltip_disappear_function = a_veto_function
		end

	set_tooltip_window_related_window (a_window: EV_WINDOW) is
			-- Set `tooltip_window'.`related_window' with `a_window'.
		do
			tooltip_window.set_related_window (a_window)
		ensure
			related_window_set: tooltip_window.related_window = a_window
		end

feature{EVS_GENERAL_TOOLTIP_WINDOW} -- Setting

	set_is_pointer_on_tooltip (b: BOOLEAN) is
			-- Set `is_pointer_on_tooltip' with `b'.
		do
			if is_pointer_on_tooltip_enabled then
				is_pointer_on_tooltip := b
			end
		ensure
			is_pointer_on_tooltip_set: is_pointer_on_tooltip_enabled implies is_pointer_on_tooltip = b
		end

	set_is_tooltip_pined (b: BOOLEAN) is
			-- Set `is_tooltip_pined' with `b'.
		do
			is_tooltip_pined := b
		ensure
			is_tooltip_pined_set: is_tooltip_pined = b
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

	tooltip_remain_delay_time: INTEGER
			-- Time (in milliseconds) for tooltip to remain displayed when pointer is out of owner
			-- Default value is 0, meaning tooltip will disappear once pointer leaves owner region.

	tooltip_background_color: EV_COLOR
			-- Background color of tooltip window			

feature -- Access

	veto_tooltip_display_functions: LINKED_LIST [FUNCTION [ANY, TUPLE, BOOLEAN]] is
			-- Functions used to determine whether or not to display tooltip when other condition
			-- such as `is_tooltip_enabled', pointer on owner are all satisfied.
			-- If any function in the list returns True, tooltip display is vetoed.
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

	force_tooltip_disappear_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Function used to determine whether or not to hide tooltip when other condition
			-- are all satisfied.
			-- This is useful for example when you want tooltip to disappear right away when certain keys
			-- are not pressed.

	tooltip_window_related_window: EV_WINDOW is
			-- Tooltip window related window
		do
			Result := tooltip_window.related_window
		ensure
			result_set: Result = tooltip_window.related_window
		end

feature -- Measure

	max_tooltip_width: INTEGER
			-- Max width in pixel allowed for tooltip

	max_tooltip_height: INTEGER
			-- Max height in pixel allowed for tooltip

	required_tooltip_width: INTEGER is
			-- Required width in pixel to display tooltip
			-- If `max_tooltip_width' is larger than this, `max_tooltip_width' will be used when
			-- tooltip is displayed.
		require
			tooltip_enabled: is_tooltip_enabled
		deferred
		ensure
			result_non_negative: Result >= 0
		end

	required_tooltip_height: INTEGER is
			-- Required height in pixel to display tooltip
			-- If `max_tooltip_height' is larger than this, `max_tooltip_height' will be used when
			-- tooltip is displayed.
		require
			tooltip_enabled: is_tooltip_enabled
		deferred
		ensure
			result_non_negative: Result >= 0
		end

	pointer_offset: INTEGER is 20
			-- y offset to display tooltip window
			-- This is the offset for tooltip window to be displayed below or in some cases above pointer.

feature{EVS_GENERAL_TOOLTIP_WINDOW} -- Status report

	is_owner_destroyed: BOOLEAN is
			-- If owner destroyed
			-- Attach this to owner's `is_destroyed'.
		deferred
		end

	tooltip_widget: EV_WIDGET is
			-- Widget of tooltip
		deferred
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Owner actions

	owner_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Pointer enter actions of owner of current tooltip
			-- Attach this to owner's `pointer_enter_actions'.
		deferred
		ensure
			result_attached: Result /= Void
		end

	owner_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Pointer leave actions of owner of current tooltip
			-- Attach this to owner's `pointer_leave_actions'.			
		deferred
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Actions

	on_pointer_enter is
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

	on_pointer_leave is
			-- Action to be performed when pointer leaves current tooltip owner
		do
			is_pointer_on_owner := False
			if is_tooltip_enabled and then is_my_tooltip_displayed and then not is_picking_from_tooltip then
				if tooltip_remain_delay_time > 0 then
					setup_timer (tooltip_remain_delay_time, agent hide_tooltip)
				else
					setup_timer (0, Void)
					hide_tooltip
				end
			else
				setup_timer (0, Void)
			end
		ensure then
			pointer_not_on_owner: not is_pointer_on_owner
		end

feature{NONE} -- Tooltip show/hide

	show_tooltip is
			-- Show tooltip.
		require
			tooltip_enabled: is_tooltip_enabled
			my_tooltip_not_displayed: not is_my_tooltip_displayed
		local
			l_window: like tooltip_window
			l_show: BOOLEAN
			l_is_vetoed: BOOLEAN
		do
			l_window := tooltip_window
			if not is_my_tooltip then
				if l_window.has_owner then
						-- We only display tooltip of current if other's tooltip is not pined.
					if not l_window.owner.is_tooltip_pined then
						l_window.detach_owner
						l_show := True
					end
				else
					l_show := True
				end
				if l_show then
					if is_tooltip_displayed then
						l_window.hide_tooltip
					end
					l_window.attach_owner (Current)
				end
			elseif not is_my_tooltip_displayed then
				l_show := True
			end
			if l_show and then not is_tooltip_display_vetoed then
					-- Use `veto_tooltip_display_funcitons' to do final tooltip display decision.
--				if veto_tooltip_display_function /= Void then
--					veto_tooltip_display_function.call ([])
--					l_is_vetoed := veto_tooltip_display_function.last_result
--				end
--				if not l_is_vetoed then
					l_window.show_tooltip (screen.pointer_position.x, screen.pointer_position.y)
					setup_timer (tooltip_status_check_time, agent hide_tooltip)
--				end
			end
		ensure
			my_tooltip_displayed:
				-- If not other's pined tooltip is displayed and not vertoed by `veto_tooltip_display_function'
				-- tooltip should be displayed.
				-- (not (is_others_tooltip_displayed and then tooltip_window.owner.is_tooltip_pined)) implies is_my_tooltip_displayed
		end

	hide_tooltip is
			-- Hide tooltip.
		require
			tooltip_enabled: is_tooltip_enabled
			my_tooltip_displayed: is_my_tooltip_displayed
		local
			l_force_hide: BOOLEAN
			l_hide: BOOLEAN
		do
			if not is_tooltip_pined then
				if not is_picking_from_tooltip and then force_tooltip_disappear_function /= Void then
					force_tooltip_disappear_function.call ([])
					l_hide := force_tooltip_disappear_function.last_result
				end
				if not l_hide and then not (is_pointer_on_tooltip_enabled and then is_pointer_on_tooltip) and not is_pointer_on_owner then
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

	force_hide_tooltip is
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

feature{NONE} -- Status report

	is_my_tooltip_displayed: BOOLEAN is
			-- Is tooltip for current displayed?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.owner = Current and then tooltip_window.is_displayed
		ensure
			good_result: Result implies (tooltip_window.is_displayed and then tooltip_window.owner = Current)
		end

	is_others_tooltip_displayed: BOOLEAN is
			-- Is tooltip for others displayed?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.owner /= Current and then tooltip_window.is_displayed
		ensure
			good_result: Result implies (tooltip_window.is_displayed and then tooltip_window.owner /= Current)
		end

	is_tooltip_displayed: BOOLEAN is
			-- Is tooltip displayed, no mater whether it's mine or other's?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.is_displayed
		ensure
			good_result: Result implies tooltip_window.is_displayed
		end

	is_my_tooltip: BOOLEAN is
			-- Does tooltip belong to current?
		require
			tooltip_enabled: is_tooltip_enabled
		do
			Result := tooltip_window.has_owner and then tooltip_window.owner = Current
		ensure
			good_result: Result implies (tooltip_window.has_owner and then tooltip_window.owner = Current)
		end

feature{EVS_GENERAL_TOOLTIP_WINDOW} -- Setting

	set_pointer_on_tooltip (b: BOOLEAN) is
			-- Set `is_pointer_on_tooltip' with `b'.
		do
			is_pointer_on_tooltip := b
		ensure
			is_pointer_on_tooltip_set: is_pointer_on_tooltip = b
		end

	set_picking_from_tooltip (b: BOOLEAN) is
			-- Set `is_picking_from_tooltip' with `b'.
		do
			is_picking_from_tooltip := b
		ensure
			is_picking_from_tooltip_set: is_picking_from_tooltip = b
		end

	setup_timer (timeout: INTEGER; a_agent: PROCEDURE [ANY, TUPLE]) is
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

feature{NONE} -- Access

	tooltip_window: EVS_GENERAL_TOOLTIP_WINDOW is
			-- Window to display tooltip
		once
			create Result
		end

feature{NONE} -- Implementation

	timer: EV_TIMEOUT is
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

	pointer_enter_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent to wrap `on_pointer_enter'
		do
			if pointer_enter_agent_internal = Void then
				pointer_enter_agent_internal := agent on_pointer_enter
			end
			Result := pointer_enter_agent_internal
		ensure
			result_attached: Result /= Void
		end

	pointer_leave_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent to wrap `on_pointer_leave'
		do
			if pointer_leave_agent_internal = Void then
				pointer_leave_agent_internal := agent on_pointer_leave
			end
			Result := pointer_leave_agent_internal
		ensure
			result_attached: Result /= Void
		end

	pointer_enter_agent_internal: like pointer_enter_agent
			-- Implementation of once per object  `pointer_enter_agent'

	pointer_leave_agent_internal: like pointer_leave_agent
			-- Implementation of once per object  `pointer_leave_agent'

	actual_tooltip_background_color: EV_COLOR is
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

	tooltip_background_color_internal: EV_COLOR is
			-- Internal `tooltip_background_color'
		local
			l_style: EVS_TOOLTIP_STYLE
		do
			create l_style.make
			Result := l_style.tooltip_background_color
		ensure
			result_attached: Result /= Void
		end

	tooltip_status_check_time: INTEGER is 100
			-- Time interval in milliseconds to check tooltip status		

	veto_tooltip_display_functions_internal: like veto_tooltip_display_functions
			-- Implementation of once per object `veto_tooltip_display_functions'

	is_tooltip_display_vetoed: BOOLEAN is
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
					l_func.item.call ([])
					Result := l_func.item.last_result
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

indexing
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
