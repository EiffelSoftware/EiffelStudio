indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	EXAMPLE_APP

inherit
	MT_CONSTANTS
	
	ARGUMENTS
	
creation
	make

feature -- Initialization

	make is
		do
			if arg_number /= 3 then
				print_usage
			else
			!!appl.set_login(argument(1), argument(2))
				-- Setting a host name of the database server,
				-- database name, accessing priority and wait time.
			appl.connect
				-- Connecting to the database
			appl.start_transaction
			--appl.start_version_access
			
			-- Example routines --
			
			read_file_and_store_objects
				-- Read a text file in the example project directory.
				-- Then create new objects of the class BOOK, AUTHOR
				-- and PUBLISHER, and store these objects in the database.

			appl.commit_transaction
			appl.start_transaction
		-- The followings are the examples for the document "A mechanism for..." --
			
			find_and_print_books_from_title("EIFFEL THE LANGUAGE")
				-- An example of entry point
								
			find_and_print_books_using_index("M", "N")
				-- An example of index
				
			print_all_instances_of_class("PUBLISHER")
				-- An example of class of extent
				
			print_all_instances_by_stream("PUBLISHER")
				-- Another example of class of extent
				-- This uses stream mechanism.

			--print_properites_of_book("Design Patterns") 
				-- This uses 'mt_load_all_properties'.
				-- In order to test this routine, you need to edit the
				-- classes AUTHOR, PERSON, PUBLISHE and BOOK.
				-- By default, attributes of these classes is not exported to 
				-- any class. You need to change it. For example, that 
				-- part for the class PERSON should look like:
				--
				-- feature 
				--	name: STRING
				--	birth_year: INTEGER
				
			print_properites_of_book_using_mt_get_functions("Design Patterns")
				-- This uses 'mt_get_string_by_name' etc.

			print_all_authors_of_book_transparent("Design Patterns")
				-- Get successors using transparent loading mechanism.

			--print_all_authors_of_book_explicit("Design Patterns")
				-- Get successors using explicit loading mechanism.
				-- In order to test this routine, you need to edit the
				-- classes AUTHOR, PERSON, PUBLISHE and BOOK.
				-- By default, attributes of these classes is not exported to 
				-- any class. You need to change it. For example, that 
				-- part for the class PERSON should look like:
				--
				-- feature 
				--	name: STRING
				--	birth_year: INTEGER

			--print_all_authors_of_book_using_stream("Design Patterns")
				-- Get successors using stream.
				-- In order to test this routine, you need to edit the
				-- classes AUTHOR, PERSON, PUBLISHE and BOOK.
				-- By default, attributes of these classes is not exported to 
				-- any class. You need to change it. For example, that 
				-- part for the class PERSON should look like:
				--
				-- feature 
				--	name: STRING
				--	birth_year: INTEGER

--			remove_price_of_book("Wireless Information Networks")
				-- Remove an attribute value
			
--			delete_book("Distributed Algorithms")
				-- Delete an object
			
			--print_publisher_and_authors_of_book_explicit("Design Patterns")
				-- In order to test this routine, you need to edit the
				-- classes AUTHOR, PERSON, PUBLISHE and BOOK.
				-- By default, attributes of these classes is not exported to 
				-- any class. You need to change it. For example, that 
				-- part for the class PERSON should look like:
				--
				-- feature 
				--	name: STRING
				--	birth_year: INTEGER
			print_publisher_and_authors_of_book_transparent("Design Patterns")
				-- These two illustrate the difference between the transparent
				-- loading feature and the explicit loading feature.
									
			appl.commit_transaction
				-- Committing the transaction
			--appl.end_version_access
			appl.disconnect
				-- Disconnecting from the database
			end
		end

	print_usage is
		do
			print("Usage:%N")
			print("	Specify arguments <hostname> and <database_name>%N")
			print("	Right-click on the Run button and type your host name and database name in this order%N")
		end

