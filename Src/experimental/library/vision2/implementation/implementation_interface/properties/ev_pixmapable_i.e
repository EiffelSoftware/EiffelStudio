note
	description:
		"Eiffel Vision pixmapable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	pixmap: detachable EV_PIXMAP
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		require
			pixmap_not_void: a_pixmap /= Void
		deferred
		end

	remove_pixmap
			-- Make `pixmap' `Void'.
		deferred
		ensure
			pixmap_removed: pixmap = Void
		end

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN
			-- Is `a_pixmap' equal to `pixmap'?
		do
			Result := attached pixmap as l_pixmap and then a_pixmap.is_equal (l_pixmap)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PIXMAPABLE note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PIXMAPABLE_I











