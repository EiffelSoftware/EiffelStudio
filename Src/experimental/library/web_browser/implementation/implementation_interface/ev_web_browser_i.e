note
	description: "[
					Eiffel Vision web browser
					Implementation interface
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEB_BROWSER_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WEB_BROWSER note option: stable attribute end
			-- <Precursor>

feature -- Query

	is_browser_usable: BOOLEAN
			-- Is current browser usable?
		deferred
		end

feature -- Command

	load_uri (a_uri: READABLE_STRING_GENERAL)
			-- Load content from `a_uri' for rendering
		require
			is_browser_usable: is_browser_usable
			not_empty: a_uri /= void and then not a_uri.is_empty
		deferred
		end

	back
			-- Go to previous URI
		require
			is_browser_usable: is_browser_usable
		deferred
		end

	forth
			-- Go to next URI
		require
			is_browser_usable: is_browser_usable
		deferred
		end

	home
			-- Go to home page
		require
			is_browser_usable: is_browser_usable
		deferred
		end

	search
			-- Go to default search page
		require
			is_browser_usable: is_browser_usable
		deferred
		end

	refresh
			-- Refresh current page
		require
			is_browser_usable: is_browser_usable
		deferred
		end

	stop
			-- Stop loading URI
		require
			is_browser_usable: is_browser_usable
		deferred
		end

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




end -- class EV_WEB_BROWSER_I
