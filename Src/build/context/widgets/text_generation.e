indexing
	description: "Eiffel code generation."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEXT_GENERATION

feature {NONE}

	function_name (a_string: STRING; context: STRING; func_name: STRING) is
		do
			a_string.append ("%T%T%T")
			a_string.append (context)
			a_string.append (func_name)
		end

	function_to_string (a_string: STRING; context: STRING; func_name: STRING) is
			-- Create the string corresponding to the call
			-- of  the routine 'func_name' with no arguments
		do
			function_name (a_string, context, func_name)
			a_string.append ("%N")
		end

	cond_f_to_string (a_string: STRING; condition: BOOLEAN; context: STRING; func_name1, func_name2: STRING) is
			-- Create the string corresponding to the call
			-- of  the routine `func_name1' or `func_name2'
			-- depending on the value of `condition'
		do
			if condition then
				function_to_string (a_string, context, func_name1)
			else
				function_to_string (a_string, context, func_name2)
			end
		end

	function_int_to_string (a_string: STRING; context: STRING; func_name: STRING; number: INTEGER) is
			-- Create the string corresponding to the call
			-- of  the routine 'func_name' with an integer as argument
		do
			function_name (a_string, context, func_name)
			a_string.append (" (")
			a_string.append (number.out)
			a_string.append (")%N")
		end

	function_string_to_string (a_string: STRING; context: STRING; func_name: STRING; string: STRING) is
			-- Create the string corresponding to the call
			-- of  the routine 'func_name' with a string as argument
		do
			function_name (a_string, context, func_name)
			a_string.append (" (%"")
			a_string.append (string)
			a_string.append ("%")%N")
		end

	function_bool_to_string (a_string: STRING; context: STRING; func_name: STRING; bool: BOOLEAN) is
			-- Create the string corresponding to the call
			-- of  the routine 'func_name' with a boolean as argument
		do
			function_name (a_string, context, func_name)
			a_string.append (" (")
			if bool then
				a_string.append ("true")
			else
				a_string.append ("false")
			end
			a_string.append (")%N")
		end

	function_int_int_to_string (a_string: STRING; context: STRING; func_name: STRING; n1, n2: INTEGER) is
			-- Create the string corresponding to the call
			-- of  the routine 'func_name' with two integers as argument
		do
			function_name (a_string, context, func_name)
			a_string.append (" (")
			a_string.append (n1.out)
			a_string.append (", ")
			a_string.append (n2.out)
			a_string.append (")%N")
		end

end -- class TEXT_GENERATION

