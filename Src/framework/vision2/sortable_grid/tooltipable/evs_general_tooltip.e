indexing
	description: "Object that represents a general tooltip"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GENERAL_TOOLTIP

inherit
	EVS_GENERAL_TOOLTIPABLE

feature{NONE} -- Initialization

	make (a_enter_actions: like pointer_enter_actions;
	      a_leave_actions: like pointer_leave_actions;
	      a_widget_function: like widget_function;
	      a_destroy_function: like owner_destroy_function;
	      a_width_function: like required_width_function;
	      a_height_function: like required_height_function) is
			-- Initialize agents used for current tooltip.
			-- See `pointer_enter_actions', `pointer_leave_actions', `widget_function',
			-- `owner_destroy_function', `required_width_function', `required_height_function'
			-- for more information.
		require
			a_enter_actions_attached: a_enter_actions /= Void
			a_leave_actions_attached: a_leave_actions /= Void
			a_widget_function_attached: a_widget_function /= Void
			a_destroy_function_attached: a_destroy_function /= Void
			a_width_function_attached: a_width_function /= Void
			a_height_function_attached: a_height_function /= Void
		do
			pointer_enter_actions := a_enter_actions
			pointer_leave_actions := a_leave_actions
			widget_function := a_widget_function
			owner_destroy_function := a_destroy_function
			required_width_function := a_width_function
			required_height_function := a_height_function
		ensure
			pointer_enter_actions_set: pointer_enter_actions = a_enter_actions
			pointer_leave_actions_set: pointer_leave_actions = a_leave_actions
			widget_function_set: widget_function = a_widget_function
			owner_destroy_function_set: owner_destroy_function = a_destroy_function
			required_width_function_set: required_width_function = a_width_function
			required_height_function_set: required_height_function = a_height_function
		end

feature -- Access

	pointer_enter_actions: like owner_pointer_enter_actions
			-- Actions to be performed when screen pointer enters widget.

	pointer_leave_actions: like owner_pointer_leave_actions
			-- Actions to be performed when screen pointer leaves widget.

	widget_function: FUNCTION [ANY, TUPLE, EV_WIDGET]
			-- Function to return widget for current tooltip
			-- Ensure return value of this function is attached.

	owner_destroy_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Function to indicate whether or not owner of current tooltip is destroyed.

	required_width_function: FUNCTION [ANY, TUPLE, INTEGER]
			-- Function to return required width in pixels of current tooltips.
			-- Ensure return value is non-negative.

	required_height_function: FUNCTION [ANY, TUPLE, INTEGER]
			-- Function to return required height in pixels of current tooltips.
			-- Ensure return value is non-negative.

feature -- Status report

	has_tooltip_text: BOOLEAN is
			-- Does current tooltip has any text?
		deferred
		end

feature{EVS_GENERAL_TOOLTIP_WINDOW} -- Status report

	is_owner_destroyed: BOOLEAN is
			-- If owner destroyed
			-- Attach this to owner's `is_destroyed'.
		local
			l_func: like owner_destroy_function
		do
			l_func := owner_destroy_function
			l_func.call ([])
			Result := l_func.last_result
		end

	tooltip_widget: EV_WIDGET is
			-- Widget of tooltip
		local
			l_func: like widget_function
		do
			l_func := widget_function
			l_func.call ([])
			Result := l_func.last_result
		end

feature{NONE} -- Implementation

	owner_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Pointer enter actions of owner of current tooltip
			-- Attach this to owner's `pointer_enter_actions'.
		do
			Result := pointer_enter_actions
		end

	owner_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Pointer leave actions of owner of current tooltip
			-- Attach this to owner's `pointer_leave_actions'.			
		do
			Result := pointer_leave_actions
		end

	required_tooltip_width: INTEGER is
			-- Required width in pixel to display tooltip
			-- If `max_tooltip_width' is larger than this, `max_tooltip_width' will be used when
			-- tooltip is displayed.
		local
			l_func: like required_width_function
		do
			l_func := required_width_function
			l_func.call ([])
			Result := l_func.last_result
		end

	required_tooltip_height: INTEGER is
			-- Required height in pixel to display tooltip
			-- If `max_tooltip_height' is larger than this, `max_tooltip_height' will be used when
			-- tooltip is displayed.
		local
			l_func: like required_height_function
		do
			l_func := required_height_function
			l_func.call ([])
			Result := l_func.last_result
		end

invariant
	pointer_enter_actions_attached: pointer_enter_actions /= Void
	pointer_leave_actions_attached: pointer_leave_actions /= Void
	tooltip_widget_function_attached: widget_function /= Void
	owner_destroy_function_attached: owner_destroy_function /= Void
	required_width_function_attached: required_width_function /= Void
	required_height_function_attached: required_height_function /= Void

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
