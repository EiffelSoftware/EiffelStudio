indexing

	description: "Data representation of cluster data";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_DATA 

inherit

	LINKABLE_DATA
		redefine
			recursive_inherit_links, recursive_cli_sup_links,
			is_in_system, update_name, 
			visible_links, trace, relative_center
		end

	HASHABLE

creation

	make, make_root, make_root_from_storer, make_from_storer

feature -- Initialization

	make (cluster_name: STRING; i: INTEGER) is
			-- Create a CLUSTER_DATA object with `cluster_name' as cluster 
			-- name.
		require
			name_exists: cluster_name /= void;
			name_not_empty: not cluster_name.empty;
			valid_i: i < 0
		local
			col: EV_COLOR
		do
			set_name (cluster_name);
			!! content.make;
		--	!! chart.do_nothing;
		--	!! description.make_with_default;
			view_id := i
			!! col.make_rgb(0,0,255)
			set_color(col)
		ensure
			correctly_set: name.is_equal (cluster_name)
		end

	make_root (cluster_name: STRING; i: INTEGER) is
			-- Create a CLUSTER_DATA object with `cluster_name' as cluster 
			-- name.
		require
			name_exists: cluster_name /= void;
			name_not_empty: not cluster_name.empty;
			valid_i: i < 0
		do
			make (cluster_name, i)
			is_root := true
			is_root_for_generation := true
		ensure
			correctly_set: name.is_equal (cluster_name);
			is_root: is_root
		end

	make_root_from_storer (storer: S_CLUSTER_DATA; path: STRING) is
			-- Retrieve information from `storer'.
		require
			valid_storer	: storer	/= void
		do
			if system.has_system_data_to_load then 
				view_id := storer.view_id + system.view_id
			else
				view_id := storer.view_id;
				is_root := True;
			end
			View_information.add_cluster (Current);
		--	make_from_storer (storer, path, System.system_classes);
		end;

feature -- Internal Properties

	is_icon: BOOLEAN;
			-- Is current cluster iconified ?

	tag_relative_x: INTEGER;
			-- Relative horizontal position of tag

	tag_is_south: BOOLEAN;
			-- Is tag located to the south of cluster

	width: INTEGER;
			-- Cluster's physical width on drawing area

	height: INTEGER;
			-- Cluster's physical height on drawing area

	icon_width: INTEGER;
			-- Cluster's physical icon_width on drawing area

	icon_height: INTEGER;
			-- Cluster's physical icon_height on drawing area

	is_in_system: BOOLEAN is
			-- Is current entity in system ?
		do
			Result := precursor or is_root
		end

feature -- Implementation

	is_root: BOOLEAN;
			-- Is this cluster the root cluster ?

	is_class: BOOLEAN is FALSE

	content: CLUSTER_CONTENT;
			-- Classes/clusters within Current cluster

feature -- Access

	clusters: LINKED_LIST [ CLUSTER_DATA ] is
			-- Clusters contained in Current cluster
		require
			valid_content	: content	/= void
		do
			Result := content.clusters
		end

	id: INTEGER is
			-- Id is the view_id
		do
			Result := view_id
		ensure then
			valid_result: Result = view_id 
		end

	classes: LINKED_LIST [CLASS_DATA] is
			-- Classes contained in Current cluster
		require
			valid_content	: content	/= void
		do
			Result := content.classes;
		end; 

	default_color: EV_COLOR is
			-- Default color
		require else
			valid_resources	: resources	/= void
		do
			Result := Resources.cluster_color
		end

	hash_code: INTEGER is
		require else
			valid_name	: name	/= void
		do
			Result := name.hash_code
		end

	minimal_width: INTEGER is
			-- Minimal width of cluster.
			-- It must contains all objets inside.
		require
			cluster_in_system: is_in_system
			valid_content	: content	/= void
		local
			cluster: CLUSTER_DATA
		do
			Result := content.minimal_width
		ensure
			positive: Result >= 0
		end; 

	minimal_height: INTEGER is
			-- Minimal height of cluster.
			-- It must contains all objets inside.
		require
			cluster_in_system: is_in_system
			valid_content	: content	/= void
		local
			cluster: CLUSTER_DATA
		do
			Result := content.minimal_height
		ensure
			positive: Result >= 0
		end;

	workarea_width: INTEGER is
		do
			if is_icon then
				Result := icon_width
			else
				Result := width
			end
		end;

	workarea_height: INTEGER is
		do
			if is_icon then
				Result := icon_height
			else
				Result := height
			end
		end

feature -- Settings

	set_view_id ( i: INTEGER ) is
		do
			view_id := i
		end

feature -- Link properties

	recursive_cli_sup_links: LINKED_LIST [CLI_SUP_DATA] is
			-- Recursive list of all links in current cluster
		do
			Result := precursor
			Result.append (content.recursive_cli_sup_links)
		end; 

	visible_links: LINKED_LIST [CLI_SUP_DATA] is
			-- Recursively collect links which are not in iconized cluster
			-- (Only clients and heir links).
		do
			Result := precursor
			if client_links /= void then
				merge_list_into (client_links, Result)
			end
			if not is_icon then
				Result.finish
				Result.merge_right (content.visible_links)
			end
		end

	icon_heir_links (all_heirs: BOOLEAN): LINKED_LIST [INHERIT_DATA] is
		local
			list: LINKED_LIST [INHERIT_DATA];
		do
			if all_heirs then
				list := extern_inherit_links;
			else
				list := heir_links
			end;
			if list /= Void then
				!! Result.make;
				from
					list.start
				until
					list.after
				loop
					if list.item.is_compressed then
						Result.put_front (list.item)
					end;
					list.forth
				end;
			else
				!! Result.make
			end
		ensure
			valid_result: Result /= Void
		end;

	icon_client_links (all_clients: BOOLEAN): LINKED_LIST [CLI_SUP_DATA] is
		local
			list: LINKED_LIST [CLI_SUP_DATA];
		do
			if all_clients then
				list := extern_client_links;
			else
				list := client_links
			end;
			if list /= Void then
				!! Result.make;
				from
					list.start
				until
					list.after
				loop	
					if list.item.is_compressed then
						Result.put_front (list.item)
					end;
					list.forth
				end;
			else
				!! Result.make
			end
		ensure
			valid_result: Result /= Void
		end;

	recursive_inherit_links: LINKED_LIST [INHERIT_DATA] is
			-- Recursive list of all links in current cluster
		do
			Result := precursor
			Result.finish
			Result.merge_right (content.recursive_inherit_links)	
		end


feature -- Settings

	set_icon (value: like is_icon) is
			-- Set `icon'.
		do
			is_icon := value
		ensure
			is_icon = value
		end; 

	set_tag_relative_x (value: like tag_relative_x) is
			-- Set relative horizontal position of tag.
		do
			tag_relative_x := value
		ensure
			tag_relative_x = value
		end; 

	set_tag_south (value: like tag_is_south) is
			-- Set `tag_is_south'.
		do
			tag_is_south := value
		ensure
			tag_is_south = value
		end;

	set_width (new_width: like width) is
			-- Set 'width`.
		require
			new_width_positive: new_width > 0
		do
			width := new_width
		end;

	set_height (new_height: like width) is
			-- Set 'height`.
		require
			new_height_positive: new_height > 0
		do
			height := new_height
		end;

	set_icon_width (new_width: like width) is
			-- Set 'width`.
		require
			new_width_positive: new_width > 0
		do
			icon_width := new_width
		end;

	set_icon_height (new_height: like width) is
			-- Set 'height`.
		require
			new_height_positive: new_height > 0
		do
			icon_height := new_height
		end;

	set_cluster_details (v: CLUSTER_VIEW) is
		require
			valid_v	: v	/= void
		do
			is_icon := v.is_icon;
			height := v.height;
			width := v.width;
			tag_relative_x := v.tag_relative_x;
			tag_is_south := v.tag_is_south;
			icon_height := v.icon_height;
			icon_width := v.icon_width;
		end;

	set_name (s: STRING) is
			-- set name from `s'.
		require else
			valid_resources	: resources	/= void
		do
			name := clone (s);
			name.to_upper;
			set_file_name (s);
			--set_icon_width (Resources.cluster_title_margin * 2 +
			--			Resources.cluster_icon_x_margin * 2 +
			--			Resources.cluster_name_font.width_of_string (name));
		end;


	set_file_name ( s :STRING ) is
			-- set file_name from `s'.
		do
			!!file_name.make 
			if s=Void or else s.count=0 then 
				file_name.extend( clone ( name ))
			else
				file_name.extend( deep_clone (s))
			end
		end

