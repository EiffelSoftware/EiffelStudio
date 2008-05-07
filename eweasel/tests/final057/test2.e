class TEST2

feature

	evaluate (a_type: STRING; a_context: STRING): TEST3 is
		do
			create Result
			print (a_type.generating_type)
			print ("%N")
			print (a_context.generating_type)
			print ("%N")
		end

	solved (a_type: TEST3; a_orig_type: STRING): TEST3 is
		do
			create Result
			print (a_type.generating_type)
			print ("%N")
			print (a_orig_type.generating_type)
			print ("%N")
		end

	
end
