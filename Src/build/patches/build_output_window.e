indexing

	description: 
		"Output window that redirects the output to build error_box.";
	date: "$Date$";
	revision: "$Revision$"

class BUILD_OUTPUT_WINDOW

inherit

	OUTPUT_WINDOW
	redefine
		put_indent
	end
	
creation
	
	make
	
feature -- Initialization
	
	make (eb: ERROR_BOX) is 
		do
			error_box := eb
		end
		
feature -- Output

	put_string (s: STRING) is 
		do 
			error_box.put_string (s) 
		end;

	new_line is 
		do 
			error_box.new_line 
		end;

	put_char (c: CHARACTER) is 
		do 
			error_box.put_char (c) 
		end;
	
	put_indent (nbr_of_tabs: INTEGER) is
			-- Put indent of `nbr_of_tabs'.
		local
			str: STRING
		do
			str := "        "
			if nbr_of_tabs > 1 then
				str.multiply (nbr_of_tabs)
			end
			put_string (str)
		end
	
feature {NONE} -- Implementation
	
	error_box: ERROR_BOX
	

end -- class BUILD_OUTPUT_WINDOW
