indexing

	descriotion:
		"Child for a SPLIT_WINDOW.";
	date: "$Date$";
	revision: "$Revision$"

class SPLIT_WINDOW_CHILD

inherit
	FORM
		rename
			make as form_make,
			make_unmanaged as form_make_unmanaged
		redefine
			implementation, parent,
			manage, unmanage
		end

creation
	make,
	make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			form_make (a_name, a_parent);
			a_parent.implementation.add_child (Current);
			parent := a_parent
		end;

	make_unmanaged (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			form_make_unmanaged (a_name, a_parent);
			a_parent.implementation.add_child (Current);
			parent := a_parent
		end

feature -- Access

	exists: BOOLEAN is
			-- Does Current exist?
		do
			Result := implementation.exists
		end

feature -- Widget Management

	manage is
			-- Manage Current.
			--| Ie. Make it visible on the screen.
		do
			implementation.set_managed (True);
			parent.implementation.add_managed_child (Current)
		end;

	unmanage is
			-- Unmanage Current.
			--| Ie. Make ir invisible on the screen.
		do
			implementation.set_managed (False);
			parent.implementation.remove_managed_child (Current)
		end

feature {SPLIT_WINDOW_I} -- Implementation

	implementation: FORM_WINDOWS;
			-- Implementation Window

feature {NONE} -- Implementation

	parent: SPLIT_WINDOW
			-- Parent of Current

end -- class SPLIT_WINDOW_CHILD
