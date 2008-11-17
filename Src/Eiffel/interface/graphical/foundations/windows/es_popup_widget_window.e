indexing
	description: "[
		A simple popup window for displaying a widget structure.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_POPUP_WIDGET_WINDOW

inherit
	ES_POPUP_WINDOW
		rename
			make as make_popup_window
		redefine
			is_focus_sensitive,
			is_pointer_sensitive
		end

create
	make

convert
	to_popup_window: {EV_POPUP_WINDOW}

feature {NONE} -- Initialization

	frozen make (a_widget: like widget; a_recycle: like is_recycled_on_closing; a_use_drop_shadow: like has_drop_shadow)
			-- Initializes a new popup widget window.
			--
			-- `a_widget': The widget to display in the window.
			-- `a_recycle': True to recycle the window and widget auotmaticaly when the window is closed.
			-- `a_use_drop_shadow': True to set a drop shadow on the popup window, False otherwise.
		require
			a_widget_is_interface_usable: a_widget.is_interface_usable
			not_a_widget_has_parent: not a_widget.widget.has_parent
		do
			widget := a_widget
			auto_recycle (a_widget)

			is_recycled_on_closing := a_recycle
			set_is_focus_sensitive (True)
			set_is_pointer_sensitive (False)

			make_popup_window (a_use_drop_shadow)
		ensure
			is_initialized: is_initialized
			widget_set: widget = a_widget
		end

	build_window_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the windows's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			a_container.set_border_width ({ES_UI_CONSTANTS}.dialog_border)
			a_container.extend (widget)
		end

feature -- Access

	widget: !ES_WIDGET [EV_WIDGET]
			-- Inner popup window widget, set during creation

feature -- Status report

	is_focus_sensitive: BOOLEAN assign set_is_focus_sensitive
			-- Indicates if the window is sensitive to focus. By default, if the window loses focus then
			-- is it closed.
		do
			Result := internal_is_focus_sensitive
		end

	is_pointer_sensitive: BOOLEAN assign set_is_pointer_sensitive
			-- Indicates if the window is sensitive to having a mouse pointer. By default, if the mouse pointer leaves the
			-- window, is it remains open.
		do
			Result := internal_is_pointer_sensitive
		end

feature {NONE} -- Status report

	is_recycled_on_closing: BOOLEAN
			-- Indicates if the window should be recycled on closing.

feature -- Status setting

	set_is_focus_sensitive (a_sensitive: like is_focus_sensitive)
			-- Sets window's sensitivity to retaining focus.
			-- See `is_focus_sensitive' for more information.
			--
			-- `a_sensitive': True to close the window when focus is lost, False to keep it open.
		require
			is_interface_usable: is_interface_usable
		do
			internal_is_focus_sensitive := a_sensitive
		ensure
			is_focus_sensitive_set: is_focus_sensitive = a_sensitive
		end

	set_is_pointer_sensitive (a_sensitive: like is_pointer_sensitive)
			-- Sets window's sensitivity to the position of the mouse pointer within the window.
			-- See `is_pointer_sensitive' for more information.
			--
			-- `a_sensitive': True to close the window when mouse pointer leaves the window, False to keep it open.
		require
			is_interface_usable: is_interface_usable
		do
			internal_is_pointer_sensitive := a_sensitive
		ensure
			is_pointer_sensitive_set: is_pointer_sensitive = a_sensitive
		end

feature {NONE} -- Internal implementation cache

	internal_is_focus_sensitive: like is_focus_sensitive
			-- Mutable version of `is_focus_sensitive'

	internal_is_pointer_sensitive: like is_pointer_sensitive
			-- Mutable version of `is_pointer_sensitive'

invariant
	widget_is_interface_usable: is_interface_usable and is_initialized implies widget.is_interface_usable
	widget_has_parent: is_interface_usable and is_initialized implies widget.widget.has_parent
	
;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
