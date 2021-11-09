note
	description: "[
			Vision2 Web browser GTK implementation
									]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEB_BROWSER_IMP

inherit
	EV_WEB_BROWSER_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			needs_event_box
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		local
			l_webkit_item: POINTER
		do
				-- Make sure that gtk backend is initialized first.
			app_implementation.do_nothing
			create webkit
			webkit.new

			set_c_object ({GTK}.gtk_scrolled_window_new (default_pointer, default_pointer))

			l_webkit_item := webkit.item
			{GTK}.gtk_widget_show (l_webkit_item)
			{GTK}.gtk_container_add (visual_widget, l_webkit_item)

			Precursor {EV_PRIMITIVE_IMP}
		end

	needs_event_box: BOOLEAN = True
		-- <Precursor>

	old_make (an_interface: attached like interface)
			-- <Precursor>
		do
			check never_used: False end
		end

feature -- Query

	is_browser_usable: BOOLEAN
			-- Is current browser usable?
		do
			Result := webkit.is_usable
		end

feature -- Command

	load_uri (a_uri: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			webkit.load_uri (a_uri)
		end

	back
			-- <Precursor>
		local
			l_result: BOOLEAN
		do
			l_result := webkit.go_back
		end

	forth
			-- <Precursor>
		local
			l_result: BOOLEAN
		do
			l_result := webkit.go_forward
		end

	home
			-- <Precursor>
		do
			check not_implemented: False end
		end

	search
			-- <Precursor>
		do
			check not_implemented: False end
		end

	refresh
			-- <Precursor>
		do
			webkit.reload
		end

	stop
			-- <Precursor>
		do
			webkit.stop_loading
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WEB_BROWSER note option: stable attribute end
			-- <Precursor>

feature {NONE} -- Implementation

	webkit: EV_WEBKIT_WEB_VIEW;
			-- WebkitGTK object

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WEB_BROWSER_IMP

