class PARENT feature

	display is
		do
			io.put_string ("In class PARENT");
			io.new_line;
			io.put_string ("---------------");
			io.new_line;
			first_message
		end;

	first_message is
		do
			io.put_string ("Message number 1");
			io.new_line; io.new_line
		end;

end
