indexing

	description:
		"Factorization of graphical characteristics for client-supplier%
		%relation representation (reference or aggregation).";
	date: "$Date$";
	revision: "$Revision $"

deferred class GRAPH_CLIENTELE

inherit

	BASIC_ROUTINES
		undefine
			is_equal
		end

	GRAPH_RELATION
		rename
			from_form as client,
			to_form as supplier
		redefine
			data, link_body, attach_attributes_drawing,
			build_attributes, draw_attributes, erase_attributes,
			make_attributes, recompute_attributes_closure,
			attributes_closure, build_link_body, update_form,
			draw_in_and_update_list, set_color, 
			figure_at
		end

feature -- Abstraction

	data: CLI_SUP_DATA
			-- Link data associated with Current

feature -- Properties

	client: GRAPH_LINKABLE;
			-- Client linkable
		
	supplier: GRAPH_LINKABLE
			-- Supplier linkable

feature -- Graphical properties

	link_body: EC_DOUBLE_LINE
			-- Arrow line figure

	reverse_link_head: EC_ARROW_HEAD
			-- Head of reverse link

	reverse_label: EC_TEXT_FIG
			-- Label for reverse link

	label: EC_TEXT_FIG
			-- Label of current relation

	multiple_rhomb: EC_RHOMB
			-- a Multiplicity capability of current clientele link

	multiple_text: EC_TEXT_FIG
			-- Multiplicity of current clientele link

	reverse_multiple_text: EC_TEXT_FIG
			-- Multiplicity of reverse link

	multiple_bar: EC_SEGMENT
			-- Bar separating 'multiple_text' and 'reverse_multiple_text'

	reverse_erase_label_rectangle: EC_RECTANGLE;

	erase_label_rectangle: EC_RECTANGLE;

	has_label: BOOLEAN is
			-- Does Current have a label?
		do
			Result := not label.text.empty or else
				(reverse_label /= Void and then 
				not reverse_label.text.empty)
		end;

	has_reverse: BOOLEAN is
			-- Has relation's arrow a reverse head ?
		do
			Result := reverse_link_head /= Void
		end; 

feature -- Multiple properties

	is_multiple: BOOLEAN is
			-- Is current relation multiple
		do
			Result := multiple_rhomb /= Void and
				(multiple_text /= Void or
				reverse_multiple_text /= Void)
		end; 

	has_multiplicity: BOOLEAN is
			-- Has current relation a 'multiple_text' ?
		do
			Result := multiple_text /= Void
		end;

	has_reverse_multiplicity: BOOLEAN is	
			-- Has current relation a 'reverse_multiple_text' ?
		do
			Result := reverse_multiple_text /= Void and multiple_bar /= Void
		end;

	multiple_size: INTEGER is
			-- Size of a side of 'multiple_rhomb'
		local
			font: EV_FONT
		once
			font := resources.get_font("link_digit_font")
			Result := font.string_width ("8");
			Result := Result.max (font.ascent + font.descent) + 6
		end

feature -- Access

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		local
			tmp_point: EC_COORD_XY
		do
			if System.show_all_relations or else
				not data.is_implementation
			then
				Result := precursor (x_coord, y_coord);
				if Result = Void then
					if label_at (x_coord, y_coord) /= Void then
						Result := Current
					end
				end
			end;
		end; 

	label_at (x_coord, y_coord: INTEGER): LABEL_DATA is
			-- Label data pointed by `x_coord' and `y_coord'
		local
			p: EC_COORD_XY
		do
			if not system.is_label_hidden then
				!! p;
				p.set (x_coord, y_coord);
				if not label.text.empty then
					if label.closure.contains (p) then
						Result := data.label
					end;
				end;
				if Result = Void and then 
					reverse_label /= Void and then
					not reverse_label.text.empty
				then
					if reverse_label.closure.contains (p) then
						Result := data.reverse_label 
					end
				end
			end;
		end; 

