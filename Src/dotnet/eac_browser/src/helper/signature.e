indexing
	description: "Print in output the eiffel type with all its eiffelfeatures corresponding to given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	SIGNATURE

feature -- Implementation

	signature_member (a_member: CONSUMED_MEMBER): STRING is
			-- return signature of `a_member'.
		require
			non_void_a_member: a_member /= Void
		local
			i: INTEGER
			l_function: CONSUMED_FUNCTION
			l_attribute: CONSUMED_FIELD
			l_literal_attribute: CONSUMED_LITERAL_FIELD
		do
			Result := a_member.dotnet_name
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
				Result := Result + a_member.arguments.item (i).dotnet_name + ": " + a_member.arguments.item (i).type.name

				i := i + 1
			end
			if i /= 1 then
				Result := Result + ")"
			end
			
			l_function ?= a_member
			if l_function /= Void then
				Result := Result + ": " + l_function.return_type.name
			end
			
			l_attribute ?= a_member
			if l_attribute /= Void then
				Result := Result + ": " + l_attribute.return_type.name
				l_literal_attribute ?= l_attribute
				if l_literal_attribute /= Void then
					Result := Result + " is " + l_literal_attribute.value
				end
			end
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
		
end -- class SIGNATURE

