indexing

	description: "Node that represents a graph linkable.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_SORT_NODE

inherit

	TOPOLOGICAL

creation

	make

feature -- Initialization

	make (link: like graph_linkable) is
		do
			graph_linkable := link
		end;

feature -- Properties

	graph_linkable: GRAPH_LINKABLE;
			-- Graph linkable that is being sorted

	x_level: INTEGER;
			-- Sort x level

	y_level: INTEGER;
			-- Sort y level

	topological_id: INTEGER;
			-- Topolical_id for graph_linkable

	successors: LINKED_LIST [like Current] is do end;

feature -- Access

	descendants (list: ARRAYED_LIST [GRAPH_LINKABLE]): LINKED_LIST [like Current] is
			--	Visible descendants in workarea in `list'.
		local
			parent_links: LINKED_LIST [INHERIT_DATA];
			parent_cluster: CLUSTER_DATA;
			graph_cluster: GRAPH_CLUSTER;
			found: BOOLEAN;
			cur: CURSOR
		do
			!! Result.make;
			parent_links := graph_linkable.data.parent_links;	
			if parent_links /= Void then
				cur := list.cursor;
				from
					parent_links.start
				until
					parent_links.after
				loop
					found := False
					from
						list.start
					until
						found or else list.after
					loop
						if list.item.data = parent_links.item.heir then
							found := True;
							Result.put_front (list.item.sort_node)
						end;
						list.forth
					end;
					parent_links.forth
				end;
				list.go_to (cur)
			end;
		end;

feature -- Setting 

	set_x_level (x: INTEGER) is
			-- Set x_level to `x'.
		require
			valid_x_value: x >= 0
		do
			x_level := x
		ensure
			x_level_set: x_level = x
		end;

	set_y_level (y: INTEGER) is
			-- Set y_level to `y'.
		require
			valid_y_value: y >= 0
		do
			y_level := y
		ensure
			y_level_set: y_level = y
		end;

	set_topological_id (id: INTEGER) is
			-- Set topological_id to `id'.
		do
			topological_id := id
		ensure
			topological_id_set: topological_id = id
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Order relation on linkables
		do
			Result := topological_id < other.topological_id;
		end;

end -- class GRAPH_SORT_NODE
