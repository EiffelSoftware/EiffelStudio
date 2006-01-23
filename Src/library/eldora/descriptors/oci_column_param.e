indexing
	description: "Wrapper for column descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_column_param.e $"

class
	OCI_COLUMN_PARAM

inherit
	OCI_PARAMETER
		redefine
			get_attributes
		end
	
	OCI_DEFINITIONS
		export {NONE} all
		undefine
			is_equal
		end
		
create
	make
		
feature {NONE} -- Initialization

	make (stmt: OCI_STATEMENT; index: INTEGER; errh: OCI_ERROR_HANDLER) is
		local
			status: INTEGER_16
			l_descriptor: like descriptor
		do
			status := oci_param_get (stmt.handle, stmt.handle_type, errh.handle, $l_descriptor, index)
			descriptor := l_descriptor
			errh.check_error (status)
			is_allocated := status = Oci_success
			get_attributes (errh)
		end
		
feature -- Access

	data_size: INTEGER_16
		-- the maximum size of the column in bytes
	
	data_type: INTEGER_16
		-- the data type of the column
	
	name: STRING
		-- the column name
	
	is_nullable: BOOLEAN
		-- `True' if null values are permitted for the column 
	
	precision: INTEGER_8
		-- the precision of numeric columns
	
	scale: INTEGER_8
		-- the scale of numeric columns
	
	type_name: STRING
		-- the type name
	
	schema_name: STRING
		-- the schema name under which the type has been created
	
--	ref_tdo: OCI_REF -- the in-memory REF of the TDO for the type, if the column type is an object type
	
	charset_id: INTEGER_16
		-- the character set id, if the type attribute is of a string/character type

	charset_form: INTEGER_8
		-- the character set form, if the type attribute is of a string/character type
	
	is_string_type (type: INTEGER): BOOLEAN is
			-- Is `type' a string/character type ?
		do
			Result := 
				type = Sqlt_chr or
				type = Sqlt_str or
				type = Sqlt_vcs
		end
		
	is_numeric_type (type: INTEGER): BOOLEAN is
			-- Is `type' a numeric type ?
		do
			Result := 
				type = Sqlt_num or
				type = Sqlt_int or
				type = Sqlt_flt or
				type = Sqlt_vnu or
				type = Sqlt_pdn or
				type = Sqlt_uin
		end
		
	get_attributes (errh: OCI_ERROR_HANDLER) is
			-- Assign values of attributes
		do
			Precursor (errh)
			data_size := int16_attr (Oci_attr_data_size, errh)
			data_type := int16_attr (Oci_attr_data_type, errh)
			name := str_attr (Oci_attr_name, errh)
			is_nullable := int8_attr (Oci_attr_is_null, errh) /= 0
			if is_numeric_type (data_type) then
				precision := int8_attr (Oci_attr_precision, errh)
				scale := int8_attr (Oci_attr_scale, errh)
			end
			if data_type = Sqlt_nty or data_type = Sqlt_ref then
				type_name := str_attr (Oci_attr_type_name, errh)
				schema_name := str_attr (Oci_attr_schema_name, errh)
				-- To do : ref_tdo
			end
			if is_string_type (data_type) then
				charset_id := int16_attr (Oci_attr_charset_id, errh)
				charset_form := int8_attr (Oci_attr_charset_form, errh)
			end
		end
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class OCI_COLUMN_PARAM
