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

	WIZARD_MESSAGE_OUTPUT

feature -- Access
	
 	assertions: LINKED_LIST[WIZARD_WRITER_ASSERTION]
			-- Assertions

feature -- Basic operation

	generate_precondition (a_name: STRING; type: WIZARD_DATA_TYPE_DESCRIPTOR; 
					in_param, out_param: BOOLEAN) is
			-- Generate precondition.
		require
			non_void_descriptor: type /= Void
			non_void_string: a_name /= Void
			valid_string: not a_name.empty
		local
			tmp_tag, tmp_body: STRING
			tmp_writer: WIZARD_WRITER_ASSERTION
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create assertions.make
			create visitor
		
			visitor.visit (type)

			if not visitor.is_basic_type and not is_boolean (visitor.vt_type) 
					and not visitor.is_enumeration then
				tmp_tag := "non_void_"
				tmp_tag.append (a_name)
				tmp_body := clone (a_name)
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
			valid_name: not a_feature_name.empty
		local
			tmp_tag, tmp_body, a_precondition_name: STRING
		do
			a_precondition_name := vartype_namer.user_precondition_name (a_feature_name)
			tmp_tag := clone (a_precondition_name)
			tmp_body := clone (a_precondition_name)

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
			valid_string: not a_name.empty
		local
			tmp_tag, tmp_body: STRING
			tmp_writer: WIZARD_WRITER_ASSERTION
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create assertions.make
			create visitor
			visitor.visit (a_type)

			if not visitor.is_basic_type and not is_boolean (visitor.vt_type) 
					and not visitor.is_enumeration then
				if ret_val then
					tmp_tag := "non_void_"
					tmp_tag.append (a_name)
					tmp_body := clone (Result_keyword)
					tmp_body.append (" /= Void")
					create tmp_writer.make (tmp_tag, tmp_body)
					assertions.extend (tmp_writer)
				end

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
			valid_name: not a_name.empty
			non_void_descriptor: type /= Void
			non_void_visitor: visitor /= Void
		local
			tmp_tag, tmp_body: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			pointed_descriptor ?= type
			if pointed_descriptor /= Void and not (visitor.vt_type = binary_or (Vt_ptr, Vt_byref)) then
				if visitor.is_structure_pointer or visitor.is_interface_pointer then
					tmp_tag := "valid_"
					tmp_tag.append (a_name)
					tmp_body := clone (a_name)
					tmp_body.append (".item /= default_pointer")
					create Result.make (tmp_tag, tmp_body)

				elseif not visitor.is_basic_type_ref  then
					tmp_tag := "valid_"
					tmp_tag.append (a_name)
					tmp_body := clone (a_name)
					if in_param then
						tmp_body.append (".item /= Void")
					else
						tmp_body.append (".item = Void")
					end
					create Result.make (tmp_tag, tmp_body)
				end
			elseif visitor.is_structure then
				tmp_tag := "valid_"
				tmp_tag.append (a_name)
				tmp_body := clone (a_name)
				tmp_body.append (".item /= default_pointer")
				create Result.make (tmp_tag, tmp_body)
			end
		end

	additional_postcondition (a_name: STRING; type: WIZARD_DATA_TYPE_DESCRIPTOR; 
		visitor: WIZARD_DATA_TYPE_VISITOR; ret_val: BOOLEAN): WIZARD_WRITER_ASSERTION is
			-- A writer
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
			non_void_descriptor: type /= Void
			non_void_visitor: visitor /= Void
		local
			tmp_tag, tmp_body: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			pointed_descriptor ?= type
			if pointed_descriptor /= Void  then
				if  (visitor.vt_type = binary_or (Vt_ptr, Vt_byref)) then
					tmp_tag := "valid_"
					tmp_tag.append (a_name)
					if ret_val then
						tmp_body := clone (Result_keyword)
					else
						tmp_body := clone (a_name)
					end
					tmp_body.append (".item /= default_pointer")
					create Result.make (tmp_tag, tmp_body)

				elseif ret_val and (visitor.is_structure_pointer or
						visitor.is_interface_pointer) 
				then
					tmp_tag := "valid_"
					tmp_tag.append (a_name)
					tmp_body := clone (Result_keyword)
					tmp_body.append (".item /= default_pointer")
					create Result.make (tmp_tag, tmp_body)

				elseif not visitor.is_basic_type_ref and
						not visitor.is_structure_pointer and
						not visitor.is_interface_pointer 
				then
					tmp_tag := "valid_"
					tmp_tag.append (a_name)
					if ret_val then
						tmp_body := clone (Result_keyword)
					else
						tmp_body := clone (a_name)
					end
					tmp_body.append (".item /= Void")
					create Result.make (tmp_tag, tmp_body)
				end
			elseif visitor.is_structure then
				tmp_tag := "valid_"
				tmp_tag.append (a_name)
				if ret_val then
					tmp_body := clone (Result_keyword)
				else
					tmp_body := clone (a_name)
				end
				tmp_body.append (".item /= default_pointer")
				create Result.make (tmp_tag, tmp_body)

			end
		end

	header_file_name (class_name: STRING): STRING is
			-- Header file name
		require
			non_void_class_name: class_name /= Void
			valid_class_name: not class_name.empty
		do
			create Result.make (0)
			Result.append (Percent_double_quote)
			Result.append ("E_")
			Result.append (class_name)
			Result.append (Header_file_extension)
			Result.append (Percent_double_quote)
		ensure
			non_void_header_name: Result /= Void
			valid_header_name: not result.empty
		end

end -- class WIZARD_EIFFEL_ASSERTION_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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
