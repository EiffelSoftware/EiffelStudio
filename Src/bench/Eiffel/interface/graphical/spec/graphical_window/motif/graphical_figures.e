indexing

	description: 
		"Manages a list of Text lines -- adding, searching %
		%and updating text lines.";
	date: "$Date$";
	revision: "$Revision $"

deferred class GRAPHICAL_FIGURES

inherit

	ARRAYED_LIST [TEXT_LINE]
		rename
			wipe_out as arrayed_list_wipe_out,
			search as array_search,
			cursor as array_cursor,
			go_to as array_go_to
		export
			{NONE} arrayed_list_wipe_out, array_search, array_cursor, array_go_to
		end;
	GRAPHICAL_VALUES
		undefine
			is_equal, copy, setup
		end;
	TEXT_WINDOW
		rename
			current_line as current_text_line,
			count as text_count
		undefine
			is_equal, copy, setup
		redefine
			put_address, put_feature_name, put_feature, put_feature_error,
			put_error, put_class, put_after_class, put_classi, put_cluster,
		   	process_breakpoint, process_padded, put_class_syntax,
			put_quoted_comment, put_operator, put_symbol, put_ace_syntax,
			put_keyword, put_indent, process_quoted_text, put_comment,
			process_basic_text, process_column_text, process_call_stack_item,
			process_indentation
		end;
	SHARED_APPLICATION_EXECUTION
		undefine
			is_equal, copy, setup
		end
	EB_CONSTANTS
		undefine
			is_equal, copy, setup
		end

feature -- Access

	current_line: TEXT_LINE;
			-- Current line

	highlighted_line: TEXT_LINE;
			-- Current line

	current_text: TEXT_FIGURE
			-- Current text figure

	maximum_height_per_line: INTEGER;
			-- Maximum height of line

	maximum_descent_per_line: INTEGER;
			-- Maximum descent of line

	maximum_width: INTEGER;
			-- Max width of workarea

	cursor_position: INTEGER;
			-- Cursor position
 
	drawing: DRAWING_IMP is
			-- Drawing implementation
		deferred
		end;

	workarea_width: INTEGER is
			-- Width of workarea
		deferred
		end;

	workarea_height: INTEGER is
			-- Height of workarea
		deferred
		end;

	x_offset, y_offset: INTEGER is
			-- X and Y offset
		deferred
		end;

	tabs_from_pixel (pix: INTEGER): STRING is
			-- Tabulation string from number of `pix'
		local
			n: INTEGER
		do
			n := pix // tab_pixel_length;
			!! Result.make (n);
			if n > 0 then
				Result.extend ('%T');
				Result.multiply (n)
			end
		end;

	character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		do
			if y_pos <= 0 then
				Result := 0
			else
				find_text (x_pos, y_pos);
				if current_line = Void then
						-- Can't find line (coord MUST be after document)
					Result := text.count - 1
				else
					if current_text /= Void then
						-- Get the closest character position in text
						Result := current_text.character_position 
								(Current, x_pos + x_offset)
					elseif x_pos <= initial_x_position then
							-- Get the text position at the start of current next line
						Result := i_th (index).text_position
					elseif index = count then 
						Result := text.count - 1
					else
							-- Get the text position at the end of current next line.
						Result := i_th (index + 1).text_position - 1
					end
				end
			end
		end;

	coordinate (char_pos: INTEGER): COORD_XY is
			-- Coordinate of character postion `char_pos'
		local
			a: like area;
			i, c: INTEGER;
			fig: TEXT_FIGURE;
			line: TEXT_LINE;
			found: BOOLEAN;
		do
			from
				c := count;
				a := area;
				i := 0
			until
				found or else i >= c
			loop
				line := a.item (i);
				found := line.text_position > char_pos;
				i := i + 1
			end;
			if found then
				if char_pos = 0 then
					-- go back to previous line
					line := a.item (0);
				else
					line := a.item (i - 2);
				end;
			elseif i = c then
				line := a.item (i - 1);
			end
			if line /= Void then
				if line.empty then
					-- Must only be a new line
					!! Result;
					Result.set (workarea_width, line.base_left_y)
				else
					fig := line.text_with_position (char_pos);
					if fig /= Void then
						Result := fig.coordinate (Current, char_pos)
					end
				end
			end;
			if Result = Void then
				line := i_th (count);
				-- Must be after end of document
				!! Result;
				Result.set (workarea_width, line.base_left_y)
			end
		end;