feature -- Graphical questions.

	includes (other: like Current): BOOLEAN is
			-- Does Current include `other' in tn
		require
			valid_other	: other	/= void
		do
			Result :=
				(other.x <= x + width) and then
				(other.x + other.width >= x) and then
				(other.y <= y + height) and then
				(other.y + other.height >= y)
		end;

	intersects (other: like Current): BOOLEAN is
			-- Does Current intersects with `other'?
		require
			not_icon: not is_icon;
			valid_other: other /= Void
			other_not_icon: not other.is_icon
		do
			Result :=
				(other.x <= x + width) and then
				(other.x + other.width >= x) and then
				(other.y <= y + height) and then
				(other.y + other.height >= y)
		end;

	visible_descendant_of (linkable: LINKABLE_DATA): BOOLEAN is
			-- Is current linkable a visible descendant of `linkable' ?
		do
			if linkable = Current then
				Result := true
			elseif parent_cluster /= void then
				if not is_hidden then
					if not (parent_cluster.is_icon and
						parent_cluster /= linkable)
					then
						Result := parent_cluster.visible_descendant_of
										(linkable)
					end
				end
			end
		end;

	contains_linkable (linkable: LINKABLE_DATA): BOOLEAN is
			-- Does current contain `linkable' ?
		local
			p_cluster: like Current
		do
			if linkable = Current then
				Result := True
			else
				p_cluster := linkable.parent_cluster;
				if p_cluster /= Void then
					Result := contains_linkable (p_cluster)
				end
			end
		end;

	find_compress_which_can_take (relation: RELATION_DATA):
					COMP_LINK_DATA [RELATION_DATA_KEY] is
			-- Find a compress link that could take relation
			-- from Current cluster.
			-- (Void if not found)
		require
			valid_relation: relation /= Void
		local
			rel_data: RELATION_DATA;
			links: LINKED_LIST [RELATION_DATA]
		do
			if relation.is_inheritance then
				links := heir_links;
				if links /= Void then
					from
						links.start
					until
						links.after or else
						Result /= Void
					loop
						rel_data := links.item;
						if rel_data.is_able_to_compress (relation) then
							Result ?= rel_data
						end;
						links.forth
					end;
				end;
			else
				links := client_links;
				if links /= Void then
					from
						links.start
					until
						links.after or else
						Result /= Void
					loop
						rel_data := links.item;
						if rel_data.is_able_to_compress (relation) then
							Result ?= rel_data
						end;
						links.forth
					end;
				end
			end;
			if Result = Void and then
				parent_cluster /= Void
			then
				Result := parent_cluster.find_compress_which_can_take
					(relation)
			end;
		end;

	maximal_left_extend (new_y, new_height: INTEGER): INTEGER is
			-- Maximal width of cluster.
			-- It must not cover other objects.
		require
			cluster_in_system: is_in_system
		do
			if is_root or is_icon then
				Result := 30000
			else
				Result := x + width
			end;
			Result := Result - 1
		ensure
			maximal_more_than_minimal_width: Result >= minimal_width
		end;

	maximal_right_extend (new_y, new_height: INTEGER): INTEGER is
			-- Maximal width of cluster.
			-- It must not cover other objects.
		require
			cluster_in_system: is_in_system
		do
			if is_root or is_icon then
				Result := 30000
			else
				Result := parent_cluster.width - x
			end;
			Result := Result - 1
		ensure
			maximal_more_than_minimal_width: Result >= minimal_width
		end;

	maximal_top_extend (new_x, new_width: INTEGER): INTEGER is
			-- Maximal height of cluster.
			-- It must not cover other objects.
		require
			cluster_in_system: is_in_system
		local
			other_x, other_width, other_y: INTEGER
		do
			if is_root or is_icon then
				Result := 30000
			else
				Result := y + height
			end;
			Result := Result-1
		ensure
			maximal_more_than_minimal_height: Result >= minimal_height
		end;

	maximal_bottom_extend (new_x, new_width: INTEGER): INTEGER is
			-- Maximal height of cluster.
			-- It must not cover other objects.
		require
			cluster_in_system: is_in_system
		local
			other_x, other_width, other_y: INTEGER
		do
			if is_root or is_icon then
				Result := 30000
			else
				Result := parent_cluster.height - y;
			end;
			Result := Result-1
		ensure
			maximal_more_than_minimal_height: Result >= minimal_height
		end; 

	new_content_area (area_x, area_y, area_width, area_height: INTEGER;
		cluster_moved: CLUSTER_DATA): LINKED_LIST[LINKABLE_DATA] is
			-- Determine if 'cluster_moved` can move classes the specified area 
		require
			valid_content	: content	/= void
		do
			Result := content.new_content_area (area_x, area_y,
							area_width, area_height, cluster_moved,
							false)
		end;

	all_entities_in_area (area_x, area_y, area_width, area_height: INTEGER;
		cluster_moved: CLUSTER_DATA): LINKED_LIST[LINKABLE_DATA] is
			-- Enitities contained in area
		require
			valid_content	: content	/= void
		do
			Result := content.new_content_area (area_x, area_y,
							area_width, area_height, cluster_moved,
							true)
		ensure
			valid_result: Result /= Void
		end; -- new_classes_area

	is_area_legal_for (area_x, area_y, area_width, area_height: INTEGER;
				linkable_moved: LINKABLE_DATA): BOOLEAN is
			-- Is specified area free of objects ?
		require
			valid_content	: content	/= void
		do
			Result :=  (area_x > 0) and (area_y > 0) and
						(area_x + area_width < width) and
						(area_y + area_height < height);
			if Result then
				Result := content.is_area_legal_for (area_x, area_y, 
						area_width, area_height, linkable_moved)
			end;
		end;

	is_content_area_legal_for (area_x, area_y, area_width, 
				area_height: INTEGER;
				linkable_moved: LINKABLE_DATA): BOOLEAN is
			-- Is specified area free of objects ?
		require
			valid_content	: content	/= void
		do
			Result := content.is_area_legal_for (area_x, area_y, 
					area_width, area_height, linkable_moved)
		end;

	relative_center (parent_cl: PS_CLUSTER): EC_COORD_XY is
			-- Center relative to parent cluster `parent_cl'
		require else
			valid_parent_cl	: parent_cl	/= void
		do
			!! Result;
			Result.set (parent_cl.x + x + width//2,
					parent_cl.y + y + height//2)
		end

	handle_to (parent_cl: PS_CLUSTER; p: EC_COORD_XY): EC_COORD_XY is
			-- Point on the linkable used to reach `p'
		require
			p /= void
			valid_parent_cl	: parent_cl	/= void
		local
			x1, y1, x2, y2: INTEGER;
			px, py: INTEGER;
		do
			!! Result;
			Result.set (parent_cluster.x + x, parent_cluster.y + y);
			!! Result;
			x1 := parent_cl.x + x;
			x2 := x1 + width;
			y1 := parent_cl.y + y;
			y2 := y1 + height;
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
				elseif py > y2 then
					Result.set (px, y2)
				else
					Result.set (x1, y1)
				end
			end
		ensure
			valid_result: Result /= void
		end 

