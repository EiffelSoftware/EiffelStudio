indexing

	description: "System description of a view.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_VIEW

inherit

	ONCES

	STORABLE

	CONSTANTS

	S_CASE_INFO

creation

	make

feature {NONE} -- Initialization

	make (system_data: SYSTEM_DATA) is
			-- Make a view with name as `n' and
			-- id as `i'..
		require
			valid_system_data: system_data /= Void
		do
			view_information.initialize_for_storing;
			view_name := system_data.view_name;
			view_id := system_data.view_id;
			show_bon := system_data.show_bon;
			!! clusters.make (10);
			!! classes.make (10);
			!! shared_handles.make_filled (20);
			add_root_cluster (system_data.root_cluster);
			is_grid_visible := system_data.is_grid_visible;
			is_grid_magnetic := system_data.is_grid_magnetic;
			grid_spacing := system_data.grid_spacing;
			shared_handles := view_information.view_shared_handles;
			description := system_data.view_description;
			is_aggreg_hidden := system_data.is_aggreg_hidden;
			is_client_hidden := system_data.is_client_hidden;
			is_inheritance_hidden := system_data.is_inheritance_hidden;
			is_label_hidden := system_data.is_label_hidden;
			show_all_relations := system_data.show_all_relations;
			view_information.clear;
		end;

feature -- Properties

	show_bon: BOOLEAN;
			-- Show bon notation?

	view_id: INTEGER;
			-- Id for current

	view_name: STRING;
			-- view_name of Current view

	description: DESCRIPTION_DATA;
			-- Description for Current view

	clusters: HASH_TABLE [FIXED_LIST [CLUSTER_VIEW], INTEGER]
			-- Hashed on parent cluster view id. Item is then hashed on
			-- cluster view id

	classes: HASH_TABLE [FIXED_LIST [CLASS_VIEW], INTEGER];
			-- Hashed on parent cluster view id. 

	root_cluster: CLUSTER_VIEW;
			-- Root cluster of System

	shared_handles: FIXED_LIST [REAL_HANDLE_VIEW]
			-- List of shared handles for system

	modified: BOOLEAN;
			-- Has Current view been modified ?

	is_grid_visible: BOOLEAN;
			-- Is grid visible in a graphical representation on screen ?

	is_grid_magnetic: BOOLEAN;
			-- Do entities glu to the grid as if it was magnetic ?

	grid_spacing: INTEGER;
			-- Size of a grid square

	show_all_relations: BOOLEAN;
			-- Show all relations (includes relationshipt
			-- resulting from implementation) ?

	is_aggreg_hidden: BOOLEAN;
			-- Is aggregate relations hidden ?

	is_client_hidden: BOOLEAN;
			-- Is client relations hidden ?

	is_inheritance_hidden: BOOLEAN;
			-- Is inheritance relations hidden ?

	is_label_hidden: BOOLEAN;
			-- Is relations labels hidden ?

feature {SYSTEM_VIEW_LIST} -- Setting

	set_view_details (v_name: STRING; v_id: INTEGER) is
			-- Set view_name to `v_name' and
			-- set view_id to `v_id'.
		require
			valid_v_name: v_name /= Void;
			valid_v_id: v_id > 0
		do
			view_name := v_name;
			view_id := v_id
		end;

feature -- Retrieving information

	clusters_with_cluster_id (parent_id: INTEGER): FIXED_LIST [CLUSTER_VIEW] is
			-- Clusters with parent cluster id `id'
		do
			Result := clusters.item (parent_id)
		end;

	classes_with_cluster_id (parent_id: INTEGER): FIXED_LIST [CLASS_VIEW] is
			-- Clusters with parent cluster id `id'
		do
			Result := classes.item (parent_id)
		end;

