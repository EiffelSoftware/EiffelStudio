indexing
	description: "Processing interface for C component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_GENERATOR

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_component: WIZARD_COMPONENT_DESCRIPTOR; an_interface: WIZARD_INTERFACE_DESCRIPTOR; a_writer: WIZARD_WRITER_CPP_CLASS) is
			-- Initialize
		require
			non_void_component: a_component /= Void
			non_void_interface: an_interface /= Void
			non_void_writer: a_writer /= Void
		do
			component := a_component
			interface := an_interface
			cpp_class_writer := a_writer
		end

feature -- Access

	cpp_class_writer: WIZARD_WRITER_CPP_CLASS
			-- C++ class writer.

feature {NONE} -- Implementation

	clean_up is
			-- Clean up.
		do
			component := Void
			interface := Void
			cpp_class_writer := Void
		end

invariant
	non_void_writer: not finished implies cpp_class_writer /= Void

end -- class WIZARD_COMPONENT_INTERFACE_C_GENERATOR

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