feature -- Comparison

	same_parent_as (other: like Current): BOOLEAN is
		require
			valid_other	: other	/= void
		do
			Result := (not is_root and then not other.is_root and then
						parent_cluster.name.is_equal (other.parent_cluster.name)) 
					or else (is_root and then other.is_root)
		end;

feature -- Element change

	put_in_cluster (cluster: CLUSTER_DATA) is
			-- Remove the cluster of `parent_cluster' if exists, and
			-- put the cluster in `cluster'.
		do
			if parent_cluster /= Void then
				parent_cluster.remove_cluster (Current)
				check_compressed_links (cluster)
			end;
			parent_cluster := cluster;
			cluster.add_cluster (Current)
		end;

feature -- Removal

	remove_from_system is
			-- Remove the cluster from system.
		require else
			valid_parent_cluster	: parent_cluster	/= void
		do
			clear_editor;
			parent_cluster.remove_cluster (Current);
			parent_cluster := Void;
		end;

feature -- Update

	update_minimal_size is
		require
			valid_height	: height	/= void
			valid_width	: width	/= void
		do
			height := height.max (minimal_height + 50);
			width := width.max (minimal_width + 50);
		end;

	update_title is
		do	
			workareas.update_title (Current);
		end;

	update_name is
		require else
			valid_content	: content	/= void
		do
