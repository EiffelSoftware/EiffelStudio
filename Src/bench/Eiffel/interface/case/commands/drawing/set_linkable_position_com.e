indexing

	description: 
		"Command that positions a list of linkables in a workarea.";
	date: "$Date$";
	revision: "$Revision $"

class SET_LINKABLE_POSITION_COM

inherit

	EC_COMMAND;
	ALIGN_GRID

creation

	make

feature {NONE} -- Initialization

	make (parent_c: CLUSTER_DATA; list: LINKED_LIST [LINKABLE_DATA]) is
			-- Initialize Current with parent_cluster `parent_c' and
			-- `linkables_to_be_resolved' to `list'.
		require
			valid_parent_c: parent_c /= Void;
			valid_list: list /= Void
		do
			parent_cluster := parent_c;
			linkables_to_be_resolved := list
		ensure
			set: parent_cluster = parent_c and then
					linkables_to_be_resolved = list
		end;

feature -- Properties

	parent_cluster: CLUSTER_DATA;
			-- Parent cluster containing `linkables_to_be_resolved'

	linkables_to_be_resolved: LINKED_LIST [LINKABLE_DATA];
			-- List of linkables that need to be resolved for
			-- positioning

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Resolved positions for linkables in `linkables_to_be_resolved'.
			-- Should certainly be reviewed.
		local
			x1, y1, initial_x, initial_y: INTEGER;
			linkable: LINKABLE_DATA;
			max_width, final_width: INTEGER;
			cannot_fit_anymore, can_fit: BOOLEAN;
			linkable_width: INTEGER;
			cluster_data: CLUSTER_DATA;
			compress_links: COMPRESS_LINKS_U;
			enlarge_cluster: ENLARGE_CLUSTER
		do
			initial_y := 40;
			if parent_cluster.is_icon then
				max_width := 480
			else
				max_width := parent_cluster.width
			end;
			final_width := max_width;
			from
				linkables_to_be_resolved.start
			until
				linkables_to_be_resolved.after
			loop
				linkable := linkables_to_be_resolved.item;
				if linkable.is_cluster then
					cluster_data ?= linkable;
					!! compress_links.make (cluster_data, True);
					compress_links.redo
				end;
				can_fit := False;
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
						x1 := initial_x;
						y1 := initial_y;
						if linkable.is_class then
							x1 := x1 - parent_cluster.workarea_width // 2;
							y1 := y1 - parent_cluster.workarea_height // 2;
						end
						can_fit := parent_cluster.is_content_area_legal_for 
							(align_grid (x1), 
							align_grid (y1),
							parent_cluster.workarea_width,
							parent_cluster.workarea_height,
							linkable)
					else
						can_fit := True;
						cluster_data := linkable.parent_cluster;
						!! enlarge_cluster.make (cluster_data, 
								initial_y - parent_cluster.height +
								parent_cluster.workarea_height, 0)
					end;
				end;
				linkable_width := parent_cluster.workarea_width
				if linkable.is_class then
					-- pascalf, we test if it has already x and y
						-- Center for class
						if linkable.x=Void or linkable.x=0 then
							linkable.set_x (align_grid (initial_x +  
								linkable_width//2));
							linkable.set_y (align_grid (initial_y));
							initial_x := initial_x + parent_cluster.workarea_width;
							if initial_x > final_width then
								final_width := initial_x;
							end;
						else
							if (linkable.x+20)>final_width then
								final_width := linkable.x+20
							end
							if (linkable.y+20)>initial_y then 
								initial_y := linkable.y + 20
							end
						end
				else
					-- is a cluster
						linkable.set_x (align_grid (initial_x));
						linkable.set_y (align_grid (initial_y));
				end
				linkables_to_be_resolved.forth
			end;
			if parent_cluster.is_icon then
				if (initial_y = 40 and then initial_x < max_width) then
					final_width := initial_x
				end;
				if parent_cluster.width < final_width + 10 then
					parent_cluster.set_width (final_width + 10);	
				end
				if parent_cluster.height < initial_y + 40 then
					parent_cluster.set_height (initial_y + 40);	
				end
			end;
		ensure then
			valid_width_for_parent: parent_cluster.width > 0
			valid_height_for_parent: parent_cluster.height > 0
		end;

end -- class SET_LINKABLE_POSITION_COM
