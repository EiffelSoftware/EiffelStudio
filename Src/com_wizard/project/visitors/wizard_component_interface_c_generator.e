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

	make (a_component: WIZARD_COMPONENT_DESCRIPTOR; an_interface: WIZARD_INTERFACE_DESCRIPTOR;
					a_writer: WIZARD_WRITER_CPP_CLASS) is
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
