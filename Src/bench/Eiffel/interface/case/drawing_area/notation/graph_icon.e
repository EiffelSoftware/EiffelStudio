indexing

	description: 
		"Graphical representation for an iconized cluster.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_ICON

inherit

	GRAPH_LINKABLE
		rename
			select_it as old_select,
			unselect as old_unselect
		redefine
			data
		end;

	GRAPH_LINKABLE
		redefine
			unselect, select_it, data
		select
			unselect, select_it
		end

creation

	make

feature {NONE} -- Initialization

	make (a_cluster: CLUSTER_DATA; graph_group: GRAPH_GROUP) is
			-- create GRAPH_CLUSTER object with a_cluster as link 
		require
			a_cluster_exists: a_cluster /= void;
			is_iconized: a_cluster.is_icon
		local
			interior: EC_INTERIOR;
			iconized_interior: EC_INTERIOR;
			path: EC_PATH
		do
			data := a_cluster;
			parent_group := graph_group;
			!!center;
			parent_group.icon_list.add_form (Current);
			!!title.make
			observer_management.add_observer(data,title)
			title.set_text (data.name);
			title.set_font (Resources.cluster_name_font);
			!!cluster_title.make;
			!! path.make;
			path.set_line_width (2);
			path.set_onoffdash_line;
			cluster_title.set_path (path);
			!!interior.make;
			cluster_title.set_interior (interior);
			!!cluster.make;
			cluster.set_path (path);
			!!iconized_interior.make;
			iconized_interior.set_foreground_color (Resources.cluster_iconized_color);
			cluster.set_interior (iconized_interior);
			!!interior.make;
			interior.set_foreground_color (Resources.drawing_bg_color);
			!!erase_rectangle.make;
			erase_rectangle.path.set_foreground_color
				(Resources.drawing_bg_color);
			erase_rectangle.set_interior (interior);
			set_unselected_style;
			attach_workarea (graph_group.workarea);
			build;
			set_color;
			update_clip_area;
		ensure
			data = a_cluster;
			closure_created: closure /= Void;
			title_exists: title /= Void;
			cluster_exists: cluster /= Void;
			cluster_is_icon: data.is_icon
		end 

feature -- Properties

	data: CLUSTER_DATA
			-- Cluster data associated with Current graphical figure

	order: INTEGER is 3
			-- Precedence of 'Current' as graphical entity

	upper_left: EC_COORD_XY is
			-- Figure at upper left point.
		do
			!!Result;
			Result.set(cluster.up_left.x, cluster.up_left.y)
		end; -- upper_left

	bottom_right: EC_COORD_XY is
			-- Figure at bottom right point.
		do
			!!Result;
			Result.set(cluster.down_right.x, cluster.down_right.y)
		end; -- bottom_right

	closure: EC_CLOSURE is
			-- Cluster's closure
		do
			Result := erase_rectangle.closure
		end; -- closure

	cluster_title: EC_CLUSTER_FIG;
			-- Cluster which contains the title

	cluster: EC_CLUSTER_FIG;
			-- Global cluster

	title: EC_TEXT_FIG;
			-- Title figure

	erase_rectangle: EC_RECTANGLE;
			-- Rectangle who cover all the cluster

	origin: EC_COORD_XY is
			-- Origin a the inheritance link
		do
			Result := cluster.up_left
		end 

feature -- Access

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		local
			p: EC_COORD_XY
		do
			!!p;
			p.set (x_coord, y_coord);
			if cluster.contains (p) or cluster_title.contains (p) then
				Result := Current
			end
		end -- figure_at

feature -- Setting

	attach_workarea (a_workarea: WORKAREA) is
			-- Attach a workarea to the figure
		do
			workarea := a_workarea;
			cluster_title.attach_drawing (a_workarea);
			cluster.attach_drawing (a_workarea);
			title.attach_drawing (a_workarea);
			erase_rectangle.attach_drawing (a_workarea)
		end; 

feature -- Output

	draw_border is
			-- Draw the border of icon.
		local
			icon_title_interior: EC_INTERIOR
		do
			icon_title_interior := cluster_title.interior;
			cluster_title.set_interior (Void);
			cluster_title.draw;
			cluster_title.set_interior (icon_title_interior);
			cluster.draw
		end; 

	draw is
			-- Draw the border of icon.
		do
			cluster.draw;
			cluster_title.draw;
			title.draw
		end;

	erase_drawing is
			-- Erase current figure.
		do
			erase_rectangle.draw
		end; 

	select_it is
			-- Set `selected' to true.
			-- Add this figure in `workarea.selected_figures'.
			-- Draw this figure.
		do
			set_selected_style;
			old_select
		end; -- select_it

	unselect is
			-- Set `selected' to false.
			-- Remove this figure in `workarea.selected_figures'.
			-- Draw this figure.
		do
			set_unselected_style;
			old_unselect
		end; -- unselect

	invert_skeleton (painter: PATCH_PAINTER; relative_x, relative_y: INTEGER) is
			-- Invert the cluster's skeleton.
			-- Draw on `painter' as if the origin is at
			-- (`origin_x', `origin_y').
		local
			origin_x, origin_y: INTEGER
		do
			origin_x := align_grid (local_x+relative_x);
			origin_y := align_grid (local_y+relative_y);
			painter.draw_rectangle (origin_x+
				Resources.cluster_icon_x_margin,
				origin_y-(cluster_title.down_right.y-
				cluster_title.up_left.y),
				cluster_title.down_right.x-cluster_title.up_left.x,
				cluster_title.down_right.y-cluster_title.up_left.y);
			painter.draw_rectangle
				(origin_x, origin_y,
				cluster.down_right.x-cluster.up_left.x,
				cluster.down_right.y-cluster.up_left.y)
		end 

