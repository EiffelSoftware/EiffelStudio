indexing

	description: "BON graphical representation for a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_CLUSTER 

inherit

	GRAPH_GROUP
		undefine
			is_equal
		redefine
			cluster_at
		end

	GRAPH_LINKABLE
		redefine
			unselect, select_it, data, draw_in,
			partial_draw,observer_update
		end

creation

	make

feature -- Update

	observer_update is
			-- Update the drawing, according to data.
		do
			erase_rectangle_title.draw
			update_form
 			update_clip_area
			set_color
			cluster_title.draw
			title.draw
		end

feature {NONE} -- Initialization

	make (a_cluster: CLUSTER_DATA; graph_group: GRAPH_GROUP) is
			-- Create GRAPH_CLUSTER object with a_cluster as link 
		require
			a_cluster_exists: a_cluster /= void;
			not a_cluster.is_icon
		local
			interior: EC_INTERIOR;
			cluster_path: EC_PATH
		do
			data := a_cluster
			observer_management.add_observer(data,Current)
		
			!!center;
			!!cluster_list.make;
			!!class_list.make;
			!!icon_list.make;
			parent_group := graph_group;
			parent_group.cluster_list.add_form (Current);
			!!closure.make;
			!!cluster_title.make;
			!!title.make
			observer_management.add_observer(data,title)
			!!cluster_path.make;
			!!interior.make;
			cluster_path.set_line_width (2);
			cluster_path.set_onoffdash_line;
			cluster_title.set_path (cluster_path);
			cluster_title.set_interior (interior);
			title.set_text (data.name);
			title.set_font (Resources.cluster_name_font);
			!!cluster.make;
			cluster.set_path (cluster_path);
			!!interior.make;
			interior.set_foreground_color (Resources.drawing_bg_color);
			!!erase_rectangle.make;
			erase_rectangle.path.set_foreground_color
				(Resources.drawing_bg_color);
			erase_rectangle.set_interior (interior);
			!!erase_rectangle_title.make;
			erase_rectangle_title.path.set_foreground_color
				(Resources.drawing_bg_color);
			erase_rectangle_title.set_interior (interior);
			set_unselected_style;
			attach_workarea (graph_group.workarea);
			update_lists;
			build;
			set_color;
			update_clip_area;
		ensure
			data_set: data = a_cluster;
			closure_created: closure /= Void;
			cluster_title_exists: cluster_title /= Void;
			title_exists: title /= Void;
			cluster_exists: cluster /= Void;
			cluster_not_icon: not data.is_icon
		end -- make

feature -- Properties

	data: CLUSTER_DATA
			-- Cluster data associated with Current

	order: INTEGER is 3
			-- Precedence of 'Current' as graphical entity

	icon_number: INTEGER is 1;

feature -- Graphical properties

	closure: EC_CLOSURE;
			-- Cluster's closure.

	cluster_title: EC_CLUSTER_FIG;
			-- Cluster which contains the title.

	cluster: EC_CLUSTER_FIG;
			-- global cluster.

	title: EC_TEXT_FIG;
			-- Title figure

	erase_rectangle: EC_RECTANGLE;
			-- Rectangle who cover all the cluster

	erase_rectangle_title: EC_RECTANGLE;
			-- Rectangle who cover all the cluster's title

	origin: EC_COORD_XY is
			-- origin a the inheritance link.
		do
			Result := cluster.up_left
		end;

	cluster_tag_width: INTEGER is
			-- width of the tag of the cluster
		do
			Result := title_text_width +
				Resources.cluster_title_margin * 2;
		end;

	upper_left : EC_COORD_XY is
			-- figure upper left point.
		do
			!!Result;
			Result.set(cluster.up_left.x, cluster.up_left.y)
		end; 

	bottom_right : EC_COORD_XY is
			-- figure bottom right point.
		do
			!!Result;
			Result.set(cluster.down_right.x, cluster.down_right.y)
		end;

feature -- Setting

	attach_workarea (a_workarea: WORKAREA) is
			-- Attach a workarea to the figure
		require else
			a_workarea_exists : not (a_workarea = Void)
		do
			workarea := a_workarea;
			cluster.attach_drawing (a_workarea);
			cluster_title.attach_drawing (a_workarea);
			title.attach_drawing (a_workarea);
			erase_rectangle.attach_drawing (a_workarea);
			erase_rectangle_title.attach_drawing (a_workarea);
			cluster_list.attach_workarea (a_workarea);
			class_list.attach_workarea (a_workarea);
			icon_list.attach_workarea (a_workarea)
		ensure then
			workarea_set: a_workarea = workarea
		end; 

