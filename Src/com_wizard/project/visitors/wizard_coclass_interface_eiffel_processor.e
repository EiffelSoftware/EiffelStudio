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

	generate_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			l_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			if a_interface.is_implementing_coclass (coclass) then
				dispatch_interface := a_interface.dispinterface and not a_interface.dual
				create l_clause.make
				l_clause.set_name (a_interface.eiffel_class_name)
				generate_functions_and_properties (a_interface, l_clause)
				eiffel_writer.add_inherit_clause (l_clause)
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

