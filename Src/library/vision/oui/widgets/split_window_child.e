indexing

	descriotion:
		"Child for a SPLIT_WINDOW.";
	date: "$Date$";
	revision: "$Revision$"

class SPLIT_WINDOW_CHILD

inherit
	SPLIT_WINDOW_CHILD_IMP
		rename 
			make as make_imp
		redefine
			manage, unmanage
		end

create
	make,
	make_unmanaged

feature -- Initialization

	make (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			make_imp (a_name, a_parent)
			parent.add_child (Current)
		end

	make_unmanaged (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			make_imp (a_name, a_parent)
			parent.remove_child (Current)
		end

feature -- Widget Management

	manage is
			-- Manage Current.
			--| Ie. Make it visible on the screen.
		do
			set_child_managed
			parent.add_managed_child (Current)
		end;

	unmanage is
			-- Unmanage Current.
			--| Ie. Make ir invisible on the screen.
		do
			set_child_unmanaged
			parent.remove_managed_child (Current)
		end


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




end -- class SPLIT_WINDOW_CHILD

