indexing
	description: "Processing interface for C component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_GENERATOR
		redefine
			default_create
		end

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize instance.
		do
			create generated_coclasses.make (10)
		end
		
feature -- Initialization

	initialize (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_interface: WIZARD_INTERFACE_DESCRIPTOR; a_writer: WIZARD_WRITER_CPP_CLASS) is
			-- Initialize
		require
			non_void_component: a_component /= Void
			non_void_interface: a_interface /= Void
			non_void_writer: a_writer /= Void
		do
			component := a_component
			interface := a_interface
			cpp_class_writer := a_writer
			finished := False
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

