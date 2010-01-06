
class TEST2

feature

	try
		do
			print ({like Current}.value); 
			io.new_line
		end

	value: INTEGER 
		external "C inline"
		alias "29"
		end

end
