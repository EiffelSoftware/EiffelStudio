class FORMAT_LIST

inherit

	CONSTANTS
		undefine
			copy, is_equal, setup, consistent
		end;
	FIXED_LIST [FORMAT_BUTTON]
		rename
			make as list_make
		end

creation

	make

feature {NONE}

	make (a_parent: ROW_COLUMN; ed: CONTEXT_EDITOR) is
		local
			fb: FORMAT_BUTTON
		do
			make_filled (Context_const.number_of_formats);
			!BEHAVIOUR_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Behaviour_format_nbr);
			!GEOMETRY_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Geometry_format_nbr);
			!ATTRIBUTE_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Attribute_format_nbr);
			!RESIZE_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Resize_format_nbr);
			!ALIGNMENT_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Align_format_nbr);
			!SUBMENU_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Submenu_format_nbr);
			!GRID_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Grid_format_nbr);
			!COLOR_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.color_format_nbr);
			!FONT_BUTTON!fb.make (a_parent, ed)
			put_i_th (fb, Context_const.Font_format_nbr);
		ensure
			Current_content_not_void: not has (Void)
		end

feature -- Update buttons 

	update_buttons (option_list: ARRAY [INTEGER]) is
		require
			valid_option_list: option_list /= Void;
			option_has_9: option_list.count = 9
		local
			i: INTEGER;
			form_number: INTEGER;
			ct: INTEGER;
			fb: FORMAT_BUTTON
		do
			from
				i := 1;
				ct := Context_const.number_of_formats
			until
				i >= count
			loop
				fb := i_th (i);
				form_number := option_list @ (i);
				if form_number = 0 then
					fb.unmanage
				else
					fb.manage;
					fb.set_form_number (form_number)
				end;
				i := i + 1					
			end;
		end

end