feature -- Access

	handle_at (x_relative, y_relative: INTEGER): INTEGER is
			-- # of hand at `x_rel', `y_rel' relative to the origin
		local
			width, height: INTEGER;
			x_rel, y_rel: INTEGER
			handle_size: INTEGER
		do
			handle_size := 20;
			width := cluster.down_right.x-cluster.up_left.x;
			height := cluster.down_right.y-cluster.up_left.y;
			x_rel := x_relative-cluster.up_left.x;
			y_rel := y_relative-cluster.up_left.y;
			if inside_rectangle (x_rel, y_rel, 0, 0, handle_size, handle_size) then
				Result := 1
			elseif inside_rectangle (x_rel, y_rel, width-handle_size, 0,
						width, handle_size)
			then
				Result := 2
			elseif inside_rectangle(x_rel, y_rel, 0, height-handle_size,
						handle_size, height)
			then
				Result := 3
			elseif inside_rectangle (x_rel, y_rel, width-handle_size,
						height-handle_size, width, height)
			then
				Result := 4
			else
				Result := 0
			end
		end; 

	cluster_at (x_coord, y_coord: INTEGER): GRAPH_CLUSTER is
			-- Cluster pointed by `x_coord' and `y_coord'.
		local
			p: EC_COORD_XY
		do
			!!p
			p.set (x_coord, y_coord)
			if cluster.contains (p) then
				Result := precursor (x_coord, y_coord)
				if Result = Void then
					Result := Current
				end
			end
		end

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		local
			p: EC_COORD_XY
		do
			!!p;
			p.set (x_coord, y_coord);
			if cluster.contains (p) then
				Result := class_list.figure_at (x_coord, y_coord);
				if Result = void then
					Result := icon_list.figure_at (x_coord, y_coord)
				end;
				if Result = void then
					Result := cluster_list.figure_at (x_coord,
									y_coord);
					if (Result = Void) then
						Result := Current
					end
				end
			else
				if cluster_title.contains (p) then
					Result := Current
				end
			end
		end; 

	is_on_tag (x_coord, y_coord: INTEGER): BOOLEAN is
			-- Is `x_coord', `y_coord' on tag ?
		require
			cluster_title_exists: cluster_title /= Void
		local
			p: EC_COORD_XY
		do
			!!p;
			p.set (x_coord, y_coord);
			Result := cluster_title.contains (p)
		end;

