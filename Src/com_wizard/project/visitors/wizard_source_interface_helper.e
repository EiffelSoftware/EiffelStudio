indexing
	description: "Helper functions for source interface generation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_HELPER

inherit
	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

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
			Result.append (variable_name (connection_point_inner_class_name (an_interface, a_coclass_writer)))
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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

