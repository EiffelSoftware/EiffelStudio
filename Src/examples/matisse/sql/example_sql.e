indexing
	description: "Eiffel-MATISSE Binding: Example for the SQL interface";
	date: "$Date$";
	revision: "$Revision$"
	
class EXAMPLE_SQL

inherit
	MT_CONSTANTS

	ARGUMENTS

creation
	make
	
feature
	make is
		do
			if arg_number /= 3 then
				print_usage
			else
			!!mt_appl.set_login(argument(1), argument(2))
			
			load_presidents("..\..\data\presidents.txt")
			start_quiz(query_list_very_easy, "U.S. President Quiz: Level 1")
			start_quiz(query_list_easy, "U.S. President Quiz: Level 2")
			start_quiz(query_list_difficult, "U.S. President Quiz: Level 3")
			
			print_ending_message
			mt_appl.disconnect
			end
		end
	
	print_usage is
		do
			print("Usage:%N")
			print("	Specify arguments <hostname> and <database_name>%N")
			print("	Right-click on the Run button and type your host name and database name in this order%N")
		end
	
	print_ending_message is
		do
			print("You can see the SQL statements which are used to answer %N")
			print("the preceding questinos in the class EXAMPLE_SQL%N")
		end
feature

	load_presidents(filename: STRING) is
		do
			mt_appl.connect
				-- connect to the database
			mt_appl.start_transaction
				-- start a transaction
			load_president_info(filename)
				-- load data into the database
			mt_appl.commit_transaction
				-- commit the transaction
		end

	load_president_info(filename: STRING) is
		local
			data_file: PLAIN_TEXT_FILE
			a_line: STRING
			tokens: STRING_TOKEN
			separator: CHARACTER
			president_number: INTEGER
			president_name: STRING
			president_duty: STRING
			first_lady_name: STRING
			president, first_lady: PERSON
			a_presidency: PRESIDENCY
			middle_initial: CHARACTER
			start_year, end_year: INTEGER
		do
			!!data_file.make_open_read(filename)
			from
			until
				data_file.off
			loop
				data_file.read_line
				a_line := data_file.last_string
				!!tokens.make(a_line.count)
				tokens.make_from_string(a_line)
				tokens.token_start
				president_number := tokens.token_item.to_integer
				tokens.token_forth
				president_name := tokens.token_item
				tokens.token_forth
				president_duty := tokens.token_item
				tokens.token_forth
				if tokens.token_off then
					first_lady_name := Void
				else
					first_lady_name := tokens.token_item
				end
				president := get_person_from_name(president_name)
				if president = Void then
					!!president.make_from_name(
						first_name_out_of_full_name(president_name),
						middle_initial_out_of_full_name(president_name),
						last_name_out_of_full_name(president_name))
					current_db.persist(president)
				end
				if first_lady_name /= Void then
					first_lady := get_person_from_name(first_lady_name)
					if first_lady = Void then
						!!first_lady.make_from_name(
							first_name_out_of_full_name(first_lady_name),
							middle_initial_out_of_full_name(first_lady_name),
							last_name_out_of_full_name(first_lady_name))
						president.set_spouse(first_lady)
					end
				end
				a_presidency := get_presidency_from_number(president_number)
				if a_presidency = Void then
					start_year := start_year_from_duty(president_duty)
					end_year := end_year_from_duty(president_duty)
					!!a_presidency.make(president_number, start_year, end_year, president)
					current_db.persist(a_presidency)
				end
				print(president_number) print("  ")
				print(president_duty) print(" ")
				print(president.get_first_name) print(" ") print(president.get_last_name) print(" ")
				print(first_lady.get_first_name) print(" ") print(first_lady.get_last_name)
				io.new_line
			end
		end
	
	start_quiz(query_list: LINKED_LIST[ARRAY[STRING]]; label: STRING) is
		local
			quiz: ARRAY[STRING]
			sql_statement: MT_SQL_STATEMENT
			result_set: MT_SQL_RESULT_SET
			a_presidency: PRESIDENCY
		do
			io.new_line
			io.new_line
			print(label)
			io.new_line
			mt_appl.start_version_access
			from
				query_list.start
			until
				query_list.off
			loop
				quiz := query_list.item
				print(quiz.item(1)) print(": ")
				print(quiz.item(2))
				io.new_line
				io.read_line
				!!sql_statement.make
				result_set := sql_statement.execute_query(quiz.item(3))
				from
					result_set.start
				until
					result_set.exhausted
				loop
					a_presidency ?= result_set.item
					print(a_presidency)
					io.new_line
					result_set.forth
				end
				result_set.close
				query_list.forth
				io.new_line
				io.new_line
			end
			mt_appl.end_version_access
		end

