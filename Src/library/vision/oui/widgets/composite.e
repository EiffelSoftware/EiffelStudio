indexing

	description:
		"General notion of composite widget %
		%i.e. which accepts children";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	COMPOSITE 

inherit

	WIDGET
		redefine
			implementation, parent
		end

feature -- Access

	parent: COMPOSITE is
			-- Parent of composite
		do
			Result ?= widget_manager.parent (Current)
		end;

	children: ARRAYED_LIST [WIDGET] is
			-- List of children for Current composite
		require
			exists: not destroyed
		do
			Result:= widget_manager.children_of (Current);
		ensure
			valid_result: Result /= Void
		end;

	descendents: ARRAYED_LIST [WIDGET] is
			-- List of descendents for Current composite
		require
			exists: not destroyed
		do
			!! Result.make (10);
			widget_manager.descendents_of (Current, Result);
		ensure
			valid_result: Result /= Void
		end;

feature -- Measurement

	children_count: INTEGER is
			-- Number of children
		require
			exists: not destroyed;
		local
			ch: ARRAYED_LIST [WIDGET]
		do
			ch := widget_manager.children_of (Current);
			Result:= ch.count
		ensure
			positive_result: Result >= 0
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: COMPOSITE_I;
			-- Implementation of Current

end -- class COMPOSITE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
