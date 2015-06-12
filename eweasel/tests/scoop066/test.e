note
	description: "Test some basic operations on passive processors."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_shared: separate ANY
			l_supplier: separate SUPPLIER
		do
			create l_shared
			create <NONE> l_supplier.make (l_shared)


			test_simple_query (l_supplier)
			test_simple_command (l_supplier)
			test_regular_lockpassing (l_supplier, l_shared)
			test_passive_query_lockpassing (l_supplier, l_shared)
			test_passive_command_lockpassing (l_supplier, l_shared)
			test_separate_callback_query (l_supplier)
			test_separate_callback_command (l_supplier)

			print ("OK: No deadlock occurred.%N")
		end

	check_result (i: INTEGER)
		do
			if i /= 42 then
				print ("Error: Result does not match.%N")
			end
		end

feature -- Basic operations

	test_simple_query (supp: separate SUPPLIER)
		do

			check_result (supp.simple_query)
			print ("Executed simple query.%N")
		end

	test_simple_command (supp: separate SUPPLIER)
		do
			supp.do_nothing
			print ("Executed simple command.%N")
		end

	test_regular_lockpassing (supp: separate SUPPLIER; shared: separate ANY)
		do
			shared.out.do_nothing
			check_result (supp.regular_lockpassing (shared))
			print ("Executed regular lockpassing query.%N")
		end

	test_passive_query_lockpassing (supp: separate SUPPLIER; shared: separate ANY)
		do
			shared.out.do_nothing
			check 42 = supp.passive_query_lockpassing end
			print ("Executed passive lockpassing query.%N")
		end

	test_passive_command_lockpassing (supp: separate SUPPLIER; shared: separate ANY)
			-- Check if lockpassing happens on a synchronous command to a passive processor.
			-- If `supp' wouldn't be passive, this example would deadlock.
		do
			shared.out.do_nothing
			supp.passive_command_lockpassing
				-- Make sure that the test wasn't asynchronous.
			supp.out.do_nothing
			print ("Executed passive lockpassing command.%N")
		end

	test_separate_callback_query (supp: separate SUPPLIER)
		do
			check_result (supp.callback_query (Current))
			print ("Executed separate callback query.%N")
		end

	test_separate_callback_command (supp: separate SUPPLIER)
		do
			supp.callback_command (Current)
			print ("Executed separate callback command.%N")
		end
end
