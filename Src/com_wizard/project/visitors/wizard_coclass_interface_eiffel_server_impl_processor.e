indexing
	description: "Processing interfaces for Eiffel server implementation coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 
		redefine
			generate_interface_features 
		end

create
	make

feature -- Basic operations

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			if not has_descendants_in_coclass (coclass, an_interface) then
				if 
					an_interface.dispinterface and 
					not an_interface.dual
				then
					dispatch_interface := True
				end
				create inherit_clause.make
				inherit_clause.set_name (an_interface.eiffel_class_name)

				generate_functions_and_properties (an_interface, inherit_clause)
			end
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		do
		end

	generate_functions_and_properties (an_interface: WIZARD_INTERFACE_DESCRIPTOR;
				an_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties for interface.
		local
			interface_generator: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_GENERATOR
		do
			create interface_generator.make (coclass, an_interface, eiffel_writer, an_inherit_clause)
			interface_generator.generate_functions_and_properties (an_interface)
		end

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_PROCESSOR

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
