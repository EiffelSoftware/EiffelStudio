note
	description: "Summary description for {PS_ROOT_OBJECT_STRATEGY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	PS_ROOT_OBJECT_STRATEGY

inherit
	COMPARABLE

feature

	None: PS_ROOT_OBJECT_STRATEGY
			-- Never declare a root automatically (and preserve any previous status).
		once
			create Result
		end

	Insert_argument_only: PS_ROOT_OBJECT_STRATEGY
			-- Declare only the object that is used as an argument in an insert operation as root.
			-- Do not touch the root status of any referenced objects.
		once
			create Result
		end

	Update_argument_only: PS_ROOT_OBJECT_STRATEGY
			-- Declare only the object that is used as an argument in an insert or update operation as root.
			-- Do not touch the root status of any referenced objects.
		once
			create Result
		end

	Complete: PS_ROOT_OBJECT_STRATEGY
			-- Declare the top object and all transitively referenced objects as root.
		once
			create Result
		end

feature -- Comparison operation

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is `Current' a weaker isolation level than `other'?
		local
			valid_levels: LINKED_LIST [PS_ROOT_OBJECT_STRATEGY]
		do
			create valid_levels.make
			valid_levels.extend (Complete)
			if Current = Update_argument_only and valid_levels.has (other) then
				Result := True
			else
				valid_levels.extend (Update_argument_only)
				if Current = Insert_argument_only and valid_levels.has (other) then
					Result := True
				else
					valid_levels.extend (Insert_argument_only)
					if Current = None and valid_levels.has (other) then
						Result := True
					else
						Result := False
					end
				end
			end
		end


end
