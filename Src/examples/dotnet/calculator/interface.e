--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	INTERFACE

feature

	operator_key: STRING
		-- Letter key associated to an operation.

	associated_command: STATE
		-- Associated state.

	help_message: STRING
		-- Help message.

	set_interface (k, m: STRING; c: STATE) is
			-- Fill out key with `k', command with `c' and message with `m'.
		do
			operator_key := k
			associated_command := c
			help_message := m
		ensure
			operator_key = k
			associated_command = c
			help_message = m
		end; -- set_interface

end -- class INTERFACE
