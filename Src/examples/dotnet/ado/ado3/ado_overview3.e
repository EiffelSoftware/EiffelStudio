indexing
	description: "[
		Root class for Ado Overview3.

		DataReaders 

		The DataReader object is somewhat synonymous with a read-only/forward-only 
		cursor over data. The DataReader API supports flat as well as hierarchical data. 
		A DataReader object is returned after executing a command against a database. 
		The format of the returned DataReader object is different from a recordset.
		For example, you might use the DataReader to show the results of a search list 
		in a web page. 
		]"
	note: "[
		Translated from Microsoft .NET Framework SDK samples from location
		FrameworkSDK\Samples\QuickStart\howto\samples\adoplus\adooverview3
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ADO_OVERVIEW3

create
	make

feature -- Initialization

	make is
		local
			ok : BOOLEAN
		do
			create my_sql_connection.make_from_connection_string
				(("server=(local)\NetSDK;Trusted_Connection=yes;database=northwind").to_cil)
	 		create my_sql_command.make_from_cmd_text_and_connection
				(("select * from customers").to_cil, my_sql_connection)

			my_sql_connection.open
			my_reader := my_sql_command.execute_reader

				-- Print header
			print ("Customer ID    ")
			print ("Company Name%N")

				-- Iterate through result-set
			from
				ok := my_reader.read
			until
				not ok
			loop
				feature {SYSTEM_CONSOLE}.write (
					my_reader.get_item_string (("CustomerID").to_cil).to_string)
				feature {SYSTEM_CONSOLE}.write (("    ").to_cil)
				feature {SYSTEM_CONSOLE}.write (
					my_reader.get_item_string (("CompanyName").to_cil).to_string)
				feature {SYSTEM_CONSOLE}.write_line
				ok := my_reader.read
			end

				-- Close everything
			my_reader.close
			my_sql_connection.close

				-- Wait before closing the console
			io.read_line
		end
		
feature -- Access

	my_reader : DATA_SQL_DATA_READER
	my_sql_connection : DATA_SQL_CONNECTION
	my_sql_command : DATA_SQL_COMMAND

end -- class ADO_OVERVIEW3
