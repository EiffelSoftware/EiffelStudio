indexing

	description: 
		"Undoable command for showing a linkable entity.";
	date: "$Date$";
	revision: "$Revision $"

class SHOW_LINKABLE_U

inherit

	LINKABLE_ABSTRACTION;
	ALIGN_GRID

creation

	make

feature -- Initialization

	make (a_data: like linkable_data) is
		require
			valid_data: a_data /= Void;
			data_is_hidden: a_data.is_hidden
		local
			cluster_data,cluster_data2, parent_cluster: CLUSTER_DATA;
			initial_x, initial_y: INTEGER;
			can_fit: BOOLEAN;
			max_width: INTEGER;
			x1, y1, width, height: INTEGER
		do
			linkable_data := a_data
			parent_cluster := linkable_data.parent_cluster
			cluster_data ?= linkable_data
			x1 := a_data.x
			y1 := a_data.y
			if cluster_data /= Void then
				width := cluster_Data.workarea_width
				height := cluster_data.workarea_height
			else
				width := parent_cluster.workarea_width
				height := parent_cluster.workarea_height
			end
			if linkable_data.is_class then
				x1 := x1 - width // 2;
				y1 := y1 - height // 2;
			end;
			if not parent_cluster.is_area_legal_for 
				(x1, y1, width, height,
					linkable_data)	
			then
				had_to_move := True
				initial_y := 40;
				initial_x := 30;
				linkable_data := a_data;
				if parent_cluster.is_icon then
					max_width := 480
				else
					max_width := parent_cluster.width
				end;
				from
				until
					can_fit
				loop
					initial_x := initial_x + 30;
					if initial_x > max_width then
						initial_x := 30;
						initial_y := initial_y + 80;
					end;
					if parent_cluster.is_icon or else
						(parent_cluster.width > initial_x and then
							parent_cluster.height > initial_y)
					then
						cluster_data ?= linkable_data
						if cluster_data /= Void then	
							can_fit := parent_cluster.is_content_area_legal_for
									(align_grid (initial_x), 
									align_grid (initial_y),
									cluster_data.workarea_width, 
									cluster_data.workarea_height,
									linkable_data)	
						else
							can_fit := parent_cluster.is_content_area_legal_for
									(align_grid (initial_x), 
									align_grid (initial_y),
									a_data.parent_cluster.workarea_width, 
									a_data.parent_cluster.workarea_height,
									linkable_data)	
						end
					else
						can_fit := True
						cluster_data := linkable_data.parent_cluster
						cluster_data2 ?= linkable_data
						if cluster_data2 /= Void then
							!! enlarge_cluster.make (cluster_data, 
							initial_y - parent_cluster.height + 
							cluster_data2.workarea_height, 0)
						else
							!! enlarge_cluster.make (cluster_data, 
							initial_y - parent_cluster.height + 
							linkable_data.parent_cluster.workarea_height, 0)
						end
					end
				end
				if linkable_data.is_class then
						-- Center for class
					x := align_grid (initial_x + 
							linkable_data.parent_cluster.workarea_width//2);
				else
					x := align_grid (initial_x);
				end
				y := align_grid (initial_y);
			end;
			record;
			redo;
		end;

feature -- Property

	name: STRING is "Show linkable";

feature -- Update

	redo is
		local
			old_x, old_y: INTEGER
		do
			if had_to_move then
				if enlarge_cluster /= Void then
					enlarge_cluster.redo
				end;
				old_x := linkable_data.x;
				old_y := linkable_data.y;
				if x /= 0 then
					linkable_data.set_x (x);
				end;
				if y /= 0 then
					linkable_data.set_y (y)
				end;
				x := old_x;
				y := old_y;
			end;
			show_linkable
		end;

	undo is
		local
			old_x, old_y: INTEGER
		do
			if had_to_move then
				if enlarge_cluster /= Void then
					enlarge_cluster.undo
				end;
				old_x := linkable_data.x;
				old_y := linkable_data.y;
				linkable_data.set_x (x);
				linkable_data.set_y (y);
				x := old_x;
				y := old_y;
			end;
			hide_linkable;
		end;

feature {NONE} -- Implementation

	enlarge_cluster: ENLARGE_CLUSTER;

	had_to_move: BOOLEAN;

	x, y: INTEGER

end -- class SHOW_LINKABLE_U
