note
	description:
		"Abstraction for objects that have a pixmap property."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end

feature -- Access

	pixmap: detachable EV_PIXMAP
			-- Copy of image displayed on `Current'.
			-- Void if none.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmap
		ensure
			bridge_ok: (Result = Void and implementation.pixmap = Void) or
				(attached Result and then attached implementation.pixmap as l_pixmap and then Result.is_equal (l_pixmap))
		end

feature {EV_BUILDER} -- Access

	internal_pixmap_path: detachable STRING_32
			-- Path of `pixmap'.

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Display image of `a_pixmap' on `Current'.
			-- Image of `pixmap' will be a copy of `a_pixmap'.
			-- Image may be scaled in some descendents, i.e EV_TREE_ITEM
			-- See EV_TREE.set_pixmaps_size.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			implementation.set_pixmap (a_pixmap)
		ensure
			--pixmap_assigned: pixmap_equal_to (a_pixmap) and pixmap /= a_pixmap
		end

	remove_pixmap
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end

feature {EV_BUILDER} -- Element change

	set_internal_pixmap_path (a_path: READABLE_STRING_GENERAL)
			-- Assign `a_path' to `internal_pixmap_path'.
		do
			if a_path = Void then
				internal_pixmap_path := Void
			else
				internal_pixmap_path := a_path.as_string_32
			end
		ensure
			path_set: a_path /= Void implies (attached internal_pixmap_path as l_internal_pixmap_path and then a_path.same_string (l_internal_pixmap_path))
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and pixmap = void
		end

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN
			-- Is `a_pixmap' equal to `pixmap'?
		do
			Result := implementation.pixmap_equal_to (a_pixmap)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PIXMAPABLE_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_PIXMAPABLE











