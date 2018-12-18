note
	description: "[
			Eiffel Vision2 Internet Web Browser Widget
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEB_BROWSER

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WEB_BROWSER_I
		-- Responsible for interaction with native graphics toolkit

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'
		do
			create {EV_WEB_BROWSER_IMP} implementation.make
		end

feature -- Query

	is_browser_usable: BOOLEAN
			-- Is current browser usable?
		do
			Result := implementation.is_browser_usable
		end

feature -- Command

	load_uri (a_uri: READABLE_STRING_GENERAL)
			-- Requests loading of the specified URI string
		require
			is_browser_usable: is_browser_usable
			not_empty: a_uri /= void and then not a_uri.is_empty
		do
			implementation.load_uri (a_uri)
		end

	back
			-- Loads the previous history item
		require
			is_browser_usable: is_browser_usable
		do
			implementation.back
		end

	forth
			-- Go forth
		require
			is_browser_usable: is_browser_usable
		do
			implementation.forth
		end

	refresh
			-- Loads the next history item
		require
			is_browser_usable: is_browser_usable
		do
			implementation.refresh
		end

	stop
			-- Stop loading
		require
			is_browser_usable: is_browser_usable
		do
			implementation.stop
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
