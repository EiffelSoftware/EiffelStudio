indexing
	description: "Generate C server code for property"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_SERVER_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_PROPERTY_GENERATOR

feature -- Basic operations

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C server access and setting features.
		require
			non_void_component: a_component /= Void
			non_void_coclass_name: a_component.name /= Void
			non_void_property: a_property /= Void
		local
			l_name, l_signature, l_string: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_access_feature.make
			create c_setting_feature.make

			l_visitor := a_property.data_type.visitor 

			-- Access feature
			create l_name.make (100)
			l_name.append ("get_")
			l_name.append (a_property.name)
			c_access_feature.set_name (l_name)

			c_access_feature.set_body (access_body (a_property.component_eiffel_name (a_component), l_visitor))
			c_access_feature.set_result_type ("STDMETHODIMP")
			c_access_feature.set_comment (a_property.description)

			-- Set c signature
			create l_signature.make (100)
			l_signature.append (" /* [out] */ ")
			l_signature.append (l_visitor.c_type)
			l_signature.append (l_visitor.c_post_type)
			l_signature.append ("* a_value")
			c_access_feature.set_signature (l_signature)

			-- Setting feature
			create l_name.make (100)
			l_name.append ("set_")
			l_name.append (a_property.name)
			c_setting_feature.set_name (l_name)

			-- set c setting body
			create l_string.make (100)
			l_string.append ("set_")
			l_string.append (a_property.component_eiffel_name (a_component))
			c_setting_feature.set_body (setting_body (l_string, l_visitor))

			c_setting_feature.set_result_type (Std_method_imp)
			c_setting_feature.set_comment (a_property.description)

			-- Set c signature
			create l_signature.make (100)
			l_signature.append (" /* [in] */ ")
			l_signature.append (l_visitor.c_type)
			l_signature.append (l_visitor.c_post_type)
			l_signature.append (" a_value")
			c_setting_feature.set_signature (l_signature)
		end

