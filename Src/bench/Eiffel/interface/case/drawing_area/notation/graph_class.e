indexing

	description: 
		"Graphical representation of a class.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_CLASS

inherit
 
	GRAPH_LINKABLE
		rename
			title as class_name
		redefine
			data,select_it,unselect
		end

	SINGLE_MATH
		undefine
			is_equal
		end

	CLASS_CONST
		undefine
			is_equal
		end

creation

	make

feature {NONE} -- Initialization

	make (a_class: CLASS_DATA; graph_group: GRAPH_GROUP) is
			-- Create Current with a_class as link.
		require
			a_class_exists: a_class /= Void
			graph_group_exists: graph_group /= Void
		local
			picture: EC_PICTURE
			i: INTEGER
			interior: EC_INTERIOR
		do
			data := a_class
			observer_management.add_observer(data,Current)
			data.set_color_name (resources.class_interior_color.name)
			parent_group := graph_group;
		
			!!ellipse.make
			center := ellipse.origin;
			parent_group.class_list.add_form (Current);
			!!root_ellipse.make;
			!!segment.make;
			!!signs.make (1, 5);
			from
				i := 1
			until
				i > 5
			loop
				!!picture.make;
				signs.put (picture, i);
				picture.set_foreground_color (Resources.class_color);
				i := i+1
			end;
			!!class_name.make
			observer_management.add_observer(data,class_name)
			class_name.set_text (data.name)
			class_name.set_font (Resources.class_name_font);
			!! generic_param.make;
			build_generics_text;
			generic_param.set_font (Resources.generic_font);

			ellipse.path.set_foreground_color (Resources.class_color);
			!! interior.make;
			ellipse.set_interior (interior);

			!!erase_ellipse.make;
			erase_ellipse.path.set_foreground_color (Resources.drawing_bg_color);
			erase_ellipse.set_interior (Resources.background_interior);

			!! rectangle.make
			rectangle.set_interior (interior) -- ( bottom_right )
			!! erase_rectangle.make
			erase_rectangle.path.set_foreground_color ( Resources.drawing_bg_color)
			erase_rectangle.set_interior ( Resources.background_interior )

			set_unselected_style
			attach_workarea (graph_group.workarea)
			build;
			update_clip_area;
		ensure
			data_set: data = a_class
		end -- make

feature -- Properties

	data: CLASS_DATA
			-- Entity corresponding to this graphical unit

	order: INTEGER is 2
			-- Precedence of 'Current' as graphical entity

feature -- Graphical properties

	ellipse: EC_ELLIPSE
			-- Main ellipse

	rectangle , erase_rectangle: EC_RECTANGLE
			-- rectangle

	closure: EC_CLOSURE is
			-- Ellipse's closure
		do
			Result := erase_ellipse.closure
		end -- closure

	upper_left: EC_COORD_XY is
			-- figure upper left point.
		do
			!!Result;
			Result.set (center.x - ellipse.radius1, center.y -
				ellipse.radius2)
		end; -- upper_left

	bottom_right: EC_COORD_XY is
			-- figure bottom right point.
		do
			!!Result;
			Result.set (center.x + ellipse.radius1, center.y +
				ellipse.radius2)
		end; -- bottom_right

	origin: EC_COORD_XY is
			-- Origin of the class.
		do
			Result := ellipse.origin
		end 

feature -- Setting

	attach_workarea (a_workarea: WORKAREA) is
			-- Attach a workarea to the figure
		do
			workarea := a_workarea;
			attach_drawing (a_workarea)
		ensure then
			a_workarea = workarea
		end; 

feature -- Access

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		local
			p: EC_COORD_XY
		do
			!!p;
			p.set (x_coord, y_coord);
			if ellipse.contains(p) then
				Result := Current
			end
		end 

feature -- Removal

	destroy_without_clip_update is
			-- Destroy this and all its links.
		do
			destroy_links_in (workarea.aggreg_list);
			destroy_links_in (workarea.cli_sup_list);
			destroy_links_in (workarea.inherit_list);
			deselect_links
		end; -- destroy