feature -- Update

	find_text (relative_x, relative_y: INTEGER) is
			-- Find clickable text from coordinates.
		local
			fig: TEXT_FIGURE;
			p: COORD_XY
		do
			current_text := Void;
			find_line (relative_y);
			if current_line /= Void then
				!! p;
				p.set (relative_x + x_offset, relative_y);
				current_text := current_line.text_figure (p);
			end;
		end;

	find_line (relative_y: INTEGER) is
			-- Find text line text from `relative_y' coordinate.	
		local
			a: like area;
			i, c: INTEGER;
			fig: TEXT_FIGURE;
			line: TEXT_LINE;
			found: BOOLEAN;
			rel_y: INTEGER;
			desc: INTEGER
		do
			rel_y := relative_y + y_offset;
			desc := maximum_descent_per_line;
			from
				c := count;
				a := area;
				i := 0
			until
				found or else i >= c
			loop
				line := a.item (i);
				if line.base_left_y + desc > rel_y then
					found := True;
					index := i + 1
				else
					i := i + 1
				end;
			end;
			if found then
				current_line := line
			else
				current_line := Void
			end
		ensure
			ok: current_line /= Void implies 
					i_th (index) = current_line
		end;

	find_clickable_figure_with_stone (stone: STONE) is
			-- Find clickable text from `stone'.
		local
			a: like area;
			i, c: INTEGER;
			fig: TEXT_FIGURE;
			line: like item
		do
			from
				a := area;
				i := 0;
				c := count;
			until
				fig /= Void or else i >= c
			loop
				line := a.item (i);
				fig := line.clickable_figure_with_stone (stone);
				i := i + 1
			end;
			current_text := fig;
		end;

	find_clickable (relative_x, relative_y: INTEGER) is
			-- Find clickable text from coordinates.	
		local
			a: like area;
			i, c: INTEGER;
			fig: TEXT_FIGURE;
			p: COORD_XY;
			found: BOOLEAN;
			line: like current_line
		do
			!! p;
			p.set (relative_x + x_offset, relative_y + y_offset);
			find_line (relative_y);
			if current_line /= Void then
				fig := current_line.clickable_figure (p);
				if fig = Void then
						-- Go back until one is found
					from
						a := area;
						i := index - 2
					until
						fig /= Void or else i < 0
					loop
						line := a.item (i);
						fig := line.clickable_from_end;
						i := i - 1
					end
				end;
			end;
			current_text := fig;
		end;