feature {NONE} -- Selection management

	set_selected_style is
			-- Set color for selected state.
		do
			cluster_title.interior.set_foreground_color
						(Resources.selected_interior_color);
			title.set_foreground_color (Resources.selected_invert_color)
		end; -- set_selected_style

	set_unselected_style is
			-- Set color for unselected state.
		local
			no_interior: EC_INTERIOR
		do
			cluster_title.interior.set_foreground_color
								(Resources.cluster_title_interior_color);
			title.set_foreground_color (data.color)
		end -- set_unselected_style

feature -- Removal

	destroy_without_clip_update is
			-- Destroy this and all its links.
			-- Do not update the clip area. 
		do
			destroy_links_in (workarea.aggreg_list);
			destroy_links_in (workarea.cli_sup_list);
			destroy_links_in (workarea.inherit_list)
		end; -- destroy

feature -- Update

	update_form is
			-- Update the content according to the
			-- correpsonding entity.
		local
			new_group: GRAPH_GROUP
		do
			if parent_group.data /= data.parent_cluster then
				parent_group.icon_list.remove_form (Current);
				new_group := workarea.find_graph_group
								(data.parent_cluster);
				if new_group /= void then
					parent_group := new_group;
					new_group.icon_list.add_form (Current)
				end
			end;
			title.set_text (data.name);
			build
		end 

feature {NONE} -- Specifications

	title_text_width: INTEGER is
			-- Width of title
		do
			Result := Resources.cluster_name_font.string_width (title.text)
		end;

	title_text_height: INTEGER is
			-- Height of title
		do
			Result := Resources.cluster_name_font.ascent +
				Resources.cluster_name_font.descent
		end 

feature {NONE} -- Implementation access

	inside_rectangle (x_rel, y_rel, minx, miny, maxx, maxy: INTEGER): BOOLEAN is
			-- Is `x_rel', `y_rel' in (`minx', `miny', `maxx', `maxy') ?
		do
			Result := (x_rel >= minx) and (y_rel >= miny) and
				(x_rel <= maxx) and (y_rel <= maxy)
		end -- inside_rectangle

feature {NONE} -- Implementation

	build is
			-- put the differents elements according to cluster position.
		local
			length: INTEGER;
			icon_x_margin: INTEGER;
			title_margin, title_margin_2: INTEGER
		do
			local_x := data.x+parent_group.local_x;
			local_y := data.y+parent_group.local_y;
			length := title_text_width;
			if length < 30 then
				length := 30
			end;
			icon_x_margin := Resources.cluster_icon_x_margin;
			title_margin := Resources.cluster_title_margin;
			title_margin_2 := title_margin*2;
			title.base_left.set (local_x+title_margin+icon_x_margin,
								local_y-title_margin);
			cluster_title.up_left.set (local_x+icon_x_margin,
					local_y-title_text_height-title_margin_2);
			cluster_title.down_right.set (local_x+length+title_margin_2+
							icon_x_margin, local_y);
			cluster_title.build;
			cluster.up_left.set (local_x, local_y);
			cluster.down_right.set (
				local_x+length+title_margin_2+icon_x_margin*2,
				local_y+Resources.cluster_icon_y_margin);
			cluster.build;
			erase_rectangle.upper_left.set
				(cluster.up_left.x-1, cluster_title.up_left.y-1);
			erase_rectangle.set_width
				(cluster.down_right.x-cluster.up_left.x+2);
			erase_rectangle.set_height
				(cluster.down_right.y-cluster_title.up_left.y+2);
			center.set_x ((cluster.up_left.x+cluster.down_right.x) // 2);
			center.set_y ((cluster.up_left.y+cluster.down_right.y) // 2);
			recompute_closure
		end; -- build

	recompute_closure is
			-- Recalculate closure.
		do
			erase_rectangle.recompute_closure
		end; -- recompute_closure

	set_color is
			-- Set color to Current.
		local
			a_color: EV_COLOR
		do
			a_color := data.color;
			title.set_foreground_color (a_color)
			cluster.path.set_foreground_color (a_color);
			cluster_title.path.set_foreground_color (a_color);
		end;

feature {WORKAREA_MOVE_DATUM_COM} -- Implementation access

	final_point_at_position (p: EC_COORD_XY;
				rel_x, rel_y: INTEGER; align_coord: BOOLEAN): EC_COORD_XY is
			-- Point where a line from `from_pt' to Current
			-- with relative positions `rel_x' and `rel_y'
		local
			x1, y1, x2, y2: INTEGER;
			px, py: INTEGER
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
					Result.set (x1, p.y)
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
					Result.set (px, y1)
					if cluster_title.contains (Result) then
						Result.set_y (cluster_title.up_left.y);
					end;
				elseif py > y2 then
					Result.set (px, y2)
					if data.tag_is_south and then
						cluster_title.contains (Result)
					then
						Result.set_y (cluster_title.down_right.y);
					end;
				else
					Result.set (x1, y1)
				end
			end
		end

end -- class GRAPH_ICON
