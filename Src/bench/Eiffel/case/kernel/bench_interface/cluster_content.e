indexing

	description: "Clusters/classes of a given cluster.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_CONTENT

inherit

	S_CASE_INFO;		
	ONCES;
	CONSTANTS;
	ALIGN_GRID

creation

	make, make_from_storer

feature {NONE} -- Initialization

	make is
			-- Create current.
		do
			!! classes.make;
			!! clusters.make
		end;

	make_from_storer (cluster: CLUSTER_DATA; storer: S_CLUSTER_DATA;
		path: STRING; system_classes: HASH_TABLE [CLASS_DATA, INTEGER]) is
			-- Make from storage the cluster content for
			-- cluster `cluster' from path `path'.
		do
		end


feature -- Implementation

	classes: LINKED_LIST [ CLASS_DATA ]
			-- Classes within Cluster

	clusters: LINKED_LIST [ CLUSTER_DATA ]
			-- Clusters within Cluster

feature  -- Properties

	recursive_cli_sup_links: LINKED_LIST [CLI_SUP_DATA] is
			-- Recursive list of all links in current cluster
		do
			!! Result.make;
			from
				classes.start
			until
				classes.after
			loop
				Result.finish
				Result.merge_right (classes.item.recursive_cli_sup_links)

				classes.forth
			end;
			from
				clusters.start
			until
				clusters.after
			loop
				Result.finish
				Result.merge_right (clusters.item.recursive_cli_sup_links)
				clusters.forth
			end
		ensure
			valid_result: Result /= Void
		end; 

	visible_links: LINKED_LIST [CLI_SUP_DATA] is
			-- Recursively collect links which are not in iconized cluster
		do
			!! Result.make;
			from
				classes.start
			until
				classes.after
			loop
				Result.finish
				Result.merge_right (classes.item.visible_links)
				classes.forth
			end;
			from
				clusters.start
			until
				clusters.after
			loop
				Result.finish
				Result.merge_right (clusters.item.visible_links)
				clusters.forth
			end
		ensure
			valid_result: Result /= Void
		end;

	recursive_inherit_links: LINKED_LIST [INHERIT_DATA] is
			-- Recursive list of all links in current cluster
		do
			!! Result.make;
			from
				classes.start
			until
				classes.after
			loop
				Result.finish
				Result.merge_right (classes.item.recursive_inherit_links)
				classes.forth
			end;
			from
				clusters.start
			until
				clusters.after
			loop		
				Result.finish
				Result.merge_right (clusters.item.recursive_inherit_links);
				clusters.forth
			end
		ensure
			valid_result: Result /= Void
		end; 

	minimal_width: INTEGER is
			-- Minimal width of cluster.
			-- It must contains all objets inside.
		local
			cluster: CLUSTER_DATA
		do
			Result := 30;
			from
				classes.start
			until
				classes.after
			loop
				if classes.item.x >= Result then
					Result := classes.item.x
				end;
				classes.forth
			end;
			from
				clusters.start
			until
				clusters.after
			loop
				cluster := clusters.item;
				if cluster.is_icon then
					if cluster.x + cluster.icon_width >= Result then
						Result := cluster.x + cluster.icon_width
					end
				else
					if cluster.x + cluster.width >= Result then
						Result := cluster.x + cluster.width
					end
				end;
				clusters.forth
			end
		ensure
			positive: Result >= 0
		end;

	minimal_height: INTEGER is
			-- Minimal height of cluster.
			-- It must contains all objets inside.
		local
			cluster: CLUSTER_DATA
		do
			Result := 30;
			from
				classes.start
			until
				classes.after
			loop
				if classes.item.y >= Result then
					Result := classes.item.y
				end;
				classes.forth
			end;
			from
				clusters.start
			until
				clusters.after
			loop
				cluster := clusters.item;
				if cluster.is_icon then
					if cluster.y + cluster.icon_height >= Result then
						Result := cluster.y + cluster.icon_height
					end
				else
					if cluster.y + cluster.height >= Result then
						Result := cluster.y + cluster.height
					end
				end;
				clusters.forth
			end
		ensure
			positive: Result >= 0
		end;

