indexing
	description: "Coclass generator helper."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_GENERATOR_HELPER

feature -- Basic operations

	is_ancestor_of (an_interface, probable_ancestor: WIZARD_INTERFACE_DESCRIPTOR): BOOLEAN is
			-- Is `probable_ancestor' ancestor of `an_inteface'?
		require
			non_void_interface: an_interface /= Void
			non_void_ancestor: probable_ancestor /= Void
		do
			if an_interface.inherited_interface /= Void then
				Result := an_interface.inherited_interface.guid.is_equal 
							(probable_ancestor.guid)
				if not Result then
					Result := is_ancestor_of (an_interface.inherited_interface, probable_ancestor)
				end
			end
		end

	has_descendants_in_coclass (a_coclass: WIZARD_COCLASS_DESCRIPTOR;
				an_interface: WIZARD_INTERFACE_DESCRIPTOR): BOOLEAN is
			-- Does `an_interface' have descendants among intefaces of `a_coclass'?
		require
			non_void_coclass: a_coclass /= Void
			non_void_interface: an_interface /= Void
		local
			cursor: CURSOR
		do
			cursor := a_coclass.interface_descriptors.cursor
			from
				a_coclass.interface_descriptors.start
			until
				a_coclass.interface_descriptors.after or
				Result
			loop
				if not a_coclass.interface_descriptors.item.guid.is_equal (an_interface.guid) then
					Result := is_ancestor_of (a_coclass.interface_descriptors.item, an_interface)
				end
				a_coclass.interface_descriptors.forth
			end
			a_coclass.interface_descriptors.go_to (cursor)
		end
	
	descendant_in_coclass (a_coclass: WIZARD_COCLASS_DESCRIPTOR;
				an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_INTERFACE_DESCRIPTOR is
			-- Descendant of `an_interface' in `a_coclass'.
		require
			non_void_coclass: a_coclass /= Void
			non_void_interface: an_interface /= Void
			has_descendants: has_descendants_in_coclass (a_coclass, an_interface)
		local
			cursor: CURSOR
		do
			cursor := a_coclass.interface_descriptors.cursor
			from
				a_coclass.interface_descriptors.start
			until
				a_coclass.interface_descriptors.after or
				Result /= Void
			loop
				if is_ancestor_of (a_coclass.interface_descriptors.item, an_interface) then
					if has_descendants_in_coclass (a_coclass, a_coclass.interface_descriptors.item) then
						Result := descendant_in_coclass (a_coclass, a_coclass.interface_descriptors.item)
					else
						Result := a_coclass.interface_descriptors.item
					end
				end
				a_coclass.interface_descriptors.forth
			end
			a_coclass.interface_descriptors.go_to (cursor)
		ensure
			non_void_descendant: Result /= Void
		end
		
end -- class WIZARD_COCLASS_GENERATOR_HELPER

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

