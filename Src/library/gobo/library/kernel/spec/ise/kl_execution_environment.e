indexing

	description:

		"Execution environment facilities"

	usage:      "This class should not be used directly through %
				%inheritance and client/supplier relationship. %
				%Inherit from KL_SHARED_EXECUTION_ENVIRONMENT instead."
	pattern:    "Singleton"
	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_EXECUTION_ENVIRONMENT

inherit

	KL_IMPORTED_STRING_ROUTINES

feature -- Access

	variable_value (a_variable: STRING): STRING is
			-- Value of environment variable `a_variable';
			-- Void if `a_variable' has not been set
		require
			a_variable_not_void: a_variable /= Void
		local
			s: ANY
			c_string: POINTER
		do
			s := a_variable.to_c
			c_string := c_getenv ($s)
			if c_string /= default_pointer then
				!! Result.make (0)
				Result.from_c (c_string)
			end
		end

feature -- Setting

	set_variable_value (a_variable, a_value: STRING) is
			-- Set environment variable `a_variable' to `a_value'.
			-- (This setting may fail on certain platforms.)
		require
			a_variable_not_void: a_variable /= Void
			a_variable_not_empty: not a_variable.empty
			a_value_not_void: a_value /= Void
		local
			a_string: STRING
			s: ANY
			i: INTEGER
		do
			!! a_string.make (a_variable.count + a_value.count + 1)
			a_string.append_string (a_variable)
			a_string.append_character ('=')
			a_string.append_string (a_value)
			s := a_string.to_c
			i := c_putenv ($s)
		ensure
			-- (This setting may fail on certain platforms, hence the
			-- following commented postcondition.)
			-- variable_set: equal (variable_value (a_variable), a_value)
		end

feature -- Conversion

	interpreted_string (a_string: STRING): STRING is
			-- String where the environment variables have been
			-- replaced by their values. The environment variables
			-- are considered to be either ${[^}]*} or $[a-zA-Z0-9_]+
			-- and the dollar sign is escaped using $$. Non defined
			-- environment variables are replaced by empty strings.
			-- The result is not defined when `a_string' does not
			-- conform to the conventions above.
			-- Return a new string each time.
		require
			a_string_not_void: a_string /= Void
		local
			str: STRING
			i, j, nb: INTEGER
			c: CHARACTER
			stop: BOOLEAN
		do
			from
				i := 1
				nb := a_string.count
				Result := STRING_.make (nb)
			until
				i > nb
			loop
				c := a_string.item (i)
				i := i + 1
				if c /= '$' then
					Result.append_character (c)
				elseif i > nb then
						-- Dollar at the end of `a_string'.
						-- Leave it as it is.
					Result.append_character ('$')
				else
					c := a_string.item (i)
					if c = '$' then
							-- Escaped dollar character.
						Result.append_character ('$')
						i := i + 1
					else
							-- Found beginning of a environment variable
							-- It is either ${VAR} or $VAR.
						str := STRING_.make (5)
						if c = '{' then
								-- Looking for a right brace.
							from
								i := i + 1
								stop := False
							until
								i > nb or stop
							loop
								c := a_string.item (i)
								if c = '}' then
									stop := True
								else
									str.append_character (c)
								end
								i := i + 1
							end
						else
								-- Looking for a non-alphanumeric character
								-- (i.e. [^a-zA-Z0-9_]).
							from
								stop := False
							until
								i > nb or stop
							loop
								c := a_string.item (i)
								inspect c
								when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
									str.append_character (c)
									i := i + 1
								else
									stop := True
								end
							end
						end
						str := variable_value (str)
						if str /= Void then
							Result.append_string (str)
						end
					end
				end
			end
		ensure
			interpreted_string_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_getenv (s: POINTER): POINTER is
		external
			"C (char *): EIF_POINTER | <stdlib.h>"
		alias
			"getenv"
		end

	c_putenv (s: POINTER): INTEGER is
		external
			"C (char *): EIF_INTEGER | <stdlib.h>"
		alias
			"putenv"
		end

end -- class KL_EXECUTION_ENVIRONMENT