feature -- Input

	put_after_class (e_class: CLASS_C; str: STRING) is
			-- Put "-- class" followed by `t' in the text.
		do
			put_comment (" -- ");
			put_keyword ("class ");
			put_class (e_class, e_class.name_in_upper);
			new_line
		end;

	put_operator (str: STRING;
			e_feature: E_FEATURE; is_keyword: BOOLEAN) is
		   -- Process operator text.
		local
			stone: FEATURE_STONE;
			fig: TEXT_FIGURE
		do
			!! stone.make (e_feature);
			if is_keyword then
				!KEYWORD_TEXT_IMAGE! fig
			else
				!SYMBOL_TEXT_IMAGE! fig
			end;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_string (s: STRING) is
			-- Add text `s'.
		local
			fig: STRING_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, s);
		end;

	put_char (c: CHARACTER) is
			-- Add `c' to the text image.
		do
			put_string (c.out);
		end;

	new_line is
			-- Add a new line to text.
		require else
			valid_current_line: current_line /= Void
		local
			text_fig: TEXT_FIGURE;
		do
			current_line.set_base_left_y (current_y);
			extend (current_line);
debug ("DRAWING")
	if not current_line.empty then
		text_fig ?= current_line.last;
		if text_fig /= Void then
			text_fig.append_text (" ")
			text_fig.append_text (count.out)
			text_fig.append_text ("-")
			text_fig.append_text (text_fig.base_left_x.out)
			text_fig.append_text ("width -")
			text_fig.append_text (current_x.out)
		end
	end
end
			text_position := text_position + 1;
			!! current_line.make (Current);
			maximum_width := maximum_width.max (current_x);
			current_x := initial_x_position;
			current_y := current_y + maximum_height_per_line;
			text.extend ('%N');
		end;

	put_classi (e_class: CLASS_I; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		local
			fig: CLASS_TEXT_IMAGE;
			stone: CLASSI_STONE
		do
			!! stone.make (e_class);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_cluster (e_cluster: CLUSTER_I; str: STRING) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		local
			fig: CLUSTER_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, str)
		end;

	put_class (e_class: CLASS_C; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		local
			fig: CLASS_TEXT_IMAGE;
			stone: CLASSC_STONE
		do
			!! stone.make (e_class);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_class_syntax (syn: SYNTAX_ERROR; e_class: CLASS_C; str: STRING) is
			-- Put `address' for `e_class'.
		local
			fig: CLASS_TEXT_IMAGE;
			stone: CL_SYNTAX_STONE
		do
			!! stone.make (syn, e_class);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `address' for `e_class'.
		local
			fig: DEFAULT_TEXT_IMAGE;
			stone: ACE_SYNTAX_STONE
		do
			!! stone.make (syn);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		local
			fig: ERROR_TEXT_IMAGE;
			stone: ERROR_STONE
		do
			!! stone.make (error);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_feature_error (feat: E_FEATURE; str: STRING; a_pos: INTEGER) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		local
			fig: FEATURE_TEXT_IMAGE;
			stone: FEATURE_ERROR_STONE
		do
			!! stone.make (feat, a_pos);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_feature (feat: E_FEATURE; str: STRING) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		local
			fig: FEATURE_TEXT_IMAGE;
			stone: FEATURE_STONE
		do
			!! stone.make (feat);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, str)
		end;

	put_feature_name (f_name: STRING; e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		local
			fig: FEATURE_TEXT_IMAGE;
			stone: FEATURE_NAME_STONE
		do
			!! stone.make (f_name, e_class);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, f_name)
		end;

	put_address (address: STRING; a_name: STRING; e_class: CLASS_C) is
			-- Put `address' with `a_name' for `e_class'.
		local
			fig: OBJECT_TEXT_IMAGE;
			stone: OBJECT_STONE
		do
			!! stone.make (address, a_name, e_class);
			!! fig;
			fig.set_stone (stone);
			add_text_figure (fig, address)
		end;

	put_comment (s: STRING) is
			-- Add comment text `s'.
		local
			fig: COMMENT_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, s);
		end;

	put_symbol (s: STRING) is
			-- Add special text `s'.
		local
			fig: SYMBOL_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, s);
		end;

	put_keyword (s: STRING) is
			-- Add keyword text `s'.
		local
			fig: KEYWORD_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, s);
		end;

	process_indentation (t: INDENT_TEXT) is
			-- Process indentation `t'.
		local
			fig: STRING_TEXT_IMAGE;
			w: INTEGER;
			str: STRING
		do
			str := t.image;
			!! fig;
			fig.set_is_tab;
			w := tab_pixel_length * t.indent_depth;
			fig.set_width (w);
			fig.set_text_info (str, text_position);
			fig.set_base_left (current_x, current_y);
			current_line.extend (fig);

			current_x := w + current_x;
			text.append (str);
			text_position := text_position + str.count
		end;

	put_indent (depth: INTEGER) is
			-- Put indent of depth `d'.
		local
			str: STRING;
			t: INDENT_TEXT
		do
			!! t.make (depth);
			process_indentation (t)
		end;

	put_quoted_comment (s: STRING) is
			-- Add quoted text `s'.
		local
			fig: FEATURE_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, s);
		end;