--			basic_update;
--			Workareas.update_title (Current);
--			Workareas.update_cluster_chart (Current, stone_type);
--			content.update_cluster_name (Current);
--			Windows.update_cluster_info_in_windows (Current, False);
--			System.set_is_modified
		end;

	update_display (a_data: DATA) is
		do
--			Windows.system_window.update_page (a_data.stone_type);
--			workareas.update_cluster_chart (Current, a_data.stone_type);
--			System.set_is_modified
		end;

	clear_editor is
		do
			workareas.clear (Current)
		end;

feature -- Access

	has_class (class_name: STRING): BOOLEAN is
			-- Does class `class_name' exists in current cluster
		require
			valid_content	: content	/= void
			valid_class_name: class_name /= Void and then
								not class_name.empty
		do
			Result := content.has_class (class_name)
		end;

	has_cluster (cluster_name: STRING): BOOLEAN is
			-- Does cluster `cluster_name' exists in current cluster
		require
			valid_content	: content	/= void
			valid_cluster_name: cluster_name /= Void and then
								not cluster_name.empty
		do
			Result := content.has_cluster (cluster_name)
		end;

	has_child_with_name (data: LINKABLE_DATA; fn: STRING): BOOLEAN is
			-- Does name `fn' for `data' exists in current cluster?
		require
			valid_file_name: fn /= Void and then not fn.empty
		local
			tmp: LINKABLE_DATA
		do
			tmp := content.child_with_name (fn);
			if tmp /= Void and then tmp /= data then
				Result := True
			end
		end;

