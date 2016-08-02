note
	description: "List of GTK properties you can get/set via `g_object_get' and `g_object_set'."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK_PROPERTIES

feature --

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