feature -- Update

	update_form is
			-- Update the class according to the content of
			-- the entity.
		local
			new_group: GRAPH_GROUP
		do
			if parent_group.data /= data.parent_cluster then
				parent_group.class_list.remove_form (Current);
				new_group := workarea.find_graph_group (data.parent_cluster);
				if new_group /= Void then
					parent_group := new_group;
					new_group.class_list.add_form (Current)
				end
			end;
			class_name.set_text (data.name);
			build_generics_text;
			build
		end; -- update_form

feature -- Output

	draw is
			-- Draw the class in analysis view.
		local
			i: INTEGER
		do
			if system.uml_layout then
					rectangle.draw
			else
				ellipse.draw
			end
			if data.is_reused then
				segment.draw
			end;
			class_name.draw;
			from
				i := 1
			until
				i > total_symb_nb
			loop
				signs.item (i).draw;
				i := i+1
			end;
			if data.is_root and then not system.uml_layout then
				root_ellipse.draw
			end;
			if not generic_param.text.empty then
				generic_param.draw
			end
		end;

	draw_border is
			-- draw the border of current class
		local
			ellipse_interior: EC_INTERIOR
		do
			ellipse_interior := ellipse.interior;
			ellipse.set_interior (Void);
			rectangle.set_interior ( Void )
			if system.uml_layout then
					rectangle.draw
			else
				ellipse.draw
			end
			rectangle.set_interior ( ellipse_interior )
			ellipse.set_interior (ellipse_interior)
		end; -- draw_border

	erase_drawing is
			-- Erase current figure
		do
			if System.uml_layout then
				erase_rectangle.draw
			else
				erase_ellipse.draw
			end
		end

	select_it is
			-- Set `selected' to true.
			-- Add this figure in `workarea.selected_figures'.
			-- Draw this figure.
		do
			set_selected_style
			precursor
		end

	unselect is
			-- Set `selected' to false.
			-- Remove this figure in `workarea.selected_figures'.
			-- Draw this figure.
		do
			set_unselected_style
			precursor
		end

	invert_skeleton (painter: PATCH_PAINTER; relative_x, relative_y: INTEGER) is
			-- Invert the class's skeleton.
			-- Draw on `painter' as if the origin is at
			-- (`origin_x', `origin_y').
		local
			origin_x, origin_y: INTEGER
		do
			origin_x := align_grid (local_x+relative_x)
			origin_y := align_grid (local_y+relative_y)
			if system.uml_layout then
				painter.draw_rectangle (origin_x - (rectangle.width//2) ,
						 origin_y - (rectangle.height//2), 
						rectangle.width, rectangle.height ) 
			else
				painter.draw_arc (origin_x, origin_y,
					ellipse.radius1, ellipse.radius2, 0, 360, 0)
				painter.draw_arc (origin_x, origin_y,
					2, 2, 0, 360, 0)
			end
		end 

feature {NONE} -- Implementation properties

	root_ellipse: EC_ELLIPSE;
			-- Ellipse which symbolize the root class

	signs: ARRAY [EC_PICTURE];
			-- Little bitmaps in the class

	segment: EC_SEGMENT;
			-- Segment which indicate if the class is reused

	class_name: EC_TEXT_FIG
			-- Text to write the class name

	generic_param: EC_TEXT_FIG;
			-- List of generic parameters

	erase_ellipse: EC_ELLIPSE;
			-- Ellipse to erase the class

	total_symb_nb: INTEGER;
			-- Total number of symbols

	symbols: ARRAY [EV_PIXMAP] is
			-- Pixmaps (abstract, actual, ...).
		local
			pix: EV_PIXMAP;
		once
			!!Result.make (1, 5);
			Result.put (Pixmaps.circle_pixmap, circle_position);
			Result.put (Pixmaps.star_pixmap, star_position);
			Result.put (Pixmaps.triangle_pixmap, triangle_position);
			Result.put (Pixmaps.square_pixmap, square_position);
			Result.put (Pixmaps.plus_pixmap, plus_position)
		end

	class_text_height: INTEGER is
			-- Height of class text
		do
			Result := Resources.class_name_font.ascent
				+ Resources.class_name_font.descent
		end

	class_text_width: INTEGER is
			-- Width of class text
		do
			Result := Resources.class_name_font.string_width (class_name.text)
		end

	generic_text_height: INTEGER is
			-- Height of generic text
		do
			Result := Resources.generic_font.ascent
				+ Resources.generic_font.descent
		end

	generic_text_width: INTEGER is
			-- Width of generic text
		do
			Result := Resources.generic_font.string_width (generic_param.text)
		end

feature {NONE} -- Implementation

	set_symbol (b: BOOLEAN; pos: INTEGER) is
			-- If `b' is true, increment `total_symb_nb',
			-- and make the next signs representing the `pos'-th symbol.
		local
			p: EV_PIXMAP
		do
-- 			if b then
-- 				p := symbols.item (pos);
-- 			--	if p.is_valid then
-- 					total_symb_nb := total_symb_nb+1;
-- 					signs.item (total_symb_nb).set_pixmap (p);
-- 					signs.item (total_symb_nb).upper_left.set_y
-- 						(-class_text_height-
-- 						Resources.class_symbols_offset-
-- 						bitmap_height);
-- 			--	end
--			end
		end 

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a drawing to the figure
		require
			drawing_exists: a_drawing /= Void
		local
			i: INTEGER
		do
			segment.attach_drawing (a_drawing);
			class_name.attach_drawing (a_drawing);
			generic_param.attach_drawing (a_drawing);
			ellipse.attach_drawing (a_drawing);
			rectangle.attach_drawing ( a_drawing)
			root_ellipse.attach_drawing (a_drawing);
			from
				i := 1
			until
				i > 5
			loop
				signs.item (i).attach_drawing (a_drawing);
				i := i+1
			end;

			erase_rectangle.attach_drawing (a_drawing)
			erase_ellipse.attach_drawing (a_drawing)
		end;

	build_generics_text is
			-- build text corresponding to generic parameters of
			-- current class
		do
			if data.generics.empty then
				generic_param.set_text ("")
			else
				generic_param.set_text (data.generic_string_name)
			end
		end; 

	build is
			-- Put the differents elements according to the ellipse position.
		local
			total_height, min_y, max_y, y_offset: INTEGER;
			total_width, local_class_w, local_generic_w: INTEGER;
			i: INTEGER
		do
			local_x := data.x+parent_group.local_x;
			local_y := data.y+parent_group.local_y;
			ellipse.origin.set (local_x, local_y);
			min_y := -class_text_height;
			max_y := 0;
			class_name.base_left.set_y (- Resources.class_name_font.descent);
			total_symb_nb := 0;
			set_symbol (data.is_deferred, star_position);
			set_symbol (data.is_effective, plus_position);
			set_symbol (data.is_persistent, circle_position);
			set_symbol (data.is_interfaced, triangle_position);
			if total_symb_nb > 0 then
				min_y := signs.item (1).upper_left.y
			end;
			if data.is_reused then
				segment.start.set_y (Resources.class_reused_offset);
				segment.final.set_y (Resources.class_reused_offset);
				max_y := Resources.class_reused_offset+1
			end;
			if not generic_param.text.empty then
				max_y := max_y+Resources.class_generic_offset+
					generic_text_height;
				generic_param.base_left.set_y (max_y -
					Resources.generic_font.descent)
			end;
			total_height := max_y-min_y;
			y_offset := local_y-(min_y+max_y) // 2;
			ellipse.set_radius2 ((total_height+
					Resources.class_ellipse_y_offset*2) // 2);
			total_width := total_symb_nb*(bitmap_width+
					Resources.class_symbols_spacing);
			from
				i := 1
			until
				i > total_symb_nb
			loop
				signs.item (i).upper_left.set (local_x+(i-1)*
					(bitmap_width+Resources.class_symbols_spacing)-
					(total_width // 2),
						y_offset+signs.item (i).upper_left.y);
				i := i+1
			end;
			local_class_w := class_text_width;
			if total_width < local_class_w then
				total_width := local_class_w
			end;
			class_name.base_left.set (local_x-(local_class_w // 2),
				y_offset+class_name.base_left.y);
			if data.is_reused then
				segment.start.set (class_name.base_left.x,
					y_offset+segment.start.y);
				segment.final.set (class_name.base_left.x+local_class_w,
					y_offset+segment.final.y)
			end;
			if not generic_param.text.empty then
				local_generic_w := generic_text_width;
				if total_width < local_generic_w then
					total_width := local_generic_w
				end;
				generic_param.base_left.set (local_x-
					(local_generic_w // 2),
						y_offset+generic_param.base_left.y)
			end;
			if total_width+
			Resources.class_ellipse_x_offset < total_height * 4
			then
				if generic_param.text.empty and total_symb_nb = 0 then
					ellipse.set_radius1 (total_height*2)
				else
					if not generic_param.text.empty and
					total_symb_nb /= 0
					then
						ellipse.set_radius1 ((total_width+
						generic_param.text.count * 2 +
						Resources.class_ellipse_x_offset) // 2)
					else
						ellipse.set_radius1 (((total_width+
						generic_param.text.count * 2 +
						Resources.class_ellipse_x_offset)
						// 2) + 7)
					end
				end
			else
				if generic_param.text.empty and total_symb_nb = 0 then
					ellipse.set_radius1 ((total_width+
						generic_param.text.count * 2 + 
						Resources.class_ellipse_x_offset) // 2)
				else
					ellipse.set_radius1 (((total_width+
						generic_param.text.count * 2 +
						Resources.class_ellipse_x_offset)
						// 2) + 3)
				end
			end;
			if data.is_root then
				root_ellipse.set_radius1 (ellipse.radius1);
				root_ellipse.set_radius2 (ellipse.radius2);
				root_ellipse.origin.set (center.x, center.y);
				ellipse.set_radius1 (root_ellipse.radius1+
							Resources.class_root_offset*2);
				ellipse.set_radius2 (root_ellipse.radius2+
							Resources.class_root_offset*2)
			end;

		
			rectangle.origin.set ( local_x-(total_width//2)-5,
				 local_y-(total_height//2)-5)
			rectangle.set_width ( total_width + 10 )
			rectangle.set_height ( total_height+10 )
			erase_rectangle.origin.set ( local_x-(total_width//2)-5,
				 local_y-(total_height//2)-5)
			erase_rectangle.set_width ( total_width + 10 )
			erase_rectangle.set_height ( total_height+10 )
	
		
			erase_ellipse.origin.set (center.x, center.y)
			erase_ellipse.set_radius1 (ellipse.radius1);
			erase_ellipse.set_radius2 (ellipse.radius2 + 5);
			recompute_closure
		end; -- build

	recompute_closure is
			-- Recompute class's closure
		do
			erase_ellipse.recompute_closure
		end -- recompute_closure

	set_color is
			-- Set color to class.
		local
			i: INTEGER;
			a_color: EV_COLOR
		do
			a_color := data.color
			ellipse.interior.set_foreground_color (a_color);
			from
				i := 1
			until
				i > 5
			loop
				signs.item (i).set_background_color (a_color);
				i := i+1
			end;
		end;

	set_selected_style is
			-- Set color for selected state.
		local
			i: INTEGER
		do
			ellipse.interior.set_foreground_color 
						(Resources.selected_interior_color);
			class_name.set_foreground_color
						(Resources.selected_invert_color);
			generic_param.set_foreground_color
						(Resources.selected_invert_color);
			segment.path.set_foreground_color
						(Resources.selected_invert_color);
			root_ellipse.path.set_foreground_color
				(Resources.selected_invert_color);
			from
				i := 1
			until
				i > 5
			loop
				signs.item (i).set_foreground_color
					(Resources.selected_invert_color);
				signs.item (i).set_background_color
					(Resources.selected_interior_color);
				i := i+1
			end
		end; -- set_selected_style

	set_unselected_style is
			-- Set color for unselected state.
		local
			i: INTEGER;
		do
			set_color;
			class_name.set_foreground_color (Resources.class_color);
			generic_param.set_foreground_color (Resources.class_color);
			segment.path.set_foreground_color (Resources.class_color);
			root_ellipse.path.set_foreground_color (Resources.class_color);
			from
				i := 1
			until
				i > 5
			loop
				signs.item (i).set_foreground_color
							(Resources.class_color);
				i := i+1
			end
		end -- set_unselected_style

feature {WORKAREA_MOVE_DATUM_COM} -- Implementation access

	final_point_at_position (b: EC_COORD_XY;
				rel_x, rel_y: INTEGER; align_coord: BOOLEAN): EC_COORD_XY is
			-- Point where a line from `from_pt' to Current
			-- with relative positions `rel_x' and `rel_y'
		local
			x1, y1: INTEGER;
			a1, a2: INTEGER;
			b1, b2: INTEGER;
			a1a2: INTEGER;
			temp, temp2,tmp3,temp4,temp3: REAL;
			recx,recy:INTEGER
			pente : REAL
			real_local_x, real_local_y: INTEGER;
			gap_x	: INTEGER
			gap_y	: INTEGER
			tangente_angle	: REAL
			tangente_limite	: REAL
			infinity	: INTEGER	
		do
			if align_coord then
				real_local_x := align_grid (local_x + rel_x);
				real_local_y := align_grid (local_y + rel_y);
			else
				real_local_x := local_x + rel_x;
				real_local_y := local_y + rel_y;
			end

			b1 := b.y - real_local_y; -- Relative height (b to center)
			b2 := b.x - real_local_x; -- Relative width (b to center)

			if not system.uml_layout
			then
				--| The formular is derived from the intersection 
				--| of the ellipse and the line from `p' to
				--| the center. (center is center, b is from point and
				--| Result is the intersection point, a1 is vertical radius 
				--| and a2 is horizontal radius).
				a1 := ellipse.radius2; 
				a2 := ellipse.radius1; 
				a1a2 := a1 * a2;
				x1 := real_local_x;
				y1 := real_local_y;
				recx := rectangle.width
				recy := rectangle.height
					-- Need to split up multiplication since
					-- it was getting too big for the integer (overflow problem)
					-- in some instances.
				temp := a1*a1;
				temp := temp*b2*b2;
				temp2 := a2*a2;
				temp2 := temp2*b1*b1;
				temp := temp + temp2;
				if temp > 0 then
					temp := sqrt (temp);
					temp3 := b2*a1a2 / temp
					temp4 := b1*a1a2 / temp
					x1 := x1 + temp3.truncated_to_integer;
					y1 := y1 + temp4.truncated_to_integer;
				end
				!! Result;
				Result.set (x1, y1)
			else

				b1	:= - b1				

				tangente_limite	:= rectangle.height / rectangle.width
				if b2 /= 0
				then
					tangente_angle	:= b1 / b2
				else
					infinity	:= 30000
					tangente_angle	:= b1 * infinity
				end

				if tangente_angle < - tangente_limite
				then
					if b1 /= 0
					then
						gap_x	:= ( rectangle.height * b2 ) // ( 2 * b1 )
					else
						gap_x	:= 0
					end

					if	b2 >= 0	and
						b1 <= 0
					then
						x1	:= real_local_x - gap_x
						y1	:= real_local_y + ( rectangle.height // 2 )
					else
						x1	:= real_local_x + gap_x
						y1	:= real_local_y - ( rectangle.height // 2 )
					end
				else
					if tangente_angle > tangente_limite
					then
						if b1 /= 0
						then
							gap_x	:= ( rectangle.height * b2 ) // ( 2 * b1 )
						else
							gap_x	:= 0
						end

						if b1 > 0
						then
							x1	:= real_local_x + gap_x
							y1	:= real_local_y - ( rectangle.height // 2 )
						else
							x1	:= real_local_x - gap_x
							y1	:= real_local_y + ( rectangle.height // 2 )
						end
					else
						if b2 /= 0
						then
							gap_y	:= ( rectangle.width * b1 ) // ( 2 * b2 )
						else
							gap_y	:= 0
						end

						if b2 > 0
						then
							x1	:= real_local_x + ( rectangle.width // 2 )
							y1	:= real_local_y - gap_y 
						else
							x1	:= real_local_x - ( rectangle.width // 2 )
							y1	:= real_local_y + gap_y 
						end
					end
				end
					 
				!! Result
				Result.set	( x1	, y1	)
		
			end
		end;

end -- class GRAPH_CLASS
