indexing
	description: "Eiffel-MATISSE Binding: Example for HASH_TABLE";
	date: "$Date$";
	revision: "$Revision$"
	
class EXAMPLE_HT

inherit
	MT_CONSTANTS

	ZIP_CODE_CONSTANTS
	
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
			mt_appl.connect
			load_zip_code
			mt_appl.disconnect
			
			mt_appl.connect
			read_zip_code
			mt_appl.disconnect
			end
		end
	
	print_usage is
		do
			print("Usage:%N")
			print("	Specify arguments <hostname> and <database_name>%N")
			print("	Right-click on the Run button and type your host name and database name in this order%N")
		end
	
feature

	load_zip_code is
		local
			a_zip: ZIP_CODE
			the_table: ZIP_CODE_TABLE
			hash_table: HASH_TABLE[ZIP_CODE, INTEGER]
		do
			mt_appl.start_transaction
			
			!!the_table
			current_db.persist(the_table)
			hash_table := the_table.get_zip_table
			
			!!a_zip.make(94403)
			a_zip.add_city("SAN MATEO", "CA", Zip_Standard)
			hash_table.put(a_zip, a_zip.get_zip_code)
			
			!!a_zip.make(94402)
			a_zip.add_city("SAN MATEO", "CA", Zip_Standard)
			hash_table.put(a_zip, a_zip.get_zip_code)
			
			!!a_zip.make(93117)
			a_zip.add_city("GOLETA", "CA", Zip_Standard)
			a_zip.add_city("GAVIOTA", "CA", Zip_Standard)
			a_zip.add_city("ISLA VISTA", "CA", Zip_Standard)
			a_zip.add_city("SANTA BARBARA", "CA", Zip_Standard)
			hash_table.put(a_zip, a_zip.get_zip_code)
			
			!!a_zip.make(12345)
			a_zip.add_city("SCHENECTADY", "NY", Zip_Unique)
			a_zip.add_city("GENERAL ELECTRIC", "NY", Zip_Unique)
			a_zip.add_city("SCHDY", "NY", Zip_Unique)
			hash_table.put(a_zip, a_zip.get_zip_code)

			!!a_zip.make(09876)
			a_zip.add_city("APO", "AE", Zip_Military)
			hash_table.put(a_zip, a_zip.get_zip_code)
			
			!!a_zip.make(20001)
			a_zip.add_city("WASHINGTON", "DC", Zip_Standard)
			hash_table.put(a_zip, a_zip.get_zip_code)
			
			!!a_zip.make(67039)
			a_zip.add_city("DOUGLASS", "KS", Zip_Standard)
			hash_table.put(a_zip, a_zip.get_zip_code)
			
			hash_table.put(Void, 0)
			mt_appl.commit_transaction
		end
		

	read_zip_code is
		local
			a_zip: ZIP_CODE
			the_table: ZIP_CODE_TABLE
			hash_table: HASH_TABLE[ZIP_CODE, INTEGER]
			c: MT_CLASS
			n: INTEGER
		do
			mt_appl.start_version_access
			!!c.make_from_name("ZIP_CODE_TABLE")
			the_table ?= c.all_instances.item(0)
			hash_table := the_table.get_zip_table
			
			print(hash_table.item(94403)) io.new_line io.new_line
			print(hash_table.item(20001)) io.new_line io.new_line
			print(hash_table.item(12345)) io.new_line io.new_line
			
			from n := 1
			until n = 0
			loop
				print("Enter ZIP code (e.g. 67039), enter 0 to quit:  ")
				io.read_integer
				io.new_line
				n := io.last_integer
				if n /= 0 then
					hash_table.search(n)
					if hash_table.found then
						print(hash_table.found_item) 
						io.new_line io.new_line
					else
						print("The zip code entered is not registered in the database%N%N")
					end
				end
			end	
				
			mt_appl.end_version_access
		end

feature

	mt_appl: MATISSE_APPL
	
end -- EXAMPLE_SQL
