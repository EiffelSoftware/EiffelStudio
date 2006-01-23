indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SET_UP

