indexing

	description: 
		"Factorization of graphical characteristics for linkables representation.";
	date: "$Date$";
	revision: "$Revision $"

deferred class GRAPH_LINKABLE 

inherit

	GRAPH_FORM
		redefine
			data
		end;
	ALIGN_GRID
		undefine
			is_equal
		end

feature -- Properties

	parent_group: GRAPH_GROUP;
			-- Parent group (cluster or workarea)

	local_x: INTEGER;
			-- Horizontal position in workarea

	local_y: INTEGER;
			-- Vertical position in workarea

	data: LINKABLE_DATA;

	center: EC_COORD_XY;
			-- figure's center.
			
	upper_left: EC_COORD_XY is
			-- figure upper left point.
		deferred
		end; -- upper_left
		
	bottom_right: EC_COORD_XY is
			-- figure bottom right poiont.
		deferred
		end; 

	sort_node: GRAPH_SORT_NODE is
			-- Sort node for current
		do
			if internal_sort_node = Void then
				!! internal_sort_node.make (Current);
			end;
			Result := internal_sort_node
		ensure
			valid_result: Result /= Void
		end;

	stone: STONE is
		do
			Result := data.stone
		end;

feature -- Access

	is_valid_in (relative_x, relative_y: INTEGER): BOOLEAN is
			-- Is `relative_x' and `relative_y' valid in Current?
		local
			origin_x, origin_y: INTEGER
		do
			origin_x := center.x+ relative_x;
			origin_y := center.y+ relative_y;
			Result := workarea.contains (origin_x, origin_y) 
		end;

	is_valid_in_other (a_workarea: WORKAREA; 
				relative_x, relative_y: INTEGER): BOOLEAN is
			-- Is `relative_x' and `relative_y' valid in other
			-- `a_workarea'?
		do
		end;

feature -- Removal

	wipe_out_sort_node is
			-- Wipe_out sort node information.
		do
			internal_sort_node := Void
		ensure
			inter_sort_is_void: internal_sort_node = Void
		end

feature {WORKAREA_MOVE_DATUM_COM} -- Implementation Access

	final_point_at_position (p: EC_COORD_XY;
				rel_x, rel_y: INTEGER; align_coord: BOOLEAN): EC_COORD_XY is
			-- Point where a line from `p' to Current
			-- with relative positions `rel_x' and `rel_y'
		require
			p /= void
		deferred
		ensure
			valid_result: Result /= void
		end 

feature {GRAPH_RELATION, WORKAREA_MOVE_DATUM_COM, 
	WORKAREA_MOVE_HANDLE_COM, WORKAREA_ADD_HANDLE_COM} -- Implementation Access

	handle_to (p: EC_COORD_XY): EC_COORD_XY is
			-- Point on the linkable used to reach `p'
		require
			p /= void
		do
			Result := final_point_at_position (p, 0, 0, false)
		ensure
			valid_result: Result /= void
		end -- handle_to

feature {NONE} -- Implementation

	destroy_links_in (list: GRAPH_LIST [GRAPH_RELATION]) is
			-- Destroy all links linked with current linkable.
		require
			list /= void
		do
			from
				list.start
			until
				list.off
			loop
				if list.item.to_form = Current or
				list.item.from_form = Current
				then
					list.item.erase;
					list.remove
				else
					list.forth
				end
			end
		end; -- destroy_links_in

	deselect_links is
			-- Deselect all links linked with current linkable
		local
			list: GRAPH_LIST[GRAPH_FORM];
			relation: GRAPH_RELATION
		do
			list := workarea.selected_figures;
			from
				list.start
			until
				list.off
			loop
				relation ?= list.item;
				if relation /= Void and then
				(relation.from_form = Current or
					relation.to_form = Current)
				then
					list.remove
				else
					list.forth
				end
			end
		end 

feature {NONE} -- Implementation specification

	internal_sort_node: GRAPH_SORT_NODE;

invariant

	has_center: center /= void

end -- class GRAPH_LINKABLE
