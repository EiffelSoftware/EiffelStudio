indexing

	description: 
		"Ancestor of graphical entity groups (cluster, workarea).";
	date: "$Date$";
	revision: "$Revision $"

deferred class GRAPH_GROUP 

feature -- Properties

	data: CLUSTER_DATA is
			-- Cluster associated with current group
		deferred
		end; -- data

	workarea: WORKAREA is
			-- Current workarea
		deferred
		end; -- workarea

	local_x: INTEGER is
			-- Horizontal position in workarea
		deferred
		end; -- local_x

	local_y: INTEGER is
			-- Vertical position in workarea
		deferred
		end -- local_y

feature -- Content properties

	cluster_list: GRAPH_LIST [GRAPH_CLUSTER];
			-- List of clusters in this cluster

	class_list: GRAPH_LIST [GRAPH_CLASS];
			-- List of classes in this cluster

	icon_list: GRAPH_LIST [GRAPH_ICON];
			-- List of icons in this cluster

	form_list: GRAPH_LIST [GRAPH_FORM] is
			-- List of forms in this group
		local
			old_position : CURSOR
		do
			!!Result.make;
			Result.merge (class_list);
			Result.merge (cluster_list);
			Result.merge (icon_list);
			old_position := cluster_list.cursor;
			from
				cluster_list.start
			until
				cluster_list.after
			loop
				Result.merge (cluster_list.item.form_list);
				cluster_list.forth
			end;
			cluster_list.go_to (old_position)
		end -- form_list

feature -- Access

	cluster_at (x_coord, y_coord: INTEGER): GRAPH_CLUSTER is
			-- Cluster pointed by `x_coord' and `y_coord'.
		local
			curs: CURSOR
		do
			curs := cluster_list.cursor;
			from
				cluster_list.start
			until
				cluster_list.after or not (Result = Void)
			loop
				Result := cluster_list.item.cluster_at (x_coord,
									y_coord);
				cluster_list.forth
			end;
			cluster_list.go_to (curs)
		end; -- cluster_at

	find_graph_group (to_search: CLUSTER_DATA): GRAPH_GROUP is
			-- Find recursively a GRAPH_CLUSTER whose `data' is `to_search'
		require
			not (to_search = Void)
		local
			curs: CURSOR
		do
			if data = to_search then
				Result := Current
			else
				curs := cluster_list.cursor;
				from
					cluster_list.start
				until
					cluster_list.after or not (Result = Void)
				loop
					Result := cluster_list.item.find_graph_group
									(to_search);
					cluster_list.forth
				end;
				cluster_list.go_to (curs)
			end
		end; 

	find_class (to_search: CLASS_DATA): GRAPH_CLASS is
			-- Find recursively a GRAPH_CLASS whose `data' is `to_search'
		require
			not (to_search = Void)
		local
			cur: CURSOR
		do
			cur := class_list.cursor;
			from
				class_list.start
			until
				class_list.after or not (Result = Void)
			loop
				if to_search = class_list.item.data then
					Result := class_list.item
				end;
				class_list.forth
			end;
			class_list.go_to (cur);
			cur := cluster_list.cursor;
			from
				cluster_list.start
			until
				cluster_list.after or not (Result = Void)
			loop
				Result := cluster_list.item.find_class (to_search);
				cluster_list.forth
			end;
			cluster_list.go_to (cur)
		end; 

	find_icon (to_search: CLUSTER_DATA): GRAPH_ICON is
			-- Find recursively a GRAPH_ICON whose `data' is `to_search'
		require
			to_search /= void
		local
			cur: CURSOR;
		do
			cur := icon_list.cursor;
			from
				icon_list.start
			until
				icon_list.after or Result /= void
			loop
				if to_search = icon_list.item.data then
					Result := icon_list.item
				end;
				icon_list.forth
			end;
			icon_list.go_to (cur);
			cur := cluster_list.cursor;
			from
				cluster_list.start
			until
				cluster_list.after or not (Result = Void)
			loop
				Result := cluster_list.item.find_icon (to_search);
				cluster_list.forth
			end;
			cluster_list.go_to (cur)
		end; 

	find_linkable (to_search: LINKABLE_DATA): GRAPH_LINKABLE is
			-- Find recursively a GRAPH_LINKABLE whose `data' is `to_search'
		require
			valid_search: to_search /= Void
		local
			cur: CURSOR;
			graph_cluster: GRAPH_CLUSTER
		do
			if to_search = data then
				graph_cluster ?= Current;
				Result := graph_cluster
			else
				cur := class_list.cursor;
				from
					class_list.start
				until
					class_list.after or Result /= void
				loop
					if to_search = class_list.item.data then
						Result := class_list.item
					end;
					class_list.forth
				end;
				class_list.go_to (cur);
				cur := icon_list.cursor;
				from
					icon_list.start
				until
					icon_list.after or Result /= void
				loop
					if to_search = icon_list.item.data then
						Result := icon_list.item
					end;
					icon_list.forth
				end;
				icon_list.go_to (cur);
				cur := cluster_list.cursor;
				from
					cluster_list.start
				until
					cluster_list.after or Result /= void
				loop
					Result := cluster_list.item.find_linkable
									(to_search);
					cluster_list.forth
				end;
				cluster_list.go_to (cur)
			end
		end; 

	find_linkable_in_current (to_search: LINKABLE_DATA): GRAPH_LINKABLE is
			-- Find recursively a GRAPH_LINKABLE whose `data' is `to_search'
		require
			valid_search: to_search /= Void
		local
			cur: CURSOR;
			graph_cluster: GRAPH_CLUSTER
		do
			if to_search = data then
				graph_cluster ?= Current;
				Result := graph_cluster
			else
				cur := icon_list.cursor;
				from
					icon_list.start
				until
					icon_list.after or Result /= void
				loop
					if to_search = icon_list.item.data then
						Result := icon_list.item
					end;
					icon_list.forth
				end;
				icon_list.go_to (cur);
				cur := cluster_list.cursor;
				from
					cluster_list.start
				until
					cluster_list.after or Result /= void
				loop
					if to_search = cluster_list.item.data then
						Result := cluster_list.item
					end;
					cluster_list.forth
				end;
				cluster_list.go_to (cur);
				cur := class_list.cursor;
				from
					class_list.start
				until
					class_list.after or Result /= void
				loop
					if to_search = class_list.item.data then
						Result := class_list.item
					end;
					class_list.forth
				end;
				class_list.go_to (cur);
			end
		end; 

	find_cluster (to_search: CLUSTER_DATA): GRAPH_CLUSTER is
			-- Find recursively a GRAPH_CLUSTER whose `data' is `to_search'
		require
			valid_search: to_search /= Void
		local
			cur: CURSOR;
			graph_cluster: GRAPH_CLUSTER
		do
			if to_search = data then
				graph_cluster ?= Current;
				Result := graph_cluster
			else
				cur := cluster_list.cursor;
				from
					cluster_list.start
				until
					cluster_list.after or (Result /= Void)
				loop
					Result := cluster_list.item.find_cluster
								(to_search);
					cluster_list.forth
				end;
				cluster_list.go_to (cur)
			end
		end 

feature -- Update

	update_lists is
			-- Update `cluster_list' and `class_list' from the system.
		deferred
		end 

end -- class GRAPH_GROUP
