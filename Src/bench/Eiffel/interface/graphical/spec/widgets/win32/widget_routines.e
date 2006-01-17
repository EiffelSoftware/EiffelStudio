indexing
	description:
		"Routines applied to different widgets for a particalar toolkit. %
		%In some instances, it was not worth while to abstract separate %
		%classes to implement simple routines."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class WIDGET_ROUTINES

feature -- Setting

	set_scrolled_text_background_color (a_widget: SCROLLED_T_I; a_color: COLOR) is
			-- Set the scrolled text widget `a_widget' background color
			-- to `a_color'
		local
			text_windows: TEXT_I
		do
			text_windows ?= a_widget;
			text_windows.set_background_color (a_color)
		end;

	copy_text_from_widget (a_widget: SCROLLED_T_I) is
			-- Copy the text from `a_widget'.
		local
			wel_edit: WEL_EDIT
		do
			wel_edit ?= a_widget;
			if wel_edit.has_selection then
				wel_edit.clip_copy
			end
		end;

	cut_text_from_widget (a_widget: SCROLLED_T_I) is
			-- Cut the text from `a_widget'.
		local
			wel_edit: WEL_EDIT
		do
			wel_edit ?= a_widget;
			if wel_edit.has_selection then
				wel_edit.clip_cut
			end
		end;

	paste_text_to_widget (a_widget: SCROLLED_T_I) is
			-- Paste the text to `a_widget'.
		local
			wel_edit: WEL_EDIT
		do
			wel_edit ?= a_widget;
			wel_edit.clip_paste
		end;

	init_button (a_button: BUTTON_I) is
			-- Initialize the button.
		do
		end;

	real_project_height (a_widget: WIDGET_I): INTEGER is
		local
			wel_window: WEL_WINDOW
		do
			wel_window ?= a_widget;
			Result := wel_window.client_rect.height
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class WIDGET_ROUTINES
