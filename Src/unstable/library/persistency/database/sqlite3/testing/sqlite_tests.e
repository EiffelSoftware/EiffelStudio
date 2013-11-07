note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SQLITE_TESTS

inherit
	EQA_TEST_SET

	SQLITE_SHARED_API
		undefine
			default_create
		end

feature -- Test routines

	test_sqlite_argument_validity
		local
			h: SQLITE_BINDING_HELPERS
		do
			create h
			assert ("{NATURAL_8}.max_value: OK", h.is_valid_argument ({NATURAL_8}.max_value))
			assert ("{NATURAL_16}.max_value: OK", h.is_valid_argument ({NATURAL_16}.max_value))
			assert ("{NATURAL_32}.max_value: OK", h.is_valid_argument ({NATURAL_32}.max_value))
			assert ("{NATURAL_64}.max_value: bad value", not h.is_valid_argument ({NATURAL_64}.max_value))

			assert ("{INTEGER_8}.max_value: OK", h.is_valid_argument ({INTEGER_8}.max_value))
			assert ("{INTEGER_16}.max_value: OK", h.is_valid_argument ({INTEGER_16}.max_value))
			assert ("{INTEGER_32}.max_value: OK", h.is_valid_argument ({INTEGER_32}.max_value))
			assert ("{INTEGER_64}.max_value: OK", h.is_valid_argument ({INTEGER_64}.max_value))

			assert ("True: OK", h.is_valid_argument (True))
			assert ("False: OK", h.is_valid_argument (True))

			assert ("REAL_32: OK", h.is_valid_argument ({REAL_32}.max_value))
			assert ("REAL_64: OK", h.is_valid_argument ({REAL_64}.max_value))

			assert ("STRING_8: OK", h.is_valid_argument ({STRING_8} "abc"))
			assert ("STRING_32 containing ASCII: OK", h.is_valid_argument ({STRING_32} "abc"))
			assert ("STRING_32 containg unicode: bad value", not h.is_valid_argument ({STRING_32} "%/20320/%/22909/%/21527/"))

			assert ("LIST: bad type", not h.is_valid_argument (create {ARRAYED_LIST [INTEGER]}.make (0)))
			assert ("TUPLE: bad type", not h.is_valid_argument ([123, "abc"]))
			assert ("ARRAY: bad type", not h.is_valid_argument (<<1,2,3,'a','b','c',"foo",Void>>))
		end

	test_sqlite
			-- New test routine
		local
			db: SQLITE_DATABASE
			q: SQLITE_QUERY_STATEMENT
			q_modify: SQLITE_MODIFY_STATEMENT
			q_insert: SQLITE_INSERT_STATEMENT
			s, expected_s: STRING_8
			args: TUPLE
			b: BOOLEAN
			dbl_fmt: FORMAT_DOUBLE
		do
				-- Open database
			create db.make_create_read_write ("testing.sqlite")
			assert ("db is opened", not db.is_closed)

				-- Remove any existing table
			create q_modify.make ("DROP TABLE IF EXISTS Testing;", db)
			assert ("drop query is compiled", q_modify.is_compiled)
			q_modify.execute

			create q.make ("SELECT name FROM sqlite_master ORDER BY name;", db)
			assert ("select query is compiled", q.is_compiled)
			assert ("Testing table is dropped",  across q.execute_new as ic all not ic.item.string_value (1).is_case_insensitive_equal_general ("Testing") end)

				-- Create a new table
			create q_modify.make ("CREATE TABLE Testing (Id INTEGER PRIMARY KEY, Quantity INTEGER, Text TEXT, Value FLOAT, State INTEGER);", db)
			assert ("modify query is compiled", q_modify.is_compiled)
			q_modify.execute
			assert ("Testing table is created",  across q.execute_new as ic some ic.item.string_value (1).is_case_insensitive_equal_general ("Testing") end)

				-- Insert data
			create q_insert.make ("INSERT INTO Testing (Quantity, Text, Value, State) VALUES (?1, ?2, :VAR_VALUE, :VAR_STATE);", db)
			assert ("insert query is compiled", q_insert.is_compiled)

				-- Commit handling
			db.begin_transaction (False)
			assert ("in transaction", db.is_in_transaction)

				-- Execute the statement multiple (10) times
			b := False
			create expected_s.make_empty
			create dbl_fmt.make (2, 2)


			across 1 |..| 10 as ic loop
				b := not b
					-- Execute the INSERT statement with the argument list.
				args := [
						{INTEGER_64}.max_value.to_natural_64, -- ic.item.to_natural_8,
						"Eiffel SQLite Rocks!", -- Using Eiffel object (unnamed variable @ index 1 will replace ?1)
						create {SQLITE_DOUBLE_ARG}.make (":VAR_VALUE", ((ic.item - 1) * 3.14)), -- Using a named argument (will replace :VAR_VALUE),
						b --create {SQLITE_BOOLEAN_ARG}.make (":VAR_STATE", b) -- Using a named argument (will replace :VAR_STATE),
					]
				expected_s.append ("> Row "+ ic.item.out + ": ")
				expected_s.append ("Id:" + ic.item.out)
				expected_s.append (", ")
				expected_s.append ("Quantity:")
				if attached args.item (1) as l_item then
					expected_s.append (l_item.out)
				end
				expected_s.append (", ")
				expected_s.append ("Text:")
				if attached {READABLE_STRING_8} args.reference_item (2) as l_text then
					expected_s.append (l_text)
				end
				expected_s.append (", ")
				expected_s.append ("Value:")
				if attached {SQLITE_DOUBLE_ARG} args.reference_item (3) as l_dble then
					expected_s.append (dbl_fmt.formatted (l_dble.value))
					if expected_s.ends_with ("00") then
						expected_s.remove_tail (1)
					end
				end
				expected_s.append (", ")
				expected_s.append ("State:" + args.boolean_item (4).to_integer.out)

				expected_s.append_character ('%N')
				q_insert.execute_with_arguments (args)
				assert ("1 change due to insertion", db.changes_count = 1)
			end

				-- Commit changes
			db.commit
			assert ("10 changes", db.total_changes_count = 10)
			assert ("out of transaction", not db.is_in_transaction)

				-- Query the contents of the Example table
			create q.make ("SELECT * FROM Testing LIMIT 10;", db)
			assert ("select query is compiled", q.is_compiled)
			create s.make_empty
			q.execute (agent (ia_row: SQLITE_RESULT_ROW; ia_buf: STRING_8): BOOLEAN
				local
					j, j_count: NATURAL
				do
					ia_buf.append ("> Row " + ia_row.index.out + ": ")

					from
						j := 1
						j_count := ia_row.count
					until
						j > j_count
					loop
							-- Print the column name.
						ia_buf.append_string (ia_row.column_name (j))
						ia_buf.append_character (':')

							-- Print the text value, regardless of type.
						if ia_row.is_null (j) then
							ia_buf.append_string ("<NULL>")
						else
							ia_buf.append_string (ia_row.string_value (j))
						end

						if j < j_count then
							ia_buf.append_string (", ")
						end
						j := j + 1
					end

					ia_buf.append_character ('%N')

						-- Cut processing after 5 rows of data have been returned
					Result := (ia_row.index \\ 5) = 0
				end(?, s))
			assert ("Expected query result", expected_s.starts_with (s))


			create q_modify.make ("UPDATE Testing SET Text = 'Eiffel rules' WHERE State = 1;", db)
			q_modify.execute
			assert ("5 changes", db.changes_count = 5)
			assert ("15 total changes", db.total_changes_count = 15)

			create q_modify.make ("UPDATE Testing SET Text = 'Eiffel rules!!!' WHERE Id = 1;", db)
			q_modify.execute
			assert ("1 change", db.changes_count = 1)
			assert ("16 total changes", db.total_changes_count = 16)

				-- Query the contents of the Example table
			create q.make ("SELECT Quantity, Text, Value, State FROM Testing WHERE Id = ?1 ;", db)
			assert ("select query is compiled", q.is_compiled)
			q.execute_with_arguments (agent (ia_row: SQLITE_RESULT_ROW): BOOLEAN
					do
						assert ("col#1 is Quantity", ia_row.column_name (1).is_case_insensitive_equal ("Quantity"))
						assert ("col#2 is Text", ia_row.column_name (2).is_case_insensitive_equal ("Text"))
						assert ("col#3 is Value", ia_row.column_name (3).is_case_insensitive_equal ("Value"))
						assert ("col#4 is State", ia_row.column_name (4).is_case_insensitive_equal ("State"))

						assert ("Quantity is integer", attached {INTEGER_64} ia_row.value (1) as i64 and then i64 > 0)
						assert ("Quantity", ia_row.value (1) = ia_row.integer_64_value (1))

						assert ("Text is string", attached {READABLE_STRING_GENERAL} ia_row.value (2))
						assert ("Text", ia_row.value (2) ~ ia_row.string_value (2))

						assert ("Value is real_64", attached {REAL_64} ia_row.value (3) as r64 and then r64 > 0)
						assert ("Value", ia_row.value (3) = ia_row.real_64_value (3))

						assert ("State is Boolean, i.e integer", attached {INTEGER_64} ia_row.value (4))
						assert ("State", ia_row.value (4) = ia_row.integer_64_value (4))
						assert ("State is True", ia_row.boolean_value (4) = True)

						Result := True -- One result is enough
					end,
					[3] -- argument ?1
				)

			create q_modify.make ("DELETE FROM Testing WHERE Id > 7 AND State=0 ;", db)
			q_modify.execute
			assert ("2 deletions", db.changes_count = 2)
			assert ("18 total changes", db.total_changes_count = 18)

			print ("Closing Database...%N")
			db.close
			assert ("db is closed", db.is_closed)
		end

end


