indexing
	description: "Processing interfaces for Eiffel coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 

inherit
	WIZARD_COCLASS_INTERFACE_PROCESSOR

feature {NONE} -- Initialization

	make (a_coclass: WIZARD_COCLASS_DESCRIPTOR; an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Initialize
		require
			non_void_coclass: a_coclass /= Void
			non_void_writer: an_eiffel_writer /= Void
		do
			coclass := a_coclass
			eiffel_writer := an_eiffel_writer
		end

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
			-- Eiffel class writer.

	dispatch_interface: BOOLEAN
			-- Does coclass have dispinterface?

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
				eiffel_writer.add_inherit_clause (inherit_clause)
			end
		end

feature {NONE} -- Implementation

	generate_functions_and_properties (an_interface: WIZARD_INTERFACE_DESCRIPTOR;
				an_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties for interface.
		require
			non_void_interface: an_interface /= Void
			non_void_inherit_clause: an_inherit_clause /= Void
		deferred
		end

	clean_up is
			-- Clean up.
		do
			coclass := Void
			eiffel_writer := Void
		end

invariant
	non_void_writer: not finished implies eiffel_writer /= Void

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR

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
