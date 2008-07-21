indexing
	description: "Objects that provide assertion routines throwing exceptions with provided tag if conditin is met. Provide partial compatibility with Gobo test cases"
	author: "mogh"
	date: "$Date$"
	revision: "$Revision$"


class
	CDD_ASSERTION_ROUTINES

inherit
	EXCEPTIONS
		export
			{NONE} all
		end


feature -- Basic Operations

	assert (a_tag: STRING; a_condition: BOOLEAN) is
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_true (a_tag, a_condition)
		end

	assert_true (a_tag: STRING; a_condition: BOOLEAN) is
			-- Assert that `a_condition' is true.
		require
			a_tag_not_void: a_tag /= Void
		do
			if not a_condition then
				raise(a_tag)
			end
		end

	assert_false (a_tag: STRING; a_condition: BOOLEAN) is
			-- Assert that `a_condition' is false.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_true(a_tag, not a_condition)
		end


feature -- Equality

	assert_equal (a_tag: STRING; expected, actual: ANY) is
			-- Assert that `objects_are_equal (expected, actual)'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert(assert_equal_message (a_tag, expected, actual), objects_are_equal(expected, actual))
		end

	assert_not_equal (a_tag: STRING; expected, actual: ANY) is
			-- Assert that `not objects_are_equal (expected, actual)'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_false (assert_not_equal_message (a_tag, expected, actual), objects_are_equal(expected, actual))
		end

	assert_same (a_tag: STRING; expected, actual: ANY) is
			-- Assert that `expected = actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_equal_message (a_tag, expected, actual), expected = actual)
		end

	assert_not_same (a_tag: STRING; expected, actual: ANY) is
			-- Assert that `expected /= actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_false (assert_not_equal_message (a_tag, expected, actual), expected = actual)
		end

	assert_integers_equal (a_tag: STRING; expected, actual: INTEGER) is
			-- Assert that `expected = actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_integers_not_equal (a_tag: STRING; expected, actual: INTEGER) is
			-- Assert that `expected /= actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_false (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_strings_equal (a_tag: STRING; expected, actual: STRING) is
			-- Assert that `expected' and `actual' are the same string.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected, actual), expected.is_equal (actual))
		end

	assert_strings_not_equal (a_tag: STRING; expected, actual: STRING) is
			-- Assert that `expected' and `actual' are not the same string.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_false (assert_strings_not_equal_message (a_tag, expected, actual), expected.is_equal (actual))
		end

	assert_strings_case_insensitive_equal (a_tag: STRING; expected, actual: STRING) is
			-- Assert that `expected' and `actual' are the same string (case insensitive).
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected, actual), expected.is_case_insensitive_equal (actual))
		end

	assert_characters_equal (a_tag: STRING; expected, actual: CHARACTER) is
			-- Assert that `expected = actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_characters_not_equal (a_tag: STRING; expected, actual: CHARACTER) is
			-- Assert that `expected /= actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_false (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_booleans_equal (a_tag: STRING; expected, actual: BOOLEAN) is
			-- Assert that `expected = actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_booleans_not_equal (a_tag: STRING; expected, actual: BOOLEAN) is
			-- Assert that `expected /= actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert_false (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end


feature  -- Files

	assert_files_equal (a_tag: STRING; a_filename1, a_filename2: STRING) is
			-- Assert that there is no difference between the
			-- files named `a_filename1' and `a_filename2'.
			-- (Expand environment variables in filenames.)
		require
			a_tag_not_void: a_tag /= Void
			a_filename1_not_void: a_filename1 /= Void
			a_filename1_not_empty: a_filename1.count > 0
			a_filename2_not_void: a_filename2 /= Void
			a_filename2_not_empty: a_filename2.count > 0
		local
			a_file1, a_file2: PLAIN_TEXT_FILE
			a_message: STRING
			done: BOOLEAN
			i: INTEGER
		do

			create a_file1.make (interpreted_string (a_filename1))
			a_file1.open_read
			if a_file1.is_open_read then
				create a_file2.make (interpreted_string (a_filename2))
				a_file2.open_read
				if a_file2.is_open_read then
					from until done loop
						a_file1.read_line
						a_file2.read_line
						i := i + 1
						if a_file1.end_of_file then
							if not a_file2.end_of_file then
								create a_message.make (50)
								a_message.append_string (a_tag)
								a_message.append_string (" (diff between files '")
								a_message.append_string (a_filename1)
								a_message.append_string ("' and '")
								a_message.append_string (a_filename2)
								a_message.append_string ("' at line ")
								a_message.append_integer (i)
								a_message.append_string (")")
								a_file1.close
								a_file2.close
								done := True
							else
								a_file1.close
								a_file2.close
								done := True
							end
						elseif a_file2.end_of_file then
							create a_message.make (50)
							a_message.append_string (a_tag)
							a_message.append_string (" (diff between files '")
							a_message.append_string (a_filename1)
							a_message.append_string ("' and '")
							a_message.append_string (a_filename2)
							a_message.append_string ("' at line ")
							a_message.append_integer (i)
							a_message.append_string (")")
							a_file1.close
							a_file2.close
							done := True
						elseif not a_file1.last_string.is_equal (a_file2.last_string) then
							create a_message.make (50)
							a_message.append_string (a_tag)
							a_message.append_string (" (diff between files '")
							a_message.append_string (a_filename1)
							a_message.append_string ("' and '")
							a_message.append_string (a_filename2)
							a_message.append_string ("' at line ")
							a_message.append_integer (i)
							a_message.append_string (")")
							a_file1.close
							a_file2.close
							done := True
						end
					end
				else
					create a_message.make (50)
					a_message.append_string (a_tag)
					a_message.append_string (" (cannot read file '")
					a_message.append_string (a_filename2)
					a_message.append_string ("')")
					a_file1.close
				end
			else
				create a_message.make (50)
				a_message.append_string (a_tag)
				a_message.append_string (" (cannot read file '")
				a_message.append_string (a_filename1)
				a_message.append_string ("')")
			end

			if a_message /= void then
				assert (a_message, False)
			end
		end

	assert_filenames_equal (a_tag: STRING; a_filename1, a_filename2: STRING) is
			-- Assert that filenames `a_filename1' and `a_filename2'
			-- only differ by the letters '/' and '\'.
		require
			a_tag_not_void: a_tag /= Void
			a_filename1_not_void: a_filename1 /= Void
			a_filename2_not_void: a_filename2 /= Void
		local
			i, nb: INTEGER
			a_name1, a_name2: STRING
			c1, c2: CHARACTER
			a_message: STRING
		do
			nb := a_filename1.count
			if a_filename2.count = nb then
				a_name1 := a_filename1.as_lower
				a_name2 := a_filename2.as_lower
				from i := 1 until i > nb loop
					c1 := a_name1.item (i)
					c2 := a_name2.item (i)
					if c1 /= c2 and not ((c1 = '\' and c2 = '/') or (c1 = '/' and c2 = '\')) then
						i := nb + 1 -- Jump out of the loop.
						create a_message.make (50)
						a_message.append_string (a_tag)
						a_message.append_string (" (filenames '")
						a_message.append_string (a_filename1)
						a_message.append_string ("' and '")
						a_message.append_string (a_filename2)
						a_message.append_string ("' are not equal)")
					end
					i := i + 1
				end
			else
				create a_message.make (50)
				a_message.append_string (a_tag)
				a_message.append_string (" (filenames '")
				a_message.append_string (a_filename1)
				a_message.append_string ("' and '")
				a_message.append_string (a_filename2)
				a_message.append_string ("' are not equal)")
			end

			if a_message /= Void then
				assert (a_message, False)
			end
		end

feature -- Containers

	assert_arrays_same (a_tag: STRING; expected, actual: ARRAY [ANY]) is
			-- Assert that `expected' and `actual' have the same items
			-- in the same order (use '=' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag, a_message: STRING
			expected_item, actual_item: ANY
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string (a_tag)
				new_tag.append_string ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i1)
					if expected_item /= actual_item then
						create new_tag.make (15)
						new_tag.append_string (a_tag)
						new_tag.append_string ("-item #")
						new_tag.append_integer (i)
						a_message := assert_equal_message (new_tag, expected_item, actual_item)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

	assert_arrays_equal (a_tag: STRING; expected, actual: ARRAY [ANY]) is
			-- Assert that `expected' and `actual' have the same items
			-- in the same order (use `equal' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag, a_message: STRING
			expected_item, actual_item: ANY
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string (a_tag)
				new_tag.append_string ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i1)
					if not objects_are_equal (expected_item, actual_item) then
						create new_tag.make (15)
						new_tag.append_string (a_tag)
						new_tag.append_string ("-item #")
						new_tag.append_integer (i)
						a_message := assert_equal_message (new_tag, expected_item, actual_item)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

	assert_iarrays_same (a_tag: STRING; expected, actual: ARRAY [INTEGER]) is
			-- Assert that `expected' and `actual' have the same items
			-- in the same order (use '=' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag, a_message: STRING
			expected_item, actual_item: INTEGER
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string (a_tag)
				new_tag.append_string ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i2)
					if expected_item /= actual_item then
						create new_tag.make (15)
						new_tag.append_string (a_tag)
						new_tag.append_string ("-item #")
						new_tag.append_integer (i)
						a_message := assert_strings_equal_message (new_tag, expected_item.out, actual_item.out)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

feature {TS_TEST_HANDLER} -- Execution

	assert_execute (a_shell_command: STRING) is
			-- Execute `a_shell_command' and check whether the
			-- exit status code is zero.
		require
			a_shell_command_not_void: a_shell_command /= Void
			a_shell_command_not_empty: a_shell_command.count > 0
		do
			assert_exit_code_execute (a_shell_command, 0)
		end

	assert_exit_code_execute (a_shell_command: STRING; an_exit_code: INTEGER) is
			-- Execute `a_shell_command' and check whether the
			-- exit status code is `an_exit_code'.
		require
			a_shell_command_not_void: a_shell_command /= Void
			a_shell_command_not_empty: a_shell_command.count > 0
		local
			an_actual_exit_code: INTEGER
		do
			an_actual_exit_code := execute_command (a_shell_command)
			assert_integers_equal (a_shell_command, an_exit_code, an_actual_exit_code)
		end

	assert_not_exit_code_execute (a_shell_command: STRING; an_exit_code: INTEGER) is
			-- Execute `a_shell_command' and check whether the
			-- exit status code is not equal to `an_exit_code'.
		require
			a_shell_command_not_void: a_shell_command /= Void
			a_shell_command_not_empty: a_shell_command.count > 0
		local
			an_actual_exit_code: INTEGER
		do
			an_actual_exit_code := execute_command (a_shell_command)
			assert_integers_not_equal (a_shell_command, an_exit_code, an_actual_exit_code)
		end

feature {NONE} -- Messages

	void_or_out (an_any: ANY): STRING is
			-- Return `an_any.out' or Void if `an_any' is Void.
		do
			if an_any /= Void then
				Result := an_any.out
			end
		end

	assert_equal_message (a_tag: STRING; expected, actual: ANY): STRING is
			-- Message stating that `expected' and `actual' should be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			Result := assert_strings_equal_message (a_tag, void_or_out (expected), void_or_out (actual))
		end

	assert_not_equal_message (a_tag: STRING; expected, actual: ANY): STRING is
			-- Message stating that `expected' and `actual' should not be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			Result := assert_strings_not_equal_message (a_tag, void_or_out (expected), void_or_out (actual))
		end

	assert_strings_equal_message (a_tag: STRING; expected, actual: STRING): STRING is
			-- Message stating that `expected' and `actual' should be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			create Result.make (50)
			Result.append_string (a_tag)
			Result.append_string ("%N   expected: ")
			if expected = Void then
				Result.append_string ("Void")
			else
				Result.append_string (expected)
			end
			Result.append_string ("%N   but  got: ")
			if actual = Void then
				Result.append_string ("Void")
			else
				Result.append_string (actual)
			end
		ensure
			message_not_void: Result /= Void
		end

	assert_strings_not_equal_message (a_tag: STRING; expected, actual: STRING): STRING is
			-- Message stating that `expected' and `actual' should not be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			create Result.make (50)
			Result.append_string (a_tag)
			Result.append_string ("%N   got actual value: ")
			if actual = Void then
				Result.append_string ("Void")
			else
				Result.append_string (actual)
			end
			Result.append_string ("%N   should not match: ")
			if expected = Void then
				Result.append_string ("Void")
			else
				Result.append_string (expected)
			end
		ensure
			message_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	objects_are_equal (obj1, obj2: ANY): BOOLEAN is
			-- Are `obj1' and `obj2' considered equal?
		do
			if obj1 = obj2 then
				Result := True
			elseif obj1 = Void then
				Result := False
			elseif obj2 = Void then
				Result := False
			elseif obj1.same_type (obj2) then
				Result := obj1.is_equal (obj2)
			end
		ensure
			same_types: Result and (obj1 /= Void and obj2 /= Void) implies obj1.same_type (obj2)
		end



feature {NONE} -- Implementation (adapted GOBO routines, copied here to prevent GOBO dependency)

	interpreted_string (a_string: STRING): STRING is
			-- String where the environment variables have been
			-- replaced by their values. The environment variables
			-- are considered to be either ${[^}]*} or $[a-zA-Z0-9_]+
			-- and the dollar sign is escaped using $$. Non defined
			-- environment variables are replaced by empty strings.
			-- The result is not defined when `a_string' does not
			-- conform to the conventions above.
			-- Return a new string each time.
			--
			-- TODO: NOTE: this adaption of orginial gobo routine lost Unicode String support!!
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
				create Result.make(nb)
			until
				i > nb
			loop
				c := a_string.item (i)
				i := i + 1
				if c /= '$' then
					if c /= '%U' then
						Result.append_character (c)
					else
						Result.append_string (a_string.substring (i - 1, i - 1))
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
						create str.make(5)
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
									check same_type: str.same_type (a_string) end
									str.append_string (a_string.substring (i, i))
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


	variable_value (a_variable: STRING): STRING is
			-- Value of environment variable `a_variable',
			-- Void if `a_variable' has not been set;
			-- Note: If `a_variable' is a UC_STRING or descendant, then
			-- the bytes of its associated UTF unicode encoding will
			-- be used to query its value to the environment.
		do
			Result := environment_impl.get (a_variable)
		end


	execute_command (a_command: STRING): INTEGER is
			-- Ask operating system to execute `command'. Wait until
			-- termination. Return exit status code.
			-- (Note that under Windows 95/98 the exit status code
			-- returned is always 0 when `is_user_code' is true.).
		local
			retried: BOOLEAN
		do
			if not retried then
				environment_impl.system (a_command)
				Result := environment_impl.return_code

					-- TODO: replace.. Heuristics... to find out if OS is Linux
				if operating_environment.directory_separator = '/' then
						-- Under Linux, system codes are stored on the first
						-- 8 bits, and user codes on the higher bits.
					if (Result \\ 256) = 0 then
						Result := Result // 256
					else
						Result := Result \\ 256
					end
				end
			else
				Result := -1
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end


	environment_impl: EXECUTION_ENVIRONMENT is
			-- Execution environment impl
		once
			create Result
		ensure
			environment_impl_not_void: Result /= Void
		end


end
