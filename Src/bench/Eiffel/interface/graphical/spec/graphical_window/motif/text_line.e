indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class TEXT_LINE

inherit

	ARRAYED_LIST [TEXT_FIGURE]
		rename
			make as list_make
		end

creation

	make

feature {NONE} -- Initialization

	make (f: like figures) is
			-- Create current.
		do
			list_make (10);
			figures := f
		end;

feature -- Properties

	figures: GRAPHICAL_FIGURES;
			-- Associated figure list

	is_in_highlighted_line: BOOLEAN
			-- Is the Current line in a highlighted line?

	width: INTEGER is
		do
			Result := figures.workarea_width
		end;

	height: INTEGER is
		do
			Result := figures.maximum_height_per_line
		end;

	bottom_left_y: INTEGER;
			-- Bottom y coordinate of line

feature -- Access

	contains (p: COORD_XY): BOOLEAN is
			-- Does line contain point `p' between the
			-- the top and bottom of line?
		do
			Result := p.y <= bottom_left_y and p.y >= bottom_left_y - height
		end;

feature -- Setting

	set_bottom_left_y (i: like bottom_left_y) is
			-- Set `bottom_left_y' to `y'.
		do
			bottom_left_y := i
		end;

feature -- Access

	clickable_figure (p: COORD_XY): TEXT_FIGURE is
			-- Text figure that contain point `p'.
			-- If cannot find text figure at `p' then get the
			-- last clickable figure in line
		require
			valid_point: p /= Void
		local
			a: like area;
			i, c: INTEGER;
			last_fig, fig: TEXT_FIGURE
		do
			from
				c := count;
				a := area;
				i := 0
			until
				Result /= Void or else i >= c 
			loop
				fig := a.item (i);
				if fig.contains (p) then
					if fig.is_clickable then
						Result ?= fig
					else
						i := c;
					end
				elseif fig.base_left_x > p.x then
					i := c
				elseif fig.is_clickable then 
					last_fig := fig;
				end;
				i := i + 1
			end;
			if Result = Void then
				Result := last_fig
			end
		end;

	breakable_for (f: E_FEATURE; f_index: INTEGER): BREAKABLE_FIGURE is
			-- Breakable Text figure for feature `f' with index `f_index'
		require
			valid_f: f /= Void
		local
			a: like area;
			i, c: INTEGER;
			fig: BREAKABLE_FIGURE;
			found: BOOLEAN;
			b: BREAKABLE_STONE;
			bid: BODY_ID
		do
			from
				bid := f.body_id;
				c := count;
				a := area;
				i := 0
			until
				found or else i >= c 
			loop
				fig ?= a.item (i);
				if fig /= Void then
					b := fig.stone;
					found := (bid.is_equal (b.routine.body_id) and then
						b.index = f_index)
				end;
				i := i + 1
			end;
			if found then
				Result := fig
			end
		end;

	object_figure_in_line: OBJECT_TEXT_IMAGE is
			-- Object stone figure in current line 
			-- (Void, if not found. Assumed on one object per line)
		local
			a: like area;
			i, c: INTEGER;
		do
			from
				c := count;
				a := area;
				i := 0
			until
				Result /= Void or else i >= c 
			loop
				Result ?= a.item (i);
				i := i + 1
			end;
		end;

	clickable_figure_with_stone (s: STONE): TEXT_FIGURE is
			-- Text figure with stone `s'
		require
			valid_s: s /= Void
		local
			a: like area;
			i, c: INTEGER;
			fig: TEXT_FIGURE
		do
			from
				c := count;
				a := area;
				i := 0
			until
				Result /= Void or else i >= c 
			loop
				fig := a.item (i);
				if s.same_as (fig.stone) then
					Result := fig
				end;
				i := i + 1
			end;
		end;

	clickable_from_end: TEXT_FIGURE is
			-- Get first clickable searching from point `p'
			-- start of line. Return void if not found
		local
			a: like area;
			i, c: INTEGER;
			fig: TEXT_FIGURE
		do
			c := count;
			if c > 0 then
				from
					a := area;
					i := c - 1
				until
					Result /= Void or else i < 0 
				loop
					fig := a.item (i);
					if fig.is_clickable then
						Result := fig
					end;
					i := i - 1
				end
			end;
		end

feature -- Setting

	set_is_in_highlighted_line (b: BOOLEAN) is
			-- Set `is_in_highlighted_line' to `b'.
		do
			is_in_highlighted_line := b
		ensure
			set: is_in_highlighted_line = b
		end;

feature -- Output

	update_highlighted_line (d: DRAWING_X; 
			values: GRAPHICAL_VALUES; 
			b: BOOLEAN; x_offset, y_offset: INTEGER) is
			-- Select line if `b' is True. Otherwize, deselect it.
		do
			if b /= is_in_highlighted_line then
				set_is_in_highlighted_line (b);
				highlight_line (d, values, b, x_offset, y_offset)
				draw (d, values, x_offset, y_offset)
			end;
		end;

	draw (d: DRAWING_X; 
			values: GRAPHICAL_VALUES; 
			x_offset, y_offset: INTEGER) is
			-- Draw all the text in Current line.
		local
			a: like area;
			i, c: INTEGER;
			b: BOOLEAN;
			drawing: DRAWING_X;
		do
			b := is_in_highlighted_line;
			if b then
				highlight_line (d, values, True, x_offset, y_offset)
			end;
			from
				c := count;
				a := area;
				i := 0
			until
				i = c
			loop
				a.item (i).draw (d, values, b, x_offset, y_offset);
				i := i + 1
			end;
		end;

feature {NONE} -- Implementation

	highlight_line (d: DRAWING_X; 
			values: GRAPHICAL_VALUES;
			is_highlighted: BOOLEAN; x_offset, y_offset: INTEGER) is
			-- Draw the current highlighted text line.
		local
			padded_width: INTEGER;
			bp: BREAKABLE_FIGURE
		do
			if is_highlighted then
				d.set_foreground_gc_color (values.highlighted_line_bg_color);
				if count > 0 then
					bp ?= first;
					if bp /= Void then
						padded_width := figures.padded_width
					end;
				end;
			else
				d.set_foreground_gc_color (values.text_background_color);
			end;
				-- Coords are upper left corner for mel
			d.mel_fill_rectangle (d, 
				padded_width, 
				bottom_left_y - y_offset + 
				figures.maximum_descent_per_line - 
				figures.maximum_height_per_line, 
				width, height)
		end;

end -- class TEXT_LINE
