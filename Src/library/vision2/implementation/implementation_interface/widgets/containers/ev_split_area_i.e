indexing

	description: 
		"EiffelVision split area, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_I
	
inherit
	EV_CONTAINER_I
		redefine
			add_child_ok,
			child_add_successful
		end

feature -- Access

feature -- Access

	child1: EV_WIDGET_IMP
				-- The first child of the split area

	child2: EV_WIDGET_IMP
					-- The second child of the split area
	
	-- 'child' defined in EV_CONTAINER is the last child added to
	-- the split
	
feature -- Status report

	add_child_ok: BOOLEAN is
			-- True, if it is ok to add a child to
			-- container. Two children
			-- are allowed
		do
			Result := child2 = Void or child = Void
		end
	
	child_add_successful (new_child: EV_WIDGET_IMP): BOOLEAN is
			-- Used in the postcondition of 'add_child'
		do
			Result := child = new_child and (child1 = new_child or child2 = new_child)
		end	

feature {EV_SPLIT_AREA} -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into split area. Split area can 
			-- have two children.
		do
			child := child_imp
			if child1 = Void then
				add_child1 (child_imp)
			else
				add_child2 (child_imp)
			end
		end
	
	add_child1 (child_imp: EV_WIDGET_I) is
			-- Add the first child of the split.
		require
			child_not_void: child_imp /= Void
		do
			child1 ?= child_imp
		ensure then
			child1 /= Void
		end
	
	add_child2 (child_imp: EV_WIDGET_I) is
			-- Add the second child.
		require
			child_not_void: child_imp /= Void
		do
			child2 ?= child_imp
		ensure then
			child2 /= Void
		end

end -- class EV_SPLIT_AREA_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