feature {NONE} -- Adding information

	add_root_cluster (a_cluster: CLUSTER_DATA) is
			-- Add cluster and all its contents to Current
			-- from `a_cluster` (calls add_cluster which
			-- is recursive).
		require
			valid_cluster: a_cluster /= Void;
			cluster_is_root: a_cluster.is_root
		local
			cluster_view: CLUSTER_VIEW;
			ht: HASH_TABLE [CLUSTER_VIEW, INTEGER]
		do
			!! cluster_view.make (a_cluster);
			root_cluster := cluster_view;
			initialize (a_cluster);
		end;

	initialize (a_cluster: CLUSTER_DATA) is
			-- Initialize Current with `a_cluster'.
		require
			valid_cluster: a_cluster /= Void
		local
			cluster_list: LINKED_LIST [ CLUSTER_DATA ]
			class_view_list: FIXED_LIST [CLASS_VIEW];
			cluster_view_list: FIXED_LIST [CLUSTER_VIEW];
			class_view: CLASS_VIEW;
			class_list: LINKED_LIST [CLASS_DATA];
			cluster_view: CLUSTER_VIEW
		do
			class_list := a_cluster.classes;
			if not class_list.empty then
				!! class_view_list.make_filled (class_list.count);
				classes.put (class_view_list, a_cluster.view_id);
				from
					class_list.start;
					class_view_list.start
				until
					class_list.after
				loop
					!! class_view.make (class_list.item);
					class_view_list.replace (class_view);
					class_view_list.forth;
					class_list.forth
				end;
			end;
			cluster_list := a_cluster.clusters;
			if not cluster_list.empty then
				!! cluster_view_list.make_filled (cluster_list.count);
				clusters.put (cluster_view_list, a_cluster.view_id);
				from
					cluster_view_list.start
					cluster_list.start
				until
					cluster_list.after
				loop
					!! cluster_view.make (cluster_list.item);
					cluster_view_list.replace (cluster_view);
					initialize (cluster_list.item);
					cluster_view_list.forth
					cluster_list.forth
				end
			end
		end;

feature {SYSTEM_DATA} -- Retrieving View

	retrieve_view (file_name: STRING) is
			-- Retrieve view from disk.
		local
			retrieved_system: SYSTEM_VIEW;
			file: RAW_FILE;
		do		
			!! file.make (file_name);
			if file.exists and then file.readable then
				file.open_read;
				retrieved_system ?= retrieved (file);
				file.close;
				view_name := retrieved_system.view_name;
				clusters := retrieved_system.clusters;
				modified := False;
			else
				--Windows.error (Windows.main_panel, .., ..)
			end
		end;

feature {SYSTEM_DATA, SYSTEM_VIEW_LIST} -- Storage (View)

	tmp_store_to_disk is
			-- Store temporarily the Current view to disk. 
		local
			file_name: FILE_NAME;
			tmp: STRING;
			file: RAW_FILE
			--t : TRANSITION_TABLE
		do
		--	tmp := Environment.View_file_name;
		--	tmp.append_integer (view_id);
		--	!! file_name.make_from_string (tmp);
		--	file_name.add_extension (Tmp_file_name_ext);
		--	!! file.make (file_name);
		--	file.open_write;
		--	independent_store (file);	
		--	file.close
			-- added for 4.3, allows graphical retrieving
			--transition_table.make
			--transition_table.update_table
			--transition_table.save_table
		        -- 
		end;

	save_to_disk is
			-- Save Current view to disk. 
		local
			tmp_file_name: FILE_NAME;
			file_name: STRING;
			file: RAW_FILE
		do
		--	file_name := Environment.View_file_name;
		--	file_name.append_integer (view_id);
		--	!! tmp_file_name.make_from_string (file_name);
		--	tmp_file_name.add_extension (Tmp_file_name_ext);
		--	!! file.make (tmp_file_name);
		--	file.change_name (file_name);
			-- added for 4.3
			--transition_table.make
			--transition_table.update_table
			--transition_table.save_table
			--
		end;

end -- class SYSTEM_VIEW
