indexing
	description: "Processing interfaces for C coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_C_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_PROCESSOR

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end

	WIZARD_COMPONENT_C_GENERATOR
		rename
			coclass as dictionary_coclass
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_coclass: WIZARD_COCLASS_DESCRIPTOR; 
				a_coclass_generator: WIZARD_COCLASS_C_GENERATOR) is
			-- Initialize
		require
			non_void_coclass: a_coclass /= Void
			non_void_generator: a_coclass_generator /= Void
		do
			coclass := a_coclass
			coclass_generator := a_coclass_generator
		end

feature -- Access

	coclass_generator: WIZARD_COCLASS_C_GENERATOR
			-- Coclass generator.

	dispatch_interface: BOOLEAN
			-- Does coclass have dispinterface?

feature -- Basic operations

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		deferred
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		deferred
		end

feature {NONE} -- Implementation

	clean_up is
			-- Clean up.
		do
			coclass := Void
			coclass_generator := Void
		end

invariant
	non_void_coclass_generator: not finished implies coclass_generator /= Void

end -- class WIZARD_COCLASS_INTERFACE_C_PROCESSOR

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
