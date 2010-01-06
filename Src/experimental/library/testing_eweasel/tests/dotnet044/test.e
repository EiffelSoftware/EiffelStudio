class
	TEST

create
	make
	
feature {NONE} -- Initialization
	
	make is
		do
			types.do_all (agent (a_item: SYSTEM_TYPE)
				do
					io.put_string (a_item.full_name)
					io.new_line
				end)
		end

feature {NONE} -- Implementation
		
	types: LIST [SYSTEM_TYPE] is
			-- List of .NET basic types
		local
			l_result: ARRAYED_LIST [SYSTEM_TYPE]
		once
			create l_result.make (13)
			l_result.extend ({BOOLEAN})
			l_result.extend ({CHARACTER_8})
			l_result.extend ({REAL_32})
			l_result.extend ({REAL_64})
			l_result.extend ({INTEGER_8})
			l_result.extend ({INTEGER_16})
			l_result.extend ({INTEGER_32})
			l_result.extend ({INTEGER_64})
			l_result.extend ({NATURAL_8})
			l_result.extend ({NATURAL_16})
			l_result.extend ({NATURAL_32})
			l_result.extend ({NATURAL_64})
			l_result.extend ({POINTER})
			Result := l_result			
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end
		
end