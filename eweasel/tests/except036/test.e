
class TEST
inherit
	EXCEPTIONS

create
	make

feature

	make
		local
			tried: BOOLEAN
		do
			if not tried then
				try1
			else
				print ("Exception 2: %N" + exception_explanation); io.new_line
			end
		rescue
			print ("Exception 1: %N" + exception_explanation); io.new_line
			tried := True
			retry
		end

	exception_explanation: STRING
		do
			create Result.make (500)
			Result.append ("original_exception: " + original_exception.out + "%N")
			Result.append ("meaing: " + meaning (original_exception) + "%N")
			Result.append ("original_tag_name: " + original_tag_name + "%N")
			Result.append ("original_recipient_name: " + original_recipient_name + "%N")
			Result.append ("original_class_name: " + original_class_name + "%N")
			Result.append ("%N")
		end

	try1
		do
			try2
		rescue
			try_again
		end
	
	try2
		do
			raise ("Weasels")
		end

	try_again
		require
			hamster: False
		do
		end

end