feature -- Text formatting

	process_basic_text (s: STRING_TEXT) is
			-- Process string text `t'.
		local
			fig: DEFAULT_TEXT_IMAGE
		do
			!! fig;
			add_text_figure (fig, s.image);
		end;

	process_padded is
			-- Process padded value (used when processing breakpoints).
		do
			current_x := padded_width
		end;

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process the quoted `text' within a comment.
		local
			fig: BREAKABLE_FIGURE;
			breakable_stone: BREAKABLE_STONE
		do
			!! breakable_stone.make (a_bp.e_feature, a_bp.index);
			!! fig;
			fig.set_stone (breakable_stone);
			if a_bp.display_number then
				fig.set_foreground_color (stop_color);
				add_text_figure (fig, a_bp.index.out)
			else
				!! fig;
				fig.set_stone (breakable_stone);
				fig.set_text_info ("", text_position);
				fig.set_base_left (0, current_y);
				current_line.extend (fig);
				current_x := padded_width
				update_breakable_figure (fig);
			end
		end;

	process_quoted_text (t: QUOTED_TEXT) is
			-- Process the quoted `text' within a comment.
		do
			put_quoted_comment (t.image_without_quotes);
		end;

	process_column_text (t: COLUMN_TEXT) is
			-- Process `text'.
		local
			column_pos: INTEGER;
			one_space_size: INTEGER
		do
			one_space_size := string_text_font.width_of_string (" ");
			column_pos := (one_space_size * t.column_number) + 
					2*one_space_size;
			if current_x > column_pos then
				current_x := current_x + one_space_size
			else		
				current_x := column_pos
			end;
		end;

	process_call_stack_item (t: CALL_STACK_ITEM) is
			-- Process the current callstack text.
		local
			fig: STRING_TEXT_IMAGE;
			stone: CALL_STACK_STONE;
			ln: INTEGER
		do
			!! fig;
			ln := t.level_number;
			if ln > 0 then
				!! stone.make (ln);
				fig.set_stone (stone)
			end;
			add_text_figure (fig, t.image);
			check
				highlighted_line_is_void: highlighted_line = Void
			end;
			if t.displayed_callstack then
				highlighted_line := current_line;
				highlighted_line.set_is_in_highlighted_line (True);
			end;
		end;

feature -- Removal

	wipe_out is
		do
			current_text := Void;
			current_line := Void
			arrayed_list_wipe_out;
			maximum_width := 0;
			maximum_height_per_line := 0
		ensure then
			reset_size: maximum_width = 0 and then 
					maximum_height_per_line = 0;
			reset: current_text = Void and then
				current_line = Void
		end

feature {TEXT_LINE} -- Implementation

	padded_width: INTEGER is 25;
			-- Padded width

	tab_pixel_length: INTEGER;
			-- Tab length in pixels

	text_position: INTEGER
			-- Current text position

feature {NONE} -- Implementation

	current_x: INTEGER;
			-- Current y value in text

	current_y: INTEGER;
			-- Current y value in text

	initial_x_position: INTEGER is 5;
			-- Initial x position

	add_text_figure (fig: TEXT_FIGURE; s: STRING) is
			-- Add figure `fig' to world. Make sure to
			-- set_text to figure before adding.
		require
			valid_fig: fig /= Void;
			non_void_s: s /= Void;
			valid_current_line: current_line /= Void
		local
			w: INTEGER;
			tp: INTEGER
		do
			tp := text_position;
			text.append (s);
			fig.set_text_info (s, tp);
			fig.set_base_left (current_x, current_y);
			w := fig.font (Current).width_of_string (s);
			fig.set_width (w);
			current_line.extend (fig);
			current_x := current_x + w;
			tp := tp + s.count;
			text_position := tp
		end;

	init_values is
			-- Initialize values for output text. If appropriate values
			-- according to `for_format'.
		do
			maximum_height_per_line :=
					font_max_height;
			maximum_descent_per_line :=
					font_max_descent;
			current_y := maximum_height_per_line + 5;
			text_position := 0;
			cursor_position := 0;
			!! current_line.make (Current)
		end;

	update_breakable_figure (fig: BREAKABLE_FIGURE) is
			-- Update the breakable figure with current execution status information.
		require
			fig_not_void: fig /= Void;
			current_line_has_fig: current_line.has (fig)
		local
			status: APPLICATION_STATUS;
			stone: BREAKABLE_STONE
		do
			stone := fig.stone;
			status := Application.status;
			if
				status /= Void and status.is_stopped and
				status.is_at (stone.body_index, stone.index)
			then
				check
					highlighted_line_is_void: highlighted_line = Void;
				end
				highlighted_line := current_line;
				highlighted_line.set_is_in_highlighted_line (True);
					-- Execution stopped at that point.
				if Application.is_breakpoint_set (stone.routine, stone.index) then
					fig.set_pixmap (Pixmaps.bm_graphical_Stoppoint);
					fig.set_foreground_color (stop_color);
				else
					fig.set_foreground_color (breakable_color);
					fig.set_pixmap (Pixmaps.bm_graphical_Breakablepoint)
				end;
			elseif Application.is_breakpoint_set (stone.routine, stone.index) then
				fig.set_pixmap (Pixmaps.bm_graphical_Stoppoint);
				fig.set_foreground_color (stop_color);
			else
				fig.set_foreground_color (breakable_color);
				fig.set_pixmap (Pixmaps.bm_graphical_Breakablepoint)
			end
		end;

end -- class GRAPHICAL_FIGURES
