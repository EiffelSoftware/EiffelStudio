indexing
	description: "Interface"
	external_name: "ISE.Examples.Calculator.Interface"
	
class 
	INTERFACE

feature -- Access

	operator_key: STRING
		indexing
			description: "Letter key associated to an operation"
			external_name: "OperatorKey"
		end

	associated_command: STATE
		indexing
			description: "Associated state"
			external_name: "AssociatedCommand"
		end

	help_message: STRING
		indexing
			description: "Help message"
			external_name: "HelpMessage"
		end

feature -- Status Setting

	set_interface (k, m: STRING; c: STATE) is
		indexing
			description: "Fill out key with `k', command with `c' and message with `m'."
			external_name: "SetInterface"
		require
			non_void_key: k /= Void
			not_empty_key: k.get_length > 0
			non_void_message: m /= Void
			not_empty_message: m.get_length > 0
			non_void_command: c /= Void
		do
			operator_key := k
			associated_command := c
			help_message := m
		ensure
			operator_key_set: operator_key = k
			associated_command_set: associated_command = c
			help_message_set: help_message = m
		end

end -- class INTERFACE

--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

