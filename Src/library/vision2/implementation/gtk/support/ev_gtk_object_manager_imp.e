indexing
	description: "Hashtable which associates GtkObject handles with%
				%the corresponding Eiffel";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_OBJECT_MANAGER_IMP
feature

feature -- Access

	objects: HASH_TABLE [EV_GTK_ANY_IMP, POINTER] is
			-- Contains all the GtkObjects created by the application.
		once
			create Result.make (Table_size)
		ensure
			result_not_void: Result /= Void
		end

	object_from_handle (a_handle: POINTER): EV_GTK_ANY_IMP is
			-- Returns the Eiffel object associated with 
			-- `a_handle' if there is one, otherwise the 
			-- function returns Void. 
		require
			a_handle_not_void: a_handle /= Void
		do
			Result := objects.item (a_handle)
		ensure
			consisten_result: objects.has (a_handle) implies Result /= Void
		end
					 

feature -- Basic operations

	register_object (object: EV_GTK_ANY_IMP) is
			-- Register `object' in the object manager.
		require
			object_not_void: object /= Void
			unregistered: not registered (object)
		do	
			objects.put (object, object.handle)
--| FIXME PR 2159
--| When a conflict occurs during this instruction, object is not registrated in
--| the HASH_TABLE, and a contract violation occurs.
--| Suggestion: replace `put' with `force', and see if there is an equivalent
--| problem in `unregister_object' (i gess there is one).
--| This sole bug makes any V2-based application as stable as Netscape under
--| Windows* beta, so i NEED it solved for bootstrapping.
		ensure
			registered: registered (object)
		end

	unregister_object (object: EV_GTK_ANY_IMP) is
			-- Unregister `object' from the object manager.
		require
			object_not_void: object /= Void
			registered: registered (object)
		do
			objects.remove (object.handle)
		ensure
			unregistered: not registered (object)
		end

feature -- Status report

	registered (object: EV_GTK_ANY_IMP): BOOLEAN is
			-- Is `object' registered?
		require
			object_not_void: object /= Void
		do
			Result := objects.has_item (object)
		end

feature {NONE} -- Implementation

	Table_size: INTEGER is 100
			-- Initial hash table size
	

end -- class EV_GTK_OBJECT_MANAGER_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