feature

	read_file_and_store_objects is
		-- Read text file which is created by read_from_bookst_and_file_out.
		-- Create instances of PUBLISHER, AUTHOR
		-- and BOOK. Then store them in a database
		-- Section 5.1 and 5.2
		local 
			pubs: HASH_TABLE[PUBLISHER, STRING]
			authors: HASH_TABLE[AUTHOR, STRING]
			books: ARRAY[BOOK]
			a_pub: PUBLISHER
			a_book: BOOK
			an_author: AUTHOR
			i, j, n, count: INTEGER
			a_file: PLAIN_TEXT_FILE
			author_name, pub_name: STRING
			message: STRING

			a: ARRAY [AUTHOR]
			arg: AUTHOR
		do
			message := "This program is going to update the database "
			message.append(appl.database_name)
			message.append(" in host ")
			message.append(appl.host_name)
			print(message)
			print("%NIs it OK? (yes or no) ")
			io.readline
			if io.laststring.is_equal("yes") then
			!!a_file.make_open_read("..\..\books.dat")
			
			-- Creating PUBLISHER object
			a_file.read_integer
			count := a_file.last_integer
			!!pubs.make(10)
			from
				i := 1
			until
				i > count
			loop
				a_file.readline
				!!a_pub
				a_pub.set_name(a_file.laststring)
				pubs.put(a_pub, a_pub.get_name)
				i := i + 1
			end

			-- Creating AUTHOR object
			a_file.read_integer
			count := a_file.last_integer
			!!authors.make(10)
			from
				i := 1
			until
				i > count
			loop
				a_file.readline
				!!an_author
				an_author.set_name(a_file.laststring)
				a_file.read_integer
				an_author.set_birth_year(a_file.lastint)
				authors.put(an_author, an_author.get_name)
				i := i + 1
			end

			-- Creating BOOK object
			a_file.read_integer
			count := a_file.last_integer
			from
				i := 1
			until
				i > count
			loop
				a_file.readline
				!!a_book
				a_book.set_title(a_file.laststring)
				current_db.persist(a_book)
					-- Explicit promotion of transient object into persistent one
				
				a_file.read_integer
				a_book.set_price(a_file.last_integer)
				
				a_file.readline
				pub_name := a_file.laststring
				a_book.set_publisher(pubs.item(pub_name))
					-- "Persistence by reachability"
				
				a_file.read_integer
				n := a_file.last_integer
				from
					j := 1
				until
					j > n
				loop
					a_file.readline
					author_name := a_file.laststring
					a := a_book.get_written_by
					arg := authors.item(author_name)
					a.force (arg, j)
		--			a_book.get_written_by.force(authors.item(author_name), j)
						-- "Persistence by reachability"
					j :=  j + 1
				end
				i := i + 1
			end
			
			a_file.close
			end
		end

feature -- Programs in the document

	find_and_print_books_from_title(a_title: STRING) is
		-- Use entry-point
		-- section 3.2.1
		local
			ep: MT_ENTRYPOINT
			an_array: ARRAY [MT_STORABLE]
			i: INTEGER
		do
			print("%N%Nfind_and_print_books_from_title%N")
			!!ep.make_from_name("title", "BOOK")
			an_array :=  ep.retrieve_objects(a_title)
			from
				i := an_array.lower
			until
				i > an_array.upper
			loop
				print(an_array.item(i))
				i := i + 1
			end
		end

	find_and_print_books_using_index(start_v, end_v: STRING) is
		-- Section 3.2.2
		local
			an_index: MT_INDEX
			index_stream: MT_STREAM
			criterion: MT_INDEX_CRITERION
		do
			print("%N%Nfind_and_print_books_using_index%N")
			!!an_index.make("BookTitleIndex")
			criterion := an_index.criteria.item(0)
			criterion.set_start_value(start_v)
			criterion.set_end_value(end_v)
			index_stream := an_index.open_stream
			from
				index_stream.start
			until
				index_stream.exhausted
			loop
				index_stream.item.mt_load_all_values
				print(index_stream.item)
				index_stream.forth
			end
			index_stream.close
	end

	print_all_instances_of_class(a_class_name: STRING) is
		-- Section 3.2.3
		local
			a_class: MT_CLASS
			all_instances: ARRAY[MT_STORABLE]
			i: INTEGER
		do
			print("%N%Nprint_all_instances of class ")
			print(a_class_name)
			io.new_line
			!!a_class.make_from_name(a_class_name)
			all_instances := a_class.all_instances
			from
				i := all_instances.lower
			until
				i > all_instances.upper
			loop
				print(all_instances.item(i))
				i := i + 1
			end
		end
		
	print_all_instances_by_stream(a_class_name: STRING) is
		-- Use stream to print all instances of a class
		-- Section 3.2.3
		local
			a_class: MT_CLASS
			a_stream: MT_CLASS_STREAM
			i: INTEGER
		do
			print("%N%Nprint_all_instances_by_stream%N")
			!!a_class.make_from_name(a_class_name)
			a_stream := a_class.open_stream
			from
				a_stream.start
			until
				a_stream.exhausted
			loop
				print(a_stream.item)
				a_stream.forth
			end
			a_stream.close
		end
		