feature -- Output

	focus: STRING is
		do
			!!Result.make (0);
			Result.append (name);
			if not is_root then
				Result.append (" of ");
				Result.append (parent_cluster.name);
			end
		end;

	generate_hidden_entities (text_area: TEXT_AREA; display_all: BOOLEAN) is
			-- Generate hidden entities into `text_area'.
		require
			valid_content	: content	/= void
			valid_text_area: text_area /= Void
		do
			content.generate_hidden_entities (text_area, display_all);
		end;

	generate_code_to_disk is
		require
			valid_content	: content	/= void
		local
			dir_name: DIRECTORY_NAME;
			dir : DIRECTORY	
		do
		end -- generate_code

	generate_code_for_cluster_root_for_generation is
    		local
		--	classes_to_merge: MERGING_CLASS_LIST
		--	classes_merger: CLASSES_MERGER
			rescued : BOOLEAN
		do		end

	--generate_code_to_eiffel_project (classes_to_merge: MERGING_CLASS_LIST; caller: EV_WINDOW) is
	--	require
	--		classes_to_merge_exists: classes_to_merge /= Void
	--		valid_content	: content	/= void
	--	do
	--	end

	create_recursively_dir ( dir : DIRECTORY ) is
		-- the purpose of this routine is to create a directory dir with all 
		-- the eventual other directory on the way to create ...
		local
			s1,s2 : STRING
			ind,ind1 : INTEGER
			direc : DIRECTORY
			string_dealt	: BOOLEAN
		do

			string_dealt	:= false

			!! s1.make ( 20 )
			s1.append ( dir.name )
			deal_with_dollar ( s1 )
			from
				ind := 1
				ind1 := 0
			until
				string_dealt	= true
			loop
				if ind1 < s1.count
				then
					ind := s1.index_of(Environment.directory_separator,ind1+1)
					if ind>0 then
						-- let's see this directory on the way ...
						!! s2.make(20)
						s2.append(s1.substring(1,ind-1))
						if s2.count > 0
						then
							if s2.index_of(':', 1)=0 
							then
								!! direc.make (s2)
								if not direc.exists and not direc.name.empty 
								then
									direc.create_dir
								end
							end
						end
						ind1 := ind
					else
					 	-- last directory to create
						!! direc.make (s1)
						if not direc.exists and not direc.name.empty 
						then
							direc.create_dir
						end
						string_dealt	:= true
					end
				else
					string_dealt	:= true
				end
			end						
		end

	deal_with_dollar ( s : STRING ) is
		-- look for a dollar and replace the corresponding value
	local
		exec : EXECUTION_ENVIRONMENT
		s1,s2 : STRING
		ind,ind1,ind2 : INTEGER
	do
		!! exec
		if s/= Void and then s.count>0 then
			from
				ind := 1
				ind1 := 1
			until
				ind=0
			loop			
				ind := s.index_of('$',ind1)
				if ind>0 then
					-- we found one
					ind1 := s.index_of('/', ind)
					ind2 := s.index_of('\', ind)
					if ind2<ind1 and then ind2>0 then
						ind1 := ind2
					end
					!! s1.make(20)
					if ind1=0 then 
							ind1 := s.count 
					end
					if ind >0 then
							s1.append(s.substring(ind+1,ind1-1 ))
						s2 := exec.get(s1)
						s2.append_character	( environment.directory_separator	)
						if s2= Void then
							!! s2.make(20)
							s2.append("")
						end
						s.replace_substring(s2,ind,ind1)
					end
				end
			end
		end
	end

	generate_name (text_area: TEXT_AREA) is
		require else
			valid_text_area	: text_area	/= void
		do
			text_area.append_clickable_string (stone, name);
		end;

	generate_as_parent ( text_area : TEXT_AREA; heir_data : CLASS_DATA ; inh_link : INHERIT_DATA ) is
	local
		parent_cluster_stone	: PARENT_CLUSTER_STONE
	do
		!! parent_cluster_stone.make_parent	( Current	, heir_data	)

		text_area.append_clickable_string	( parent_cluster_stone	, name	)	
	end

	generate_chart (text_area: TEXT_AREA) is
			-- Generate cluster chart
		require
			valid_text_area	: text_area	/= void
		local
			l_data: LINKABLE_DATA;
			class_list: LINKED_LIST [CLASS_DATA];
			cluster_list: LINKED_LIST [CLUSTER_DATA];
		do
		end

feature -- Stone information

	stone: CLUSTER_STONE is
		do
			!! Result.make (Current)
		end;

	stone_type: INTEGER is
			-- Stone type of Current
		require else
			valid_stone_types	: stone_types	/= void
		do
			Result := Stone_types.cluster_type
		end;

feature -- Storage

	storage_info: S_CLUSTER_DATA_R332 is
		require
			valid_content	: content	/= void
		do
		
		end

	store_chart( s: S_CLUSTER_DATA_R332 )  is
		-- routine responsible to save the chart data ...
		do
		end

	save_documentation(path:STRING) is
		local
			dir: DIRECTORY
			fi : RAW_FILE
			file_n : FILE_NAME
			st: STRING
			err : BOOLEAN
		do
--			!!dir.make(path)
--			if dir.exists then
--				!!file_n.make
--				file_n.extend(reversed_engineered_file_name)
--				deal_with_dollar	( file_n	)
--				file_n.extend("doc.eif")
--				!! fi.make(file_n)
--				if fi.exists then
--					file_n.wipe_out
--					file_n.extend(reversed_engineered_file_name)
--					file_n.extend("doc.bak")
--					!! fi.make(file_n)
--					if fi.exists then 
--						err := TRUE
--					else
--						fi.create_read_write
--					end
--				else
--					fi.open_write
--				end
--				if err = FALSE then
--				if Environment.platform.is_equal("windows") then
--					from
--						description.start
--					until
--						description.after
--					loop
--						!! st.make(40)
--						st.append(deep_clone(description.item))					
--						st.replace_substring_all("%R","%R%N")
--						fi.put_string(st)
--						description.forth
--					end
--				else
--					from 
--						description.start
--					until
--						description.after
--					loop
--						!! st.make(40)
--						st.append(deep_clone(description.item))
--						st.prune_all('%R')
--						fi.put_string(st)
--						if st.item(st.count) /= '%N'then
--							fi.new_line
--						end
--						description.forth
--					end
--				end
--				fi.close
--				end
--			end
			
			
		end	

	update_root_view (new_view: BOOLEAN) is
			-- Retrieve view for current
		require
			is_root: is_root
			valid_content	: content	/= void
		do
			if new_view or else System.root_cluster.view_id /= view_id then
				set_default
			else
				System.view.root_cluster.update_data (Current);
			end;
			content.update_from_view (Current, new_view);
		end;

	update_from_view (new_view: BOOLEAN) is
			-- Update Current from view. (`new_view' means
			-- a corresponding view was not found
		require
			valid_content	: content	/= void	
		do
			content.update_from_view (Current, new_view)
		end;

