indexing

	description:
		"Rectangle (with or without scrollbars) which contains a list of %
		%selectable strings"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SCROLL_LIST 

obsolete
		"Use SCROLLABLE_LIST instead - it has the same semantics as a LIST."
inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end;

	LIST_MAN
		rename
			implementation as list_imp
		end

create

	make, make_unmanaged, make_fixed_size, make_fixed_size_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will attempt to resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_fixed_size (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will not resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will attempt to resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	make_fixed_size_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
			-- Scroll list will not resize if entries
			-- are added.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; 
			man: BOOLEAN; is_fixed: BOOLEAN) is
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		local
			ot: OBSOLETE_TOOLKIT
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			ot ?= toolkit;
			check
				obsolete_toolkit_instantiated: ot /= Void
			end;
			implementation := ot.scroll_list (Current, man, is_fixed, a_parent);
			implementation.set_widget_default;
			list_imp.set_single_selection;
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SCROLL_L_I;
			-- Implementation of list

feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE?

feature {NONE}

	set_default is
			-- Set default values to current scroll list.
		do
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




end

