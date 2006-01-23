indexing
	description: "Print in output the eiffel type with all its eiffelfeatures corresponding to given dotnet type name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	SIGNATURE

feature {NONE} -- Implementation
	
	finder: FINDER is
		once
			Create Result
		ensure
			non_void_result: Result /= Void
		end
		
	Native_array: STRING is "NATIVE_ARRAY"
		

feature -- Implementation

	signature_member (a_member: CONSUMED_MEMBER): STRING is
			-- return signature of `a_member'.
		require
			non_void_a_member: a_member /= Void
		local
			i: INTEGER
--			l_function: CONSUMED_FUNCTION
--			l_literal_attribute: CONSUMED_LITERAL_FIELD
		do
			create Result.make (100)
			Result.append (a_member.dotnet_name)

			if not a_member.is_attribute then
				Result.append ("(")
			end
			from
				i := 1
			until
				a_member.arguments = Void
				or else
				i > a_member.arguments.count
			loop
				if i > 1 then
					Result.append (",")
				end
				Result.append (a_member.arguments.item (i).type.name)

				i := i + 1
			end
			if not a_member.is_attribute then
				Result := Result + ")"
			end
			
--			l_function ?= a_member
--			if l_function /= Void then
--				Result.append (": " + l_function.return_type.name)
--			end
			
--			if a_member.is_attribute then
--				Result.append (": " + l_attribute.return_type.name)
--				l_literal_attribute ?= a_member
--				if l_literal_attribute /= Void then
--					Result.append (" is " + l_literal_attribute.value)
--				end
--			end
		ensure
			non_void_result: Result /= Void
		end
	
	signature_constructor (a_constructor: CONSUMED_CONSTRUCTOR): STRING is
			-- return signature of `a_member'.
		require
			non_void_a_constructor: a_constructor /= Void
		local
			i: INTEGER
		do
			Result := a_constructor.dotnet_name
			from
				i := 1
			until
				a_constructor.arguments = Void
				or else
				i > a_constructor.arguments.count
			loop
				if i = 1 then
					Result := Result + " ("
				else
					Result := Result + "; "
				end
				Result := Result + a_constructor.arguments.item (i).dotnet_name + ": " + a_constructor.arguments.item (i).type.name

				i := i + 1
			end
			if i /= 1 then
				Result := Result + ")"
			end
		ensure
			non_void_result: Result /= Void
		end


	eiffel_signature_member (assembly_member: CONSUMED_ASSEMBLY; a_member: CONSUMED_MEMBER): STRING is
			-- return the eiffel signature of `a_member'.
		require
			non_void_assembly_member: assembly_member /= Void
			non_void_a_member: a_member /= Void
		local
			i: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument, l_array_return_type: CONSUMED_ARRAY_TYPE

			l_function: CONSUMED_FUNCTION
			l_attribute: CONSUMED_FIELD
			l_literal_attribute: CONSUMED_LITERAL_FIELD
		do
			Result := a_member.eiffel_name
			from
				i := 1
			until
				a_member.arguments = Void
				or else
				i > a_member.arguments.count
			loop
				if i = 1 then
					Result := Result + " ("
				else
					Result := Result + "; "
				end
				Result := Result + a_member.arguments.item (i).eiffel_name + ": "

				l_array_argument := Void
				l_argument := a_member.arguments.item (i).type
				l_array_argument ?= l_argument
					-- Is type argument NATIVE_ARRAY?
				if l_array_argument /= Void then
					Result := Result + Native_array + " ["
					Result := Result + finder.eiffel_type_name (assembly_member, l_array_argument.element_type.name)
					Result := Result + "]"
				else
					Result := Result + finder.eiffel_type_name (assembly_member, l_argument.name)
				end

				i := i + 1
			end
			if i /= 1 then
				Result := Result + ")"
			end
			
			l_function ?= a_member
			if l_function /= Void then
				Result := Result + ": "
				l_array_return_type ?= l_function.return_type
				if l_array_return_type /= Void then
					Result := Result + Native_array + " ["
					Result := Result + finder.eiffel_type_name (assembly_member, l_array_return_type.element_type.name)
					Result := Result + "]"
				else
					Result := Result + finder.eiffel_type_name (assembly_member, l_function.return_type.name)
				end
			end
			
			l_attribute ?= a_member
			if l_attribute /= Void then
				Result := Result + ": "
				l_array_return_type ?= l_attribute.return_type
				if l_array_return_type /= Void then
					Result := Result + Native_array + " ["
					Result := Result + finder.eiffel_type_name (assembly_member, l_array_return_type.element_type.name)
					Result := Result + "]"
				else
					Result := Result + finder.eiffel_type_name (assembly_member, l_attribute.return_type.name)
				end
				--Result := Result + eiffel_type_name (assembly_member, l_attribute.return_type.name)
				
				l_literal_attribute ?= l_attribute
				if l_literal_attribute /= Void then
					Result := Result + " is " + l_literal_attribute.value
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	eiffel_signature_constructor (assembly_constructor: CONSUMED_ASSEMBLY; a_constructor: CONSUMED_CONSTRUCTOR): STRING is
			-- return signature of `a_member'.
		require
			non_void_assembly_constructor: assembly_constructor /= Void
			non_void_a_constructor: a_constructor /= Void
		local
			i: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
		do
			Result := a_constructor.eiffel_name
			from
				i := 1
			until
				a_constructor.arguments = Void
				or else
				i > a_constructor.arguments.count
			loop
				if i = 1 then
					Result := Result + " ("
				else
					Result := Result + "; "
				end
				Result := Result + a_constructor.arguments.item (i).eiffel_name + ": " 

				l_argument := a_constructor.arguments.item (i).type
				l_array_argument := Void
				l_array_argument ?= l_argument
					-- Is type argument NATIVE_ARRAY?
				if l_array_argument /= Void then
					Result := Result + Native_array + " ["
					Result := Result + finder.eiffel_type_name (assembly_constructor, l_array_argument.element_type.name)
					Result := Result + "]"
				else
					Result := Result + finder.eiffel_type_name (assembly_constructor, l_argument.name)
				end
				--Result := Result + eiffel_type_name (assembly_constructor, a_constructor.arguments.item (i).type.name)

				i := i + 1
			end
			if i /= 1 then
				Result := Result + ")"
			end
		ensure
			non_void_result: Result /= Void
		end
		