feature -- Output

	invert_label_skeleton (painter: PATCH_PAINTER;
				pt: EC_COORD_XY; is_reverse: BOOLEAN) is	
			-- Draw skeleton of label (`is_reverse indicates
			-- reverse_label else it is the normal label)
			-- on `painter
		do
			if is_reverse then
				reverse_label.draw_on (painter.drawing_i, pt, True)
			else
				label.draw_on (painter.drawing_i, pt, True)
			end;
		end;

	draw_in_and_update_list (clip_closure: EC_CLOSURE;
					list: LINKED_LIST [EC_DOUBLE_LINE]) is
			-- Draw the graphical representation in the analysis window
			-- if in clear area `clip'.
		do
			if (System.show_all_relations or else
					not data.is_implementation) --and then clip_closure.intersects (closure)
			then
				if data.has_shared_break_points then
					list.put_front (link_body)
				end
				draw
			end
		end;

	draw_attributes is
			-- Draw the attributes
		do
			precursor
			if not label.text.empty and then
				not System.is_label_hidden
			then
				label.draw
			end
			if has_reverse then
				reverse_link_head.draw;
				if not reverse_label.text.empty and then
					not System.is_label_hidden 
				then
					reverse_label.draw
				end
			end
			if is_multiple then
				multiple_rhomb.draw;
				if has_multiplicity then
					multiple_text.draw
				end;
				if has_reverse_multiplicity then
					reverse_multiple_text.draw
				end;
				if has_reverse then
					multiple_bar.draw
				end
			end
		end; -- draw_attributes

	erase_label is
		do
			erase_label_rectangle.set_upper_left (label.closure.up_left)
			erase_label_rectangle.set_width (label_width)
			if label.vertical then
				erase_label_rectangle.set_height
							((label.words_count) * label.line_space)
			else
				erase_label_rectangle.set_height (label_height)
			end
			erase_label_rectangle.draw
		end

	erase_reverse_label is
		do
			reverse_erase_label_rectangle.set_upper_left (reverse_label.closure.up_left);
			reverse_erase_label_rectangle.set_width (reverse_label_width);
			reverse_erase_label_rectangle.set_height (reverse_label_height);
			if reverse_label.vertical then
				reverse_erase_label_rectangle.set_height
					((reverse_label.words_count) * reverse_label.line_space);
			else
				reverse_erase_label_rectangle.set_height (reverse_label_height);
			end;
			reverse_erase_label_rectangle.draw
		end;

	erase_attributes is
		do
			precursor
			if not label.text.empty and then
				not System.is_label_hidden
			then
				erase_label
			end;
			if has_reverse then
				reverse_link_head.erase;
				if not reverse_label.text.empty then
					erase_reverse_label
				end
			end;
			if is_multiple then
				multiple_rhomb.erase;
			end
		end; -- erase_attributes

feature -- Element change

	add_reverse_link is
		require
			single_head: not has_reverse
		local
			a_color: EV_COLOR
		do
			a_color := data.color;
			if data.is_reverse_aggregation then
				!EC_BRACKET_HEAD!reverse_link_head.make (from_point,2)
			else
				!EC_TRIANGLE_HEAD!reverse_link_head.make (from_point,2)
			end;
			make_reverse_label;
			reverse_label.attach_drawing (workarea);
		--	reverse_label.set_foreground_color (a_color);
			reverse_link_head.attach_drawing (workarea);
			reverse_link_head.set_color (a_color);
			if is_multiple then
				multiple_rhomb.set_size (multiple_size);
				!! multiple_bar.make;
				multiple_bar.attach_drawing(workarea);
		--		multiple_bar.path.set_foreground_color (a_color);
			end;
			recompute_reverse_label_closure
		ensure
			double_head: has_reverse
		end; -- add_reverse_link

	add_multiplicity (reverse_side: BOOLEAN) is
			-- Add multiplicity to current relation
		require
			is_not_multiple: multiple_rhomb = Void or
					not (has_multiplicity and
						has_reverse_multiplicity)
		local
			a_color: EV_COLOR
		do
			a_color := data.color;
			if reverse_side then
				make_reverse_multiple;
				reverse_multiple_text.attach_drawing (workarea);
		--		reverse_multiple_text.set_foreground_color (a_color);
			else
				make_multiple;
				multiple_text.attach_drawing (workarea)
		--		multiple_text.set_foreground_color (a_color);
			end;
			if not (data.multiplicity /= 0 and
			data.reverse_multiplicity /= 0)
			then
				multiple_rhomb.attach_drawing (workarea);
				multiple_rhomb.set_color (a_color);
				if has_reverse then
					multiple_bar.attach_drawing (workarea);
		--			multiple_bar.path.set_foreground_color (a_color);
				end
			end
		ensure
			is_multiple: is_multiple
		end; -- add_multiplicity

	change_label is
			-- Change label's text, and redisplay it.
		do
			if not label.text.empty then
				workarea.to_refresh.merge (label.closure);
				erase_label;
			end;
			label.set_text (data.label.output_value);
			if not label.text.empty then
				build_label;
				recompute_label_closure;
				workarea.to_refresh.merge (label.closure);
				closure.merge (label.closure)
			end
		end; -- change_label

	change_label_position is
		do
			if not label.text.empty then
				workarea.to_refresh.merge (label.closure);
				erase_label;
				build_label;
				recompute_label_closure;
				workarea.to_refresh.merge (label.closure);
				closure.merge (label.closure)
			end
		end; -- change_label_position

	change_label_orientation is
		do
			if not label.text.empty then
				workarea.to_refresh.merge (label.closure);
				erase_label;
				build_label;
				recompute_label_closure;
				workarea.to_refresh.merge (label.closure);
				closure.merge (label.closure)
			end
		end -- change_label_orientation

	change_reverse_label is
		do
			if not reverse_label.text.empty then
				workarea.to_refresh.merge (reverse_label.closure)
				erase_reverse_label
			end;
			reverse_label.set_text (data.reverse_label.output_value);
			if not reverse_label.text.empty then 
				build_reverse_label;
				recompute_reverse_label_closure;
				workarea.to_refresh.merge (reverse_label.closure);
				closure.merge (reverse_label.closure);
			end
		end; -- change_reverse_label


	change_multiplicity (reverse_side: BOOLEAN) is
			-- Change the multiplicity of current relation
		require
			is_multiple: is_multiple
		do
			if reverse_side then
				multiple_rhomb.erase;
				if data.reverse_multiplicity <= 9 then
					reverse_multiple_text.set_text
							(data.reverse_multiplicity.out)
				else
					reverse_multiple_text.set_text ("i")
			end;
			multiple_rhomb.draw;
			reverse_multiple_text.draw;
				if has_multiplicity then
					multiple_text.draw;
				end
			else
				multiple_rhomb.erase;
				if data.multiplicity <= 9 then
					multiple_text.set_text (data.multiplicity.out)
				else
					multiple_text.set_text ("i")
				end;
				multiple_rhomb.draw;
				multiple_text.draw;
				if has_reverse_multiplicity then
					reverse_multiple_text.draw;
				end
			end;
			if has_reverse then
				multiple_bar.draw
			end
		ensure
			is_multiple: is_multiple
		end; -- change_multiplicity

	change_reverse_label_position is
		do
			if not reverse_label.text.empty then 
				workarea.to_refresh.merge (reverse_label.closure);
				erase_reverse_label;
				build_reverse_label;
				recompute_reverse_label_closure;
				workarea.to_refresh.merge (reverse_label.closure);
				closure.merge (reverse_label.closure);
			end
		end; -- change_reverse_label_position

	change_reverse_label_orientation is
		do
			if not reverse_label.text.empty then 
				workarea.to_refresh.merge (reverse_label.closure);
				erase_reverse_label;
				build_reverse_label;
				recompute_reverse_label_closure;
				workarea.to_refresh.merge (reverse_label.closure);
				closure.merge (reverse_label.closure);
			end
		end; -- change_reverse_label_orientation

	reverse_label_width, reverse_label_height: INTEGER
	reverse_ascent: INTEGER;

feature -- Removal

	remove_reverse_link is
		require
			double_head: has_reverse
		do
			reverse_label.set_text ("");
			reverse_link_head := Void;
			if is_multiple then
				multiple_bar := Void
			end
		ensure
			single_head: not has_reverse
		end; -- remove_reverse_link

	remove_multiplicity (reverse_side: BOOLEAN) is
			-- Remove multiplicity of current relation
		require
			is_multiple: is_multiple
		do
			if reverse_side then
				reverse_multiple_text := Void
			else
				multiple_text := Void
			end;
			if not (has_multiplicity or has_reverse_multiplicity) then
				multiple_rhomb := Void;
				if has_reverse then
					multiple_bar := Void
				end
			end
		ensure
			is_not_completely_multiple: not (has_multiplicity and
							has_reverse_multiplicity)
		end; 

feature 

	attach_attributes_drawing (a_drawing: EV_DRAWABLE) is
		do
			precursor (a_drawing);
			label.attach_drawing (a_drawing);
			if has_reverse then
				reverse_link_head.attach_drawing (a_drawing);
				reverse_label.attach_drawing (a_drawing)
			end;
			if is_multiple then
				multiple_rhomb.attach_drawing (a_drawing);
				if has_multiplicity then
					multiple_text.attach_drawing (a_drawing)
				end;
				if has_reverse_multiplicity then
					reverse_multiple_text.attach_drawing (a_drawing)
				end;
				if has_reverse then
					multiple_bar.attach_drawing (a_drawing)
				end
			end
		end; -- attach_attributes_drawing

	recompute_attributes_closure is
		do
			precursor
			if not label.text.empty then
				recompute_label_closure
			end;
			if has_reverse then
				reverse_link_head.recompute_closure;
				recompute_reverse_label_closure
			end;
			if is_multiple then
				multiple_rhomb.recompute_closure;
			end;
		end; -- recompute_attributes_closure

	attributes_closure: EC_CLOSURE is
		do
			Result := precursor
			if not label.text.empty then
				Result.merge (label.closure);
			end;
			if has_reverse then
				Result.merge (reverse_link_head.closure);
				Result.merge (reverse_label.closure)
			end;
			if is_multiple then
				Result.merge (multiple_rhomb.closure);
			end
		end; -- attributes_closure

	make_attributes is
		do
			precursor
			make_label;
			if data.is_reverse_aggregation then
				!EC_BRACKET_HEAD!reverse_link_head.make (from_point,2);
				make_reverse_label
			elseif data.is_reverse_link then
				!EC_TRIANGLE_HEAD!reverse_link_head.make (from_point,2);
				make_reverse_label
			end;
			if data.multiplicity /= 0 then
				make_multiple
			end;
			if data.reverse_multiplicity /= 0 then
				make_reverse_multiple
			end
		end; -- make_attributes

	build_attributes is
		do
			precursor
			if not label.text.empty then
				build_label
			end;
			if has_reverse then
				reverse_link_head.build (start,
						link_body.points.i_th (2));
				if not reverse_label.text.empty then
					build_reverse_label
				end
			end;
			if is_multiple then
				build_multiple_rhomb;
				if has_multiplicity then
					build_multiple_text
				end;
				if has_reverse_multiplicity then
					build_reverse_multiple_text
				end;
				if has_reverse then
					build_multiple_bar
				end
			end
		end; -- build_attributes

	build_link_body is
		local
			new_point: EC_COORD_XY
		do
			precursor
			if has_reverse then
				new_point := reverse_link_head.base
						(link_body.points.i_th (2), start);
				start.set (new_point.x, new_point.y)
			end
		end; -- build_link_body

	update_form is
		do
			if has_reverse then
				reverse_label.set_text (data.reverse_label.output_value)
			end;
			label.set_text (data.label.output_value);
			precursor
		end

feature

	make_link_head is
		deferred
		end -- make_link_head

feature 

	closest_points (ptx, pty: INTEGER; is_reverse: BOOLEAN): ARRAYED_LIST [EC_COORD_XY] is
			-- Closest points to pts and pty.
			-- Result is ordered on order of consective handles
			-- from the source figure.
			-- (Three points returned means ambigous case)
		local
			h: EC_COORD_XY;
			d_before, d_after: INTEGER;
			first_pt, second_pt: EC_COORD_XY;
			d: INTEGER;
			closest_i, closest_d: INTEGER
		do
			if handles.count = 2 then
				if is_reverse then
					first_pt := supplier_point
					second_pt := client_point
				else
					first_pt := client_point
					second_pt := supplier_point
				end;
				!! Result.make (2);
				Result.extend (first_pt);
				Result.extend (second_pt);
			else
				from
					handles.start
				until
					handles.after
				loop
					h := handles.item;
					d := (h.x - ptx) * (h.x - ptx) + 
							(h.y - pty) * (h.y - pty);
					if d < closest_d or else closest_d = 0 then
						closest_d := d;
						closest_i := handles.index
					end;
					handles.forth
				end;
				if closest_i = 1 then
					if is_reverse then
						first_pt := handles.i_th (2)
						second_pt := client_point;
					else
						first_pt := client_point;
						second_pt := handles.i_th (2)
					end;
					!! Result.make (2);
					Result.extend (first_pt);
					Result.extend (second_pt);
				elseif closest_i = handles.count then
					if is_reverse then
						first_pt := supplier_point
						second_pt := handles.i_th (closest_i - 1);
					else
						first_pt := handles.i_th (closest_i - 1);
						second_pt := supplier_point
					end;
					!! Result.make (2);
					Result.extend (first_pt);
					Result.extend (second_pt);
				else
					!! Result.make (3);
					if is_reverse then
						if closest_i + 1 = handles.count then
							Result.extend (supplier_point)
						else
							Result.extend (handles.i_th (closest_i + 1));
						end
						Result.extend (handles.i_th (closest_i));
						if closest_i - 1 = 1 then
							Result.extend (client_point)
						else
							Result.extend (handles.i_th (closest_i - 1));
						end;
					else
						if closest_i - 1 = 1 then
							Result.extend (client_point)
						else
							Result.extend (handles.i_th (closest_i - 1));
						end;
						Result.extend (handles.i_th (closest_i));
						if closest_i + 1 = handles.count then
							Result.extend (supplier_point)
						else
							Result.extend (handles.i_th (closest_i + 1));
						end;
					end
				end
			end;
		ensure
			at_least_two_or_three: Result.count = 2 or else
						Result.count = 3;
			
		end;

feature {NONE}

	make_multiple is
			-- Make the multiple attributes (rhomb & text - & bar -)
		do
			if not is_multiple then
				!! multiple_rhomb.make (multiple_size);
				if has_reverse then
					!! multiple_bar.make
				end
			end;
			!! multiple_text.make;
			if data.multiplicity <= 9 then
				multiple_text.set_text (data.multiplicity.out)
			else
				multiple_text.set_text ("i")
			end;
			multiple_text.set_font (resources.get_font("link_digit_font"))
		end

	make_reverse_multiple is
			-- Make the multiple attributes (rhomb & text - & bar -)
		do
			if not is_multiple then
				!! multiple_rhomb.make (multiple_size);
				if has_reverse then
					!!multiple_bar.make
				end
			end;
			!! reverse_multiple_text.make;
			if data.reverse_multiplicity <= 9 then
				reverse_multiple_text.set_text
							(data.reverse_multiplicity.out)
			else
				reverse_multiple_text.set_text ("i")
			end;
			reverse_multiple_text.set_font (resources.get_font("link_digit_font"))
		end; -- make_reverse_multiple

	build_multiple_rhomb is
			-- Build 'multiple_rhomb'
		local
			new_center: EC_COORD_XY;
			pts: LINKED_LIST [EC_COORD_XY]
		do
			pts := link_body.points;
			pts.finish;
			pts.back;
			new_center := (pts.item + link_body.final) // 2;
			multiple_rhomb.set_center (new_center);
			multiple_rhomb.build
		end; -- build_multiple_rhomb

	build_multiple_text is
			-- Build multiplicity number in 'multiple_rhomb'
		local
			width, height: INTEGER
			rel_x, rel_y: INTEGER
			font: EV_FONT
		do
			font := resources.get_font("link_digit_font")
			rel_x := link_body.points.i_th (link_body.points.count - 1).x -
				final.x;
			rel_y := link_body.points.i_th (link_body.points.count - 1).y -
				final.y;
			width := font.string_width (multiple_text.text);
			height := font.ascent + font.descent
			if has_reverse then
				if rel_x < 0 then
					multiple_text.base_left.set
						(multiple_rhomb.center.x + 2,
						multiple_rhomb.center.y +
						(height // 2) - 1)
				elseif rel_x > 0 then
					multiple_text.base_left.set
						(multiple_rhomb.center.x - width,
						multiple_rhomb.center.y +
						(height // 2) - 1)
				elseif rel_y > 0 then
					multiple_text.base_left.set
						(multiple_rhomb.center.x -
						(width // 2) + 1,
						multiple_rhomb.center.y - 1)
				else
					multiple_text.base_left.set
						(multiple_rhomb.center.x -
						(width // 2) + 1,
						multiple_rhomb.center.y +
						(height // 2) + 3)
				end
			else
				multiple_text.base_left.set (multiple_rhomb.center.x -
						(width // 2) + 1,
						multiple_rhomb.center.y +
						(height // 2) - 1)
			end
		end; -- build_multiple_text
			
	build_reverse_multiple_text is
			-- Build multiplicity number in 'multiple_rhomb' in right side
		local
			width, height: INTEGER
			rel_x, rel_y: INTEGER
			font: EV_FONT
		do
			font := resources.get_font("link_digit_font")
			rel_x := link_body.points.i_th (2).x - start.x;
			rel_y := link_body.points.i_th (2).y - start.y;
			width := font.string_width (reverse_multiple_text.text);
			height := font.ascent + font.descent
			if rel_x < 0 then
				reverse_multiple_text.base_left.set
						(multiple_rhomb.center.x + 2,
						multiple_rhomb.center.y +
						(height // 2) - 1)
			elseif rel_x > 0 then
				reverse_multiple_text.base_left.set
						(multiple_rhomb.center.x - width,
						multiple_rhomb.center.y +
						(height // 2) - 1)
			elseif rel_y > 0 then
				reverse_multiple_text.base_left.set
						(multiple_rhomb.center.x -
						(width // 2) + 1,
						multiple_rhomb.center.y - 1)
			else
				reverse_multiple_text.base_left.set
						(multiple_rhomb.center.x -
						(width // 2) + 1,
						multiple_rhomb.center.y +
						(height // 2) + 3)
			end
		end; -- build_reverse_multiple_text

	build_multiple_bar is
			-- Build the bar separating the multiple rhomb
		local
			rel_x: INTEGER
		do
			rel_x := link_body.points.i_th (link_body.points.count - 1).x -
				final.x;
			if rel_x = 0 then
					-- Bar is horizontal
				multiple_bar.start.set (multiple_rhomb.points.i_th (1).x,
						multiple_rhomb.points.i_th (1).y);
				multiple_bar.final.set (multiple_rhomb.points.i_th (3).x,
						multiple_rhomb.points.i_th (3).y)
			else
					-- Bar is vertical
				multiple_bar.start.set (multiple_rhomb.points.i_th (2).x,
						multiple_rhomb.points.i_th (2).y);
				multiple_bar.final.set (multiple_rhomb.points.i_th (4).x,
						multiple_rhomb.points.i_th (4).y)
			end
		end -- build_multiple_bar
			

	set_color is
		local
			a_color: EV_COLOR
		do
			a_color := data.color;
			precursor
		--	label.set_foreground_color (a_color);
			if has_reverse then
				reverse_link_head.set_color (a_color);
		--		reverse_label.set_foreground_color (a_color)
			end;
			if is_multiple then
				multiple_rhomb.set_color (a_color)
				if has_multiplicity then
				--	multiple_text.set_foreground_color (a_color)
				end;
				if has_reverse_multiplicity then
			--		reverse_multiple_text.set_foreground_color (a_color)
				end;
				if has_reverse then
			--		multiple_bar.path.set_foreground_color (a_color)
				end
			end;
		end;

	make_reverse_label is
		local
			font: EV_FONT
		do
			font := resources.get_font("link_label_font")
			reverse_ascent := font.ascent
			reverse_label_height := reverse_ascent + font.descent;
			!! reverse_label.make;
			reverse_label.set_text (data.reverse_label.output_value)
			reverse_label.set_font (font)
			reverse_label.set_line_space (Resources.link_label_space *
							(reverse_label_height // 2))
			reverse_label.set_separator (',')
		end; -- make_reverse_label

	recompute_label_closure is
		local
			height: INTEGER;
			interior: EC_INTERIOR
		do
			if erase_label_rectangle = Void then
				!! interior.make
				interior.set_foreground_color (Resources.get_color("drawing_background_color"))
				!! erase_label_rectangle.make
				erase_label_rectangle.path.set_foreground_color
					(Resources.get_color("drawing_background_color"))
				erase_label_rectangle.set_interior (interior)
				erase_label_rectangle.attach_drawing (workarea)
			end
			if data.is_vertical_text then
				height := (label.words_count) * label.line_space;
			else
				height := label_height;
			end
			label.closure.set (label.base_left.x - 2 , label.base_left.y
							- ascent,
							label_width + 4, height);
		end; -- recompute_label_closure

	label_width, label_height: INTEGER
	ascent: INTEGER;

	build_reverse_label is
			-- Build the position of current relation's reverse label
		require
			valid_label: not reverse_label.text.empty;
		local
			rel_from_pt, rel_to_pt: EC_COORD_XY;
			label_data: LABEL_DATA;
			label_figure: like reverse_label;
			base_left: EC_COORD_XY;
		do
			label_data := data.reverse_label;
			label_figure := reverse_label;
					-- Reverse order of handle nbr
			if data.reverse_from_handle_nbr = handles.count then
				rel_from_pt := supplier_point
			else
				rel_from_pt := handles.i_th (data.reverse_from_handle_nbr);
			end;
			if data.reverse_to_handle_nbr = 1 then
				rel_to_pt := client_point
			else
				rel_to_pt := handles.i_th (data.reverse_to_handle_nbr);
			end;
			label_figure.set_verticality (data.is_reverse_vertical_text);
			if label_figure.vertical then
				label_figure.set_words (label_data.words);
			end;
			reverse_label_width := resources.get_font("link_label_font").string_width (label_figure.longest_word);
			base_left := compute_label_coord (True, 
				data.is_reverse_left_position, 
				rel_from_pt, rel_to_pt, data.reverse_label.from_ratio);
			label_figure.set_base_left (base_left.x, base_left.y);
		end; -- build_reverse_label

	recompute_reverse_label_closure is
		local
			height: INTEGER;
			interior: EC_INTERIOR
		do
			if reverse_erase_label_rectangle = Void then
				!! interior.make;
			--	interior.set_foreground_color (Resources.drawing_bg_color);
				!! reverse_erase_label_rectangle.make;
			--	reverse_erase_label_rectangle.path.set_foreground_color
			--		(Resources.drawing_bg_color);
				reverse_erase_label_rectangle.set_interior (interior);
				reverse_erase_label_rectangle.attach_drawing (workarea);
			end
			if data.is_reverse_vertical_text then
				height := (reverse_label.words_count) * reverse_label.line_space
			else
				height := reverse_label_height;
			end;
			reverse_label.closure.set (reverse_label.base_left.x - 2, 
							reverse_label.base_left.y - reverse_ascent,
							reverse_label_width + 4, height);
		end; -- recompute_reverse_label_closure

feature {NONE, WORKAREA_MOVE_LABEL_COM} -- Implementation

	make_label is
			-- Make the label of current relation
		local
			font: EV_FONT
		do
			font := resources.get_font("link_label_font")
			ascent := font.ascent
			label_height := ascent + font.descent
			!! label.make
			label.set_text (data.label.output_value)
			label.set_font (Resources.get_font("link_label_font"))
			label.set_line_space (Resources.link_label_space *
						(label_height // 2))
			label.set_separator (',')
			observer_management.add_observer(data.label,Current)
		end; -- make_label

	build_label is
			-- Build label for Current link.
		local
			rel_from_pt, rel_to_pt: EC_COORD_XY;
			label_data: LABEL_DATA;
			label_figure: like label;
			base_left: EC_COORD_XY;
			handles_c: INTEGER
		do
			label_data := data.label;
			label_figure := label;
			handles_c := handles.count;
			if label_data.from_handle_nbr = 1 then
				rel_from_pt := client_point
			else
				rel_from_pt := handles.i_th (label_data.from_handle_nbr);
			end;
			if label_data.to_handle_nbr = handles.count then
				rel_to_pt := supplier_point
			else
				rel_to_pt := handles.i_th (label_data.to_handle_nbr);
			end;
			-- pascalf, bug reported by loryn : crashed if too many view of one link ...
			if rel_to_pt = Void then
				rel_to_pt := supplier_point
			end
			label_figure.set_verticality (data.is_vertical_text);
			if label_figure.vertical then
				label_figure.set_words (label_data.words);
			end;
			label_width := resources.get_font("link_label_font").string_width (label_figure.longest_word);
			base_left := compute_label_coord (False, 
						data.is_left_position, 
						rel_from_pt, rel_to_pt, label_data.from_ratio)
			label_figure.set_base_left (base_left.x, base_left.y);
		end;

	compute_label_coord (is_reverse, left_side: BOOLEAN; 
					rel_from_pt, rel_to_pt: EC_COORD_XY;
					ratio: REAL): EC_COORD_XY is
			-- Compute label base_left coord according
			-- to the arguments specification.
			-- `left_side' is the visual position of label.
		require
			valid_pts: rel_from_pt /= Void and then
							rel_to_pt /= Void;
			valid_reverse_label: is_reverse implies reverse_label /= Void
			valid_label: not is_reverse implies label /= Void
		local
			label_x, label_y, rel_x, rel_y: INTEGER;
			pt: CELL2 [INTEGER, INTEGER]
		do
				-- Under X, setting base left for a text
				-- doesn't really set it to that location.
				-- We need an offset to put it at the right 
				-- position.
			!! Result;
			rel_x := (rel_to_pt.x - rel_from_pt.x);
			rel_y := (rel_to_pt.y - rel_from_pt.y);
			label_x := ((rel_x * ratio).truncated_to_integer)
						+ rel_from_pt.x; -- an approximation
			label_y := ((rel_y * ratio).truncated_to_integer)
						+ rel_from_pt.y; -- an approximation
			pt := calcualate_offsets (rel_from_pt, rel_to_pt, 
						left_side, is_reverse)
			label_x := label_x + pt.item1;
			label_y := label_y + pt.item2;
			Result.set (label_x, label_y)
		end; 

	calcualate_offsets (rel_from_pt, 
				rel_to_pt: EC_COORD_XY; 
				left_side: BOOLEAN;
				is_reverse: BOOLEAN): CELL2 [INTEGER, INTEGER] is
			-- Calculate y offset for coordinates `rel_to_pt'
			-- and `rel_from_pt'
		require
			valid_pts: rel_to_pt /= Void and then rel_from_pt /= Void
		local
			rel_x, rel_y: INTEGER;
			x_offset, y_offset: INTEGER;
			additional_height, l_width, l_height: INTEGER;
			label_figure: like label;
			offset, x_diff, y_diff: INTEGER;
			label_data: LABEL_DATA
		do
			if is_reverse then
				label_data := data.reverse_label;
				label_figure := reverse_label;
				l_width := reverse_label_width;
				l_height := reverse_label_height;
			else
				label_data := data.label;
				label_figure := label;
				l_width := label_width;
				l_height := label_height
			end;
			if label_figure.vertical then
				additional_height := (label_figure.words_count - 1)
								* label_figure.line_space
			end;
			offset := 6;
			x_offset := label_data.x_offset;
			y_offset := label_data.y_offset;
			rel_x := (rel_to_pt.x - rel_from_pt.x);
			rel_y := (rel_to_pt.y - rel_from_pt.y);
					-- Ordered as:
					-- 4th / 1st
					-- 3rd / 2nd (Quadrants
			if (rel_x > 0) and (rel_y < 0) then
					-- 1st quad 
				if left_side then
					x_diff := - l_width - x_offset;
					y_diff := - offset - y_offset - additional_height;
				else
					x_diff := x_offset + offset
					y_diff := l_height + y_offset
				end
			elseif (rel_x > 0) and (rel_y > 0) then
					-- 2nd quad 
				if left_side then
					x_diff := - l_width - x_offset;
					y_diff := y_offset + offset;
				else
					x_diff := x_offset + offset;
					y_diff := - y_offset - offset - additional_height;
				end
			elseif (rel_x < 0) and (rel_y > 0) then
					-- 3rd quad
				if left_side then
					x_diff := - x_offset - l_width;
					y_diff := - y_offset - offset - additional_height;
				else
					x_diff := x_offset;
					y_diff := l_height + y_offset;
				end
			elseif (rel_x < 0) and (rel_y < 0) then
					-- 4th quad 
				if left_side then
					x_diff := - l_width - x_offset;
					y_diff := l_height + y_offset;
				else
					x_diff := x_offset + offset;
					y_diff := - offset - y_offset - additional_height;
				end
			elseif (rel_x = 0) then
					-- Vertical
				if left_side then	
						-- top side or bottom side
					x_diff := - x_offset - l_width;
					y_diff := - additional_height - y_offset
				else
						-- top side or bottom side
					x_diff := x_offset + offset;
					y_diff := - y_offset - additional_height
				end
			elseif (rel_y = 0) then
					-- Horizontal
				if left_side then	
					x_diff := - l_width - x_offset;
					if rel_x > 0 then
							-- right side
						y_diff := - y_offset - offset - additional_height
					else
							-- left side
						y_diff := y_offset + l_height
					end
				else
					x_diff := x_offset;
					if rel_x > 0 then
							-- right side
						y_diff := l_height + y_offset
					else
							-- left side
						y_diff := - y_offset - offset - additional_height
					end
				end
			end
			!! Result.make (x_diff, y_diff)
		end;

	client_point: EC_COORD_XY is
			-- Client point
			-- (if client is cluster then its the last
			-- point else it is the center).
		do
			if client.data.is_cluster then
				Result := handles.first
			else
				Result := client.center
			end
		ensure
			Result = handles.last implies client.data.is_cluster;
			Result = client.center implies not client.data.is_cluster
		end;

	supplier_point: EC_COORD_XY is
			-- Supplier point
			-- (if supplier is cluster then its the last
			-- point else it is the center).
		do
			if supplier.data.is_cluster then
				Result := handles.last
			else
				Result := supplier.center
			end
		ensure
			Result = handles.last implies supplier.data.is_cluster;
			Result = supplier.center implies not supplier.data.is_cluster
		end

invariant

	has_label: label /= Void

end -- GRAPH_CLIENTELE
