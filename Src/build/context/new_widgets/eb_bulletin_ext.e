-- Extended ebuild bulletin for eiffelbuil
-- Not to be used for Generated code
class EB_BULLETIN_EXT

inherit

	EB_BULLETIN
		rename
			make_unmanaged as eb_bull_create,
			set_width as bull_set_width,
			set_height as bull_set_height,
			set_size as bull_set_size
		end;
	EB_BULLETIN
		rename
			make_unmanaged as eb_bull_create
		redefine
			set_width, set_height, set_size
		select
			set_width, set_height, set_size
		end

creation

	make_unmanaged

feature {NONE}

	seph1, seph2, sepv1, sepv2: SEPARATOR;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
		do
			eb_bull_create (a_name, a_parent);
			!! seph1.make_unmanaged ("tmp1", Current);
			seph1.set_horizontal (True);
			!! seph2.make_unmanaged ("tmp2", Current);
			seph2.set_horizontal (True);
			!! sepv1.make_unmanaged ("tmp3", Current);
			sepv1.set_horizontal (False);
			!! sepv2.make_unmanaged ("tmp4", Current);
			sepv2.set_horizontal (False);
			seph1.set_height (separator_width);
			seph2.set_height (separator_width);
			sepv1.set_width (separator_width);
			sepv2.set_width (separator_width);
			seph1.set_x_y (separator_width, 0);
			seph2.set_x (separator_width);
			sepv1.set_x_y (0, separator_width);
			sepv2.set_y (separator_width);
			seph1.set_single_dashed_line;
			seph2.set_single_dashed_line;
			sepv1.set_single_dashed_line;
			sepv2.set_single_dashed_line;
			seph1.set_foreground_color (black_color);
			seph2.set_foreground_color (black_color);
			sepv1.set_foreground_color (black_color);
			sepv2.set_foreground_color (black_color);
			seph1.manage;
			seph2.manage;
			sepv1.manage;
			sepv2.manage;
		end;

	black_color: COLOR is
		once	
			!! Result.make;
			Result.set_name ("black")
		end;

	separator_width: INTEGER is 2;
			-- Separator width

	separator_offset: INTEGER is 
			-- Separator offset
		once
			Result := separator_width * 2
		end;

feature -- Setting sizes

	set_size (new_w, new_h: INTEGER) is
		do
			set_width (new_w);
			set_height (new_h);
		end;

	set_width (new_w: INTEGER) is
		do
			bull_set_width (new_w);
			seph1.unmanage;
			seph2.unmanage;
			sepv2.unmanage;
			seph1.set_width (new_w - separator_offset);
			seph2.set_width (new_w - separator_offset);
			sepv2.set_x (new_w - separator_width);
			sepv2.manage;
			seph2.manage;
			seph1.manage;
		end;

	set_height (new_h: INTEGER) is
		do
			bull_set_height (new_h);
			sepv1.unmanage;
			sepv2.unmanage;
			seph2.unmanage;
			sepv1.set_height (new_h - separator_offset);
			sepv2.set_height (new_h - separator_offset);
			seph2.set_y (new_h - separator_width);
			seph2.manage;
			sepv2.manage;
			sepv1.manage;
		end;

end
