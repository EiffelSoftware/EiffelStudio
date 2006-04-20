indexing
	description: "Assertion generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	generate_precondition (a_name: STRING; a_type: WIZARD_DATA_TYPE_DESCRIPTOR; 
					in_param, out_param: BOOLEAN) is
			-- Generate precondition.
		require
			non_void_descriptor: a_type /= Void
			non_void_string: a_name /= Void
			valid_string: not a_name.is_empty
		local
			l_tag, l_body: STRING
			l_writer: WIZARD_WRITER_ASSERTION
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create {ARRAYED_LIST [WIZARD_WRITER_ASSERTION]} assertions.make (20)
		
			l_visitor := a_type.visitor 

			if 
				not l_visitor.is_basic_type and 
				not is_boolean (l_visitor.vt_type) and 
				not l_visitor.is_enumeration and 
				not l_visitor.is_interface_pointer and 
				not l_visitor.is_coclass_pointer and
				l_visitor.vt_type /= Vt_lpstr and
				l_visitor.vt_type /= Vt_lpwstr and
				l_visitor.vt_type /= Vt_bstr
			then
				create l_tag.make (100)
				l_tag.append ("attached_")
				l_tag.append (a_name)
				
				create l_body.make (100)
				l_body.append (a_name)
				l_body.append (" /= Void")

				create l_writer.make (l_tag, l_body)

				assertions.extend (l_writer)

				l_writer := additional_precondition (a_name, a_type, l_visitor, in_param, out_param)
				if l_writer /= Void then
					assertions.extend (l_writer)				
				end
			end
			l_visitor := Void
		ensure
			non_void_assertions: assertions /= Void
		end

	generate_postcondition (a_name: STRING; a_type: WIZARD_DATA_TYPE_DESCRIPTOR; 
					ret_val: BOOLEAN) is
			-- Generate postcondition.
		require
			non_void_descriptor: a_type /= Void
			non_void_string: a_name /= Void
			valid_string: not a_name.is_empty
		local
			l_writer: WIZARD_WRITER_ASSERTION
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create {ARRAYED_LIST [WIZARD_WRITER_ASSERTION]} assertions.make (20)
			l_visitor := a_type.visitor 

			if not l_visitor.is_basic_type and not is_boolean (l_visitor.vt_type) and not l_visitor.is_enumeration then
				l_writer := additional_postcondition (a_name, a_type, l_visitor, ret_val)
				if l_writer /= Void then
					assertions.extend (l_writer)				
				end
			end
			l_visitor := Void
		ensure
			non_void_assertions: assertions /= Void
		end


feature {NONE}  

	additional_precondition (a_name: STRING; a_type: WIZARD_DATA_TYPE_DESCRIPTOR; 
		a_visitor: WIZARD_DATA_TYPE_VISITOR; a_in_param, a_out_param: BOOLEAN): WIZARD_WRITER_ASSERTION is
			-- A writer
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_descriptor: a_type /= Void
			non_void_visitor: a_visitor /= Void
		local
			l_tag, l_body: STRING
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			l_descriptor ?= a_type
			if l_descriptor /= Void and a_visitor.vt_type /= binary_or (Vt_ptr, Vt_byref) then
				if a_visitor.is_structure_pointer then
					create l_tag.make (100)
					l_tag.append ("valid_")
					l_tag.append (a_name)
					create l_body.make (100)
					l_body.append (a_name)
					l_body.append (".item /= default_pointer")
					create Result.make (l_tag, l_body)
				elseif not a_visitor.is_basic_type_ref and a_in_param and
						a_visitor.vt_type /= binary_or (Vt_error, Vt_byref) and
						a_visitor.vt_type /= binary_or (Vt_hresult, Vt_byref) then
					create l_tag.make (100)
					l_tag.append ("valid_")
					l_tag.append (a_name)
					create l_body.make (100)
					l_body.append (a_name)
					if is_pointed_pointer (l_descriptor) then
						l_body.append (".item /= default_pointer")
					else
						l_body.append (".item /= Void")
					end
					create Result.make (l_tag, l_body)
				end
			elseif a_visitor.is_structure then
				create l_tag.make (100)
				l_tag.append ("valid_")
				l_tag.append (a_name)
				create l_body.make (100)
				l_body.append (a_name)
				l_body.append (".item /= default_pointer")
				create Result.make (l_tag, l_body)
			end
		end

	additional_postcondition (a_name: STRING; a_type: WIZARD_DATA_TYPE_DESCRIPTOR; 
		a_visitor: WIZARD_DATA_TYPE_VISITOR; ret_val: BOOLEAN): WIZARD_WRITER_ASSERTION is
			-- A writer
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_descriptor: a_type /= Void
			non_void_visitor: a_visitor /= Void
		local
			l_tag, l_body: STRING
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			l_descriptor ?= a_type
			if l_descriptor /= Void  then
				if a_visitor.vt_type = binary_or (Vt_ptr, Vt_byref) or a_visitor.vt_type = binary_or (Vt_void, Vt_byref) then
					create l_tag.make (100)
					l_tag.append ("valid_")
					l_tag.append (a_name)
					if ret_val then
						create l_body.make (100)
						l_body.append ("Result")
					else
						create l_body.make (100)
						l_body.append (a_name)
					end
					l_body.append (".item /= default_pointer")
					create Result.make (l_tag, l_body)

				elseif ret_val and a_visitor.is_structure_pointer then
					create l_tag.make (100)
					l_tag.append ("valid_")
					l_tag.append (a_name)
					
					create l_body.make (100)
					l_body.append ("Result")
					l_body.append (".item /= default_pointer")
					create Result.make (l_tag, l_body)

				elseif 
					not a_visitor.is_basic_type_ref and
					not a_visitor.is_structure_pointer and
					not a_visitor.is_interface_pointer and
					not a_visitor.is_coclass_pointer and
					a_visitor.vt_type /= binary_or (Vt_error, Vt_byref) and
					a_visitor.vt_type /= binary_or (Vt_hresult, Vt_byref)
				then
					create l_tag.make (100)
					l_tag.append ("valid_")
					l_tag.append (a_name)
					if ret_val then
						create l_body.make (100)
						l_body.append ("Result")
					else
						create l_body.make (100)
						l_body.append (a_name)
					end
					if is_pointed_pointer (l_descriptor) then
						l_body.append (".item /= default_pointer")
					else
						l_body.append (".item /= Void")
					end
					create Result.make (l_tag, l_body)
				end
			elseif a_visitor.is_structure then
				create l_tag.make (100)
				l_tag.append ("valid_")
				l_tag.append (a_name)
				if ret_val then
					create l_body.make (100)
					l_body.append ("Result")
				else
					create l_body.make (100)
					l_body.append (a_name)
				end
				l_body.append (".item /= default_pointer")
				create Result.make (l_tag, l_body)

			end
		end

	is_pointed_pointer (a_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Does `a_descriptor' point to a pointer?
		require
			non_void_descriptor: a_descriptor /= Void
		local
			l_descriptor, l_pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			l_is_pointer: BOOLEAN
			l_type: INTEGER
		do
			from
				l_descriptor := a_descriptor
				l_pointed_descriptor ?= l_descriptor.pointed_data_type_descriptor
			until
				l_pointed_descriptor = Void
			loop
				l_descriptor := l_pointed_descriptor
				l_pointed_descriptor ?= l_descriptor.pointed_data_type_descriptor
			end
			l_type := l_descriptor.pointed_data_type_descriptor.type
			l_is_pointer := is_ptr (l_type) or is_void (l_type)
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

