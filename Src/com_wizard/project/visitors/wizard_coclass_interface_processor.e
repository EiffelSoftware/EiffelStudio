indexing
	description: "Processing interfaces for coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_PROCESSOR


feature -- Access

	coclass: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor.

feature -- Basic operations

	process_interfaces is
			-- Process interfaces.
		require
			non_void_interface_list: coclass.interface_descriptors /= Void
		do
			from
				coclass.interface_descriptors.start
			until
				coclass.interface_descriptors.off
			loop
				generate_interface_features (coclass.interface_descriptors.item)
				coclass.interface_descriptors.forth
			end

			if coclass.source_interface_descriptors /= Void then
				from
					coclass.source_interface_descriptors.start
				until
					coclass.source_interface_descriptors.off
				loop
					generate_source_interface_features (coclass.source_interface_descriptors.item)
					coclass.source_interface_descriptors.forth
				end
			end
		end

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		require
			non_void_interface: an_interface /= Void
		deferred
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		require
			non_void_interface: an_interface /= Void
		deferred
		end

invariant
	non_void_coclass: coclass /= Void

end -- class WIZARD_COCLASS_INTERFACE_PROCESSOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