feature {NONE}

	get_presidency_from_number(number: INTEGER) : PRESIDENCY is
		local
			statement: STRING
			query: MT_SQL_STATEMENT
			result_set: MT_SQL_RESULT_SET
		do
			statement := "SELECT * FROM PRESIDENCY WHERE EP_INCLUDE('"
			statement.append_integer(number)
			statement.append("', PRESIDENCY__number)")
			
			!!query.make
			result_set := query.execute_query(statement)
			result_set.start
			if result_set.exhausted then
				Result := Void
			else
				Result ?= result_set.item
			end
			result_set.close
		rescue
			print("get_presidency... rescue %N")
			print(statement)
		end
	
	get_person_from_name(full_name: STRING): PERSON is
		local
			first_name, last_name: STRING
			middle_initial: CHARACTER
			statement: STRING
			query: MT_SQL_STATEMENT
			result_set: MT_SQL_RESULT_SET
		do
			first_name := first_name_out_of_full_name(full_name)
			middle_initial := middle_initial_out_of_full_name(full_name)
			last_name := last_name_out_of_full_name(full_name)
			statement := "SELECT * FROM PERSON WHERE first_name = '"
			statement.append(first_name)
			statement.append("' AND last_name = '")
			statement.append(last_name)
			statement.append("'")
			if middle_initial /= '%U' then
				statement.append(" AND middle_initial = '")
				statement.append_character(middle_initial)
				statement.append("'")
			end
			!!query.make
			result_set := query.execute_query(statement)
			result_set.start
			if result_set.exhausted then
				Result := Void
			else
				Result ?= result_set.item
			end
			result_set.close
		end
	
	
	first_name_out_of_full_name(full_name: STRING) : STRING is
		local
			index: INTEGER
		do
			index := full_name.index_of(' ', 1)
			Result := full_name.substring(1, index - 1)
		end
	
	middle_initial_out_of_full_name(full_name: STRING) : CHARACTER is
		local
			position1, position2: INTEGER
		do
			position1 := full_name.index_of(' ', 1)
			position2 := full_name.index_of(' ', position1 + 1)
			if position2 /= 0 then
				Result := full_name.item(position1+1)
			end
		end
	
	last_name_out_of_full_name(full_name: STRING) : STRING is
		local
			position1, position2: INTEGER
		do
			position1 := full_name.index_of(' ', 1)
			position2 := full_name.index_of(' ', position1 + 1)
			if position2 = 0 then
				Result := full_name.substring(position1+1, full_name.count)
			else
				Result := full_name.substring(position2+1, full_name.count)
			end
		end
	
	start_year_from_duty(president_duty: STRING) : INTEGER is
		-- president_duty's format is something like "1944-1955"
		local
			year_string: STRING
			position: INTEGER
		do
			position := president_duty.index_of('-', 1)
			year_string := president_duty.substring(1, position - 1)
			Result := year_string.to_integer
		end
	
	end_year_from_duty(president_duty: STRING) : INTEGER is
		-- president_duty's format is something like "1944-1955"
		local
			year_string: STRING
			position: INTEGER
		do
			position := president_duty.index_of('-', 1)
			year_string := president_duty.substring(position + 1, president_duty.count)
			Result := year_string.to_integer
		end

feature
	query_list_very_easy : LINKED_LIST[ARRAY[STRING]] is
		once
			!!Result.make
			Result.extend(
				<<"Question One",
			         "Who was the First President",
       			  "SELECT * FROM PRESIDENCY WHERE number = 1">>)
       		 Result.extend(
			        <<"Question Two",
	       		  "Who is the forty second President",
			         "SELECT * FROM PRESIDENCY WHERE EP_INCLUDE('42', number)">>)
			 Result.extend(
			        <<"Question Three",
		       	  "Who are the Presidents whose spouse's name is Jacqueline",
	       		  "SELECT is_in_charge_of FROM Person WHERE EP_INCLUDE('Jacqueline', spouse.first_name)">>)
		end

	query_list_easy:  LINKED_LIST[ARRAY[STRING]] is
		once
			!!Result.make
			Result.extend(
				<<"Question One",
				  "Who was President during the Second World War",
				  "SELECT * FROM Presidency WHERE starting_year <= 1939 AND ending_year >= 1945">>)
			Result.extend(
				<<"Question Two",
				  "Who are the Presidents with a last name ending by 'ton'",
				  "SELECT is_in_charge_of FROM Person where EP_LIKE('%%ton', last_name) ORDER BY number">>)
			Result.extend(
				<<"Question Three",
				   "Who are the Presidents serving more than 8 years",
				  "SELECT * FROM Presidency WHERE (ending_year - starting_year) > 8">>)
		end
	
	query_list_difficult:  LINKED_LIST[ARRAY[STRING]] is
		once
			!!Result.make
			Result.extend(
				<<"Question One",
				  "Who are the Presidents with no First Lady",
				  "SELECT is_in_charge_of FROM Person WHERE spouse IS NULL">>)
			Result.extend(
				<<"Question Two",
				 "Who was the President with several non consecutive duties",
				 "SELECT is_in_charge_of FROM Person WHERE CARDINALITY(is_in_charge_of) > 1 ORDER BY number">>)
			Result.extend(
				<<"Question Three",
				  "Who are the Presidents with William as first name",
				  "SELECT is_in_charge_of FROM Person WHERE EP_LIKE('William%%', first_name) ORDER BY number">>)
			Result.extend(
				<<"Question Four",
			         "Who were the  Presidents who served consecutive eight years",
       			  "SELECT * FROM PRESIDENCY WHERE ending_year - starting_year = 8">>)
		end

feature

	mt_appl: MATISSE_APPL
	
end -- EXAMPLE_SQL
