indexing
	description: "GTK enums constants class."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EV_GTK_ENUMS

feature -- C enums

	frozen Gtk_toplevel_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_TOPLEVEL"
		end

	frozen Gtk_no_window_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_NO_WINDOW"
		end

	frozen Gtk_can_default_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_CAN_DEFAULT"
		end

	frozen Gdk_nothing_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_NOTHING"
		end

	frozen Gdk_delete_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_DELETE"
		end

	frozen Gdk_destroy_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_DESTROY"
		end

	frozen Gdk_expose_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_EXPOSE"
		end

	frozen Gdk_motion_notify_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_MOTION_NOTIFY"
		end

	frozen Gdk_button_press_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_BUTTON_PRESS"
		end

	frozen Gdk_2button_press_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_2BUTTON_PRESS"
		end

	frozen Gdk_3button_press_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_3BUTTON_PRESS"
		end

	frozen Gdk_button_release_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_BUTTON_RELEASE"
		end

	frozen Gdk_key_press_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_KEY_PRESS"
		end

	frozen Gdk_key_release_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_KEY_RELEASE"
		end

	frozen Gdk_enter_notify_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_ENTER_NOTIFY"
		end

	frozen Gdk_leave_notify_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_LEAVE_NOTIFY"
		end

	frozen Gdk_focus_change_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_FOCUS_CHANGE"
		end

	frozen Gdk_configure_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_CONFIGURE"
		end

	frozen Gdk_map_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_MAP"
		end

	frozen Gdk_unmap_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_UNMAP"
		end

	frozen Gdk_proximity_in_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_PROXIMITY_IN"
		end

	frozen Gdk_proximity_out_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_PROXIMITY_OUT"
		end

feature -- GdkCursor enums

	frozen Gdk_watch_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WATCH"
		end

	frozen Gdk_xterm_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_XTERM"
		end

	frozen Gdk_crosshair_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_CROSSHAIR"
		end

	frozen Gdk_question_arrow_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_QUESTION_ARROW"
		end

	frozen Gdk_left_ptr_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_LEFT_PTR"
		end

	frozen Gdk_fleur_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_FLEUR"
		end

	frozen Gdk_size_sb_v_double_arrow_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_SB_V_DOUBLE_ARROW"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_ENUMS