feature -- Xml Documentation

	xml_signature_member (a_member: CONSUMED_MEMBER; a_full_dotnet_type_name: STRING): STRING is
			-- Return the xml signature of `a_type'.
		require
			non_void_a_member: a_member /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			not_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			i: INTEGER
		do
			create Result.make (80)
--			Result.append (a_full_dotnet_type_name + ".")
			Result.append (a_member.dotnet_name)

			from
				i := 1
			until
				a_member.arguments = Void
				or else
				i > a_member.arguments.count
			loop
				if i > 1 then
					Result := Result + ","
				elseif i = 1 then
					Result.append ("(")
				end
				Result.append (a_member.arguments.item (i).type.name)

				i := i + 1
			end
			if i > 1 then
				Result := Result + ")"
			end
		ensure
			non_void_result: Result /= Void
		end
	
	xml_signature_constructor (a_constructor: CONSUMED_CONSTRUCTOR; a_full_dotnet_type_name: STRING): STRING is
			-- Return the xml signature of `a_type'.
		require
			non_void_a_constructor: a_constructor /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			not_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			i: INTEGER
		do
			create Result.make (80)
			--Result.append (a_full_dotnet_type_name + "." + 
			Result.append ("#ctor")
			from
				i := 1
			until
				a_constructor.arguments = Void
				or else
				i > a_constructor.arguments.count
			loop
				if i = 1 then
					Result.append ("(")
				else
					Result.append (",")
				end
				Result.append (a_constructor.arguments.item (i).type.name)

				i := i + 1
			end
			if i /= 1 then
				Result := Result + ")"
			end
		ensure
			non_void_result: Result /= Void
		end
		
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class SIGNATURE

