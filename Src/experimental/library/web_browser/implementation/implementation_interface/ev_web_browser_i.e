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

feature {NONE} -- Implementation

	interface: EV_WEB_BROWSER
			-- <Precursor>

feature -- Command

	load_uri (a_uri: STRING_GENERAL)
			-- Load content from `a_uri' for rendering
		require
			not_empty: a_uri /= void and then not a_uri.is_empty
		deferred
		end

	back
			-- Go to previous URI
		deferred
		end

	forth
			-- Go to next URI
		deferred
		end

	home
			-- Go to home page
		deferred
		end

	search
			-- Go to default search page
		deferred
		end

	refresh
			-- Refresh current page
		deferred
		end

	stop
			-- Stop loading URI
		deferred
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




end -- class EV_WEB_BROWSER_I
