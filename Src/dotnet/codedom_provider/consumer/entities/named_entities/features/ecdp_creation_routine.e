indexing 
	description: "Eiffel creation routine"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_CREATION_ROUTINE

inherit
	ECDP_PROCEDURE

create 
	make

feature -- Status Repport

	has_arguments (a_list_of_arguments: LINKED_LIST [ECDP_EXPRESSION]): BOOLEAN is
			-- | if `constructor_arguments.count' equal `a_list_of_argments.count' then 
			-- | compare each argument and return false if a_constructor.argument /= a_list_argument
		require
			non_void_list: a_list_of_arguments /= Void
		local
			stop: BOOLEAN
			a_param: ECDP_PARAMETER_DECLARATION_EXPRESSION
		do
			if arguments.count = a_list_of_arguments.count then
				from
					arguments.start
					a_list_of_arguments.start
					stop := False
				until
					arguments.after or a_list_of_arguments.after or stop
				loop
					stop := not a_list_of_arguments.item.type.equals_object (a_param.type)
					arguments.forth
					a_list_of_arguments.forth
				end
				Result := not stop
			else
				Result := False
			end
		end

end -- class ECDP_CREATION_ROUTINE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------