indexing
	description:
	" Externals C function of Gdk and Gtk specific for the%
	% fonts."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GDK_FONT_EXTERNALS

feature {NONE} -- GDK extenals for the fonts

	gdk_font_load (name: POINTER): POINTER is
		external
			"C (gchar *): EIF_POINTER | <gdk/gdk.h>"
		end

	gdk_string_width (font, str: POINTER): INTEGER is
		external
			"C | <gdk/gdk.h>"
		end

	c_gdk_font_ascent (font: POINTER): INTEGER is
		external
			"C [macro %"gdk_eiffel.h%"]"
		end

	c_gdk_font_descent  (font: POINTER): INTEGER is
		external
			"C [macro %"gdk_eiffel.h%"]"
		end

feature {NONE} -- Gtk externals for the fonts

	gtk_font_selection_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_font_selection_get_font_name (fontsel: POINTER): POINTER is
		external
			"C (GtkFontSelection *): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_font_selection_get_font (fontsel:POINTER):POINTER is
		external
			"C (GtkFontSelection *): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_font_selection_set_font_name (fontsel, name: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

end -- class EV_GDK_FONT_EXTERNALS
