class PARENT feature

	display is
			-- Display basic information.
		do
			io.put_string ("THIS IS SOME ADDED TEXT")
			io.new_line
			io.put_string ("In class PARENT")
			io.new_line
			io.put_string ("---------------")
			io.new_line
			first_message
		end

	first_message is
			-- Display a simple message.
		do
			io.putstring ("Message number 1")
			io.new_line; io.new_line
		end
		
end -- class PARENT
