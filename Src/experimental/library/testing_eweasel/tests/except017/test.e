indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	EXCEPTIONS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			re: BOOLEAN
		do
			if not re then
				test
			end
		rescue
			re := true
			retry
		end

	test is
		do
			test2
		rescue
			print (original_exception)
			print ("%N")
			print (original_tag_name)
			print ("%N")
			print (original_recipient_name)
			print ("%N")
			print (original_class_name)
			print ("%N")

			print (exception)
			print ("%N")
			print (tag_name)
			print ("%N")
			print (recipient_name)
			print ("%N")
			print (class_name)
			print ("%N")
			print ("---------------------------------%N")
			do_nothing
		end

	test2 is
		local
			c: TEST1
		do
			create c
			c.test1_test
		rescue
			print (original_exception)
			print ("%N")
			print (original_tag_name)
			print ("%N")
			print (original_recipient_name)
			print ("%N")
			print (original_class_name)
			print ("%N")

			print (exception)
			print ("%N")
			print (tag_name)
			print ("%N")
			print (recipient_name)
			print ("%N")
			print (class_name)
			print ("%N")
			print ("---------------------------------%N")
			do_nothing
		end



end -- class ROOT_CLASS
