class HEIR inherit

	PARENT
		redefine
			display
		end

feature

	display is
		do
			io.putstring ("In class HEIR");
			io.new_line;
			io.putstring ("-------------------");
			io.new_line
			display_routine; 
			io.putstring (an_attribute);
			io.new_line;
			io.new_line
		end;

	display_routine is 
		do 
			io.putstring ("Calling a routine of class HEIR");
			io.new_line 
		end;

	an_attribute: STRING is 
		do 
			create Result.make (0);	
			Result.append ("Showing an attribute of class HEIR");
		end;

end