feature -- Output

	draw is
			-- Display cluster in analysis view.
		do
			cluster_title.draw
			title.draw
			cluster.draw
			cluster_list.draw_in (closure)
			class_list.draw_in (closure)
			icon_list.draw_in (closure)
		end 

	draw_in (clip_closure: EC_CLOSURE) is
			-- Draw cluster if in `clip_closure'.
		do
			--if clip_closure.intersects (erase_rectangle_title.closure) then
				cluster_title.draw;
				title.draw;
				
			--end;
			--if clip_closure.intersects (closure) then
				cluster.draw;
			--end;
			cluster_list.draw_in (clip_closure);
			class_list.draw_in (clip_closure);
			icon_list.draw_in (clip_closure);
		end;

	draw_border is
			-- Draw the border of cluster.
		local
			cluster_title_interior, cluster_interior : EC_INTERIOR
		do
			cluster_title_interior := cluster_title.interior
			cluster_interior := cluster.interior
			cluster_title.set_interior (Void)
			cluster.set_interior (Void)
			cluster_title.draw
			cluster.draw
			cluster_title.set_interior (cluster_title_interior)
			cluster.set_interior (cluster_interior)
		end;

	erase_drawing is
			-- Erase current figure.
		do
			erase_rectangle.draw
			erase_rectangle_title.draw
				-- This was done for figures on the cluster border 
				-- so it is erased correctly.
			cluster_list.erase_if_not_in (erase_rectangle.closure)
			class_list.erase_if_not_in (erase_rectangle.closure)
			icon_list.erase_if_not_in (erase_rectangle.closure)
		end;

	update_title is
			-- Update the cluster title.
		do
			--workarea.to_refresh.merge (erase_rectangle_title.closure)
			erase_rectangle_title.draw
			build_title
			recompute_title_closure
			--workarea.to_refresh.merge (erase_rectangle_title.closure)	
		end

	partial_draw is
			-- Partial draw of Current.
		do
			cluster_title.draw;
			title.draw;
			cluster.draw;
		end;

	select_it is
			-- Set `selected' to true.
			-- Add this figure in `workarea.selected_figures'.
			-- Draw this figure.
		do
			set_selected_style;
			selected := true;
			workarea.selected_figures.add_form (Current);
			update_clip_area
		end; -- select_it

	unselect is
			-- Set `selected' to false.
			-- Remove this figure in `workarea.selected_figures'.
			-- Draw this figure.
		local
			no_interior: EC_INTERIOR
		do
			set_unselected_style;
			erase_rectangle_title.draw;
			selected := false;
			workarea.selected_figures.remove_form (Current);
			update_clip_area
		end; -- unselect

	set_selected_style is
			-- Set color for selected state.
		do
			cluster_title.interior.set_foreground_color
							(Resources.selected_interior_color);
			title.set_foreground_color (Resources.selected_invert_color)
		end; 

	set_unselected_style is
			-- Set color for unselected state.
		local
			no_interior: EC_INTERIOR
		do
			cluster_title.interior.set_foreground_color 
							(Resources.cluster_title_interior_color);
			title.set_foreground_color (data.color)
		end;

	invert_skeleton (painter: PATCH_PAINTER; relative_x, relative_y: INTEGER) is
			-- Invert the cluster's skeleton.
			-- Draw on `painter' as if the origin is
			-- at (`origin_x', `origin_y').
		local
			origin_x, origin_y: INTEGER
		do
			origin_x := align_grid (local_x+relative_x);
			origin_y := align_grid (local_y+relative_y);
			if data.tag_is_south then
				painter.draw_rectangle
					(origin_x+data.tag_relative_x,
					origin_y+data.height+2,
					cluster_title.down_right.x-
					cluster_title.up_left.x,
					cluster_title.down_right.y-
					cluster_title.up_left.y)
			else
				painter.draw_rectangle
					(origin_x+data.tag_relative_x,
					origin_y-(cluster_title.down_right.y-
					cluster_title.up_left.y),
					cluster_title.down_right.x-
					cluster_title.up_left.x,
					cluster_title.down_right.y-
					cluster_title.up_left.y-2)
			end;
			painter.draw_rectangle
				(origin_x, origin_y,
				cluster.down_right.x-cluster.up_left.x,
				cluster.down_right.y-cluster.up_left.y);
			painter.draw_segment (origin_x, origin_y, 
					origin_x + 3, origin_y);
			painter.draw_segment (origin_x, origin_y, 
					origin_x, origin_y + 3);
			painter.draw_arc (origin_x, origin_y,
				2, 2, 0, 360, 0)
		end; -- invert_skeleton

	invert_tag (painter: PATCH_PAINTER; relative_x: INTEGER; is_south: BOOLEAN) is
			-- Invert cluster's tag as if it moved of `relative_x'.
		local
			origin_x, origin_y: INTEGER
		do
			origin_x := local_x+relative_x;
			origin_y := local_y;
			if is_south then
				painter.draw_rectangle
					(origin_x+data.tag_relative_x,
					origin_y+data.height,
					cluster_title.down_right.x-
					cluster_title.up_left.x,
					cluster_title.down_right.y-
					cluster_title.up_left.y)
			else
				painter.draw_rectangle
					(origin_x+data.tag_relative_x,
					origin_y-(cluster_title.down_right.y-
					cluster_title.up_left.y),
					cluster_title.down_right.x-
					cluster_title.up_left.x,
					cluster_title.down_right.y-
					cluster_title.up_left.y)
			end
		end;

	invert_skeleton_resize (painter: PATCH_PAINTER; handle: INTEGER; px, py: INTEGER) is
			-- Invert cluster's skeleton as if we must resize to `px', `py'.
		local
			x1, y1, x2, y2, tagx: INTEGER
		do
			if handle = 1 then
				x1 := cluster.up_left.x-px;
				y1 := cluster.up_left.y-py;
				x2 := cluster.down_right.x;
				y2 := cluster.down_right.y
			elseif handle = 2 then
				x1 := cluster.up_left.x;
				y1 := cluster.up_left.y-py;
				x2 := cluster.down_right.x+px;
				y2 := cluster.down_right.y
			elseif handle = 3 then
				x1 := cluster.up_left.x-px;
				y1 := cluster.up_left.y;
				x2 := cluster.down_right.x;
				y2 := cluster.down_right.y+py
			elseif handle = 4 then
				x1 := cluster.up_left.x;
				y1 := cluster.up_left.y;
				x2 := cluster.down_right.x+px;
				y2 := cluster.down_right.y+py
			end;
			tagx := x1 + data.tag_relative_x;
			if tagx + cluster_tag_width > x2 then
				tagx := x2 - cluster_tag_width
			end;
			if data.tag_is_south then
				draw_rectangle_from_to (
					painter,
					tagx,
					y2+2,
					tagx+
					cluster_title.down_right.x-
					cluster_title.up_left.x,
					y2+(cluster_title.down_right.y-
					cluster_title.up_left.y))
			else
				draw_rectangle_from_to (
					painter,
					tagx,
					y1-(cluster_title.down_right.y-
					cluster_title.up_left.y),
					tagx+cluster_title.down_right.x
					-cluster_title.up_left.x, y1-2)
			end;
			draw_rectangle_from_to (painter, x1, y1, x2, y2)
	
		end; 

	draw_rectangle_from_to (painter: PATCH_PAINTER; x1, y1, x2, y2: INTEGER) is
			-- Draw a rectangle on `painter' from `x1', `y1' to `x2', `y2'.
		require
			painter_exists: not (painter = Void);
			x2_greater_than_x1: x2 >= x1;
			y2_greater_than_y1: y2 >= y1
		do
			
            painter.draw_rectangle (x1, y1, x2-x1, y2-y1)
		end; -- draw_rectangle_from_to

feature -- Update

	update_lists is
			-- Update `cluster_list', `class_list' and 'icon_list'
		local
			new_graph_class: GRAPH_CLASS
			classes: LINKED_LIST [ CLASS_DATA ]
			clusters: LINKED_LIST [ CLUSTER_DATA ]
			new_graph_cluster: GRAPH_CLUSTER
			new_graph_icon: GRAPH_ICON
			cluster_data: CLUSTER_DATA
		do
			class_list.wipe_out
			classes := data.classes
			from
				classes.start
			until
				classes.after
			loop
				if not classes.item.is_hidden then
					!!new_graph_class.make (classes.item, Current)
				end
				classes.forth
			end
			cluster_list.wipe_out
			icon_list.wipe_out
			clusters := data.clusters
			from
				clusters.start
			until
				clusters.after
			loop
				cluster_data := clusters.item
				if not cluster_data.is_hidden then
					if cluster_data.is_icon then
						!!new_graph_icon.make (cluster_data, Current)
					else
						!!new_graph_cluster.make (cluster_data, Current)
					end
				end
				clusters.forth
			end
		end; 

	update_form is
			-- Update the content according to the
			-- correpsonding entity
		local 
			new_group: GRAPH_GROUP
		do
			if parent_group.data /= data.parent_cluster then 
				parent_group.cluster_list.remove_form (Current); 
				new_group := workarea.find_graph_group
								(data.parent_cluster); 
				if new_group /= void then 
					parent_group := new_group;
					new_group.cluster_list.add_form (Current) 
				end 
			end;
			title.set_text (data.name);
			build
		end; 

feature {NONE} -- Implementation properties

	title_text_width: INTEGER is
			-- Width of cluster title
		do
			Result := Resources.cluster_name_font.string_width (title.text)
		end

	title_text_height: INTEGER is
			-- Height of cluster title
		do
			Result := Resources.cluster_name_font.ascent +
				Resources.cluster_name_font.descent
		end

feature {NONE} -- Implementation Access

	inside_rectangle (x_rel, y_rel, minx, miny, maxx, maxy: INTEGER): BOOLEAN is
			-- Is `x_rel', `y_rel' in (`minx', `miny', `maxx', `maxy') ?
		do
			Result := (x_rel >= minx) and (y_rel >= miny) and
				(x_rel <= maxx) and (y_rel <= maxy)
		end

