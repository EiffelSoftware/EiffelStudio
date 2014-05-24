note
	description: "Vision2 Web browser for Mac OS X."
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
			interface
		end

create
	make

feature -- Query

	is_browser_usable: BOOLEAN
			-- Is current browser usable?
		do
			Result := False
		end

feature -- Command

	load_uri (a_uri: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			check implemented: False end
		end

	back
			-- <Precursor>
		do
			check implemented: False end
		end

	forth
			-- <Precursor>
		do
			check implemented: False end
		end

	home
			-- <Precursor>
		do
			check implemented: False end
		end

	search
			-- <Precursor>
		do
			check implemented: False end
		end

	refresh
			-- <Precursor>
		do
			check implemented: False end
		end

	stop
			-- <Precursor>
		do
			check implemented: False end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WEB_BROWSER note option: stable attribute end
			-- <Precursor>

invariant

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
