indexing

	description: 
		"Graphcial representation for reference relationship.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_CLI_SUP

inherit

	GRAPH_CLIENTELE
		redefine
			build_label, build_link_body, data, link_head, build_handles,
			attach_attributes_drawing, build_attributes, draw_attributes,
			erase_attributes, make_attributes, recompute_attributes_closure,
			attributes_closure, add_reverse_link, remove_reverse_link,
			build_multiple_text, build_reverse_multiple_text,
			remove_multiplicity, handle_at,
			build_multiple_rhomb, set_color,
			make_relation
		end

creation

	make, make_reflexive

feature {NONE} -- Initialization

	make (a_cli_sup: CLI_SUP_DATA; a_workarea: WORKAREA) is
			-- create GRAPH_CLI_SUP object with `a_cli_sup' as link 
		require
			has_client_link: a_cli_sup /= Void;
			has_workarea: a_workarea /= Void;
			data_not_aggrege: not a_cli_sup.is_aggregation
		local
			colo: EV_COLOR
		do
			workarea := a_workarea;
			data := a_cli_sup;
			-- pascalf
			if data.color_name = Void then
				--if resources.link_color/= Void then
				--	data.set_color_name (resources.link_color.name)
				--else
				--	data.set_color_name (resources.cli_link_color.name)
				--end
				!! colo.make_rgb(0,255,255)
				data.set_color(colo)
			end
		--
			client := a_workarea.find_linkable (data.client)
			supplier := a_workarea.find_linkable (data.supplier)
			if client /= Void and then supplier /= Void then
				a_workarea.cli_sup_list.add_form (Current)
				!! link_body.make
				make_relation (a_workarea)
				update_clip_area
			end
			!! multiple_text.make
		ensure
			data_correctly_set: data = a_cli_sup;
		end; -- make

	make_reflexive (a_cli_sup: CLI_SUP_DATA; a_workarea: WORKAREA) is
			-- create GRAPH_CLI_SUP object with `a_cli_sup' as reflexive link
		require
			has_client_link: a_cli_sup /= Void;
			has_workarea: a_workarea /= Void;
			data_not_aggrege: not a_cli_sup.is_aggregation
		do
			workarea := a_workarea;
			data := a_cli_sup;
			client := a_workarea.find_linkable (data.client);
			if client /= Void then
				a_workarea.cli_sup_list.add_form (Current);
				supplier := client;
			end;
			!! link_body.make;
			make_reflexive_relation (a_workarea);
			update_clip_area;
		ensure
			data_correctly_set: data = a_cli_sup;
		end; -- make_reflexive

feature -- Properties

	data: CLI_SUP_DATA;
			-- Client-sup data associated with Current

