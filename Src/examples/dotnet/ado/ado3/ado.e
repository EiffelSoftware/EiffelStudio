indexing
	description: "[
		Root class for Ado Overview 3.

		DataReaders 

		The DataReader object is somewhat synonymous with a read-only/forward-only 
		cursor over data. The DataReader API supports flat as well as hierarchical data. 
		A DataReader object is returned after executing a command against a database. 
		The format of the returned DataReader object is different from a recordset.
		For example, you might use the DataReader to show the results of a search list 
		in a web page. 
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	note: "[
		Translated from Microsoft .NET Framework SDK samples from location
		FrameworkSDK\Samples\QuickStart\howto\samples\adoplus\adooverview3
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ADO
	
inherit
	EXCEPTIONS

create
	make

feature -- Initialization

	make is
		local
			ok, retried: BOOLEAN
		do
			if not retried then
				create connection.make ("server=(local)\NetSDK;Trusted_Connection=yes;database=northwind")
		 		create command.make ("select * from customers", connection)
	
				io.put_string ("Connecting to server `(local)\NetSDK' and database `northwind'...%N")
				connection.open
				io.put_string ("Connection successful, retrieving data...%N%N")
				reader := command.execute_reader
	
					-- Print header
				io.put_string ("Customer ID%TCompany Name%N")
				io.put_string ("-------------------------------------------------%N%N")
	
					-- Iterate through result-set
				from
					ok := reader.read
				until
					not ok
				loop
					io.put_string (reader.item ("CustomerID").to_string)
					io.put_string ("%T%T")
					io.put_string (reader.item ("CompanyName").to_string)
					io.new_line
					ok := reader.read
				end
	
					-- Close everything
				reader.close
				connection.close
			else
				if reader /= Void then 
					reader.close 
				end
				if connection /= Void then
					connection.close
				end
			end
				-- Wait before closing the console
			io.read_line
		rescue
				-- Rescue any exception and display corresponding error message
			io.put_string ("%NThe following error occured: ")
			io.put_string (tag_name)
			retried := True
			retry
		end
		
feature -- Access

	reader : DATA_SQL_DATA_READER
			-- ADO.NET SQL data reader

	connection : DATA_SQL_CONNECTION
			-- ADO.NET SQL connection object

	command : DATA_SQL_COMMAND;
			-- ADO.NET SQL command object

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ADO