feature

	set_default is
		require else
			valid_resources	: resources	/= void
		do
			is_icon := True;
			set_width	(Resources.cluster_width)
			set_height	 (Resources.cluster_height)
			set_icon_height (Resources.cluster_icon_y_margin)
			set_icon_width (Resources.cluster_icon_x_margin)
		ensure then
			is_icon: is_icon
			valid_width: width > 0
			valid_height: height > 0
			valid_icon_width: icon_width > 0
			valid_icvalid_icon_height: icon_height > 0
		end;

feature -- Eiffel Generation

	is_root_for_generation : BOOLEAN

	set_is_root_for_generation ( b :BOOLEAN ) is
		do
			is_root_for_generation := b	
		end
	
feature  -- Operations

	add_cluster (new_cluster: like Current) is
			-- Add `new_cluster' to clusters.
		require
			new_cluster_exists: new_cluster /= Void;
			cluster_not_in_Current: not clusters.has (new_cluster)
			valid_clusters	: clusters	/= void
		do
			clusters.extend (new_cluster);
		ensure
			cluster_in_Current: clusters.has (new_cluster)
		end; 

	remove_cluster (old_cluster: like Current) is
			-- Remove `old_cluster' from clusters.
		require
			non_void_cluster: old_cluster /= Void;
			old_cluster_in_cluster: clusters.has (old_cluster)
			valid_clusters	: clusters	/= void
		do
			clusters.start;
			clusters.prune (old_cluster);
		ensure
			not_in_clusters: not clusters.has (old_cluster)
		end;

