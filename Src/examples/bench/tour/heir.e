class HEIR inherit

	PARENT
		redefine
			display
		end

feature

	display is
		do
			io.put_string ("In class HEIR");
			io.new_line;
			io.put_string ("-------------------");
			io.new_line
			display_routine; 
			io.put_string (an_attribute);
			io.new_line;
			io.new_line
		end;

	display_routine is 
		do 
			io.put_string ("Calling a routine of class HEIR");
			io.new_line 
		end;

	an_attribute: STRING is 
		do 
			create Result.make (0);	
			Result.append ("Showing an attribute of class HEIR");
		end;

end
