
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATOR_O 

inherit

	SEPARATOR_I
		
		export
			{NONE} all
		end;

	PRIMITIVE_O
		rename
			set_width as old_set_width,
			set_height as old_set_height,
			set_size as old_set_size,
			set_x as old_set_x,
			set_y as old_set_y,
			set_x_y as old_set_x_y	
		end;

	PRIMITIVE_O
		redefine
			set_width,
			set_height,
			set_size ,
			set_x,
			set_y,
			set_x_y 	
		select
			set_size, set_height, set_width,
			set_x, set_y, set_x_y
		end;


	PRIMITIVE_O
		redefine
			set_size, set_height, set_width,
			set_x, set_y, set_x_y
		end

creation

	make

feature 

	make (a_separator: SEPARATOR) is
			-- Create a openlook separator.
		
		local
			ext_name: ANY;
		do
			ext_name := a_separator.identifier.to_c;		
			screen_object := create_separator ($ext_name, a_separator.parent.implementation.screen_object)
		ensure
			is_horizontal
		end

feature {NONE}

	style: INTEGER;
			-- style of the line

	horizontal: INTEGER;
			-- 1 if separator is horizontal
			-- 0 if vertical
	
feature 

	is_horizontal: BOOLEAN is
			-- Is separator orientation horizontal?
		do
			Result := horizontal = 1;
		end;

	set_horizontal (flag: BOOLEAN) is
            		-- Set orientation of the scale to horizontal if `flag',
            		-- to vertical otherwise.
        	do
            		if flag then 
				horizontal := 1
			else
				horizontal := 0
			end;
			inspect style
				when 0 then
					set_single_line
				when 1 then
					set_double_line
				when 2 then
					set_single_dashed_line
				when 3  then
					set_double_dashed_line
				when 4 then
					set_no_line			
				end;			
        	ensure then
            		value_correctly_set: is_horizontal = flag
        	end;

	set_single_line is
			-- Set separator display to be single line.
		
		do
			c_set_single_line (screen_object, horizontal);
			style := 0
		end;

	set_double_line is
			-- Set separator display to be double line.
		
		do
			c_set_double_line (screen_object, horizontal);
			style := 1
		end;

	set_single_dashed_line is
			-- Set separator display to be single dashed line.
		
		do
			c_set_single_dashed_line (screen_object, horizontal);
			style := 2
		end;

	set_double_dashed_line is
			-- Set separator display to be double dashed line.
		
		do
			c_set_double_dashed_line (screen_object, horizontal);
			style := 3
		end;

	set_no_line is
			-- Make current separator invisible.
		
		do
			c_set_no_line (screen_object, horizontal);
			style := 4
		end;

	set_width (new_width: INTEGER) is
		do
			set_managed (false);
			old_set_width (new_width);
			set_managed (true);
		end;

	set_height (new_height: INTEGER) is
		do
			set_managed (false);
			old_set_height (new_height);
			set_managed (true);
		end;

	set_size (new_width, new_height: INTEGER) is
		do
			set_managed (false);
			old_set_size (new_width, new_height);
			set_managed (true);
		end;

	set_x (new_x: INTEGER) is
		do
			set_managed (false);
			old_set_x (new_x);
			set_managed (true);
		end;

	set_y (new_y: INTEGER) is
		do
			set_managed (false);
			old_set_y (new_y);
			set_managed (true);
		end;

	set_x_y (new_x, new_y: INTEGER) is
		do
			set_managed (false);
			old_set_x_y (new_x, new_y);
			set_managed (true);
		end;

feature {NONE} -- External features

	c_set_single_line (scr_obj: POINTER; hztl: INTEGER) is
		external
			"C"
		end;

	c_set_no_line (scr_obj: POINTER; hztl: INTEGER) is
		external
			"C"
		end;

	c_set_double_dashed_line (scr_obj: POINTER; hztl: INTEGER) is
		external
			"C"
		end;

	c_set_single_dashed_line (scr_obj: POINTER; hztl: INTEGER) is
		external
			"C"
		end;

	c_set_double_line (scr_obj: POINTER; hztl: INTEGER) is
		external
			"C"
		end;

	create_separator (name: POINTER; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
