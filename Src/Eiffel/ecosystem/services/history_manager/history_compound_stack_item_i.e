class
	HISTORY_COMPOUND_STACK_ITEM_I

feature -- Access

	description: ?READABLE_STRING_32
			-- Friendly description of the stack item
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end
		
	frozen data: !ANY
			-- Stack item data
		do
			Result := 
		end
		
		
		
feature -- Status report

	is_data_value (a_data: !ANY): BOOLEAN
			-- Determines if the supplied data is valid for the Current stack frame
		require
			is_interface_usable: is_interface_usable
		deferred
		end
		
end
		
