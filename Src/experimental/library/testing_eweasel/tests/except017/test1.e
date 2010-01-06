indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST1

inherit
	EXCEPTIONS

feature

	test1_test is
		do
			test1_test1
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

	test1_test1 is
		do
			raise ("my test")
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

end
