indexing
	description: "Objects that ..."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_CHECKED_MEMBER_METHOD_BASE

inherit
	EC_CHECKED_MEMBER
		redefine
			member
		end

feature -- Access {EC_CHECKED_MEMBER}
		
	member: METHOD_BASE
			-- Member that was examined.

feature -- Access
			
	checked_parameter_types: ARRAY [EC_CHECKED_TYPE] is
			-- `member' method checked parameter types.
		local
			l_params: NATIVE_ARRAY [PARAMETER_INFO]
			l_type: EC_CHECKED_TYPE
			i: INTEGER
		do
			l_params := member.get_parameters
			i := l_params.count
			create Result.make (1, i)
			if i > 0 then
				from
				until
					i = 0
				loop
					l_type := checked_type (l_params.item (i - 1).parameter_type)
					Result.put (l_type, i)
					i := i - 1
				end
			end
		ensure
			result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	are_parameters_compliant (a_check_eiffel: BOOLEAN): BOOLEAN is
			-- Are `member' parameters compliant?
			-- If `a_check_eiffel' then parameters are checked for Eiffel compliance.
		local
			l_params: like checked_parameter_types
			i: INTEGER
		do
			l_params := checked_parameter_types
			i := l_params.count
			Result := True
			if i > 0 then
				from				
				until
					i = 0 or not Result
				loop
					if a_check_eiffel then
						Result := l_params.item (i).is_eiffel_compliant
					else
						Result := l_params.item (i).is_compliant
					end	
					i := i - 1
				end
			end
		end
			
end -- class EC_CHECKED_MEMBER_METHOD_BASE
