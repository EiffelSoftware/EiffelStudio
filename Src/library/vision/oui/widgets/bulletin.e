
-- Area for free-form placement on any of its children.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BULLETIN 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make, make_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAn) is
			-- Create a bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.bulletin (Current, man);
			set_default
		end;

feature

	allow_recompute_size is
			-- Allow Current bulletin to recompute its size 
			-- according to its children.
		require
			exists: not destroyed	
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size is
			-- Forbid Current bulletin to recompute its size 
			-- according to its children.
		require
			exists: not destroyed	
		do
			implementation.forbid_recompute_size
		end;

	set_default_position (flag: BOOLEAN) is
			-- Set default position of Current to `flag'.
		require
			exists: not destroyed	
		do
			implementation.set_default_position (flag);
		end;

	circulate_up is
			-- Circulate the children of this widget up
		require
			exists: not destroyed
		do
			implementation.circulate_up;
		end;

	circulate_down is
			-- Circulate the children of this widget down
		require
			exists: not destroyed
		do
			implementation.circulate_down;
		end;

	restack_children (a_stackable_array: ARRAY [STACKABLE]) is
			-- the stackable's in the array have to have the
			-- same parent.
		require
			exists: not destroyed;
			valid_restackable: valid_stackables (a_stackable_array);
		do
			implementation.restack_children (a_stackable_array);
		end;

	valid_stackables (a_stackable_array: ARRAY [STACKABLE]): BOOLEAN is
			-- check that the array of stackables meets the critea
			-- require for widgets to be restacked
		require
			exists: not destroyed;
			valid_array: a_stackable_array /= Void and then
					not a_stackable_array.empty;
		local
			index1: INTEGER;
		do
			Result := True;
			from index1 := a_stackable_array.lower 
			until  not Result or else index1 > a_stackable_array.upper
			loop
				If a_stackable_array.item (index1) = Void  then
					Result := False;
				elseif not a_stackable_array.item (index1).is_stackable or else
				  not a_stackable_array.item (index1).realized or else
				  a_stackable_array.item (index1).parent /= a_stackable_array.item(a_stackable_array.lower).parent then
					Result := False;
				end;
				index1 := index1 + 1;
			end;
		end;

feature {NONE}

	set_default is
			-- Set default values to current bulletin.
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: BULLETIN_I
			-- Implementation of bulletin

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
