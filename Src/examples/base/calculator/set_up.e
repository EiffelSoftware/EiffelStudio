note
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class
	SET_UP

feature

	associated_operator: HASH_TABLE [INTERFACE, STRING]
			-- Hash-table of operations with name and help messages.
		once
				-- Hash-tables are resizable anyway.
			create Result.make (10)
		end

	enter_operator (k, m: STRING; c: STATE)
			-- Enter a command `c' associated with a key `k'
			-- and an help message `m'.
		local
			interface: INTERFACE
		do
			create interface.make (k, m, c)
			associated_operator.put (interface, interface.operator_key)
		end

feature {NONE}

	keys_messages
			-- Print available operations.
		do
			io.putstring ("Allowable operations are: %N")
			across
				associated_operator as c
			loop
					-- Print out an information on an allowable operation.
				io.put_string ("%T%'")
				io.put_string (c.key)
				io.put_string ("%': ")
				io.put_string (c.item.help_message)
				io.put_new_line
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SET_UP