feature {CLUSTER_DATA} -- Update

	update_cluster_name (a_cluster: CLUSTER_DATA) is
			-- Update the cluster name `a_cluster'.
		local
		--	ed: EC_CLASS_WINDOW;
			s_type: INTEGER
		do
--			s_type := a_cluster.stone_type;
--			from
--				classes.start
--			until
--				classes.after
--			loop
--				ed := classes.item.editor;
--				if ed /= Void then
--					ed.update_title;
--					ed.update_page (s_type);
--				end;
--				classes.forth
--			end;
		end;

feature {CLUSTER_DATA} -- Access

	new_content_area (area_x, area_y, area_width, area_height: INTEGER;
		linkable_moved: LINKABLE_DATA; 
		find_all: BOOLEAN): LINKED_LIST[LINKABLE_DATA] is
			-- Determine if 'cluster_moved` can classes the specified area 
		local
			is_area_legal: BOOLEAN;
			cluster: CLUSTER_DATA;
			c_lass: CLASS_DATA
		do
			!! Result.make;
			is_area_legal := True;
			from
				clusters.start
			until
				clusters.after or not is_area_legal
			loop
				cluster := clusters.item;
				if not cluster.is_hidden and then 
					linkable_moved /= cluster 
				then
					if cluster.is_icon then
						if (cluster.x >= area_x) and then
							(cluster.y > area_y) and then
							(cluster.x + cluster.icon_width <
							area_x + area_width) and then
							(cluster.y + cluster.icon_height <
							area_y + area_height)
						then
							Result.put_front (cluster)
						else 
								-- If areas intersects then it is not legal
							is_area_legal := not (cluster.x <= area_x + area_width and then
									cluster.x + cluster.icon_width >= area_x and then
									cluster.y <= area_y + area_height and then
									cluster.y + cluster.icon_height >= area_y)
							if find_all and then not is_area_legal then
								is_area_legal := True;
								Result.put_front (cluster)
							end;
						end
					else
						if (cluster.x >= area_x) and then
							(cluster.y > area_y) and then
							(cluster.x + cluster.width < area_x + area_width) and then
							(cluster.y + cluster.height < area_y + area_height)
						then
							Result.put_front (cluster)
						else
								-- If areas intersects then it is not legal
							is_area_legal := not (cluster.x <= area_x + area_width and then
									cluster.x + cluster.width >= area_x and then
									cluster.y <= area_y + area_height and then
									cluster.y + cluster.height >= area_y)
							if find_all and then not is_area_legal then
								is_area_legal := True;
								Result.put_front (cluster)
							end;
						end
					end
				end;
				clusters.forth
			end;
			if is_area_legal then
				from
					classes.start
				until
					classes.after 
				loop
					c_lass := classes.item;
					if not c_lass.is_hidden and then 
						c_lass /= linkable_moved
					then
						if (c_lass.x > area_x) and then
							(c_lass.y > area_y) and then
							(c_lass.x < area_x + area_width) and then
							(c_lass.y < area_y + area_height)
						then
							Result.put_front (c_lass)
						end
					end;
					classes.forth
				end;
			else
				Result := Void
			end
		end; 

	is_area_legal_for (area_x, area_y, area_width, area_height: INTEGER;
				linkable_moved: LINKABLE_DATA): BOOLEAN is
			-- Is specified area free of objects ?
		local
			c_lass: CLASS_DATA;
			cluster: CLUSTER_DATA
		do
			Result := True;
			from
				classes.start
			until
				classes.after or not Result
			loop
				c_lass := classes.item;
				if not c_lass.is_hidden and then
					c_lass /= linkable_moved
				then
					Result :=
						(c_lass.x < area_x) or else
						(c_lass.y < area_y) or else
						(c_lass.x > area_x+area_width) or else
						(c_lass.y > area_y+area_height);
				end;
				classes.forth
			end;
			from
				clusters.start
			until
				clusters.after or not Result
			loop
				cluster := clusters.item;
				if not cluster.is_hidden and then
					linkable_moved /= cluster
				then
					if cluster.is_icon then
						Result := 
							(cluster.x + cluster.icon_width < area_x) or
							(cluster.y + cluster.icon_height < area_y) or
							(cluster.x > area_x+area_width) or
							(cluster.y > area_y+area_height)
					else
						Result :=
							(cluster.x+cluster.width < area_x) or
							(cluster.y+cluster.height < area_y) or
							(cluster.x > area_x+area_width) or
							(cluster.y > area_y+area_height);
					end
				end;
				clusters.forth
			end;
		end;

	has_class (class_name: STRING): BOOLEAN is
			-- Does class `class_name' exists in current cluster
		require
			valid_class_name: class_name /= Void and then
								not class_name.empty
		local
			search_string: STRING;
		do
			search_string := clone (class_name);
			search_string.to_upper;
			from
				classes.start
			until
				classes.after or else
					Result
			loop
				Result := classes.item.name.is_equal (search_string);
				classes.forth
			end
		end;

	has_cluster (cluster_name: STRING): BOOLEAN is
			-- Does cluster `cluster_name' exists in current cluster
		require
			valid_cluster_name: cluster_name /= Void and then
								not cluster_name.empty
		local
			search_string: STRING;
		do
			search_string := clone (cluster_name);
			search_string.to_upper;
			from
				clusters.start
			until
				clusters.after or else Result
			loop
				Result := clusters.item.name.is_equal (search_string);
				clusters.forth
			end
		end;

	child_with_name (fn: STRING): LINKABLE_DATA is
			-- Does file_name `fn' exist in current cluster
		require
			valid_name: fn /= Void and then not fn.empty
		local
			tmp1, tmp2: STRING
		do
			tmp1 := clone (fn)
			tmp1.to_upper
			from
				classes.start
			until
				classes.after or else Result /= Void
			loop
				tmp2 := clone (classes.item.name)
				tmp2.to_upper
				if tmp1.is_equal (tmp2) then
					Result := classes.item
				end
				classes.forth
			end
			-- Removed by pascalf, 08/08/1999, since a cluster may have the same
			-- name of a class.
			--from
			--	clusters.start
			--until
			--	clusters.after or else Result /= Void
			--loop
			--	tmp2 := clone (clusters.item.name)
			--	tmp2.to_upper
			--	if tmp1.is_equal (tmp2) then
			--		Result := clusters.item
			--	end
			--	clusters.forth
			--end
		end;

feature {CLUSTER_DATA} -- Output

	generate_hidden_entities (text_area: TEXT_AREA; display_all: BOOLEAN) is
			-- Generate hidden entities into `text_area'.
		require
			valid_text_area: text_area /= Void
		local
			class_list: SORTED_TWO_WAY_LIST [CLASS_DATA]
			cluster_list: SORTED_TWO_WAY_LIST [CLUSTER_DATA];
			class_data: CLASS_DATA;
			cluster_data: CLUSTER_DATA
		do
			!! class_list.make;
			from
				classes.start
			until
				classes.after
			loop
				if classes.item.is_hidden then
					class_list.put_front (classes.item)
				end;
				classes.forth
			end;
			class_list.sort;
			from
				class_list.start
			until
				class_list.after
			loop
				class_data := class_list.item;
				class_data.generate_class (text_area);
				text_area.append_string (" of ");
				class_data.parent_cluster.generate_name (text_area);
				text_area.new_line;
				class_list.forth
			end;

			!! cluster_list.make;
			from
				clusters.start
			until
				clusters.after
			loop
				if clusters.item.is_hidden then
					cluster_list.put_front (clusters.item)
				end;
				clusters.forth
			end;
			cluster_list.sort;
			if not cluster_list.empty then
				from
					cluster_list.start
				until
					cluster_list.after
				loop
					cluster_data := cluster_list.item;
					cluster_data.generate_name (text_area);
					text_area.new_line;
					cluster_list.forth
				end;
			end;
			from
				clusters.start
			until
				clusters.after
			loop
				cluster_data := clusters.item;
				if display_all or else not cluster_data.is_icon then
					text_area.indent;
					cluster_data.generate_hidden_entities (text_area, 
								display_all);
					text_area.exdent;
				end;
				clusters.forth
			end
		end;

	generate_code_to_disk (path: STRING) is
			-- Generate code in directory `path'.
		local
		--	file: INDENT_FILE;
			dir: DIRECTORY;
			file_name: FILE_NAME
			a_class: CLASS_DATA
			error_fi : BOOLEAN
		do
		end -- generate_code

	--generate_code_to_eiffel_project (cluster: CLUSTER_DATA; path: STRING; classes_to_merge: MERGING_CLASS_LIST; caller: EV_WINDOW) is
			-- Generate code in directory `path'.
	--	do
	--	end -- generate_code

	--generate_all_clusters_to_eiffel_project (classes_to_merge: MERGING_CLASS_LIST; caller: EV_WINDOW) is
			-- Generate all clusters to the eiffel project
	--	do
	--	end 

	--generate_all_modified_classes (cluster: CLUSTER_DATA; path: STRING; classes_to_merge: MERGING_CLASS_LIST) is
	--	do
	--	end

