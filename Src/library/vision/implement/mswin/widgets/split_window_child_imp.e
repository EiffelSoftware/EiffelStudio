indexing

	descriotion:
		"Child for a SPLIT_WINDOW.";
	date: "$Date$";
	revision: "$Revision$"

deferred class SPLIT_WINDOW_CHILD_IMP
 
inherit
	FORM
		rename
			make as form_make,
			make_unmanaged as form_make_unmanaged
		redefine
			parent, implementation,
			manage, unmanage
		end


feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			parent:= a_parent
			form_make (a_name, a_parent)
		end;

feature -- Access

	exists: BOOLEAN is
			-- Does Current exist?
		do
			Result := implementation.exists
		end

feature -- Widget Management

	set_child_managed is
		do
			implementation.set_managed (True)
		end

	set_child_unmanaged is
		do
			implementation.set_managed (False)
		end

	manage is
			-- Manage Current.
			--| Ie. Make it visible on the screen.
		do
			--redefine it in the descendant
		end;

	unmanage is
			-- Unmanage Current.
			--| Ie. Make ir invisible on the screen.
		do
			--redefine it in the descendant
		end

feature -- Implementation

	implementation: FORM_IMP
			-- Implementation Window

	parent: SPLIT_WINDOW;

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




end -- class SPLIT_WINDOW_CHILD_IMP

