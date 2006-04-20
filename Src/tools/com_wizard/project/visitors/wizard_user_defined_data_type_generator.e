indexing
	description: "User defined data type generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Basic operations

	process (a_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR) is
		require
			valid_descriptor: a_descriptor /= Void
			valid_visitor: a_visitor /= Void
		local
			a_type_descriptor: WIZARD_TYPE_DESCRIPTOR
			a_index: INTEGER
		do
			a_index := a_descriptor.type_descriptor_index
			a_type_descriptor := a_descriptor.library_descriptor.descriptors.item (a_index)
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
			create c_type.make (100)
			if 
				alias_descriptor.namespace /= Void and then
				not alias_descriptor.namespace.is_empty
			then
				c_type.append (alias_descriptor.namespace + "::")
			end
			c_type.append (alias_descriptor.c_type_name)
			
			create c_post_type.make (100)
			c_definition_header_file_name := alias_descriptor.c_header_file_name
			eiffel_type := alias_descriptor.eiffel_class_name.twin

			need_generate_ce := True

			create ce_function_name.make (100)
			ce_function_name.append ("ccom_ce_alias_")
			ce_function_name.append (eiffel_type)
			ce_function_name.append_integer (local_counter)

			create ce_function_signature.make (100)
			ce_function_signature.append (c_type)
			ce_function_signature.append (Space)
			ce_function_signature.append ("an_alias")

			a_type_descriptor := alias_descriptor.type_descriptor
			a_type_visitor := a_type_descriptor.visitor
			writable := a_type_visitor.writable

			need_free_memory := a_type_visitor.need_free_memory
			need_generate_free_memory := a_type_visitor.need_generate_free_memory
			
			if need_free_memory then
				if need_generate_free_memory then
					free_memory_function_name := "free_memory_" + local_counter.out
					free_memory_function_signature := (c_type + " a_pointer")
					free_memory_function_body := a_type_visitor.free_memory_function_body.twin
				else
					free_memory_function_name := a_type_visitor.free_memory_function_name.twin
				end
			end

			is_array_basic_type := a_type_visitor.is_array_basic_type
			is_basic_type := a_type_visitor.is_basic_type
			is_basic_type_ref := a_type_visitor.is_basic_type_ref
			is_coclass := a_type_visitor.is_coclass
			is_coclass_pointer := a_type_visitor.is_coclass_pointer
			is_coclass_pointer_pointer := a_type_visitor.is_coclass_pointer_pointer
			is_enumeration := a_type_visitor.is_enumeration
			is_interface := a_type_visitor.is_interface 
			is_interface_pointer := a_type_visitor.is_interface_pointer
			is_interface_pointer_pointer := a_type_visitor.is_interface_pointer_pointer
			is_structure := a_type_visitor.is_structure 
			is_structure_pointer := a_type_visitor.is_structure_pointer

			if a_type_visitor.is_basic_type  then
				need_generate_ce := False
				cecil_type := a_type_visitor.cecil_type.twin
				eiffel_type := a_type_visitor.eiffel_type.twin
				vt_type := a_type_visitor.vt_type

			else
				ce_function_body := ce_function_body_alias (eiffel_type, a_type_visitor)
				create ce_function_return_type.make (100)
				ce_function_return_type.append (Eif_reference)
			end

			if a_type_visitor.need_generate_ec then
				need_generate_ec := True

				create ec_function_name.make (100)
				ec_function_name.append ("ccom_ec_alias_")
				ec_function_name.append (eiffel_type)
				ec_function_name.append_integer (local_counter)

				ec_function_body := a_type_visitor.ec_function_body.twin
				ec_function_signature := a_type_visitor.ec_function_signature.twin
				ec_function_return_type := c_type.twin

			elseif a_type_visitor.ec_function_name /= Void then
				ec_function_name := a_type_visitor.ec_function_name.twin
			end

			if a_type_visitor.vt_type = Vt_bool then
				vt_type := Vt_bool
				is_basic_type := False
				eiffel_type := a_type_visitor.eiffel_type.twin
				need_generate_ce := False
				need_generate_ec := False

				ec_function_name := a_type_visitor.ec_function_name.twin
				ce_function_name := a_type_visitor.ce_function_name.twin
			end
			can_free := a_type_visitor.can_free
			if vt_type = Vt_userdefined or Vt_type = binary_or (Vt_userdefined, Vt_byref) then
				vt_type := a_type_visitor.vt_type
			end
		end

	process_coclass (coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
		local
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			l_interface := coclass_descriptor.default_interface_descriptor
			if l_interface.is_idispatch_heir or l_interface.dual or l_interface.dispinterface then
				vt_type := Vt_dispatch
			else
				vt_type := Vt_unknown
			end
			
			create c_type.make (100)
			if l_interface.namespace /= Void and then not l_interface.namespace.is_empty then
				c_type.append (l_interface.namespace + "::")
			end
			c_type.append (l_interface.c_type_name)
			
			create c_post_type.make (100)
			c_definition_header_file_name := l_interface.c_definition_header_file_name
			c_declaration_header_file_name := l_interface.c_declaration_header_file_name
			eiffel_type := name_for_class (coclass_descriptor.name, coclass_descriptor.type_kind, environment.is_client)

			is_coclass := True

			need_generate_ce := True
			need_generate_ec := True

			create ce_function_name.make (100)
			ce_function_name.append ("ccom_ce_interface_")
			ce_function_name.append (eiffel_type)
			ce_function_name.append_integer (local_counter)

			create ce_function_signature.make (100)
			ce_function_signature.append (c_type)
			ce_function_signature.append (" * a_interface")

			create ce_function_body.make (10000)
			ce_function_body.append (ce_function_body_interface (eiffel_type))

			create ce_function_return_type.make (100)
			ce_function_return_type.append (Eif_reference)

			create ec_function_name.make (100)
			ec_function_name.append ("ccom_ec_interface_")
			ec_function_name.append (eiffel_type)
			ec_function_name.append_integer (local_counter)

			create ec_function_return_type.make (100)
			ec_function_return_type.append (c_type)

			create ec_function_signature.make (100)
			ec_function_signature.append (Eif_reference)
			ec_function_signature.append (Space)
			ec_function_signature.append (Eif_ref_variable)

			ec_function_body := ec_function_body_wrapper (eiffel_type, c_type)

		end

	process_implemented_interface (interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- process interface
		do
			create c_type.make (100)
			if interface_descriptor.namespace /= Void and then not interface_descriptor.namespace.is_empty then
				c_type.append (interface_descriptor.namespace + "::")
			end
			c_type.append (interface_descriptor.c_type_name)
			
			create c_post_type.make (0)
			c_definition_header_file_name := interface_descriptor.c_definition_header_file_name
			c_declaration_header_file_name := interface_descriptor.c_declaration_header_file_name
			eiffel_type := interface_descriptor.eiffel_class_name
			create ce_function_name.make (0)
			create ec_function_name.make (0)
		end

	process_interface (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
		local
			impl_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR
		do
			impl_interface := interface_descriptor.implemented_interface
			create c_type.make (100)
			c_type.append (interface_descriptor.c_type_name)
			create c_post_type.make (0)
			is_interface := True
			c_definition_header_file_name := interface_descriptor.c_definition_header_file_name
			c_declaration_header_file_name := interface_descriptor.c_declaration_header_file_name
			create ce_function_name.make (100)
			create ec_function_name.make (100)

			if c_type.is_equal (Iunknown_type) then
				vt_type := Vt_unknown
				eiffel_type := vartype_namer.eiffel_name (vt_type)
				need_generate_ce := False
				need_generate_ec := False

				ce_function_name.append ("ccom_ce_pointed_unknown")
				ec_function_name.append ("ccom_ec_unknown")

			elseif c_type.is_equal (Idispatch_type) then
				vt_type := Vt_dispatch
				eiffel_type := vartype_namer.eiffel_name (vt_type)
				need_generate_ce := False
				need_generate_ec := False

				ce_function_name.append ("ccom_ce_pointed_dispatch")
				ec_function_name.append ("ccom_ec_dispatch")
			else
				if 
					interface_descriptor.namespace /= Void and then
					not interface_descriptor.namespace.is_empty
				then
					c_type.prepend ("::")
					c_type.prepend (interface_descriptor.namespace)
				end
				if interface_descriptor.is_idispatch_heir or interface_descriptor.dispinterface then
					vt_type := Vt_dispatch
				else
					vt_type := Vt_unknown
				end
				eiffel_type := interface_descriptor.eiffel_class_name.twin

				need_generate_ce := True
				need_generate_ec := True

				ce_function_name.append ("ccom_ce_interface_")
				ce_function_name.append (eiffel_type)
				ce_function_name.append_integer (local_counter)

				create ce_function_signature.make (100)
				ce_function_signature.append (c_type)
				ce_function_signature.append (" * a_interface")

				create ce_function_body.make (10000)
				ce_function_body.append (ce_function_body_interface (impl_interface.impl_eiffel_class_name (True)))

				create ce_function_return_type.make (100)
				ce_function_return_type.append (Eif_reference)

				ec_function_name.append ("ccom_ec_interface_")
				ec_function_name.append (eiffel_type)
				ec_function_name.append_integer (local_counter)

				create ec_function_return_type.make (100)
				ec_function_return_type.append (c_type)

				create ec_function_signature.make (100)
				ec_function_signature.append (Eif_reference)
				ec_function_signature.append (Space)
				ec_function_signature.append (Eif_ref_variable)

				ec_function_body := ec_function_body_wrapper (eiffel_type, c_type)
			end
		end

	process_enum (enum_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
		do
			Precursor {WIZARD_TYPE_VISITOR} (enum_descriptor)
			enum_processing
		end

	process_record (record_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- process structure
		do
			vt_type := Vt_record
			create c_type.make (100)
			if record_descriptor.namespace /= Void and then not record_descriptor.namespace.is_empty then
				c_type.append (record_descriptor.namespace + "::")
			end
			c_type.append (record_descriptor.c_type_name)
			
			create c_post_type.make (100)
			c_definition_header_file_name := record_descriptor.c_header_file_name
			eiffel_type := record_descriptor.eiffel_class_name.twin

			is_structure := True

			need_generate_ce := True
			need_generate_ec := True

			create ce_function_name.make (100)
			ce_function_name.append ("ccom_ce_record_")
			ce_function_name.append (eiffel_type)
			ce_function_name.append_integer (local_counter)

			create ce_function_signature.make (100)
			ce_function_signature.append (c_type)
			ce_function_signature.append (Space)
			ce_function_signature.append ("a_record")

			create ce_function_body.make (10000)
			ce_function_body.append (ce_function_body_record (eiffel_type, c_type))

			create ce_function_return_type.make (100)
			ce_function_return_type.append (Eif_reference)

			create ec_function_name.make (100)
			ec_function_name.append ("ccom_ec_record_")
			ec_function_name.append (eiffel_type)
			ec_function_name.append_integer (local_counter)

			create ec_function_return_type.make (100)
			ec_function_return_type.append (c_type)

			create ec_function_signature.make (100)
			ec_function_signature.append ("EIF_REFERENCE eif_ref")

			ec_function_body := ec_function_body_wrapper (eiffel_type, c_type)
			if record_descriptor.name.is_equal ("RemotableHandle") or record_descriptor.name.is_equal ("_RemotableHandle") or record_descriptor.name.is_equal ("tag_RemotableHandle") then
				is_structure := False
				is_basic_type := True
				vt_type := Vt_void
				need_generate_ce := False
				need_generate_ec := False
				c_definition_header_file_name := ""
				cecil_type := "EIF_INTEGER"
				c_type := "void"
			end
		end

 
feature {NONE} -- Implementation

	local_counter: INTEGER
			-- Counter value

	enum_processing is
			-- Enumeration processing.
		do
			c_type := "long"
			cecil_type := "EIF_INTEGER"
			create c_post_type.make (0)
			create c_definition_header_file_name.make (0)
			eiffel_type := "INTEGER"
			vt_type := Vt_i4
			is_enumeration := True
		end

	ce_function_body_record (a_class_name, a_c_type: STRING): STRING is
			-- ce function body for records
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
			non_void_c_type: a_c_type /= Void
			valid_c_type: not a_c_type.is_empty
		do
			create Result.make (200)
			Result.append ("%Treturn rt_ce.ccom_ce_record (&a_record, %"")
			Result.append (a_class_name)
			Result.append ("%", sizeof (")
			Result.append (a_c_type)
			Result.append ("));")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	ce_function_body_interface (a_class_name: STRING): STRING is
			-- ce function body for interfaces
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
		do
			create Result.make (200)
			Result.append ("%Treturn rt_ce.ccom_ce_interface (a_interface, %"")
			Result.append (a_class_name)
			Result.append ("%");")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	ec_function_body_wrapper (a_class_name, a_c_type: STRING): STRING is
			-- ec function body for wrappers.
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
			non_void_c_type: a_c_type /= Void
			valid_c_type: not a_c_type.is_empty
		do
			create Result.make (1000)
			Result.append ("%TEIF_OBJECT eif_object = 0;%N%T")
			Result.append ("EIF_POINTER a_pointer = 0;%N%N%T")
			Result.append ("eif_object = eif_protect (eif_ref);%N%T")
			Result.append ("a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), %"item%", EIF_POINTER);%N%T")
			Result.append ("eif_wean (eif_object);%N%T")
			Result.append ("return * (")
			Result.append (a_c_type)
			Result.append (" *) a_pointer;")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	ce_function_body_alias (a_class_name: STRING; a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- ce function body for aliases
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
			non_void_visitor: a_visitor /= Void
		do
			create Result.make (1000)
			Result.append ("EIF_TYPE_ID type_id = -1;%N%T")
			Result.append ("EIF_PROCEDURE make = 0;%N%T")
			Result.append ("EIF_OBJECT result = 0;%N%N%T")
			Result.append ("type_id = eif_type_id (%"")
			Result.append (a_class_name)
			Result.append ("%");%N%T")
			Result.append ("result = eif_create (type_id);%N%T")
			Result.append ("make = eif_procedure (%"make_from_alias%", type_id);%N%N%T")
			Result.append ("make (eif_access (result), ")
			if a_visitor.need_generate_ce then
				Result.append (a_visitor.ce_mapper.variable_name)
			else
				Result.append ("rt_ce")
			end
			Result.append (".")
			Result.append (a_visitor.ce_function_name)
			Result.append (" (an_alias")
			if a_visitor.writable then
				Result.append (", ")
				Result.append ("NULL")
			end
			Result.append ("));%N%N%Treturn eif_wean (result);")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
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
end -- class WIZARD_USER_DEFINED_DATA_TYPE_GENERATOR

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

