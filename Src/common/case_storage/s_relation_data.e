class S_RELATION_DATA

feature

	break_points: FIXED_LIST [S_HANDLE_DATA];
			-- List of break points

	f_rom: S_LINKABLE_KEY;
			-- Partition from which the link originates.

	t_o: S_LINKABLE_KEY;
			-- Partition to which the link destinates.

	is_left_position: BOOLEAN;
			-- Is 'label' on the left side of relation ?

	is_vertical_text: BOOLEAN;
			-- Is 'label' wrote vertically ?

	label: STRING;
			-- Label of relation

feature -- Setting values

	set_break_points (l: like break_points) is
			-- Set break_points to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			break_points := l
		ensure
			break_set: break_points = l
		end;

	set_class_links (f: like f_rom; t: like t_o) is
			-- Set f_rom to `f' and set t_o to `t'.
		require
			valid_f: f /= Void;
			valid_t: t /= Void
		do
			f_rom := f;
			t_o := t
		ensure
			links_set: f_rom = f and then t_o = t
		end;

	set_booleans (left_pos, vert: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_left_position := left_pos;
			is_vertical_text := vert
		ensure
			booleans_set: is_left_position = left_pos;
							is_vertical_text = vert
		end;

	set_label (l: STRING) is
			-- Set label to `l'.
		require
			valid_arg: l /= Void
		do
			label := l
		ensure
			label_set: label = l
		end;

end

	