feature {CLASS_DATA} -- Implementation

	add_class (new_class: CLASS_DATA) is
			-- Add `new_class' to classes.
		require
			new_class_exists: new_class /= Void;
			not_in_cluster: not classes.has (new_class)
			valid_classes	: classes	/= void
		do
			classes.extend (new_class)
		ensure
			class_in_cluster: classes.has (new_class)
		end;

	remove_class (old_class: CLASS_DATA) is
			-- Remove `old_class' from classes.
		require
			old_class_exists: old_class /= Void;
			old_class_in_cluster: classes.has (old_class)
			valid_classes	: classes	/= void
		do
			classes.start;
			classes.prune (old_class);
		ensure
			not_have_in_cluster: not classes.has (old_class)
		end;

feature -- Debug

	trace is
		require else
			valid_content	: content	/= void
		do
		end

feature {NONE} -- Implementation

	check_compressed_links (new_cluster: CLUSTER_DATA) is
		local
			all_links, links_to_check: LINKED_LIST [RELATION_DATA]
			a_link: RELATION_DATA
			to_side: BOOLEAN
			compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]
		do
			--'find links from/to cluster???'
			!!all_links.make
			!! links_to_check.make
			all_links.merge_right (recursive_inherit_links)
			all_links.merge_right (recursive_cli_sup_links)

			from
				all_links.start
			until
				all_links.off
			loop
				a_link := all_links.item
				if (not (a_link.t_o = Current)) or else (not (a_link.f_rom = Current)) then
					if a_link.is_in_compressed_link then
						a_link := correct_comp_link (a_link)
					  
						--check
						--	a_comp_link: a_link.is_compressed
					--	end
					end
				end

				if a_link /= Void and then
					(not links_to_check.has (a_link)) then
					links_to_check.extend (a_link)
				end
				all_links.forth
			end

			from
				links_to_check.start
			until
				links_to_check.off
			loop
				a_link := links_to_check.item
				if a_link.is_in_compressed_link then
					to_side := (Current = a_link.t_o)
					check
						not_to_implies_from: (not to_side) implies (Current = a_link.f_rom)
					end
					compressed_link := a_link.find_compressed_link
					--check -- pascalf, assertion not valid...
				--	compressed_link_exists: compressed_link /= Void
					--end
