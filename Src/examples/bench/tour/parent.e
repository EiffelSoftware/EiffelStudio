class PARENT feature

	display is
		do
			io.putstring ("In class PARENT");
			io.new_line;
			io.putstring ("---------------");
			io.new_line;
			first_message
		end;

	first_message is
		do
			io.putstring ("Message number 1");
			io.new_line; io.new_line
		end;

end
