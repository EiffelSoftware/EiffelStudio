﻿note
	description: "Fixes violations of rule #67 ('Formal generic parameter name has more than one character')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_GENERIC_PARAMETER_TOO_LONG_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_param_name

feature {NONE} -- Initialization
	make_with_param_name (a_class: attached CLASS_C; a_name: attached STRING)
			-- Initializes `Current' with class `a_class'.
			-- `a_name' is the name of the formal generic parameter to be changed.
		do
			make (ca_names.generic_param_too_long_fix_1 + a_name + ca_names.generic_param_too_long_fix_2 + "'" + a_name.at(1).out + "'", a_class)
			param_to_change := a_name
		end

feature {NONE} -- Implementation

	execute (a_class: attached CLASS_AS)
		local
			l_regex: RX_PCRE_REGULAR_EXPRESSION
		do
				-- Initialize the regular expression for finding all occurences of the generic parameter's name in the code.
			create l_regex.make
			l_regex.compile ("\b" + param_to_change + "\b")
			l_regex.set_case_insensitive (False)

				-- Match the classtext.
			l_regex.match (a_class.text (matchlist))

				-- Replace all occurences with the first character and then replace the classtext with the new string.
			a_class.replace_text (l_regex.replace_all (param_to_change.at (1).out), matchlist)
		end

	param_to_change: STRING
			-- The formal generic parameter's name.

end