--FIXME: Jacques: Add if..end
					if compressed_link/=void then
					compressed_link.remove_relation (a_link)
					check_empty_compressed (compressed_link, a_link, new_cluster, to_side)
					end
				end
				links_to_check.forth
			end			 
		end

	correct_comp_link (a_link: RELATION_DATA): RELATION_DATA is
			-- Get correct compressed_link_parent of 'a_link'
		require
			a_link_exists: a_link /= Void
		local
			bool : BOOLEAN
		do
		-- pascalf , has to be revised	
		from
				Result := a_link.find_compressed_link
			until
				Result = Void or else (Result.f_rom = Current or else Result.t_o = Current or else not Result.is_in_compressed_link)
			loop
				Result := Result.find_compressed_link
	
			end

			if (Result /= Void) and (not Result.is_compressed) then
			Result := Void
			end
			end
	 


	check_empty_compressed (a_compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]; flat_link: RELATION_DATA; new_cluster: CLUSTER_DATA; to_side: BOOLEAN) is
			-- Check if `a_compressed_link' can be removed
		require
			not_void_comp: a_compressed_link /= Void
			not_void_link: flat_link /= Void
			new_cluster_exists: new_cluster /= Void
		local
			compressed_link, parent_compressed, old_compressed_link: like a_compressed_link
			inh: INHERIT_DATA
			inh_comp: COMP_INHERIT_DATA
			cli_sup: CLI_SUP_DATA
			cli_sup_comp: COMP_CLI_SUP_DATA
			rel_key_link: RELATION_DATA_KEY
			same_level: BOOLEAN
			extremity_cluster, other_cluster: like new_cluster
		do
			compressed_link := a_compressed_link
			if to_side then
				extremity_cluster ?= compressed_link.t_o
			else
				extremity_cluster ?= compressed_link.f_rom
			end
			same_level := (extremity_cluster /= Void) and then (extremity_cluster = new_cluster)

			from
				old_compressed_link := compressed_link
			until
			   compressed_link = Void or else
				same_level
			loop
				if compressed_link.is_in_compressed_link then
					parent_compressed := compressed_link.find_compressed_link
				else
					parent_compressed := Void
				end

				if compressed_link.empty then
					compressed_link.remove_from_system;
					inh ?= compressed_link;
					
					if inh /= Void then
						workareas.destroy_inherit (inh);
					else
						cli_sup ?= compressed_link;
						workareas.destroy_reference (cli_sup)
					end;
					
					if parent_compressed /= Void and then compressed_link.is_in_compressed_link then
						parent_compressed.remove_relation (compressed_link)
					end
				end

				old_compressed_link := compressed_link
				compressed_link := parent_compressed

				if compressed_link /= Void then
					if to_side then
						extremity_cluster ?= compressed_link.t_o
					else
						extremity_cluster ?= compressed_link.f_rom
					end
					same_level := (extremity_cluster /= Void) and then (extremity_cluster = new_cluster)
				end
			end -- loop

			if compressed_link /= Void then
				if to_side then
					extremity_cluster ?= compressed_link.t_o
				else
					extremity_cluster ?= compressed_link.f_rom
				end

				if (extremity_cluster /= Void) and then (extremity_cluster = new_cluster) then
					rel_key_link := flat_link.key
					compressed_link.add_relation (rel_key_link)
				else
					update_compressed_link_side (old_compressed_link, to_side, flat_link)
				end
			else
				update_compressed_link_side (old_compressed_link, to_side, flat_link)
			end
 		end

	update_compressed_link_side (compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]; to_side: BOOLEAN; flat_link: RELATION_DATA) is
			-- Update the extremity of `compressed_link' specified by `to_side'
		require
			compressed_link_exists: compressed_link /= Void
			flat_link_exists: flat_link /= Void
		local
			rel_link_key: RELATION_DATA_KEY
		do
			compressed_link.set_is_in_compressed_link (False)
			
			if to_side then
				if compressed_link.empty then
					if compressed_link.f_rom.is_cluster then
						compressed_link.set_to (flat_link.t_o)
						rel_link_key := flat_link.key
						compressed_link.add_relation (rel_link_key)
						if not (compressed_link.already_in_system or else compressed_link.is_in_system) then
							compressed_link.put_relation_in_system
						end
						workareas.change_data (compressed_link)
					else
						workareas.change_data (flat_link)
					end
				else
					update_create_compressed_link (compressed_link.f_rom, compressed_link.f_rom, flat_link.t_o, flat_link)
				end
			else
				if compressed_link.empty then
					if compressed_link.t_o.is_cluster then
						compressed_link.set_from (flat_link.f_rom)
						rel_link_key := flat_link.key
						compressed_link.add_relation (rel_link_key)
						if not (compressed_link.already_in_system or else compressed_link.is_in_system) then
							compressed_link.put_relation_in_system
						end
						workareas.change_data (compressed_link)
					else
						workareas.change_data (flat_link)
					end
				else
					update_create_compressed_link (compressed_link.t_o, flat_link.f_rom, compressed_link.t_o, flat_link)
				end
			end
		end


	update_create_compressed_link (compressed_extremity, from_extremity, to_extremity: LINKABLE_DATA; flat_link: RELATION_DATA) is
			-- Build new compressed link if necessary and update the workareas
		require
			compressed_extremity_exists: compressed_extremity /= Void
			from_extremity_exists: from_extremity /= Void
			to_extremity_exists: to_extremity /= Void
			flat_link_exists: flat_link /= Void
			from_or_to_is_compressed: (compressed_extremity = from_extremity) or else (compressed_extremity = to_extremity)
		local
			cli_sup: CLI_SUP_DATA
			inh: INHERIT_DATA
			new_comp_link: COMP_LINK_DATA [RELATION_DATA_KEY]
		do
			if compressed_extremity.is_cluster then
				inh ?= flat_link
				if inh /= Void then
					!COMP_INHERIT_DATA! new_comp_link.make (from_extremity, to_extremity)
				else
					cli_sup ?= flat_link
					check
						is_cli_sup: cli_sup /= Void
					end
					--| take care of aggregations when compressed 
					--| aggregation links are implemented
					!COMP_CLI_SUP_DATA! new_comp_link.make_ref (from_extremity, to_extremity)
				end
				new_comp_link.add_relation (flat_link.key)
				new_comp_link.put_relation_in_system
				workareas.change_data (new_comp_link)
			else
				workareas.change_data (flat_link)
			end
		end;

invariant

	root_cluster_must_be_in_system: is_root implies is_in_system
	root_cluster_has_no_parent: is_root implies parent_cluster = Void
	valid_id: id < 0

end -- class CLUSTER_DATA
