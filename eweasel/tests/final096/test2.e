
class TEST2
feature
	try
		do
			io.put_boolean (attached {like {TEST1 [BOOLEAN]}.value} Current)
			io.put_new_line
			io.put_string ({like {TEST1 [BOOLEAN]}.value})
			io.put_new_line
			io.put_string (({like {TEST1 [BOOLEAN]}.value}).name)
			io.new_line
		end

end
