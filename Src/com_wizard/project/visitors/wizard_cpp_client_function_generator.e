indexing
	description: "C++ client function generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR
	
	WIZARD_VARIABLE_NAME_MAPPER
	
	ECOM_VAR_TYPE

feature -- Basic operations

	cecil_signature(a_function: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- set result type and return signature of feature
		require
			non_void_feature_writer: ccom_feature_writer /= Void
			non_void_arguments: a_function.arguments /= Void
			has_arguments: not a_function.arguments.is_empty
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			arguments := a_function.arguments
			from
				arguments.start
			until
				arguments.off
			loop
				visitor := arguments.item.type.visitor

				if is_paramflag_fretval (arguments.item.flags) then
					pointed_descriptor ?= arguments.item.type
					if pointed_descriptor /= Void then
						visitor := pointed_descriptor.pointed_data_type_descriptor.visitor
					end
					set_return_type (visitor)

				else
					Result.append (Beginning_comment_paramflag)
					if is_paramflag_fout (arguments.item.flags) then
						if is_paramflag_fin (arguments.item.flags) then
							Result.append ("in, ")
						end
						Result.append ("out")
					else
						Result.append ("in")
					end
					Result.append (End_comment_paramflag)
					if 
						visitor.is_basic_type or
						visitor.is_enumeration or
						visitor.vt_type = Vt_bool
					then
						Result.append (visitor.cecil_type)

					elseif 
						visitor.is_interface_pointer or 
						visitor.is_coclass_pointer or 
						visitor.is_structure_pointer 
					then
						Result.append (visitor.c_type)
						
					elseif 
						visitor.is_interface or 
						visitor.is_structure or
						visitor.is_array_basic_type					
					then
						Result.append (visitor.c_type + " *")

					else
						Result.append (Eif_object)
					end
					
					Result.append (Space)
					Result.append (arguments.item.name)
					
					if 
						not (visitor.c_header_file = Void or else 
						visitor.c_header_file.is_empty) 
					then
						c_header_files.extend (visitor.c_header_file)
					end
					Result.append (Comma_space)
				end
				visitor := Void
				arguments.forth
			end

			if Result.count > 0  then
				Result.remove (Result.count)
				Result.remove (Result.count)
			end
		ensure
			valid_result: Result /= Void
		end

	set_return_type (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set return type.
		require
			non_void_visitor: a_visitor /= Void
			valid_return_type: a_visitor.vt_type /= Vt_void
			non_void_feature_writer: ccom_feature_writer /= Void
		do
			if 
				a_visitor.is_basic_type or 
				a_visitor.is_enumeration or 
				(a_visitor.vt_type = Vt_bool) 
			then
				ccom_feature_writer.set_result_type (a_visitor.cecil_type)
			else
				ccom_feature_writer.set_result_type (Eif_reference)
			end
			if 
				not (a_visitor.c_header_file = Void or else 
				a_visitor.c_header_file.is_empty) 
			then
				c_header_files.extend (a_visitor.c_header_file)
			end
		end
		
end -- class WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

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
