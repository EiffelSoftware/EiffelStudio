
-- General notion of composite widget 
-- i.e. which accepts children.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class COMPOSITE 

inherit

	WIDGET
		redefine
			implementation, parent
		end

feature -- Widget hierarchy

	parent: COMPOSITE is
			-- Parent of composite
        do
            Result ?= widget_manager.parent (Current)
        end;

	children_count: INTEGER is
			-- Number of children
		require
			exists: not destroyed
		do
			Result:= implementation.children_count
		ensure
			Positive_result: Result >= 0
		end;


feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: COMPOSITE_I;
			-- Implementation of Current

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
