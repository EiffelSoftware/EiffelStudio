indexing

	description:

		"Execution environment facilities"

	usage:

		"This class should not be used directly through %
		%inheritance and client/supplier relationship. %
		%Inherit from KL_SHARED_EXECUTION_ENVIRONMENT instead."

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_EXECUTION_ENVIRONMENT

inherit

	KL_VALUES [STRING, STRING]
		rename
			value as variable_value
		end

	KL_IMPORTED_STRING_ROUTINES
	KL_IMPORTED_ANY_ROUTINES






	EXECUTION_ENVIRONMENT



feature -- Access

	variable_value (a_variable: STRING): STRING is
			-- Value of environment variable `a_variable',
			-- Void if `a_variable' has not been set;
			-- Note: If `a_variable' is a UC_STRING or descendant, then
			-- the bytes of its associated UTF unicode encoding will
			-- be used to query its value to the environment.







		do
			Result := environment_impl.get (STRING_.as_string (a_variable))





		end

feature -- Setting

	set_variable_value (a_variable, a_value: STRING) is
			-- Set environment variable `a_variable' to `a_value'.
			-- (This setting may fail on certain platforms.)
			-- Note: If `a_variable' or `a_value' are UC_STRING or
			-- descendant, then the bytes of their associated UTF
			-- unicode encoding will be passed to the environment.
		require
			a_variable_not_void: a_variable /= Void
			a_variable_not_empty: a_variable.count > 0
			a_value_not_void: a_value /= Void







		do
			put (STRING_.as_string (a_value), STRING_.as_string (a_variable))





		ensure
			-- This setting may fail on certain platforms, hence the
			-- following commented postcondition:
			-- variable_set: equal (variable_value (a_variable), STRING_.as_string (a_value))
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
			i, nb: INTEGER
			c: CHARACTER
			stop: BOOLEAN
		do
			from
				i := 1
				nb := a_string.count
				Result := STRING_.new_empty_string (a_string, nb)
			until
				i > nb
			loop
				c := a_string.item (i)
				i := i + 1
				if c /= '$' then
					if c /= '%U' then
						Result.append_character (c)
					else
						Result := STRING_.appended_substring (Result, a_string, i - 1, i - 1)
					end
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
						str := STRING_.new_empty_string (a_string, 5)
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
								elseif c /= '%U' then
									str.append_character (c)
								else
									check same_type: ANY_.same_types (str, a_string) end
									STRING_.append_substring_to_string (str, a_string, i, i)
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
							Result := STRING_.appended_string (Result, str)
						end
					end
				end
			end
		ensure
			interpreted_string_not_void: Result /= Void
		end


feature {NONE} -- Implementation


	environment_impl: EXECUTION_ENVIRONMENT is
			-- Execution environment impl
		once
			create Result
		ensure
			environment_impl_not_void: Result /= Void
		end








end