feature {CLUSTER_DATA} -- Storage

	store_information (storer: S_CLUSTER_DATA) is
		do
		end

	update_from_view (cluster: CLUSTER_DATA; new_view: BOOLEAN) is
			-- Update cluster content from view information. `new_view'
			-- implies that cluster did not have a view.
		require
			valid_cluster: cluster /= Void;
		local
			class_data: CLASS_DATA;
			cluster_data: CLUSTER_DATA;
			cluster_name: STRING;
			class_view_list: FIXED_LIST [CLASS_VIEW];
			cluster_view_list: FIXED_LIST [CLUSTER_VIEW];
			linkables_to_be_resolved: LINKED_LIST [LINKABLE_DATA];
			class_view: CLASS_VIEW;
			cluster_view: CLUSTER_VIEW;
			set_pos_com: SET_LINKABLE_POSITION_COM;
			finished, found: BOOLEAN;
			view_id: INTEGER;
			cursor: CURSOR;
			finised: BOOLEAN
		do
			!! linkables_to_be_resolved.make;
			class_view_list := System.view.classes_with_cluster_id 
							(cluster.view_id);
			if class_view_list = Void then
				!! class_view_list.make(0);
				if not classes.empty then
					View_information.set_are_new_relations; 
				end
			end;
			cluster_name := cluster.name;
			from
				classes.start;
				class_view_list.start
			until
				classes.after
			loop
				class_data := classes.item;
				found := False
				if not class_view_list.after then
					view_id := class_data.view_id;
					class_view := class_view_list.item;
					if view_id = class_view.view_id then
						found := True;
					else
						-- comments below : optimization for retrieving
						--from
						--	finished := False
						--until
						--	class_view_list.after or finished
						--loop
						--	class_view := class_view_list.item;
						--	if class_view.view_id = view_id then
						--		found := True;
						--		finished := True;
						--	elseif class_view.view_id > view_id then
						--		finished := True;
						--	else
						--		class_view_list.forth
						--	end
						--end;
						-- non optimized now
						from 
							class_view_list.start
							finished := FALSE
						until 
							class_view_list.after or finished
						loop
							class_view := class_view_list.item
							if class_view.view_id = view_id then
								found := TRUE
								finished := TRUE
							else
								class_view_list.forth
							end
						end
						-- end modif
					end
				end;
				if found then
					class_view.update_data (class_data);
					class_view_list.forth
				else
					class_data.set_default;
					linkables_to_be_resolved.put_front (class_data);
					View_information.set_are_new_relations; 
				end;
				classes.forth;
			end;
			class_view_list := Void;
			cluster_view_list := 
						System.view.clusters_with_cluster_id (cluster.view_id);
			if cluster_view_list = Void then
				!! cluster_view_list.make (0);
			end;
			from
				clusters.start;
				cluster_view_list.start
			until
				clusters.after
			loop
				cluster_data := clusters.item;
				found := False;
				if not cluster_view_list.after then
					view_id := cluster_data.view_id;
					cluster_view := cluster_view_list.item;
					if view_id = cluster_view.view_id then
						found := True;
					else
						--same thing that above
						--from
						--	finished := False;
						--until
						--	cluster_view_list.after or else finished
						--loop
						--	cluster_view := cluster_view_list.item;
						--	if cluster_view.view_id = view_id then
						--		found := True;
						--		finished := True
						--	elseif cluster_view.view_id > view_id then
						--		finished := True
						--	else 
						--		cluster_view_list.forth
						--	end
						--end
						from 
							cluster_view_list.start
							finished := FALSE
						until 
							cluster_view_list.after or finished
						loop
							cluster_view := cluster_view_list.item
							if cluster_view.view_id = view_id then
								found := TRUE
								finished := TRUE
							else
								cluster_view_list.forth
							end
						end
						-- end modif
					end;
				end;
				if found then
					cluster_view.update_data (cluster_data);
					cluster_view_list.forth
				else
					cluster_view := Void;
					cluster_data.set_default;
					linkables_to_be_resolved.put_front (cluster_data);
				end;
				cursor := clusters.cursor;
					-- Manipulation in update_from_view may result
					-- in shifting the position in `clusters'.
				cluster_data.update_from_view (cluster_view = Void);
				clusters.go_to (cursor);
				clusters.forth
			end;
			if not linkables_to_be_resolved.empty then
				!! set_pos_com.make (cluster, linkables_to_be_resolved);
				set_pos_com.execute (Void, Void)
			end;
			if new_view then
					-- Make sure cluster width and height holds content for existing
					-- classes/clusters.
					-- This was needed since moving a cluster into another
					-- cluster does not mean its contents will loose their
					-- views. However, this cluster would loose its view (including
					-- its size). Thus we have to make sure that since its
					-- contents can retain its size the enclosing cluster must therefore
					-- update its size in order to be compatible with its contents.
				cluster.update_minimal_size
			end;
		end;

feature -- Debug

	trace is
		do
			from
				classes.start
			until
				classes.after
			loop
				classes.item.trace;
				classes.forth
			end
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.trace;
				clusters.forth
			end
		end

feature {NONE} -- Implementation

	file_name_to_class_name (file_name: FILE_NAME): STRING is
			-- Transforms a file name "my_class.e" in class name "MY_CLASS"
		do
			Result := clone (file_name)
			Result.head (Result.count - 2)
			Result.to_upper
		end

	is_sorted (l: FIXED_LIST [S_LINKABLE_DATA]): BOOLEAN is
			-- Is `l' sorted based on view id?
		local
			sorted_l: SORTED_TWO_WAY_LIST [S_LINKABLE_DATA]
		do
			if l = Void then
				Result := True
			else
				!! sorted_l.make;
				from
					l.start;
					sorted_l.start
				until
					sorted_l.after
				loop
					sorted_l.put_right (l.item);
					l.forth;
					sorted_l.forth
				end;
				Result := sorted_l.sorted
			end
		end
	
invariant

	classes_not_void: classes /= Void;
	clusters_not_void: clusters /= Void;

end  -- class CLUSTER_DATA
