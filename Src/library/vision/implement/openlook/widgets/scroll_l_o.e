indexing

	description:
		"Rectangle with scrollbars or not which contains a list of %
		%selectable strings";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLL_L_O 

inherit

	SCROLL_L_I
		export
			{NONE} all
		end;

	PRIMITIVE_O
		redefine
			set_width
		end;

	FONTABLE_O
		rename
			resource_name as Ofont
		end;

	LIST_MAN_O
		rename
			cursor as list_cursor,
			set_unsigned_char as list_set_unsigned_char,
			set_int as list_set_int,
			get_int as list_get_int
		end;
		
creation

	make
	
feature 

	make (a_list: SCROLL_LIST) is
			-- Create a openlook list, get screen_object value of srolled
			-- window which contains current list.
		
		local
			ext_name: ANY;
		do
			list_make;
			ext_name := a_list.identifier.to_c;		
			screen_object := create_scrolling_list ($ext_name, a_list.parent.implementation.screen_object);
			a_list.set_list_imp (Current);
			a_list.set_font_imp (Current);
			!!items_list.make;
-- TO FIX		create_backup
		end;

	set_width (new_width: INTEGER) is
		local
			ext_max_width: ANY;
			ext_min_width: ANY
		do
			ext_max_width := OprefMaxWidth.to_c;
			ext_min_width := OprefMinWidth.to_c;
			set_dimension (screen_object, new_width, $ext_max_width);		
			set_dimension (screen_object, new_width, $ext_min_width);		
		end;

	is_output_only_mode: BOOLEAN is
			-- Is scale mode output only mode?
		
		do
			Result :=  xt_is_sensitive (screen_object)
		end;

	set_input_output is
			-- Set scale mode to input output.
		
		do
			xt_set_sensitive (screen_object, True)
		ensure
			input_output_mode: not is_output_only_mode
		end; 

	set_output_only is
			-- Set scale mode to output only.
		
		do
			xt_set_sensitive (screen_object, False)
		ensure
			output_only_mode: is_output_only_mode
		end;

	search_equal (v: STRING) is do end;

	remove_all_occurrences (ai: STRING) is do end;

feature {NONE} -- External features

	create_scrolling_list (name: POINTER; parent: POINTER): POINTER is
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
