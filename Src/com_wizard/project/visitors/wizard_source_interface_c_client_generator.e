indexing
	description: "Source interface C client generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_C_CLIENT_GENERATOR

inherit
	WIZARD_SOURCE_INTERFACE_CLIENT_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR
		export
			{NONE} all
		end
	
	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end
	
create
	generate

feature -- Initialization

	generate (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_writer: WIZARD_WRITER_CPP_CLASS) is
			-- Generate connection points features.
		do
			a_writer.add_import (an_interface.c_header_file_name)
			a_writer.add_member (cookie_member (an_interface), Private)
			a_writer.add_function (enable_routine (an_interface), Public)
			a_writer.add_function (disable_routine (an_interface), Public)
		end

feature -- Basic operations

	enable_routine (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- Enable call back routine.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		local
			a_signature: STRING
		do
			create Result.make
			Result.set_name (external_feature_name (enable_feature_name (an_interface)))
			
			create a_signature.make (100)
			a_signature.append (Eif_pointer)
			a_signature.append (Space)
			a_signature.append ("p_events")
			Result.set_signature (a_signature)
			
			Result.set_result_type (Void_c_keyword)
			Result.set_comment ("Hook up call back interface.")
			Result.set_body (enable_body (an_interface))
		ensure
			non_void_routine: Result /= Void
			valid_routine: Result.can_generate
		end

	enable_body (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Body of enable call back routine.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
			non_void_interface_guid: an_interface.guid /= Void
		do
			create Result.make (1000)
			Result.append (Tab)
			Result.append ("IConnectionPointContainer * pcpc = 0;%N%T")
			Result.append (Hresult_variable)
			Result.append (Tab)
			
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Iunknown_variable_name)
			Result.append (Struct_selection_operator)
			Result.append (Query_interface)
			Result.append ("(IID_IConnectionPointContainer, (void**)&pcpc);%N")
			
			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line_tab)
			
			Result.append ("IConnectionPoint * pcp = 0;%N%T")
			
			Result.append ("IID temp_IID = ")
			Result.append (an_interface.guid.to_definition_string)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			Result.append (Hresult_variable_name)
			Result.append (" = pcpc->FindConnectionPoint (temp_IID, &pcp);%N")
			
			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line_tab)
			
			Result.append (Hresult_variable_name)
			Result.append (" = pcp->Advise ((IUnknown *)p_events, &")
			Result.append (cookie_name (an_interface))
			Result.append (");%N")
			
			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line_tab)
			
			Result.append ("pcp->Release ();%N%T")
			Result.append ("pcpc->Release ();")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end
		
	disable_routine (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- Disable call back routine.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make
			
			Result.set_name (external_feature_name (disable_feature_name (an_interface)))
			Result.set_result_type (Void_c_keyword)
			Result.set_comment ("Tear down call back interface.")
			Result.set_body (disable_body (an_interface))
		ensure
			non_void_routine: Result /= Void
			valid_routine: Result.can_generate
		end
	
	disable_body (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Body of disable call back routine.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
			non_void_interface_guid: an_interface.guid /= Void
		do
			create Result.make (1000)
			Result.append (Tab)
			Result.append ("IConnectionPointContainer * pcpc = 0;%N%T")
			Result.append (Hresult_variable)
			Result.append (Tab)

			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Iunknown_variable_name)
			Result.append (Struct_selection_operator)
			Result.append (Query_interface)
			Result.append ("(IID_IConnectionPointContainer, (void**)&pcpc);%N")

			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line_tab)

			Result.append ("IConnectionPoint * pcp = 0;%N%T")

			Result.append ("IID temp_IID = ")
			Result.append (an_interface.guid.to_definition_string)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Hresult_variable_name)
			Result.append (" = pcpc->FindConnectionPoint (temp_IID, &pcp);%N")

			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line_tab)

			Result.append (Hresult_variable_name)
			Result.append (" = pcp->Unadvise (")
			Result.append (cookie_name (an_interface))
			Result.append (");%N")

			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line_tab)

			Result.append ("pcp->Release ();%N%T")
			Result.append ("pcpc->Release ();")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	cookie_member (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_C_MEMBER is
			-- Call back interface cookie member.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make
			
			Result.set_name (cookie_name (an_interface))
			Result.set_result_type (Dword)
			Result.set_comment ("Call back interface cookie.")
		ensure
			non_void_member: Result /= Void
			valid_member: Result.can_generate
		end
	
	cookie_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR):STRING is
			-- Name of cookie member.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("cookie_")
			Result.append (an_interface.name)
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
		
end -- class WIZARD_SOURCE_INTERFACE_C_CLIENT_GENERATOR

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
