indexing
	description: "Assertion generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_ASSERTION_GENERATOR

inherit
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export 
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Access
	
 	assertions: LIST [WIZARD_WRITER_ASSERTION]
			-- Assertions

feature -- Basic operation

	generate_precondition (a_name: STRING; type: WIZARD_DATA_TYPE_DESCRIPTOR; 
					in_param, out_param: BOOLEAN) is
			-- Generate precondition.
		require
			non_void_descriptor: type /= Void
			non_void_string: a_name /= Void
			valid_string: not a_name.is_empty
		local
			tmp_tag, tmp_body: STRING
			tmp_writer: WIZARD_WRITER_ASSERTION
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create {ARRAYED_LIST [WIZARD_WRITER_ASSERTION]} assertions.make (20)
		
			visitor := type.visitor 

			if 
				not visitor.is_basic_type and 
				not is_boolean (visitor.vt_type) and 
				not visitor.is_enumeration and 
				not visitor.is_interface_pointer and 
				not visitor.is_coclass_pointer and
				not (visitor.vt_type = Vt_lpstr) and
				not (visitor.vt_type = Vt_lpwstr) and
				not (visitor.vt_type = Vt_bstr)
			then
				create tmp_tag.make (100)
				tmp_tag.append ("non_void_")
				tmp_tag.append (a_name)
				
				create tmp_body.make (100)
				tmp_body.append (a_name)
				tmp_body.append (" /= Void")

				create tmp_writer.make (tmp_tag, tmp_body)

				assertions.extend (tmp_writer)

				tmp_writer := additional_precondition (a_name, type, visitor, in_param, out_param)
				if tmp_writer /= Void then
					assertions.extend (tmp_writer)				
				end
			end
			visitor := Void
		ensure
			non_void_assertions: assertions /= Void
		end

	user_defined_precondition (a_feature_name: STRING): WIZARD_WRITER_ASSERTION is
			-- User defined precondition.
		require
			non_void_name: a_feature_name /= Void
			valid_name: not a_feature_name.is_empty
		local
			tmp_tag, tmp_body, a_precondition_name: STRING
		do
			a_precondition_name := user_precondition_name (a_feature_name)
			tmp_tag := a_precondition_name.twin
			tmp_body := a_precondition_name.twin

			create Result.make (tmp_tag, tmp_body)
		ensure
			non_void_assertion: Result /= Void
		end

	generate_postcondition (a_name: STRING; a_type: WIZARD_DATA_TYPE_DESCRIPTOR; 
					ret_val: BOOLEAN) is
			-- Generate postcondition.
		require
			non_void_descriptor: a_type /= Void
			non_void_string: a_name /= Void
			valid_string: not a_name.is_empty
		local
			tmp_writer: WIZARD_WRITER_ASSERTION
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create {ARRAYED_LIST [WIZARD_WRITER_ASSERTION]} assertions.make (20)
			visitor := a_type.visitor 

			if 
				not visitor.is_basic_type and 
				not is_boolean (visitor.vt_type) and 
				not visitor.is_enumeration 
			then
				tmp_writer := additional_postcondition (a_name, a_type, visitor, ret_val)
				if tmp_writer /= Void then
					assertions.extend (tmp_writer)				
				end
			end
			visitor := Void
		ensure
			non_void_assertions: assertions /= Void
		end


feature {NONE}  

	additional_precondition (a_name: STRING; type: WIZARD_DATA_TYPE_DESCRIPTOR; 
		visitor: WIZARD_DATA_TYPE_VISITOR; in_param, out_param: BOOLEAN): WIZARD_WRITER_ASSERTION is
			-- A writer
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_descriptor: type /= Void
			non_void_visitor: visitor /= Void
		local
			tmp_tag, tmp_body: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			pointed_descriptor ?= type
			if pointed_descriptor /= Void and not (visitor.vt_type = binary_or (Vt_ptr, Vt_byref)) then
				if 
					visitor.is_structure_pointer 
				then
					create tmp_tag.make (100)
					tmp_tag.append ("valid_")
					tmp_tag.append (a_name)
					
					create tmp_body.make (100)
					tmp_body.append (a_name)
					tmp_body.append (".item /= default_pointer")
					create Result.make (tmp_tag, tmp_body)

				elseif is_error (visitor.vt_type) or is_hresult (visitor.vt_type) then

				elseif not visitor.is_basic_type_ref and in_param then
					
					create tmp_tag.make (100)
					tmp_tag.append ("valid_")
					tmp_tag.append (a_name)
					
					create tmp_body.make (100)
					tmp_body.append (a_name)
					tmp_body.append (".item /= Void")
					create Result.make (tmp_tag, tmp_body)
				end
			elseif visitor.is_structure then
				create tmp_tag.make (100)
				tmp_tag.append ("valid_")
				tmp_tag.append (a_name)
				
				create tmp_body.make (100)
				tmp_body.append (a_name)
				tmp_body.append (".item /= default_pointer")
				create Result.make (tmp_tag, tmp_body)
			end
		end

	additional_postcondition (a_name: STRING; type: WIZARD_DATA_TYPE_DESCRIPTOR; 
		visitor: WIZARD_DATA_TYPE_VISITOR; ret_val: BOOLEAN): WIZARD_WRITER_ASSERTION is
			-- A writer
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_descriptor: type /= Void
			non_void_visitor: visitor /= Void
		local
			tmp_tag, tmp_body: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			pointed_descriptor ?= type
			if pointed_descriptor /= Void  then
				if  (visitor.vt_type = binary_or (Vt_ptr, Vt_byref)) then
					create tmp_tag.make (100)
					tmp_tag.append ("valid_")
					tmp_tag.append (a_name)
					if ret_val then
						create tmp_body.make (100)
						tmp_body.append (Result_keyword)
					else
						create tmp_body.make (100)
						tmp_body.append (a_name)
					end
					tmp_body.append (".item /= default_pointer")
					create Result.make (tmp_tag, tmp_body)

				elseif 
					ret_val and 
					visitor.is_structure_pointer
				then
					create tmp_tag.make (100)
					tmp_tag.append ("valid_")
					tmp_tag.append (a_name)
					
					create tmp_body.make (100)
					tmp_body.append (Result_keyword)
					tmp_body.append (".item /= default_pointer")
					create Result.make (tmp_tag, tmp_body)

				elseif 
					not visitor.is_basic_type_ref and
					not visitor.is_structure_pointer and
					not visitor.is_interface_pointer and
					not visitor.is_coclass_pointer 
				then
					create tmp_tag.make (100)
					tmp_tag.append ("valid_")
					tmp_tag.append (a_name)
					if ret_val then
						create tmp_body.make (100)
						tmp_body.append (Result_keyword)
					else
						create tmp_body.make (100)
						tmp_body.append (a_name)
					end
					tmp_body.append (".item /= Void")
					create Result.make (tmp_tag, tmp_body)
				end
			elseif visitor.is_structure then
				create tmp_tag.make (100)
				tmp_tag.append ("valid_")
				tmp_tag.append (a_name)
				if ret_val then
					create tmp_body.make (100)
					tmp_body.append (Result_keyword)
				else
					create tmp_body.make (100)
					tmp_body.append (a_name)
				end
				tmp_body.append (".item /= default_pointer")
				create Result.make (tmp_tag, tmp_body)

			end
		end

end -- class WIZARD_EIFFEL_ASSERTION_GENERATOR

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

