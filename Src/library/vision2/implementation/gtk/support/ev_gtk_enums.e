indexing
	description: "GTK enums constants class."

class
	EV_GTK_ENUMS

feature -- C enums

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

end -- class EV_GTK_ENUMS
