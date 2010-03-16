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
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		local
			l_browser_window: POINTER
		do
			l_browser_window := {EV_GTK_EXTERNALS}.gtk_event_box_new
			set_c_object (l_browser_window)

			initialize

			Precursor {EV_PRIMITIVE_IMP}
		end

	old_make (an_interface: like interface)
			-- <Precursor>
		do
			check never_used: False end -- Just because {EV_ANY_I} has it as deferred
		end

	initialize
			-- Initialize `Current'
		do
			{EV_GTK_EXTERNALS}.gdk_init (default_pointer, default_pointer)
			{EV_GTK_EXTERNALS}.gdk_threads_init
			if not {EV_GTK_EXTERNALS}.g_thread_supported then
				{EV_GTK_EXTERNALS}.g_thread_init
			end

			create webkit
			webkit.new

			add_gtk_widget_to_gtk_window (c_object, webkit.item)


			{EV_GTK_EXTERNALS}.gtk_widget_show_all (scroll_window)
		end

feature -- Command

	load_uri (a_uri: STRING_GENERAL)
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

feature {NONE} -- Implementation

	interface: EV_WEB_BROWSER
			-- <Precursor>

	webkit: EV_WEBKIT_WEB_VIEW
			-- WebkitGTK object

	scroll_window: POINTER
			-- Scroll window which surround `webkit.item'

	add_gtk_widget_to_gtk_window (a_gtk_container: POINTER; a_gtk_widget: POINTER)
			-- Add `a_gtk_widget' to `a_gtk_container', add a additional scroll window
		local
			l_scroll_window: POINTER
		do
			l_scroll_window := {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (default_pointer, default_pointer)
			scroll_window := l_scroll_window
			{EV_GTK_EXTERNALS}.gtk_container_add (l_scroll_window, a_gtk_widget)
			{EV_GTK_EXTERNALS}.gtk_container_add (a_gtk_container, l_scroll_window)
		ensure
			created: scroll_window /= default_pointer
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WEB_BROWSER_IMP

