note
	description: "Used for describing a particular PND target"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_TARGET_DATA

feature -- Access

	target: EV_ABSTRACT_PICK_AND_DROPABLE
		-- Target of PND menu item.

	name: STRING_32
		-- Name for PND menu item.

	pixmap: EV_PIXMAP
		-- Pixmap used in PND menu item, if Void then no pixmap is used.

feature -- Element Change

	set_name (a_name: STRING_GENERAL)
			-- Set `name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set `a_pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			pixmap_assigned: pixmap = a_pixmap
		end

feature {EV_APPLICATION_I} -- Implementation

	set_target (a_target: like target)
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_assigned: target = a_target
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end
