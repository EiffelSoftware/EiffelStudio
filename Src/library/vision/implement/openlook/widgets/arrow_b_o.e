
-- Button drawn on screen with an arrow.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ARROW_B_O 

inherit

	ARROW_B_I;

	PICT_COL_B_O
		rename
			make as pict_make
		export
			{NONE} all
		end

creation

	make
	
feature {NONE}

	Pixmap_Directory: STRING is
			-- Directory of arrow pixmaps
		local
			ext_name: ANY;
			env_var: STRING;
		do
--			!!env_var.make (11);
--			env_var.append ("OPEN");
--			!!Result.make (0);
--			ext_name := env_var.to_c;
--			Result.from_c (getenv ($ext_name));
--			Result.append ("/widgets/")
			!!Result.make (0);
			Result.append ("/warsaw.dev/Eiffel3_dvp/EiffelVision/implement/openlook/widgets/");
		end;

	symbol_file_content (fn: STRING): PIXMAP is
			-- Use `fn' name to retrieve pixmap 
		local
			full_path: STRING;
			pixmap_implementation: PIXMAP_X
		do
			full_path := Pixmap_directory;
			full_path.append (fn);	
			!!Result.make;
			Result.read_from_file (full_path);
			pixmap_implementation ?= Result.implementation;
			if not pixmap_implementation.is_valid then
				io.putstring ("error retrieving pixmap :");
				io.putstring (fn);
				io.new_line;
			end;
		end;

	arrow_up : PIXMAP is
			-- Arrow_up pixmap
		once
			Result := symbol_file_content ("arrow_u.symb")
		end;

	arrow_down : PIXMAP is
			-- Arrow_down pixmap
		once
			Result := symbol_file_content ("arrow_d.symb")
		end;

	arrow_left : PIXMAP is
			-- Arrow_left pixmap
		once
			Result := symbol_file_content ("arrow_l.symb")
		end;

	arrow_right : PIXMAP is
			-- Arrow_right pixmap
		once
			Result := symbol_file_content ("arrow_r.symb")
		end;

	direction: PIXMAP;
			-- Current direction of Current

feature 

	make (an_arrow_b: ARROW_B) is
			-- Create an openlook arrow button.
		local
			the_screen: SCREEN_I;
			pixmap_implementation: PIXMAP_X;
			ext_name, ident: ANY;
		do
			ident := an_arrow_b.identifier.to_c;
			screen_object := create_pict_color_b ($ident, 
									an_arrow_b.parent.implementation.screen_object);
			pixmap_implementation ?= arrow_up.implementation;
			direction := arrow_up;
			pixmap_implementation.put_object (Current);
			the_screen := widget_manager.parent (an_arrow_b).implementation.screen;
			ext_name := OlabelPixmap.to_c;
			set_openlook_pixmap (screen_object, 
						pixmap_implementation.resource_pixmap (the_screen), 
						$ext_name);
			allow_recompute_size;
		end; 

	down: BOOLEAN is
			-- Is the arrow direction down ?
		do
			Result := direction = arrow_down
		end; 

	left: BOOLEAN is
			-- Is the arrow direction left ?
		do
			Result := direction = arrow_left
		end; 

	right: BOOLEAN is
			-- Is the arrow direction right ?
		do
			Result := direction = arrow_right
		end; 

	up: BOOLEAN is
			-- Is the arrow direction up ?
		do
			Result := direction = arrow_up
		end; 

	set_down is
			-- Set the arrow direction to down.
		do
			direction := arrow_down;
			set_pixmap (arrow_down)
		end; 

	set_left is
			-- Set the arrow direction to left.
		do
			direction := arrow_left;
			set_pixmap (arrow_left)
		end; 

	set_right is
			-- Set the arrow direction to right.
		do
			direction := arrow_right;
			set_pixmap (arrow_right)
		end; 

	set_up is
			-- Set the arrow direction to up.
		do
			direction := arrow_up;
			set_pixmap (arrow_up)
		end;

feature {NONE} -- External features

	getenv (arg: ANY): ANY is
		external
			"C"
		end;

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
