note
	description: "Objects that represents a tooltip in which pick-and-dropable editor tokens are displayed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_TOOLTIP

inherit
	EB_EDITOR_TOKEN_TOOLTIPABLE
		rename
			tooltip_widget as editor_token_tooltip_widget,
			required_tooltip_width as editor_token_required_tooltip_width,
			required_tooltip_height as editor_token_required_tooltip_height
		end

	EVS_GENERAL_TOOLTIP
		rename
			make as old_make
		undefine
			set_tooltip_maximum_width,
			set_tooltip_maximum_height,
			set_tooltip_maximum_size
		redefine
			initialize_tooltip_defaults
		select
			tooltip_widget,
			required_tooltip_width,
			required_tooltip_height
		end

create
	make

feature{NONE} -- Initialization

	make (a_enter_actions: like pointer_enter_actions;
	      a_leave_actions: like pointer_leave_actions;
	      a_select_actions: like select_actions;
	      a_destroy_function: like owner_destroy_function)
			-- Initialize agents used for current tooltip.
			-- See `pointer_enter_actions', `pointer_leave_actions',
			-- `owner_destroy_function', for more information.
		require
			a_enter_actions_attached: a_enter_actions /= Void
			a_leave_actions_attached: a_leave_actions /= Void
			a_destroy_function_attached: a_destroy_function /= Void
		do
			old_make (a_enter_actions,
					  a_leave_actions,
					  a_select_actions,
					  agent editor_token_tooltip_widget,
					  a_destroy_function,
					  agent editor_token_required_tooltip_width,
					  agent editor_token_required_tooltip_height)
		end

	initialize_tooltip_defaults
			-- Initializes tool tip defaults for all EiffelStudio tool tips
		do
			Precursor

			set_border_line_width (1)
			set_top_border (2)
			set_bottom_border (0)
			set_left_border (4)
			set_right_border (4)

			set_tooltip_remain_delay_time (200)
			set_pointer_on_tooltip (True)

			enable_tooltip_shadow
			enable_repeat_tooltip_display

			enable_label_font
			enable_text_wrap
		end

feature -- Status report

	has_tooltip_text: BOOLEAN
			-- Does current tooltip has any text?
		do
			Result := tokens.count > 0
		ensure then
			good_result: Result implies tokens.count > 0
		end

feature -- Status setting

	enable_label_font
			-- Enables the tool tip to use the label-styled font instead of a editor mono-spaced font
		local
			l_writer: EB_SHARED_WRITER
		do
			create l_writer
			set_overriden_font (l_writer.label_font_table, l_writer.label_font_height)
		end

	disable_label_font
			-- Disables the tool tip to use the label-styled font instead of a editor mono-spaced font
		do
			remove_overriden_font
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