feature {NONE} -- Implementation

	build is
			-- Put the differents elements according to cluster position.
		do
			build_title;
			cluster.up_left.set (local_x, local_y);
			cluster.down_right.set (local_x+data.width, local_y+data.height);
			cluster.build;
			erase_rectangle.upper_left.set
				(cluster.up_left.x-1, cluster.up_left.y-1);
			erase_rectangle.set_width
				(cluster.down_right.x-cluster.up_left.x+2);
			erase_rectangle.set_height
				(cluster.down_right.y-cluster.up_left.y+2);
			cluster_list.build;
			class_list.build;
			icon_list.build;
			center.set_x ((cluster.up_left.x+cluster.down_right.x) // 2);
			center.set_y ((cluster.up_left.y+cluster.down_right.y) // 2);
			recompute_closure
		end; 

	build_title is
			-- Build the cluster title.
		local
			length: INTEGER;
			title_margin, title_margin_2: INTEGER
		do
			local_x := data.x+parent_group.local_x;
			local_y := data.y+parent_group.local_y;
			length := title_text_width;
			if length < 30 then
				length := 30
			end;
			title_margin := Resources.cluster_title_margin;
			title_margin_2 := title_margin*2;
			if data.tag_is_south then
				title.base_left.set (
					local_x+title_margin+data.tag_relative_x,
						local_y+data.height+
						title_text_height+title_margin);
				cluster_title.up_left.set (local_x+
						data.tag_relative_x,
						local_y+data.height);
				cluster_title.down_right.set (local_x+
					data.tag_relative_x+length+title_margin_2,
					local_y+data.height+title_text_height+
					title_margin_2)
			else
				title.base_left.set (local_x+title_margin+
					data.tag_relative_x,
					local_y-title_margin);
				cluster_title.up_left.set (
					local_x+data.tag_relative_x,
					local_y-title_text_height-title_margin_2);
				cluster_title.down_right.set (local_x+
					data.tag_relative_x+
					length+title_margin_2, local_y)
			end;
			erase_rectangle_title.upper_left.set
				(cluster_title.up_left.x-1, cluster_title.up_left.y-1);
			erase_rectangle_title.set_width
				(cluster_title.down_right.x-cluster_title.up_left.x+2);
			erase_rectangle_title.set_height
				(cluster_title.down_right.y-cluster_title.up_left.y+2);
			cluster_title.build;
		end; -- build

	destroy_without_clip_update is
			-- Destroy this and all its links but do not 
			-- update the refresh area.
		do
			destroy_links_in (workarea.aggreg_list);
			destroy_links_in (workarea.cli_sup_list);
			destroy_links_in (workarea.inherit_list);
			deselect_links;
			class_list.destroy_without_clip_update;
			icon_list.destroy_without_clip_update;
			cluster_list.destroy_without_clip_update
		end -- destroy

	recompute_closure is
			-- Recalculate closure.
		do
			closure.wipe_out
			erase_rectangle.recompute_closure
			closure.merge (erase_rectangle.closure)
			recompute_title_closure	
				-- This was done for figures on the cluster border 
				-- so it is erased correctly.
			cluster_list.merge_closure (closure)
			class_list.merge_closure (closure)
			icon_list.merge_closure (closure)
		end -- recompute_closure

	recompute_title_closure is
			-- Recalculate title's closure
		do
			erase_rectangle_title.recompute_closure;
			closure.merge (erase_rectangle_title.closure)
		end;

feature {WORKAREA_MOVE_DATUM_COM} -- Implementation Access

	final_point_at_position (p: EC_COORD_XY;
				rel_x, rel_y: INTEGER; align_coord: BOOLEAN): EC_COORD_XY is
			-- Point where a line from `from_pt' to Current
			-- with relative positions `rel_x' and `rel_y'
		local
			x1, y1, x2, y2: INTEGER;
			px, py: INTEGER;
		do
			if align_coord then
				x1 := cluster.up_left.x + align_grid (rel_x);
				y1 := cluster.up_left.y + align_grid (rel_y);
				x2 := cluster.down_right.x + align_grid (rel_x);
				y2 := cluster.down_right.y + align_grid (rel_y);
			else
				x1 := cluster.up_left.x + rel_x;
				y1 := cluster.up_left.y + rel_y;
				x2 := cluster.down_right.x + rel_x;
				y2 := cluster.down_right.y + rel_y;
			end;
			!!Result; 
			px := p.x;
			py := p.y;
			if px < x1 then
				if py < y1 then
					Result.set (x1, y1)
				elseif py > y2 then
					Result.set (x1, y2)
				else
					Result.set (x1, py)
				end
			elseif px > x2 then
				if py < y1 then
					Result.set (x2, y1)
				elseif py > y2 then
					Result.set (x2, y2)
				else
					Result.set (x2, py)
				end
			else
				if py < y1 then
					Result.set (px, y1);
					-- not supported in postscript
					-- if not data.tag_is_south and then
						-- cluster_title.contains (Result)
					-- then
						-- Result.set_y (cluster_title.up_left.y);
					-- end;
				elseif py > y2 then
					Result.set (px, y2)
					-- not supported in postscript
					-- if data.tag_is_south and then
						-- cluster_title.contains (Result)
					-- then
						-- Result.set_y (cluster_title.down_right.y);
					-- end;
				else
					Result.set (x1, y1)
				end
			end
		end;
	
	set_color is
		local
			a_color: EV_COLOR
		do
			a_color := data.color;
			title.set_foreground_color (a_color)
			cluster.path.set_foreground_color (a_color);
			cluster_title.path.set_foreground_color (a_color);
		end;

end -- class GRAPH_CLUSTER
