--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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
			create  Result.make (10)
		end
	
	enter_operator (k, m: STRING; c: STATE) is
			-- Enter a command `c' associated with a key `k' 
			-- and an help message `m'.
		do
			create  interface
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
