indexing
	description: "Processing interfaces for coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_PROCESSOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		rename
			coclass as dictionary_coclass
		export
			{NONE} all
		end

	WIZARD_COCLASS_GENERATOR_HELPER
		export
			{NONE} all
		end

	
feature -- Access

	coclass: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor.

	source: BOOLEAN
			-- Is coclass source of events?

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
				source := not coclass.source_interface_descriptors.empty
				from
					coclass.source_interface_descriptors.start
				until
					coclass.source_interface_descriptors.off
				loop
					remove_from_system_interfaces (coclass.source_interface_descriptors.item.implemented_interface)
					coclass.source_interface_descriptors.item.implemented_interface.set_source (True)
					generate_source_interface_features (coclass.source_interface_descriptors.item)
					coclass.source_interface_descriptors.forth
				end
			end

			finished := True
			clean_up
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

	remove_from_system_interfaces (an_implemented_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Does `an_implemented_interface' need to be removed from `system_descriptor.interfaces'?
		do
			if system_descriptor.interfaces.has (an_implemented_interface) then
				system_descriptor.interfaces.prune_all (an_implemented_interface)
			end
		ensure
			system_does_not_have: not system_descriptor.interfaces.has (an_implemented_interface) 
		end

feature {NONE} -- Implementation

	finished: BOOLEAN
			-- Is processing finished?

	clean_up is
			-- Clean up.
		require
			finished: finished
		deferred
		end

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