feature -- Graphical properties

	link_head: EC_TRIANGLE_HEAD;
			-- Triangle head figure of arrow

	shared_circle: EC_CIRCLE
			-- Shared capability of current reference link

	start_point: EC_COORD_XY;
			-- First point near 'start' point for reflexive
			-- capabilities

	final_point: EC_COORD_XY;
			-- Final point near 'final' point for reflexive
			-- capabilities

	is_shared: BOOLEAN is
			-- Is current relation shared?
		do
			Result := shared_circle /= Void 	
					--and
				--(multiple_text /= Void or
					--reverse_multiple_text /= Void)
		end; -- is_shared

	shared_radius: INTEGER is
			-- Radius of 'shared_circle'
		local
			font: EV_FONT
		do
			font := resources.get_font("link_digit_font")
			Result := font.string_width ("8")
			Result := Result.max (font.ascent + font.descent)
			Result := (Result // 2) + 4
		end

	attributes_closure: EC_CLOSURE is
		do
			if is_shared then
				Result := precursor
				if has_reverse then
					Result.merge (reverse_link_head.closure);
					Result.merge (reverse_label.closure)
				end;
				Result.merge (shared_circle.closure)
			else
				Result := precursor
			end
		end

feature -- Access
			
	handle_at (x_coord, y_coord: INTEGER): INTEGER is
			-- Handle pointed by `x_coord' and `y_coord'
			-- 0 if no handle is pointed.
			-- Return 0 if reflexive
		do
			if data.is_reflexive then
				Result := 0
			else
				Result := precursor (x_coord, y_coord)
			end
		end; 

feature -- Shared and multiple management

	add_shared (reverse_side: BOOLEAN) is
			-- Add shared capability to current relation
		local
			a_color: EV_COLOR
		do
			a_color := data.color
			if reverse_side then
				make_reverse_shared
				--reverse_multiple_text.attach_drawing (workarea)
				--reverse_multiple_text.set_foreground_color (a_color)
			else
				make_shared
				multiple_text.attach_drawing (workarea)
				multiple_text.set_foreground_color (a_color)
			end
			if not (data.shared /= 0 and data.reverse_shared /= 0) then
				shared_circle.attach_drawing (workarea)
				shared_circle.set_color (a_color)
				--if has_reverse then
					--multiple_bar.attach_drawing (workarea)
					--multiple_bar.path.set_foreground_color (a_color)
				--end
			end
		ensure
			is_shared: is_shared
		end

feature -- Element change

	add_reverse_link is
			-- Add reverse link.
		do
			precursor
			if is_shared then
				shared_circle.set_radius (shared_radius);
				if not is_multiple then
					!!multiple_bar.make;
					multiple_bar.attach_drawing (workarea);
				--	multiple_bar.path.set_foreground_color (data.color)
				end
			end
		end; 

feature -- Removal

	destroy_without_clip_update is
			-- Destroy 'Current' from 'workarea'
		do
			workarea.cli_sup_list.remove_form (Current)
		end;

	remove_reverse_link is
		do
			precursor
			if is_shared and not is_multiple then
				multiple_bar := Void
			end
		end;

	remove_shared (reverse_side: BOOLEAN) is
			-- Remove shared capability of current relation
		require 
			is_shared: is_shared
		do
			--if reverse_side then
				--if data.reverse_multiplicity = 0 then
					--reverse_multiple_text.erase;
				--	reverse_multiple_text := Void
				--end
			--else
				--if data.multiplicity = 0 then
					--multiple_text.erase;
					--multiple_text := Void
				--end
			--end;
			if not (data.reverse_shared /= 0 or data.shared /= 0) then
				shared_circle.erase;
				shared_circle := Void
			end
		ensure
			is_not_shared: not is_shared
		end; -- remove_shared

	remove_multiplicity (reverse_side: BOOLEAN) is
			-- Remove multiplicity depending on `reverse_side'.
		do
			if is_shared then
				if reverse_side then
					if data.reverse_shared /= 0 then
						reverse_multiple_text.set_text ("1")
					else
						reverse_multiple_text.erase;
						reverse_multiple_text := Void
					end
				else
					if data.shared /= 0 then
						multiple_text.set_text ("1")
					else
						multiple_text.erase;
						multiple_text := Void
					end
				end;
				if (reverse_multiple_text = Void or else
					reverse_multiple_text.text.is_equal ("1")) and
				(multiple_text = Void or else
					multiple_text.text.is_equal ("1")) 
				then
					multiple_rhomb.erase;
					multiple_rhomb := Void
				end;
			else
				precursor (reverse_side)
			end
		end; -- remove_multiplicity

feature -- Output

	draw_attributes is
			-- Draw the attribute figures.
		do
			precursor
			if is_shared then
				shared_circle.draw;
			end
		end; 

	erase_attributes is
			-- Erase the attribute figures.
		do
			precursor
			if is_shared then
				shared_circle.erase;
			end
		end; 

feature {NONE} -- Implementation

	make_shared is
			-- Make shared attributes (circle & text - & bar -)
		do
			if not is_shared then
				!!shared_circle.make (shared_radius)
				if has_reverse and (multiple_bar = Void) then
					!!multiple_bar.make
				end
			end
			if not has_multiplicity then
				multiple_text.set_text ("1")
				multiple_text.set_font (resources.get_font("link_digit_font"))
			end
		end

	make_reverse_shared is
			-- Make shared attributes (circle & text - & bar -)
		do
			if not is_shared then
				!!shared_circle.make (shared_radius);
				--if has_reverse and (multiple_bar = Void) then
					--!!multiple_bar.make
				--end
			end;
			--if not has_reverse_multiplicity then
				--!!reverse_multiple_text.make;
				--reverse_multiple_text.set_text ("1");
				--reverse_multiple_text.set_font
							--(Resources.link_digit_font);
			--end
		end;

	build_shared_circle is
			-- Build shared circle
		local
			tmp_center, new_center: EC_COORD_XY;
			pts: LINKED_LIST [EC_COORD_XY]
		do
			pts := link_body.points;
			pts.finish;
			pts.back;
			!! new_center;
			if is_multiple then
				new_center := (pts.item + link_body.final) // 2;
				tmp_center := (pts.item + new_center) // 2;
				new_center := (tmp_center + new_center) // 2;
			else
				new_center := (pts.item + link_body.final) // 2;
			end;
			shared_circle.set_center (new_center)
		end; 

	build_multiple_text is
			-- Build multiplicity number in 'multiple_rhomb'
		local
			width, height: INTEGER;
			rel_x, rel_y: INTEGER
			font: EV_FONT
		do
			font := resources.get_font("link_digit_font")
			if is_shared then
				rel_x := link_body.points.i_th
					(link_body.points.count - 1).x - final.x;
				rel_y := link_body.points.i_th
					(link_body.points.count - 1).y - final.y;
				width := font.string_width (multiple_text.text);
				height := font.ascent + font.descent;
				if has_reverse then
					if rel_x < 0 then
						multiple_text.base_left.set
							(multiple_rhomb.center.x + 3,
							multiple_rhomb.center.y +
							(height // 2) - 1)
					elseif rel_x > 0 then
						multiple_text.base_left.set
							(multiple_rhomb.center.x -
							width - 1,
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
					multiple_text.base_left.set
						(multiple_rhomb.center.x -
						(width // 2) + 1,
					multiple_rhomb.center.y +
						(height // 2) - 1)
				end
			else
				precursor
			end
		end; -- build_multiple_text

	build_reverse_multiple_text is
			-- Build multiplicity number in 
			-- 'multiple_rhomb' in right side.
		local
			width, height: INTEGER;
			rel_x, rel_y: INTEGER
			font: EV_FONT
		do
			font := resources.get_font("link_digit_font")
			if is_shared then
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
			else
				precursor
			end
		end 

	attach_attributes_drawing (a_drawing: EV_DRAWABLE) is
		do
			precursor (a_drawing)
			if is_shared then
				shared_circle.attach_drawing (a_drawing);
			end
		end

	recompute_attributes_closure is
		do
			precursor
			if is_shared then
				shared_circle.recompute_closure
			end
		end; -- recompute_attributes_closure

	make_attributes is
		do
			precursor
			if data.shared /= 0 then
				make_shared
			end;
			if data.reverse_shared /= 0 then
				make_reverse_shared
			end
		end; -- make_attributes

	build_attributes is
			-- Build the attribute figures.
		do
			precursor
			if is_shared then
				build_shared_circle;
			end
		end; -- build_attributes
	
	build_multiple_rhomb is
			-- Build the rhomb figure.
		local
			tmp_center, new_center: EC_COORD_XY;
			pts: LINKED_LIST [EC_COORD_XY]
		do
			pts := link_body.points;
			pts.finish;
			pts.back;
			if is_shared then
				tmp_center := (pts.item + link_body.final) // 2;
				new_center := (link_body.final + tmp_center) // 2;
				new_center := (tmp_center + new_center) // 2;
			else
				new_center := (pts.item + link_body.final) // 2;
			end;
			multiple_rhomb.set_center (new_center);
			multiple_rhomb.build
		end;

	build_link_body is
			-- Build the link body.
		local
			start_pt, final_pt: EC_COORD_XY;
			graph_class: GRAPH_CLASS;
			cluster: CLUSTER_DATA;
			width_const, height_const: INTEGER
		do
			if data.is_reflexive then
				!! start_pt;
				!! final_pt;
				if supplier.data.is_cluster then
					cluster ?= client.data;
					if cluster.is_icon then
						width_const := cluster.icon_width // 2;
						height_const := cluster.icon_height // 2;
					else
						width_const := cluster.width // 2;
						height_const := cluster.height // 2;
					end;
					start_pt.set (client.local_x, client.local_y);
					final_pt.set (start_pt.x - width_const,
							start_pt.y + height_const)
				else
					graph_class ?= client;
					start_pt.set (client.center.x,
							client.center.y);
					final_pt.set (start_pt.x -
							graph_class.ellipse.radius1,
							start_pt.y);
				end;
				start_pt := client.handle_to (final_pt);
				final_pt.set (final_pt.x, final_pt.y - 10);
				final_pt := supplier.handle_to (final_pt);
				start.set (start_pt.x, start_pt.y);
				final.set (final_pt.x, final_pt.y);
				start_point.set (start.x - 10, start.y);
				final_point.set (start.x - 10, final.y);
				from_point.set (start.x, start.y);
				to_point.set (final.x, final.y);
			else
				precursor
			end
		end; -- build_link_body

	build_label is
			-- Built the labe to be displayed on link.
		local
			additional_height: INTEGER;
			label_data: LABEL_DATA
			font1: EV_FONT
		do
			font1 := resources.get_font("link_label_font")
			if data.is_reflexive then
				label_data := data.label;
				label.set_verticality (data.is_vertical_text);
				label_height := font1.ascent + font1.descent;
				if label.vertical then
					label.set_words (label_data.words);
					additional_height :=  (label.words_count - 1)
							* label.line_space
				end;
				label_width := font1.string_width (label.longest_word);
				label.base_left.set (start.x - label_data.x_offset
							- label_width - 10,
							start.y - label_data.y_offset - additional_height)
			else
				precursor
			end
		end

	make_reflexive_relation (a_workarea: WORKAREA) is
			-- Make the graphical representation of current relation
		require
			has_workarea: a_workarea /= Void
		local
			points: LINKED_LIST[EC_COORD_XY];
		do
			!!from_point;
			!!to_point;
			points := link_body.points;
			points.start;
			!! start_point;
			points.put_right (start_point);
			!! final_point;
			points.finish;
			points.put_left (final_point);
			make_link_head;
			make_attributes;
			attach_workarea (a_workarea);
			set_color;
			build
		end; 

	make_link_head is
			-- Create the link head figure.
		do
			!! link_head.make (to_point,2)
			-- 2 is to swpecify that it is a client-supplier link
		end -- make_link_head

	make_relation (a_workarea: WORKAREA) is
			-- Create a relation for `a_workarea'.
		do
			!! start_point;
			!! final_point;
			precursor (a_workarea);
		end;

	build_handles is
			-- Build the handles for Current link.
		do
			if data.is_reflexive then
				handles.first.set (start.x, start.y);
				handles.last.set (final.x, final.y);
			else
				precursor
			end
		end;

	set_color is
			-- Set the color to the current link.
		do
			precursor
			if is_shared then
				shared_circle.set_color (data.color)
			end
		end

invariant
	GRAPH_CLI_SUP_multiple_text_exists: multiple_text /= Void

end -- class GRAPH_CLI_SUP