feature {NONE} -- Implementation

	access_body (l_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Access body code
		require
			non_void_name: l_name /= Void
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (1000)
			Result.append ("%TECATCH;%R%N%R%N%T")
			Result.append (cecil_function (l_name, l_visitor))

			Result.append ("%R%N%T*a_value = ")
			if l_visitor.is_basic_type or l_visitor.is_enumeration then
				Result.append ("(")
				Result.append (l_visitor.c_type)
				Result.append (")tmp_value")
			else
				if l_visitor.need_generate_ec then
					Result.append (Generated_ec_mapper)
				else
					Result.append ("rt_ec")
				end
				Result.append (".")
				Result.append (l_visitor.ec_function_name)
				Result.append (" (tmp_value")
				if l_visitor.writable then
					Result.append (", NULL")
				end
				Result.append (")")
			end
			Result.append (";%R%N%TEND_ECATCH;%R%N%T")
			Result.append ("return S_OK;")
		end

	setting_body (l_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Setting body code
		require
			non_void_name: l_name /= Void
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (1000)
			Result.append ("%TECATCH;%R%N")
			Result.append (set_variable (l_visitor))
			Result.append ("%R%N%T")
			Result.append (cecil_procedure (l_name, l_visitor))
			Result.append ("%R%N%TEND_ECATCH;%R%N%T")
			Result.append ("return S_OK;")
		end

	set_variable (l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Variables
		require
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (1000)
			Result.append (Tab)
			if l_visitor.is_basic_type or l_visitor.is_enumeration then
				Result.append (l_visitor.cecil_type)
				Result.append (" tmp_value = (")
				Result.append (l_visitor.cecil_type)
				Result.append (")a_value")
			elseif (l_visitor.vt_type = Vt_bool) then
				Result.append (l_visitor.cecil_type)
				Result.append (" tmp_value = rt_ce.")
				Result.append (l_visitor.ce_function_name)
				Result.append (" (a_value)")
			else
				Result.append ("EIF_OBJECT tmp_value;%R%N%T")
				Result.append ("tmp_value = eif_protect (")
				if l_visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append ("rt_ce")
				end
				Result.append (".")
				Result.append (l_visitor.ce_function_name)
				Result.append (" (a_value")
				if l_visitor.writable then
					Result.append (", NULL")
				end
				Result.append ("))")
			end

			Result.append (Semicolon)
		end

	cecil_function (function_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up eif_function call
		require
			non_void_visitor: l_visitor /= Void
		local
			cecil_function_type, cecil_function_name, cecil_type: STRING
		do
			if 
				l_visitor.is_basic_type or
				l_visitor.is_enumeration or
				l_visitor.vt_type = Vt_bool
			then
				cecil_type := l_visitor.cecil_type
				if 
					is_int (l_visitor.vt_type) or 
					is_integer2 (l_visitor.vt_type) or 
					is_integer4 (l_visitor.vt_type) or 
					is_unsigned_int (l_visitor.vt_type) or 
					is_unsigned_long (l_visitor.vt_type) or 
					is_unsigned_short (l_visitor.vt_type) 
				then
					cecil_function_type := Eif_integer_function
					cecil_function_name := Eif_integer_function_name
					
				elseif 
					is_character (l_visitor.vt_type) or 
					is_unsigned_char (l_visitor.vt_type) 
				then
					cecil_function_type := Eif_character_function
					cecil_function_name := Eif_character_function_name
					
				elseif is_real4 (l_visitor.vt_type) then
					cecil_function_type := Eif_real_function
					cecil_function_name := Eif_real_function_name
					
				elseif is_real8 (l_visitor.vt_type) then
					cecil_function_type := Eif_double_function
					cecil_function_name := Eif_double_function_name
					
				elseif l_visitor.vt_type = Vt_bool then
					cecil_function_type := Eif_boolean_function
					cecil_function_name := Eif_boolean_function_name
				end
			else
				cecil_type := Eif_reference
				cecil_function_type := Eif_reference_function
				cecil_function_name := Eif_reference_function_name
			end

			Result := cecil_function_code (cecil_function_type, cecil_function_name, function_name)
			Result.append ("%R%N%T")

			Result.append (cecil_type)
			Result.append (" tmp_value")
			
			if not (l_visitor.is_basic_type or l_visitor.is_enumeration or l_visitor.vt_type = Vt_bool) then
				Result.append (" = 0")
			end
			Result.append (";%R%N%T")
			
			Result.append ("if (eiffel_function != NULL)%R%N%T%T")
			
			Result.append ("tmp_value = (FUNCTION_CAST (")
			Result.append (cecil_type)
			Result.append (", (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));%R%N%T")
			
			Result.append ("else%R%N%T%T")
			
			Result.append ("tmp_value = eif_field (eif_access (eiffel_object), %"")
			Result.append (function_name)
			Result.append ("%", ")
			Result.append (cecil_type)
			Result.append (");%R%N%T")
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.is_empty
		end

	cecil_function_code (function_type, function_name, call_func_name: STRING): STRING is
			-- Cecil code
		require
			non_void_type: function_type /= Void
			non_void_name: function_name /= Void
			non_void_call_name: call_func_name /= Void
			not_empty: not function_type.is_empty and then not function_name.is_empty
							and then not call_func_name.is_empty
		do
			create Result.make (200)
			Result.append (function_type)
			Result.append (" eiffel_function = 0;%R%N%T")
			
			Result.append ("eiffel_function = ")
			Result.append (function_name)
			Result.append (" (%"")
			Result.append (call_func_name)
			Result.append ("%", type_id);%R%N%T")
		ensure
			non_void_code: Result /= Void
			valid_code: not Result.is_empty
		end

	cecil_procedure (function_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Cecil procedure code
		require
			non_void_name: function_name /= Void
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (10000)
			Result.append ("EIF_PROCEDURE eiffel_procedure;%R%N%T")

			Result.append ("eiffel_procedure = eif_procedure (%"")
			Result.append (function_name)
			Result.append ("%", type_id);%R%N%T")

			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, ")
			if l_visitor.is_basic_type or l_visitor.is_enumeration then
				Result.append (l_visitor.cecil_type)
			elseif l_visitor.vt_type = Vt_bool then
				Result.append ("EIF_BOOLEAN")
			else
				Result.append ("EIF_REFERENCE")
			end

			Result.append ("))eiffel_procedure) (eif_access (eiffel_object), ")
			if l_visitor.is_basic_type or l_visitor.vt_type = Vt_bool or l_visitor.is_enumeration then
				Result.append ("tmp_value")
			else
				Result.append ("eif_access (tmp_value)")
			end
			Result.append (");")
			if not (l_visitor.is_basic_type or l_visitor.vt_type = Vt_bool or l_visitor.is_enumeration) then
				Result.append ("%R%N%Teif_wean (tmp_value);")
			end
		ensure
			non_void_procedure: Result /= Void
			valid_procedure: not Result.is_empty
		end

end -- class WIZARD_C_SERVER_PROPERTY_GENERATOR

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
