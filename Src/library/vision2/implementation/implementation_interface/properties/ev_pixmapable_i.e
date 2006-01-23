indexing
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

	pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		require
			pixmap_not_void: a_pixmap /= Void
		deferred
		end

	remove_pixmap is
			-- Make `pixmap' `Void'.
		deferred
		ensure
			pixmap_removed: pixmap = Void
		end
		
	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		do
			Result := a_pixmap.is_equal (pixmap)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

indexing
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

