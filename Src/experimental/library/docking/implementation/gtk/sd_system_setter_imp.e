note
	description: "GTK implementation for SD_SYSTEM_SETTER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_SETTER_IMP

inherit
	SD_SYSTEM_SETTER

	EV_BUTTON_IMP
		rename
			make as make_not_use
		export
			{NONE} all
		end

feature -- Command

	before_enable_capture
			-- <Precursor>
		do
		end

	after_disable_capture
			-- <Precursor>
		do
		end

	is_remote_desktop: BOOLEAN
			-- <Precursor>
		do
		end

	clear_background_for_theme (a_widget: EV_DRAWING_AREA; a_rect: EV_RECTANGLE)
			-- <Precursor>
		do
			if attached {EV_DRAWING_AREA_IMP} a_widget.implementation as l_widget_imp then
				c_clear_background (l_widget_imp.c_object, a_rect.left, a_rect.top, a_rect.width, a_rect.height)
			else
				check not_possible: False end
			end
		end

feature {NONE} -- Externals

	c_clear_background (a_gtk_widget: POINTER; a_x, a_y, a_width, a_height: INTEGER_32)
			-- Clear background
			-- This feature will set background to theme background color/pixmap
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				GtkWidget *l_widget;
				l_widget = GTK_WIDGET ($a_gtk_widget);
				gdk_window_set_back_pixmap (l_widget->window, NULL, TRUE);
				gdk_window_clear_area (l_widget->window, $a_x, $a_y, $a_width, $a_height);		
			}
			]"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end