--	print_properites_of_book(book_title: STRING) is
--		-- Example of mt_load_all_values
--		local
--			a_book: BOOK
--			an_ep: MT_ENTRYPOINT
--			books: ARRAY[BOOK]
--			i: INTEGER
--		do
--			print("%N%Nprint_properites_of_book%N")
--			!!an_ep.make_from_name("title", "BOOK")
--			books ?= an_ep.retrieve_objects(book_title)
--			from i := books.lower
--			until	i > books.upper
--			loop
--				a_book := books.item(i)
--				a_book.mt_load_all_properties
--				print("Title: ")
--				print(a_book.title) io.new_line
--				print("Price: ")
--				print(a_book.price) io.new_line
--				print(a_book.publisher)
--				print("Authors: %N")
--				print(a_book.written_by)
--				i := i + 1
--			end
--		end
	
	print_properites_of_book_using_mt_get_functions(book_title: STRING) is
		-- Example of mt_get_* functions
		local
			a_book: BOOK
			an_ep: MT_ENTRYPOINT
			books: ARRAY[MT_STORABLE]
			i: INTEGER
		do
			print("%N%Nprint_properites_of_book_using_mt_get_functions%N")
			!!an_ep.make_from_name("title", "BOOK")
			books := an_ep.retrieve_objects(book_title)
			from i := books.lower
			until i > books.upper
			loop
				a_book ?= books.item(i)
				print(a_book.mt_get_string_by_name("title"))
				print(a_book.mt_get_real_by_name("price"))
				print(a_book.mt_get_successor_by_name("publisher"))
				print(a_book.mt_get_successors_by_name("written_by"))
				i := i + 1
			end
		end		

	print_all_authors_of_book_transparent(book_title: STRING) is
		-- This verson uses get_written_by instead of stream.
		-- Section 3.6
		local
			authors: ARRAY[AUTHOR]
			a_book: BOOK
			an_ep: MT_ENTRYPOINT
			i: INTEGER
		do
			print("%N%Nprint_all_authors_of_book: Using get_written_by%N")
			!!an_ep.make_from_name("title", "BOOK")
			a_book ?= an_ep.retrieve_objects(book_title).item(1)
			authors := a_book.get_written_by
			from
				i := authors.lower
			until
				i > authors.upper
			loop
				print(authors.item(i))
				i := i + 1
			end
		end
		
--	print_all_authors_of_book_explicit(book_title: STRING) is
--		-- This verson uses load_successors instead of stream
--		-- Section 3.6
--		local
--			authors: MT_ARRAY[AUTHOR]
--			a_book: BOOK
--			an_ep: MT_ENTRYPOINT
--			i: INTEGER
--		do
--			print("%N%Nprint_all_authors_of_book_3%N")
--			!!an_ep.make_from_name("title", "BOOK")
--			a_book ?= an_ep.retrieve_first(book_title)
--			authors ?= a_book.written_by
--			authors.load_successors
--			from
--				i := authors.lower
--			until
--				i > authors.upper
--			loop
--				print(authors.item(i))
--				i := i + 1
--			end
--		end
	
