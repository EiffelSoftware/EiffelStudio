indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_HELPER

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end


feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	connection_point_inner_class_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_coclass_writer: WIZARD_WRITER_CPP_CLASS): STRING is
			-- Name of inner class.
		require
			non_void_interface: an_interface /= Void
			non_void_coclass: a_coclass_writer /= Void
		do
			create Result.make (100)
			Result.append ("ecom_XCP_")
			Result.append (an_interface.c_type_name)
			Result.append ("_")
			Result.append (a_coclass_writer.name)
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
		
	connection_point_attrubute_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_coclass_writer: WIZARD_WRITER_CPP_CLASS): STRING is
			-- Name of connection point attribute.
		require
			non_void_interface: an_interface /= Void
			non_void_coclass: a_coclass_writer /= Void
		do
			create Result.make (100)
			Result.append ("p_" + connection_point_inner_class_name (an_interface, a_coclass_writer))
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class WIZARD_SOURCE_INTERFACE_HELPER

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

