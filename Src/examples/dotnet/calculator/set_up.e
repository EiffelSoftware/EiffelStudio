--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Set up"
	external_name: "ISE.Examples.Calculator.SetUp"
	
class 
	SET_UP 

inherit
	IO

feature -- Access
    
	associated_operator: HASH_TABLE [INTERFACE, STRING]
		indexing
			description: "Hash-table of operations with name and help messages"
			external_name: "AssociatedOperator"
		end

feature -- Basic Operations

	enter_operator (k, m: STRING; c: STATE) is
		indexing
			description: "Enter a command `c' associated with a key `k' and an help message `m'."
			external_name: "EnterOperator"
		require
			non_void_key: k /= Void
			not_empty_key: k.get_length > 0
			non_void_command: c /= Void
			non_void_message: m /= Void
			not_empty_message: m.get_length > 0
		local
			i: INTERFACE
		do
			create i
			interface := i
			interface.set_interface (k, m, c)
			associated_operator.put (interface, interface.operator_key)
		ensure
			interface_created: interface /= Void
			key_set: interface.operator_key.equals_string (k)
			message_set: interface.help_message.equals_string (m)
			command_set: interface.associated_command = c
		end

feature {NONE} -- Implementation
	
	interface: INTERFACE
		indexing
			description: "Interface"
			external_name: "Interface"
		end
		
	index: INTEGER
		indexing
			description: "Index"
			external_name: "Index"
		end
		
	keys: ARRAY [STRING]
		indexing
			description: "Keys"
			external_name: "Keys"
		end
		
	io: CONSOLE
		indexing
			description: "Console"
			external_name: "Io"
		end

	help_start is
		indexing
			description: "Start printing available operations."
			external_name: "HelpStart"
		do
			io.put_string ("Allowable operations are: %N")
			keys := associated_operator.current_keys
			index := 1
		ensure
			non_void_keys: keys /= Void
			index_equals_one: index = 1
		end

	help_next is
		indexing
			description: "Increment `index'."
			external_name: "HelpNext"
		do
			index := index + 1
		ensure
			index_incremented: index = old index + 1
		end

	help_over: BOOLEAN is
		indexing
			description: "Is the number of available operations reviewed exhausted?"
			external_name: "HelpOver"
		require
			non_void_keys: keys /= Void
		do
			Result := (index = keys.count + 1)
		end

	help_action is
		indexing
			description: "Print out a information on an allowable operation."
			external_name: "HelpAction"
		require
			non_void_associated_operator: associated_operator /= Void
			non_void_keys: keys /= Void
		local
			one_key: STRING
		do
			one_key := keys.item (index)
			interface := associated_operator.item (one_key)
			io.put_string ("%T%'")
			io.put_string (one_key)
			io.put_string  ("%': ")
			io.put_string (interface.help_message);
			io.new_line
		ensure
			non_void_interface: interface /= Void
		end

	keys_messages is
		indexing
			description: "Display keys messages."
			external_name: "KeysMessages"	
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