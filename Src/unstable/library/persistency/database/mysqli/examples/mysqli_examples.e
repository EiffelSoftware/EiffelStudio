note
	description: "Usage example for MYSQLI library"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_EXAMPLES

feature  -- Creation

	client: MYSQLI_CLIENT
				-- Adjust your connection settings here
		once
			create Result.make
--			Result.set_host ("127.0.0.1")
--			Result.set_username ("root")
			Result.set_password ("pollo")
			Result.connect
		end

	run_segfaulting_query
		do
			client.execute_query ("SELECT firstName, lastName, itemsOwned FROM Persons WHERE itemsOwned  >  3;")
			from
				client.last_result.start
			until
				client.last_result.off
			loop
				io.put_string ("%TRow: ")
				io.put_string (client.last_result.item.out)
				client.last_result.forth
			end
		end

	run_simple_example
		do
			io.put_string ("Testing simple queries:%N")

			client.execute_query("SELECT 'Eiffel', 'MySQL'")
			from
				client.last_result.start
			until
				client.last_result.off
			loop
				io.put_string ("%TRow: ")
				io.put_string (client.last_result.item.out)
				io.put_string (" (should be 'Eiffel,MySQL')%N")
				client.last_result.forth
			end
		end

	run_prepared_statement_example
				-- Prepared statements
		local
			a_integer: INTEGER
			a_string: STRING
			a_date: DATE
			a_prepared_statement: STRING
		do
			io.put_string ("Testing prepared statements:%N")
			create a_string.make_empty
			create a_date.make_now
			client.execute_query ("DROP TABLE IF EXISTS `test_statements`")
			client.execute_query ("CREATE TABLE `test_statements` ( `a_integer` INTEGER NOT NULL, `a_date` DATE NOT NULL ) ENGINE=InnoDB")

			-- Support for parameters
			create a_prepared_statement.make_from_string ("INSERT INTO `test_statements` (`a_integer`, `a_date`) VALUES (?, ?)")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make (42), 1)
				prep.parameters.put_i_th (create {MYSQLI_DATE_VALUE}.make_as_string ("1985-06-01"), 2)
				prep.execute
				prep.close
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			-- And regular queries
			create a_prepared_statement.make_from_string ("SELECT * FROM `test_statements`")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				prep.close
				-- Mapped to actual Eiffel types, without intermediate string conversion
				a_integer := prep.last_result.at (1).at_field ("a_integer").as_integer
				a_string := prep.last_result.at (1).at_field ("a_date").as_string
				a_date := prep.last_result.at (1).at_field ("a_date").as_date
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			io.put_string ("%Ta_integer: ")
			io.put_integer (a_integer)
			io.put_string (" (should be '42')%N%Ta_date: ")
			io.put_string (a_string)
			io.put_string (" (should be '1985-06-01')%N%Ta_date.year: ")
			io.put_integer (a_date.year)
			io.put_string (" (should be '1985')%N")

			client.execute_query ("DROP TABLE IF EXISTS `test_statements`")
		end

	run_hash_table_example
				-- Results as lists of hash tables
		local
			l_result: like client.last_result
			l_hash_table: like client.last_result.item.as_hash_table
		do
			io.put_string ("Testing multi-result-sets and results as hash tables:%N")

			client.execute_query("SELECT 1 AS `one`, 2 AS `two`; SELECT 3 AS `three`, 4 AS `four`, 5 AS `five`;")

			from
				client.last_results.start
			until
				client.last_results.after
			loop
				l_result := client.last_results.item
				from
					l_result.start
				until
					l_result.after
				loop
					l_hash_table := l_result.item.as_hash_table

					from
						l_hash_table.start
					until
						l_hash_table.after
					loop
						io.put_string ("%TKey: ")
						io.put_string (l_hash_table.key_for_iteration)
						io.put_string (", Value: ")
						io.put_string (l_hash_table.item_for_iteration.as_string)
						io.put_new_line
						l_hash_table.forth
					end
					l_result.forth
				end
				client.last_results.forth
			end
		end

	run_transaction_example
				-- Transactions
		do
			io.put_string ("Testing transactions:%N")

			client.execute_query ("DROP TABLE IF EXISTS `test_transactions`")
			client.execute_query ("CREATE TABLE `test_transactions` ( `a_integer` INTEGER NOT NULL) ENGINE=InnoDB")
			client.execute_query ("INSERT INTO `test_transactions` (`a_integer`) VALUES (1)")

			client.set_flag_autocommit (False)

			client.execute_query ("UPDATE `test_transactions` SET `a_integer` = `a_integer` + 5")
			client.rollback

			client.execute_query ("UPDATE `test_transactions` SET `a_integer` = `a_integer` * 10")
			client.commit

			client.execute_query ("UPDATE `test_transactions` SET `a_integer` = `a_integer` + 5")
			client.rollback

			client.set_flag_autocommit (True)

			client.execute_query ("SELECT * FROM `test_transactions`")
			io.put_string ("%Ta_integer: ")
			io.put_integer (client.last_result.at (1).at_field ("a_integer").as_integer)
			io.put_string (" (should be '10')%N")

			client.execute_query ("DROP TABLE IF EXISTS `test_transactions`")
		end

end
