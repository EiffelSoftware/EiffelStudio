class 
	SET_UP 

feature {NONE}
	
	interface: INTERFACE
	index: INTEGER
	keys: ARRAY [STRING]

feature 
    
	associated_operator: HASH_TABLE [INTERFACE, STRING] is
			-- Hash-table of operations with name and help messages.
		once
				-- Hash-tables are resizable anyway.
			create Result.make (10)
		end
	
	enter_operator (k, m: STRING; c: STATE) is
			-- Enter a command `c' associated with a key `k' 
			-- and an help message `m'.
		do
			create interface
			interface.set_interface (k, m, c)
			associated_operator.put (interface, interface.operator_key)
		end

feature {NONE}

	help_start is
			-- Start printing available operations.
		do
			io.putstring ("Allowable operations are: %N")
         		keys := associated_operator.current_keys
         		index := 1
		end; 

	help_next is
		do
			index := index + 1
		end

	help_over: BOOLEAN is
			-- Is the number of available operations reviewed exhausted?
		do
			Result := index = keys.count + 1
		end

	help_action is
			-- Print out a information on an allowable operation.
		local
			one_key: STRING
		do
			one_key := keys.item (index)
			interface := associated_operator.item (one_key)
			io.putchar ('%T')
			io.putchar ('%'')
			io.putstring (one_key)
			io.putchar ('%'')
			io.putstring (": ")
			io.putstring (interface.help_message);
			io.new_line
		end

	keys_messages is
		do
			from
				help_start
			until
				help_over
			loop
				help_action
				help_next
			end
		end

end -- class SET_UP

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

