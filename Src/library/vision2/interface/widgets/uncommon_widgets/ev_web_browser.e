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
			implementation,
			create_implementation
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WEB_BROWSER_I
		-- Responsible for interaction with native graphics toolkit

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'
		do
			create {EV_WEB_BROWSER_IMP} implementation.make (Current)
		end

feature -- Command

	load_uri (a_uri: STRING_GENERAL)
			-- Requests loading of the specified URI string
		require
			not_empty: a_uri /= void and then not a_uri.is_empty
		do
			implementation.load_uri (a_uri)
		end

	back
			-- Loads the previous history item
		do
			implementation.back
		end

	forth
			-- Go forth
		do
			implementation.forth
		end

	refresh
			-- Loads the next history item
		do
			implementation.refresh
		end

	stop
			-- Stop loading
		do
			implementation.stop
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


end -- class EV_WEB_BROWSER
