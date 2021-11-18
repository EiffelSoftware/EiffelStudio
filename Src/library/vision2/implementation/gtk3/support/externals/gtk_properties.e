note
	description: "List of GTK properties you can get/set via `g_object_get' and `g_object_set'."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK_PROPERTIES

feature -- Various GTK properties

	x: POINTER
			-- "x" property.
		external
			"C inline"
		alias
			"[
			static char *v = "x";
			return (EIF_POINTER) v;
			]"
		end

	y: POINTER
			-- "y" property.
		external
			"C inline"
		alias
			"[
			static char *v = "y";
			return (EIF_POINTER) v;
			]"
		end

	x_offset: POINTER
			-- "x-offset" property.
		external
			"C inline"
		alias
			"[
			static char *v = "x-offset";
			return (EIF_POINTER) v;
			]"
		end

	y_offset: POINTER
			-- "y-offset" property.
		external
			"C inline"
		alias
			"[
			static char *v = "y-offset";
			return (EIF_POINTER) v;
			]"
		end

	width: POINTER
			-- "width" property.
		external
			"C inline"
		alias
			"[
			static char *v = "width";
			return (EIF_POINTER) v;
			]"
		end

	height: POINTER
			-- "height" property.
		external
			"C inline"
		alias
			"[
			static char *v = "height";
			return (EIF_POINTER) v;
			]"
		end

	width_request: POINTER
			-- "width-request" property.
		external
			"C inline"
		alias
			"[
			static char *v = "width-request";
			return (EIF_POINTER) v;
			]"
		end

	height_request: POINTER
			-- "height-request" property.
		external
			"C inline"
		alias
			"[
			static char *v = "height-request";
			return (EIF_POINTER) v;
			]"
		end

	vertical_separator: POINTER
			-- "vertical-separator" property.
		external
			"C inline"
		alias
			"[
			static char *v = "vertical-separator";
			return (EIF_POINTER) v;
			]"
		end

	foreground: POINTER
			-- "foreground" property.
		external
			"C inline"
		alias
			"[
			static char *v = "foreground";
			return (EIF_POINTER) v;
			]"
		end

	foreground_rgba: POINTER
			-- "foreground-rgba" property.
		external
			"C inline"
		alias
			"[
			static char *v = "foreground-rgba";
			return (EIF_POINTER) v;
			]"
		end

	background: POINTER
			-- "background" property.
		external
			"C inline"
		alias
			"[
			static char *v = "background";
			return (EIF_POINTER) v;
			]"
		end

	background_rgba: POINTER
			-- "background-rgba" property.
		external
			"C inline"
		alias
			"[
			static char *v = "background-rgba";
			return (EIF_POINTER) v;
			]"
		end

feature -- Font properties

	family: POINTER
			-- "family" property.
		external
			"C inline"
		alias
			"[
			static char *v = "family";
			return (EIF_POINTER) v;
			]"
		end

	size: POINTER
			-- "size" property.
		external
			"C inline"
		alias
			"[
			static char *v = "size";
			return (EIF_POINTER) v;
			]"
		end

	style: POINTER
			-- "style" property.
		external
			"C inline"
		alias
			"[
			static char *v = "style";
			return (EIF_POINTER) v;
			]"
		end


	weight: POINTER
			-- "weight" property.
		external
			"C inline"
		alias
			"[
			static char *v = "weight";
			return (EIF_POINTER) v;
			]"
		end

	underline: POINTER
			-- "underline" property.
		external
			"C inline"
		alias
			"[
			static char *v = "underline";
			return (EIF_POINTER) v;
			]"
		end

	strikethrough: POINTER
			-- "strikethrough" property.
		external
			"C inline"
		alias
			"[
			static char *v = "strikethrough";
			return (EIF_POINTER) v;
			]"
		end

	rise: POINTER
			-- "rise" property.
		external
			"C inline"
		alias
			"[
			static char *v = "rise";
			return (EIF_POINTER) v;
			]"
		end

feature -- Format properies

	xalign: POINTER
			-- "xalign" property.
		external
			"C inline"
		alias
			"[
			static char *v = "xalign";
			return (EIF_POINTER) v;
			]"
		end

	justify: POINTER
			-- "justify" property.
		external
			"C inline"
		alias
			"[
			static char *v = "justify";
			return (EIF_POINTER) v;
			]"
		end

	justification: POINTER
			-- "justification" property.
		external
			"C inline"
		alias
			"[
			static char *v = "justification";
			return (EIF_POINTER) v;
			]"
		end

	left_margin: POINTER
			-- "left-margin" property.
		external
			"C inline"
		alias
			"[
			static char *v = "left-margin";
			return (EIF_POINTER) v;
			]"
		end

	right_margin: POINTER
			-- "right-margin" property.
		external
			"C inline"
		alias
			"[
			static char *v = "right-margin";
			return (EIF_POINTER) v;
			]"
		end

	pixels_above_lines: POINTER
			-- "pixels-above-lines" property.
		external
			"C inline"
		alias
			"[
			static char *v = "pixels-above-lines";
			return (EIF_POINTER) v;
			]"
		end

	pixels_below_lines: POINTER
			-- "pixels-below-lines" property.
		external
			"C inline"
		alias
			"[
			static char *v = "pixels-below-lines";
			return (EIF_POINTER) v;
			]"
		end

feature -- Gtk properties

	gtk_font_name: POINTER
			-- "gtk-font-name" property.
		external
			"C inline"
		alias
			"[
			static char *v = "gtk-font-name";
			return (EIF_POINTER) v;
			]"
		end

	gtk_menu_bar_accel: POINTER
			-- "gtk-menu-bar-accel" property.
		external
			"C inline"
		alias
			"[
			static char *v = "gtk-menu-bar-accel";
			return (EIF_POINTER) v;
			]"
		end

	gtk_menu_icons: POINTER
			-- "gtk-menu-bar-accel" property.
		external
			"C inline"
		alias
			"[
			static char *v = "gtk-menu-images";
			return (EIF_POINTER) v;
			]"
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