--	print_all_authors_of_book_using_stream(book_title: STRING) is
--		-- Section 3.6
--		local
--			a_stream: MT_STREAM
--			an_author: AUTHOR
--			a_book: BOOK
--			an_ep: MT_ENTRYPOINT
--		do
--			print("%N%Nprint_all_authors_of_book: Using stream%N")
--			!!an_ep.make_from_name("title", "BOOK")
--			a_book ?= an_ep.retrieve_first(book_title)
--			if a_book /= Void then
--				a_stream := a_book.written_by.open_stream
--				from
--					a_stream.start
--				until
--					a_stream.exhausted
--				loop
--					print(a_stream.item)
--					a_stream.forth
--				end
--				a_stream.close
--			end
--		end

	remove_price_of_book(book_title: STRING) is
		-- Remove the value of attribute 'price'
		-- Section 4.2
		local
			ep: MT_ENTRYPOINT
			a_book: BOOK
		do
			print("%N%NRemove value%N")
			!!ep.make_from_name("title", "BOOK")
			a_book ?= ep.retrieve_first(book_title)
			if a_book /= Void then
				a_book.mt_remove_value_by_name("price")
			end
		end
	
	delete_book(book_title: STRING) is
		-- Section 4.3
		local
			ep: MT_ENTRYPOINT
			a_book: BOOK
		do
			print("%N%Ndelete book: ")
			print(book_title) io.new_line
			!!ep.make_from_name("title", "BOOK")
			a_book ?= ep.retrieve_first(book_title)
			if a_book = Void then
				print("The book is not found%N")
			else
				a_book.mt_remove
			end
		end

feature

--	print_publisher_and_authors_of_book_explicit(book_title: STRING) is
--		-- Use 'mt_load_all_successors' and 'mt_load_all_values'
--		-- This is using explicit loading.
--		local
--			a_book: BOOK
--			a_publisher: PUBLISHER
--			authors: MT_ARRAY[AUTHOR]
--			an_ep: MT_ENTRYPOINT
--			i: INTEGER
--		do
--			print("%N%Nprint_publisher_and_authors_of_book using explicit loading%N")
--			!!an_ep.make_from_name("title", "BOOK")
--			a_book ?= an_ep.retrieve_first(book_title)
--			if a_book /= Void then
--				a_book.mt_load_all_successors
--				a_publisher := a_book.publisher
--				a_publisher.mt_load_all_values
--				print(a_publisher.name)
--				authors := a_book.written_by
--					-- authors is still empty
--				from
--					authors.load_successors
--					i := authors.lower
--				until
--					i > authors.upper
--				loop
--					authors.item(i).mt_load_all_values
--					print(authors.item(i).name)
--					i := i + 1
--				end
--			end
--		end
	
	print_publisher_and_authors_of_book_transparent(book_title: STRING) is
		-- Use get_* functions, that is transparent loading
		local
			a_book: BOOK
			a_publisher: PUBLISHER
			authors: ARRAY[AUTHOR]
			an_ep: MT_ENTRYPOINT
			i: INTEGER
		do
			print("%N%Nprint_publisher_and_authors_of_book using transparent loading%N")
			!!an_ep.make_from_name("title", "BOOK")
			a_book ?= an_ep.retrieve_objects(book_title).item(1)
			if a_book /= Void then
				a_publisher := a_book.get_publisher
				print(a_publisher.get_name)
				authors := a_book.get_written_by
				from
					i := authors.lower
				until
					i > authors.upper
				loop
					print(authors.item(i).get_name)
					i := i + 1
				end
			end
		end

feature {NONE}

	appl : MATISSE_APPL

end -- class EXAMPLE_APP
