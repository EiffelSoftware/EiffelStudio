indexing

	description:
		"General notion of composite widget %
		%i.e. which accepts children"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	descendants: ARRAYED_LIST [WIDGET] is
			-- List of descendants for Current composite
		require
			exists: not destroyed
		do
			create Result.make (10);
			widget_manager.descendants_of (Current, Result);
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

	implementation: COMPOSITE_I;;
			-- Implementation of Current

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




end -- class COMPOSITE

