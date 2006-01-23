indexing
	description: "Abstract OCI Parameter descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_parameter.e $"

deferred class
	OCI_PARAMETER

inherit
	OCI_DESCRIPTOR

feature {NONE} -- Initialization

	make_parameter (parent: OCI_HANDLE; errh: OCI_ERROR_HANDLER; position: INTEGER) is
			-- Create a descriptor of a parameter specified by `position' in the describe or
			-- statement `handle'
		require
			valid_parent: parent /= Void and then (parent.is_allocated and 
					(parent.handle_type = Oci_htype_describe or parent.handle_type = 
					Oci_htype_stmt))
		local
			status: INTEGER_16
			l_descriptor: like descriptor
		do
			status := oci_param_get (parent.handle, parent.handle_type, errh.handle, $descriptor,
					position)
			descriptor := l_descriptor
			errh.check_error (status)
			is_allocated := status = Oci_success
		end

feature -- Access

	parameter_type: INTEGER_8
		-- type of information described by the parameter
		
--	num_attrs: INTEGER_16 -- the number of attributes
--	
--	num_params: INTEGER_16 -- the number of parameters
--	
--	object_id: INTEGER -- object or schema Id
--	
--	object_name: STRING -- object, schema, or database name
--	
--	object_schema: STRING -- schema where the object is located
--	
--	timestamp: DATE_TIME -- the timestamp of the object this description is based on 
		
	get_attributes (errh: OCI_ERROR_HANDLER) is
		require
			allocated: is_allocated
			valid_error_handler: valid_error_handle (errh)
		do
			parameter_type := int8_attr (Oci_attr_ptype, errh)
--			num_attrs := int16_attr (Oci_attr_num_attrs, errh)
--			num_params := int16_attr (Oci_attr_num_params, errh)
--			object_id := int_attr (Oci_attr_obj_id, errh)
--			object_name := str_attr (Oci_attr_obj_name, errh)
--			object_schema := str_attr (Oci_attr_obj_schema, errh)
		end
	
feature {NONE} -- Implementation
		
	descriptor_type: INTEGER is
			-- Descriptor type
		do
			Result := Oci_dtype_param
		end
		
feature {NONE} -- Externals

	oci_param_get (hndlp: POINTER; htype: INTEGER; errhp: POINTER; parmdpp: POINTER; pos: INTEGER):
			INTEGER_16 is
		external
			"C (void *, int, void *, void **, int): short | %"oci.h%""
		alias
			"OCIParamGet"
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




end -- class OCI_PARAMETER
