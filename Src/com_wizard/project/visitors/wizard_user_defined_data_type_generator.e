indexing
	description: "User defined data type generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_USER_DEFINED_DATA_TYPE_GENERATOR

inherit
	WIZARD_DATA_TYPE_GENERATOR

	WIZARD_TYPE_VISITOR
		redefine
			process_enum
		end

	WIZARD_WRITER_DICTIONARY

	WIZARD_SHARED_GENERATION_ENVIRONMENT

feature -- Basic operations

	process (a_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR) is
		require
			valid_descriptor: a_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			a_type_descriptor: WIZARD_TYPE_DESCRIPTOR
			an_index: INTEGER
		do
			an_index := a_descriptor.type_descriptor_index
			a_type_descriptor := a_descriptor.library_descriptor.descriptors.item (an_index)
			vt_type := a_descriptor.type
			local_counter := counter (a_descriptor)

			visit (a_type_descriptor)

			set_visitor_atributes (a_visitor)
		end

feature -- Processing

	process_alias (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
		local
			a_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			a_type_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			c_type := clone (alias_descriptor.c_type_name)
			create c_post_type.make (0)
			c_header_file := clone (alias_descriptor.c_header_file_name)
			eiffel_type := clone (alias_descriptor.eiffel_class_name)

			need_generate_ce := True

			create ce_function_name.make (0)
			ce_function_name.append ("ccom_ce_alias_")
			ce_function_name.append (eiffel_type)
			ce_function_name.append_integer (local_counter)

			create ce_function_signature.make (0)
			ce_function_signature.append (c_type)
			ce_function_signature.append (Space)
			ce_function_signature.append ("an_alias")

			a_type_descriptor := alias_descriptor.type_descriptor
			create a_type_visitor
			a_type_visitor.visit (a_type_descriptor)
			writable := a_type_visitor.writable

			if a_type_visitor.is_basic_type then
				need_generate_ce := False
				is_basic_type := True
				cecil_type := clone (a_type_visitor.cecil_type)
				eiffel_type := clone (a_type_visitor.eiffel_type)
				vt_type := a_type_visitor.vt_type

			else
				ce_function_body := ce_function_body_alias 
					(eiffel_type, a_type_visitor.ce_function_name, a_type_visitor.need_generate_ce)

				create ce_function_return_type.make (0)
				ce_function_return_type.append (Eif_reference)
			end

			if a_type_visitor.need_generate_ec then
				need_generate_ec := True

				create ec_function_name.make (0)
				ec_function_name.append ("ccom_ec_alias_")
				ec_function_name.append (eiffel_type)
				ec_function_name.append_integer (local_counter)

				ec_function_body := clone (a_type_visitor.ec_function_body)
				ec_function_signature := clone (a_type_visitor.ec_function_signature)
				ec_function_return_type := clone (c_type)

			else
				ec_function_name := clone (a_type_visitor.ec_function_name)
			end

			if a_type_visitor.vt_type = Vt_bool then
				vt_type := Vt_bool
				is_basic_type := False
				eiffel_type := clone (a_type_visitor.eiffel_type)
				need_generate_ce := False
				need_generate_ec := False

				ec_function_name := clone (a_type_visitor.ec_function_name)
				ce_function_name := clone (a_type_visitor.ce_function_name)
			end
			can_free := a_type_visitor.can_free

		end

	process_coclass (coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
		do
			add_warning (Current, not_supported_data_type)
		end

	process_implemented_interface (interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- process interface
		do
			add_warning (Current, not_supported_data_type)
		end

	process_interface (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
		do
			c_type := clone (interface_descriptor.c_type_name)
			create c_post_type.make (0)
			c_header_file := clone (interface_descriptor.c_header_file_name)
			eiffel_type := clone (interface_descriptor.eiffel_class_name)

			is_interface := True

			need_generate_ce := True
			need_generate_ec := True

			create ce_function_name.make (0)
			ce_function_name.append ("ccom_ce_interface_")
			ce_function_name.append (eiffel_type)
			ce_function_name.append_integer (local_counter)

			create ce_function_signature.make (0)
			ce_function_signature.append (c_type)
			ce_function_signature.append (" * a_interface")

			create ce_function_body.make (0)
			ce_function_body.append (ce_function_body_interface (eiffel_type))

			create ce_function_return_type.make (0)
			ce_function_return_type.append (Eif_reference)

			create ec_function_name.make (0)
			ec_function_name.append ("ccom_ec_interface_")
			ec_function_name.append (eiffel_type)
			ec_function_name.append_integer (local_counter)

			create ec_function_return_type.make (0)
			ec_function_return_type.append (c_type)

			create ec_function_signature.make (0)
			ec_function_signature.append (Eif_reference)
			ec_function_signature.append (Space)
			ec_function_signature.append (Eif_ref_variable)

			ec_function_body := ec_function_body_wrapper (eiffel_type, c_type)
		end

	process_enum (enum_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
		do
			Precursor {WIZARD_TYPE_VISITOR} (enum_descriptor)
			c_type := clone (Int)
			cecil_type := clone (Eif_integer)
			create c_post_type.make (0)
			create c_header_file.make (0)
			eiffel_type := clone (enum_descriptor.eiffel_class_name)

			is_enumeration := True
		end

	process_record (record_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- process structure
		do
			c_type := clone (record_descriptor.c_type_name)
			create c_post_type.make (0)
			c_header_file := clone (record_descriptor.c_header_file_name)
			eiffel_type := clone (record_descriptor.eiffel_class_name)

			is_structure := True

			need_generate_ce := True
			need_generate_ec := True

			create ce_function_name.make (0)
			ce_function_name.append ("ccom_ce_pointed_record_")
			ce_function_name.append (eiffel_type)
			ce_function_name.append_integer (local_counter)

			create ce_function_signature.make (0)
			ce_function_signature.append (c_type)
			ce_function_signature.append (" * a_record")

			create ce_function_body.make (0)
			ce_function_body.append (ce_function_body_record (eiffel_type))

			create ce_function_return_type.make (0)
			ce_function_return_type.append (Eif_reference)

			create ec_function_name.make (0)
			ec_function_name.append ("ccom_ec_record_")
			ec_function_name.append (eiffel_type)
			ec_function_name.append_integer (local_counter)

			create ec_function_return_type.make (0)
			ec_function_return_type.append (c_type)

			create ec_function_signature.make (0)
			ec_function_signature.append (Eif_reference)
			ec_function_signature.append (Space)
			ec_function_signature.append (Eif_ref_variable)

			ec_function_body := ec_function_body_wrapper (eiffel_type, c_type)
		end

 
feature {NONE} -- Implementation

	local_counter: INTEGER
			-- Counter value

	ce_function_body_record (a_class_name: STRING): STRING is
			-- ce function body for records
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.empty
		do
			create Result.make (0)

			Result.append (tab)
			Result.append (Return)
			Result.append (Space)

			Result.append (Ce_mapper)
			Result.append (Dot)
			Result.append ("ccom_ce_pointed_record")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("a_record")
			Result.append (Comma)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append (a_class_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	ce_function_body_interface (a_class_name: STRING): STRING is
			-- ce function body for interfaces
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.empty
		do
			create Result.make (0)
			Result.append (tab)

			Result.append (Return)
			Result.append (Space)

			Result.append (Ce_mapper)
			Result.append (Dot)
			Result.append ("ccom_ce_interface")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("a_interface")
			Result.append (Comma)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append (a_class_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	ec_function_body_wrapper (a_class_name, a_c_type: STRING): STRING is
			-- ec function body for wrappers.
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.empty
			non_void_c_type: a_c_type /= Void
			valid_c_type: not a_c_type.empty
		do
			create Result.make (0)
			Result.append (tab)

			-- EIF_TYPE_ID type_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append (Type_id)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_OBJECT eif_object;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append (Eif_object_variable)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_POINTER_FUNCTION item;

			Result.append (Eif_pointer_function)
			Result.append (Space)
			Result.append (Item_clause)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_POINTER a_pointer;
			-- 

			Result.append (Eif_pointer)
			Result.append (Space)
			Result.append (A_pointer)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- eif_object = eif_protect (eif_ref);

			Result.append (Eif_object_variable)
			Result.append (Space_equal_space)
			Result.append (Eif_protect)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_ref_variable)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- type_id = eif_type_id ("`a_class_name'");

			Result.append (Type_id)
			Result.append (Space_equal_space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (a_class_name)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- item = eif_pointer_function ("item", type_id);

			Result.append (Item_clause)
			Result.append (Space_equal_space)
			Result.append (Eif_pointer_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (Item_clause)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- a_pointer = item (eif_access (eif_object));

			Result.append (A_pointer)
			Result.append (Space_equal_space)
			Result.append (Item_clause)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_object_variable)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eif_wean (eif_object);

			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_object_variable)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- return *(`a_c_type *') a_pointer;

			Result.append (Return)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (a_c_type)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (A_pointer)
			Result.append (Semicolon)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	ce_function_body_alias (a_class_name, ce_function_for_alias: STRING; 
					need_generate_alias: BOOLEAN): STRING is
			-- ce function body for aliases
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.empty
			non_void_ce_function: ce_function_for_alias /= Void
			valid_ce_function: not ce_function_for_alias.empty
		do
			create Result.make (0)
			Result.append (Tab)

			-- EIF_TYPE_ID type_id;

			Result.append (Eif_type_id)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_PROCEDURE make;

			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append ("make")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_OBJECT result;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append ("result")
			Result.append (Semicolon)
			Result.append (New_line)


			--

			Result.append (New_line_tab)

			-- type_id = eif_type_id (`a_class_name');

			Result.append ("type_id")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (a_class_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- result = eif_create (type_id);

			Result.append ("result")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_create)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- make = eif_procedure ("make_from_alias", type_id);

			Result.append ("make")
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (Eif_procedure_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append ("make_from_alias")
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (Space)
			Result.append ("type_id")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)

			--

			Result.append (New_line_tab)

			-- make (eif_access (result), rt_object.`ce_function_for_alias' (an_alias));

			Result.append ("make")
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("result")
			Result.append (Close_parenthesis)
			Result.append (Comma)
			Result.append (Space)
			if need_generate_alias then
				Result.append (Generated_ce_mapper)
			else
				Result.append (Ce_mapper)
			end
			Result.append (Dot)
			Result.append (ce_function_for_alias)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("an_alias")
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)

			--

			Result.append (New_line_tab)

			-- return eif_wean (result);

			Result.append (Return)
			Result.append (Space)
			Result.append (Eif_wean)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append ("result")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end
	
end -- class WIZARD_USER_DEFINED_DATA_TYPE_GENERATOR

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

