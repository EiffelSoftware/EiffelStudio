indexing
	description: "Object that represents a display style for an item in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_GRID_COMPILER_ITEM_STYLE

inherit
	EVS_GENERAL_TOOLTIP_UTILITY

	EB_SHARED_MANAGERS
feature -- Setting

	apply (a_item: EB_GRID_COMPILER_ITEM) is
			-- Apply current style to `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

feature -- Access

	image (a_item: EB_GRID_COMPILER_ITEM): STRING is
			-- Image of current style used in search
		require
			a_item_attached: a_item /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	text (a_item: EB_GRID_COMPILER_ITEM): LIST [EDITOR_TOKEN] is
			-- Text of current style for `a_item'
		require
			a_item_attached: a_item /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Tooltip

	tooltip (a_item: EB_GRID_COMPILER_ITEM): EB_EDITOR_TOKEN_TOOLTIP is
			-- Setup related parameters for tooltip display.
		require
			a_item_attached: a_item /= Void
		deferred
		end

feature{NONE} -- Implementation

	token_writer: EB_EDITOR_TOKEN_GENERATOR is
			-- Editor token writer used to generate `tokens'
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	setup_text (a_item: EB_GRID_COMPILER_ITEM) is
			-- Setup text for `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	setup_tooltip (a_item: EB_GRID_COMPILER_ITEM) is
			-- Setup tooltip for `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	initialize_tooltip (a_tooltip: EB_EDITOR_TOKEN_TOOLTIP) is
			-- Setup parameters for `a_tooltip'.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			a_tooltip.enable_pointer_on_tooltip
			a_tooltip.set_border_line_width (1)
			a_tooltip.set_left_border (4)
			a_tooltip.set_top_border (1)
			a_tooltip.set_right_border (3)
			a_tooltip.set_bottom_border (1)
			a_tooltip.set_tooltip_remain_delay_time (200)
			a_tooltip.enable_text_wrap
			a_tooltip.enable_repeat_tooltip_display
			a_tooltip.set_tooltip_maximum_width (screen.width - 30)
			a_tooltip.set_tooltip_maximum_height (screen.height - 30)
			if a_tooltip.tooltip_window_related_window /= window_manager.last_focused_development_window.window then
				a_tooltip.set_tooltip_window_related_window (window_manager.last_focused_development_window.window)
			end
		end

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
