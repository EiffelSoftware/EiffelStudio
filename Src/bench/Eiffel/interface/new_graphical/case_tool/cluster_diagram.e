indexing
	description: "World of DIAGRAM_COMPONENTs that make up a diagram; centered on a cluster."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLUSTER_DIAGRAM

inherit
	CONTEXT_DIAGRAM
		rename
			make as make_class
		redefine
			xml_element, set_with_xml_element,
			retrieve, arrange_clusters,
			clear_figures, include_class,
			add_class, add_class_figure,
			on_class_drop, on_new_class_drop,
			has_linkable_figure, set_current_view,
			store, include_dropped_class,
			include_new_dropped_class, remove_dropped_class,
			synchronize, remove_view, remove_view_from_file,
			prepare_synchronize, remove_unneeded_classes,
			recycle, remove_included_figures, load_from_file
		end

	EB_CLUSTER_MANAGER_OBSERVER
		undefine
			default_create,
			refresh
		redefine
			on_class_moved,
			on_class_removed
		end

feature {NONE} -- Initialization 

	make (a_tool: like context_editor) is
			-- Initialize as context in `a_tool'.
		do
			default_create

				-- Register to the cluster manager.
			manager.add_observer (Current)

			set_background_color (diagram_color)
			create layout
			create class_figures.make
			create cluster_figures.make
			create included_figures.make
			included_figures.compare_objects
			create excluded_figures.make
			excluded_figures.compare_objects
			context_editor := a_tool
			enable_grid
			hide_grid
			subcluster_depth := 1 
			supercluster_depth := 1
			scale_x := 1.0
			scale_y := 1.0
			labels_shown := True
			inheritance_links_displayed := True
			client_links_displayed := False
			placement_needed := False
			feature_name_number := 0
			set_link_client
			cancelled := False

			point.set_scale_x (scale_x)
			point.set_scale_y (scale_y)
			current_view := "DEFAULT"
			create available_views.make
			available_views.compare_objects

				-- Initialization of the layers.
				-- Inheritance layer is on top because it is a thin line
				-- and would be obscured by the client links.
				-- Move handles are the farthest away.
 			create cluster_layer
			extend (cluster_layer)
 			create cluster_mover_layer
			extend (cluster_mover_layer)
			create class_layer
			extend (class_layer)
			create client_supplier_layer
			extend (client_supplier_layer)
			create inheritance_layer
			extend (inheritance_layer)
			create client_supplier_mover_layer
			extend (client_supplier_mover_layer)
			create inheritance_mover_layer
			extend (inheritance_mover_layer)
			create label_mover_layer
			extend (label_mover_layer)
			drop_actions.extend (~on_class_drop)
			drop_actions.extend (~on_new_class_drop)
			drop_actions.extend (~on_cluster_drop)
			reset_valid_tags
		end

feature {EB_CONTEXT_EDITOR, EB_DIAGRAM_HTML_GENERATOR} -- Initialization

	set_cluster (a_cluster: CLUSTER_I) is
			-- Set `a_cluster' as new center of the context.
		do
			clear_figures
			center_cluster := new_cluster_figure (a_cluster)
			create layout
			add_cluster_figure (center_cluster, True)
			include_classes_of_cluster (center_cluster, False)
			center_cluster.point.set_position (0, 0)
			add_clusters
		end

feature -- Memory management

	recycle is 
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		do
			Precursor
			manager.remove_observer (Current)
		end			

feature -- Layers

	cluster_layer: EV_FIGURE_GROUP
			-- Clusters displayed in current diagram.

	cluster_mover_layer: EV_FIGURE_GROUP
			-- Move handles for clusters.

feature -- Access

	center_cluster: CLUSTER_FIGURE
			-- Cluster this diagram is the context of.

	has_linkable_figure (a_figure: LINKABLE_FIGURE): BOOLEAN is
			-- Is `a_figure' present on `Current'?
		do
			Result := Precursor (a_figure) or cluster_layer.has (a_figure)
		end

	cluster_figure_by_cluster (a_cluster: CLUSTER_I): CLUSTER_FIGURE is
			-- Search diagram component of `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			clf: CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				cluster_layer.after or Result /= Void
			loop
				clf ?= cluster_layer.item
				check
					clf_exists: clf /= Void
				end
				if clf.cluster_i = a_cluster then
					Result := clf
				end
				cluster_layer.forth
			end
		end

	smallest_cluster_containing_point (x, y: INTEGER): CLUSTER_FIGURE is
			-- Smallest cluster figure containing (`x', `y').
		local
			clf: CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				cluster_layer.after or Result /= Void
			loop
				clf ?= cluster_layer.item
				if clf /= Void 
					and then clf.position_strictly_on_figure (x, y) 
					then
						Result := clf
				end
				cluster_layer.forth
			end
		end

	smallest_cluster_containing_classes (class_one, class_two: CLASS_FIGURE): CLUSTER_FIGURE is
			-- Smallest cluster figure containing `class_one' and `class_two'.
			-- Void if none.
		require
			classes_exist: class_one /= Void and class_two /= Void
		local
			clf: CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				Result /= Void or else cluster_layer.after
			loop
				clf ?= cluster_layer.item
				if clf /= Void then
					if
						clf.recursive_has_class (class_one)
					and then
						clf.recursive_has_class (class_two)
					then
						Result := clf
					end	
				end
				cluster_layer.forth
			end
		end

	cluster_containing_cluster (x, y: INTEGER; a_cluster: CLUSTER_FIGURE): CLUSTER_FIGURE is
			-- Search smallest cluster figure containing (`x', `y'), excluding `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			clf: CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				cluster_layer.after or Result /= Void
			loop
				clf ?= cluster_layer.item
				if clf /= Void and then clf /= a_cluster
					and then clf.position_on_figure (x, y) 
					then
						if Result /= Void and then clf.is_subcluster_of (Result) then
							Result := clf
						elseif Result = Void then
							Result := clf
						end
				end
				cluster_layer.forth
			end
		end

	cluster_figure_by_cluster_name (n: STRING): CLUSTER_FIGURE is
			-- Search group component of cluster named `n'.
		require
			name_not_void: n /= Void
		local
			clf: CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				cluster_layer.after or Result /= Void
			loop
				clf ?= cluster_layer.item
				if clf /= Void and then clf.name.is_equal (n) then
					Result := clf
				end
				cluster_layer.forth
			end
		end

feature -- Status report

	supercluster_depth: INTEGER
			-- Depth of super-clusters.

	subcluster_depth: INTEGER
			-- Depth of sub-clusters.

feature -- Status setting

	set_supercluster_depth (i: INTEGER) is
			-- Set `supercluster_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			supercluster_depth := i
		ensure
			assigned: supercluster_depth = i
		end

	set_subcluster_depth (i: INTEGER) is
			-- Set `subcluster_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			subcluster_depth := i
		ensure
			assigned: subcluster_depth = i
		end

feature {CLUSTER_FIGURE} -- Status setting

	include_classes_of_cluster (a_cluster: CLUSTER_FIGURE; on_user_demand: BOOLEAN) is
			-- Fill `a_cluster' with all its class figures.
		require
			a_cluster_not_void: a_cluster /= Void
			a_cluster_in_diagram: cluster_layer.has (a_cluster)
		local
			l: EXTEND_TABLE [CLASS_I, STRING]
		do
			l := a_cluster.cluster_i.classes
			from
				l.start
			until
				cancelled or l.after
			loop
				if on_user_demand then
					include_class (l.item_for_iteration)
				else
					add_class (l.item_for_iteration)
					if context_editor /= Void then
						context_editor.refresh_progress
					end
				end
				if not cancelled then
					l.forth
				end
			end
		end

feature -- Factory

	new_cluster_figure (a_cluster: CLUSTER_I): CLUSTER_FIGURE is
			-- Create a concrete cluster figure.
		deferred
		end

feature -- View management

	set_current_view (name: STRING) is
			-- Assign `name' to `current_view' and apply corresponding settings.
			-- Store current view.
		local
			f: RAW_FILE
		do
			 	-- Save current view.
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			store (f)
			f.close

			remove_included_figures
			reset_scales
			
				-- Restore view `name' if possible.
			current_view := name
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			else
				reset_colors
				reset_links
				included_figures.wipe_out
				excluded_figures.wipe_out
				point.set_position (0, 0)
				context_editor.reset_toggles (Current)
				set_supercluster_depth (1)
				set_subcluster_depth (1)
				synchronize (True, Void)
			end
		end

	remove_view (name: STRING) is
			-- Remove any reference to view named `name' in the .ead file.
			-- Switch to view "DEFAULT".
		local
			f: RAW_FILE
		do
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			remove_view_from_file (f, name)
			f.close

			current_view := "DEFAULT"
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			else
				reset
			end
		end

	remove_view_from_file (ptf: RAW_FILE; a_name: STRING) is
			-- Remove view named `a_name' in `ptf'.
		local
			s: STRING
			diagram_output, node: XML_ELEMENT
			parser: XML_TREE_PARSER
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
		do
				-- Remove any previous save of `current_view'.
			create parser.make
			ptf.read_stream (ptf.count)
			s := ptf.last_string
			parser.parse_string (s)
			parser.set_end_of_file
			if parser.is_correct then
				if parser.root_element.name.is_equal ("CLUSTER_DIAGRAM") then
					diagram_output := parser.root_element
					a_cursor := diagram_output.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						if node /= Void then
							if node.name.is_equal ("VIEW") then
								if node.attributes.item ("NAME").value.is_equal (a_name) then
									diagram_output.remove_at_cursor (a_cursor)
								end
							end
						end
						if not a_cursor.after then
							a_cursor.forth
						end
					end
				end
				ptf.close
				ptf.open_write
				ptf.put_string (diagram_output.out)
			end
		end

feature {EB_DIAGRAM_HTML_GENERATOR} -- View management

	change_view (name: STRING; f_name: FILE_NAME) is
			-- Retrieve view named `name' from `file'.
			-- Do not store current view.
		local
			f: RAW_FILE
		do
				-- Restore view `name' if possible.
			reset_scales
			current_view := name
			create f.make (f_name)
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			else
				reset_colors
				reset_links
				included_figures.wipe_out
				excluded_figures.wipe_out
				point.set_position (0, 0)
				context_editor.reset_toggles (Current)
				set_supercluster_depth (1)
				set_subcluster_depth (1)
				synchronize (True, Void)
			end			
		end

feature -- Synchronizing

	synchronize (projection_required: BOOLEAN; progress_dialog: EB_PROGRESS_DIALOG) is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchronization.
		do
			if not cancelled then
				if context_editor /= Void then
					context_editor.development_window.window.set_pointer_style (Default_pixmaps.Wait_cursor)			
				end
				reset_scales
				prepare_synchronize
				
				if progress_dialog /= Void then
					progress_dialog.set_value (1)
					progress_dialog.set_message ("Synchronizing superclusters ")
				end
			end
			synchronize_superclusters (
				center_cluster.cluster_i,
				supercluster_depth,
				progress_dialog)

			if not cancelled and progress_dialog /= Void then
				progress_dialog.set_value (2)
				progress_dialog.set_message ("Synchronizing subclusters ")
			end
			synchronize_subclusters (
				center_cluster.cluster_i,
				subcluster_depth,
				progress_dialog)

			if not cancelled and progress_dialog /= Void then
				progress_dialog.set_value (3)
				progress_dialog.set_message ("Removing unneeded clusters")
			end
			remove_unneeded_clusters

			if not cancelled then
				if progress_dialog /= Void then
					progress_dialog.set_value (4)
					progress_dialog.set_message ("Removing unneeded classes")
				end
				remove_unneeded_classes
	
				if progress_dialog /= Void then
					progress_dialog.set_value (5)
					progress_dialog.set_message ("Synchronizing relations")
				end
				synchronize_relations
				remove_unneeded_relations	
	
				update_pebbles
				if placement_needed then
					layout.arrange_all (Current)
					reset_links
					placement_needed := False
				end
	
				if progress_dialog /= Void then
					progress_dialog.hide
				end
				refresh
				if projection_required then
					context_editor.update_bounds (Current)
					context_editor.projector.full_project
				end
				if context_editor /= Void then
					context_editor.development_window.window.set_pointer_style (Default_pixmaps.Standard_cursor)			
				end
			end
		end

feature {NONE} -- Synchronizing

	prepare_synchronize is
			-- Invalidate all figures before synchronizing.
		local
			clf: CLUSTER_FIGURE
		do
			Precursor
			from
				cluster_layer.start
			until
				cluster_layer.after
			loop
				clf ?= cluster_layer.item
				clf.disable_needed_on_diagram
				cluster_layer.forth
			end
		end

	remove_unneeded_classes is
			-- Remove class figures where `needed_on_diagram' is False.
		local
			cf: CLASS_FIGURE
			a_cursor: CURSOR
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				a_cursor := class_layer.cursor
				if not cf.needed_on_diagram and
					not included_figures.has (cf) and
					cf.cluster_figure /= center_cluster then
						cf.remove_from_diagram (False)
						class_layer.go_to (a_cursor)
				else
					class_layer.forth
				end
			end
		end
	
	remove_unneeded_clusters is
			-- Remove cluster figures where `needed_on_diagram' is False.
		local
			clf: CLUSTER_FIGURE
			a_cursor: CURSOR
			subclusters: LINKED_LIST [CLUSTER_FIGURE]
		do
			from
				cluster_layer.start
			until
				cluster_layer.after
			loop
				clf ?= cluster_layer.item
				a_cursor := cluster_layer.cursor
				if not clf.needed_on_diagram and
					not included_figures.has (clf) and
					clf /= center_cluster then
						if cluster_figures.has (clf) then
							subclusters := clf.subclusters
							from
								subclusters.start
							until
								subclusters.after
							loop
								cluster_figures.extend (subclusters.item)
								subclusters.item.set_parent (Void)
								subclusters.forth
							end
						end
						clf.remove_from_diagram (False)
						cluster_layer.go_to (a_cursor)
				else
					cluster_layer.forth
				end
			end
		end

	synchronize_superclusters (
		a_cluster: CLUSTER_I;
		depth: INTEGER;
		progress_dialog: EB_PROGRESS_DIALOG) is
			-- Add superclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			new_cluster: CLUSTER_I
			current_fig, fig: CLUSTER_FIGURE
			needed_classes: LINKED_LIST [CLASS_FIGURE]
		do
			if not cancelled then
				if depth > 0 then
					new_cluster := a_cluster.parent_cluster
					if new_cluster /= Void then
						fig := cluster_figure_by_cluster (new_cluster)
						if fig = Void then
							add_cluster (new_cluster, True)
							fig := cluster_figure_by_cluster (new_cluster)
							synchronize_classes_of_cluster (fig)
							current_fig := cluster_figure_by_cluster (a_cluster)
							fig.add_subcluster (current_fig)
							cluster_figures.prune_all (current_fig)
							synchronize_superclusters (new_cluster, depth - 1, progress_dialog)
						else
							fig.enable_needed_on_diagram
							needed_classes := fig.classes
							from
								needed_classes.start
							until
								needed_classes.after
							loop
								needed_classes.item.enable_needed_on_diagram
								needed_classes.forth
							end
							synchronize_superclusters (new_cluster, depth - 1, progress_dialog)
						end
					end
				end
			end
		end

	synchronize_subclusters (
		a_cluster: CLUSTER_I;
		depth: INTEGER;
		progress_dialog: EB_PROGRESS_DIALOG) is
			-- Add subclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			new_cluster: CLUSTER_I
			fig: CLUSTER_FIGURE
			needed_classes: LINKED_LIST [CLASS_FIGURE]
		do
			if not cancelled then
				if depth > 0 then
					sub_clusters := a_cluster.sub_clusters
					from
						sub_clusters.start
					until
						cancelled or sub_clusters.after
					loop
						new_cluster := sub_clusters.item
						fig := cluster_figure_by_cluster (new_cluster)
						if fig = Void then
							add_cluster (new_cluster, False)
							fig := cluster_figure_by_cluster (new_cluster)
							synchronize_classes_of_cluster (fig)
							if fig.classes.is_empty then
									-- Give a decent size to new cluster.
								fig.set_size (0, 20)
							end
							cluster_figures.prune_all (fig)
							cluster_figure_by_cluster (a_cluster).add_subcluster (fig)
							synchronize_subclusters (new_cluster, depth - 1, progress_dialog)
						else
							fig.enable_needed_on_diagram
							needed_classes := fig.classes
							from
								needed_classes.start
							until
								needed_classes.after
							loop
								needed_classes.item.enable_needed_on_diagram
								needed_classes.forth
							end
							synchronize_subclusters (new_cluster, depth - 1, progress_dialog)
						end
						sub_clusters.forth
						if progress_dialog /= Void then
							progress_dialog.show
							progress_dialog.graphical_update
						end
					end
				end
			end
		end

	synchronize_classes_of_cluster (a_cluster: CLUSTER_FIGURE) is
			-- Fill `a_cluster' with all its class figures.
		require
			a_cluster_not_void: a_cluster /= Void
			a_cluster_in_diagram: cluster_layer.has (a_cluster)
		local
			l: EXTEND_TABLE [CLASS_I, STRING]
			fig: CLASS_FIGURE
		do
			l := a_cluster.cluster_i.classes
			from
				l.start
			until
				l.after
			loop
				fig := class_figure_by_class (l.item_for_iteration)
				if fig = Void then
					add_class (l.item_for_iteration)
				else
					fig.enable_needed_on_diagram
				end
				l.forth
			end
		end

feature {EB_CONTEXT_EDITOR, EB_DIAGRAM_HTML_GENERATOR} -- Saving

	store (ptf: RAW_FILE) is
			-- Freeze state of `Current'.
		local
			s: STRING
			diagram_output, view_output, node: XML_ELEMENT
			parser: XML_TREE_PARSER
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
		do
			if ptf.is_open_read then

					-- Remove any previous save of `current_view'.
				create parser.make
				ptf.read_stream (ptf.count)
				s := ptf.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				if parser.is_correct then
					if parser.root_element.name.is_equal ("CLUSTER_DIAGRAM") then
						diagram_output := parser.root_element
						a_cursor := diagram_output.new_cursor
						from
							a_cursor.start
						until
							a_cursor.after
						loop
							node ?= a_cursor.item
							if node /= Void then
								if node.name.is_equal ("VIEW") then
									if node.attributes.item ("NAME").value.is_equal (current_view) then
										diagram_output.remove_at_cursor (a_cursor)
									end
								end
							end
							if not a_cursor.after then
								a_cursor.forth
							end
						end
					end
					ptf.close
					ptf.open_write
				end
			else
				create diagram_output.make_root ("CLUSTER_DIAGRAM")
			end
			view_output := xml_element
			view_output.set_parent (diagram_output)
			diagram_output.put_last (view_output)
			ptf.put_string (diagram_output.out)
		end

	load_from_file (f: RAW_FILE) is
			-- Retrieve content of `f', if any.
		local
			vs: EB_VIEW_SELECTOR
			pdial: EB_PROGRESS_DIALOG
			default_index: INTEGER
		do
			if not cancelled then
				pdial := context_editor.Progress_dialog
				if f.exists then
					f.open_read
					if f.readable then
						vs := context_editor.view_selector
						pdial.set_value (4)
						pdial.set_message ("Retrieving saved views")
						retrieve (f)
	
						if not cancelled then
							vs.select_actions.block
							vs.set_strings (available_views)
							vs.set_text ("DEFAULT")
							default_index := available_views.index_of ("DEFAULT", 1)
							if default_index > 0 then
								vs.i_th (default_index).enable_select						
							end				
							vs.select_actions.resume
							context_editor.update_size (Current)
							context_editor.update_toggles (Current)
						end
					else
						context_editor.reset (Current)
						context_editor.reset_toggles (Current)
						context_editor.update_size (Current)
					end
				else
					context_editor.reset (Current)
					context_editor.reset_toggles (Current)
					context_editor.update_size (Current)
				end
				if not cancelled then
					context_editor.reset_tool_bar_for_cluster_view
					pdial.hide
					projector.full_project			
				end
			end
		end

	retrieve (f: RAW_FILE) is
			-- Reload former state of `Current'.
		local
			s: STRING
			parser: XML_TREE_PARSER
			diagram_input, view_input, node: XML_ELEMENT
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
		do
			if not cancelled then
				create parser.make
				f.read_stream (f.count)
				s := f.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				f.close
				if parser.is_correct then
					diagram_input := parser.root_element
					if diagram_input.name.is_equal ("CLUSTER_DIAGRAM") then
						available_views.wipe_out
						a_cursor := diagram_input.new_cursor
						from
							a_cursor.start
						until
							a_cursor.after
						loop
							node ?= a_cursor.item
							if node /= Void then
								if node.name.is_equal ("VIEW") then
									available_views.extend (node.attributes.item ("NAME").value)
									if node.attributes.item ("NAME").value.is_equal (current_view) then
										view_input := node
									end
								end
							end
							a_cursor.forth
						end
						if view_input /= Void then
							set_with_xml_element (view_input)
							update_minimum_sizes
							if context_editor /= Void then
								context_editor.update_toggles (Current)
								context_editor.update_bounds (Current)
							end
						else
							reset_colors
							reset_links
							included_figures.wipe_out
							excluded_figures.wipe_out
							point.set_position (0, 0)
							if context_editor /= Void then
								context_editor.reset_toggles (Current)
							end
							set_supercluster_depth (1)
							set_subcluster_depth (1)
							synchronize (True, Void)
						end
					else
						create error_window
						error_window.set_text ("Incorrect File:" + center_cluster.name + ".ead")
						error_window.show
					end
				else
					create error_window
					error_window.set_text ("Incorrect File:" + center_cluster.name + ".ead")
					error_window.show
				end
			end
		end

feature {NONE} -- XML

	xml_element: XML_ELEMENT is
			-- XML representation.
		local
			cf: CLASS_FIGURE
			clf: CLUSTER_FIGURE
			hf: BON_INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
			include_xe, exclude_xe, xe: XML_ELEMENT
			include_element, exclude_element: XML_ELEMENT
		do
			create Result.make_root ("VIEW")
			Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", current_view))
			Result.put_last (xml_node (Result, "SUPERCLUSTER_DEPTH", supercluster_depth.out))
			Result.put_last (xml_node (Result, "SUBCLUSTER_DEPTH", subcluster_depth.out))
			Result.put_last (xml_node (Result, "INHERITANCE_LINKS_DISPLAYED", inheritance_links_displayed.out))
			Result.put_last (xml_node (Result, "CLIENT_LINKS_DISPLAYED", client_links_displayed.out))
			Result.put_last (xml_node (Result, "LABELS_SHOWN", labels_shown.out))
			Result.put_last (xml_node (Result, "X_POS", ((point.x / scale_x)).rounded.out))
			Result.put_last (xml_node (Result, "Y_POS", ((point.y / scale_y)).rounded.out))
			create include_element.make (Result, "INCLUDED_FIGURES")

				-- Save included cluster figures.
			from
				included_figures.start
			until
				included_figures.after
			loop
				clf ?= included_figures.item
				if clf /= Void then
					create include_xe.make (include_element, "CLUSTER")
					include_xe.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", clf.name))
					include_element.put_last (include_xe)
				end
				included_figures.forth
			end

				-- Save included class figures.
			from
				included_figures.start
			until
				included_figures.after
			loop
				cf ?= included_figures.item
				if cf /= Void then
					create include_xe.make (include_element, "CLASS")
					include_xe.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", cf.name))
					include_element.put_last (include_xe)
				end
				included_figures.forth
			end
			Result.put_last (include_element)

					-- Save excluded figures.
			create exclude_element.make (Result, "EXCLUDED_FIGURES")
			from
				excluded_figures.start
			until
				excluded_figures.after
			loop
				cf ?= excluded_figures.item
				clf ?= excluded_figures.item
				if cf /= Void then
					create  exclude_xe.make (exclude_element, "CLASS")
					exclude_xe.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", cf.name))
				elseif clf /= Void then
					create exclude_xe.make (exclude_element, "CLUSTER")
					exclude_xe.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", clf.name))
				end
				exclude_element.put_last (exclude_xe)
				excluded_figures.forth
			end
			Result.put_last (exclude_element)

				-- Save figure positions.
			from
				cluster_layer.start
			until
				cluster_layer.after
			loop
				clf ?= cluster_layer.item
				Result.put_last (clf.xml_element (Result))
				cluster_layer.forth
			end
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				Result.put_last (cf.xml_element (Result))
				class_layer.forth
			end
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				hf ?= inheritance_layer.item
				xe := hf.xml_element (Result)
				if xe /= Void then
					Result.put_last (xe)
				end
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				xe := csf.xml_element (Result)
				if xe /= Void then
					Result.put_last (xe)
				end
				client_supplier_layer.forth
			end
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		local
			a_cursor, include_cursor, exclude_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node, child_node: XML_ELEMENT
			cf, cf2: CLASS_FIGURE
			clf: CLUSTER_FIGURE
			hf: BON_INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
			class_name, cluster_name, a_source_name, a_target_name: STRING
			classes_found: LINKED_LIST [CLASS_I]
			new_supercluster_depth, new_subcluster_depth: INTEGER
		do
			reset_links
			reset_colors
			reset_valid_tags
			included_figures.wipe_out
			excluded_figures.wipe_out
			new_supercluster_depth := xml_integer (an_element, "SUPERCLUSTER_DEPTH")
			new_subcluster_depth := xml_integer (an_element, "SUBCLUSTER_DEPTH")
			if new_supercluster_depth /= supercluster_depth or else
				new_subcluster_depth /= subcluster_depth then
					set_supercluster_depth (new_supercluster_depth)
					set_subcluster_depth (new_subcluster_depth)
					if context_editor /= Void then
						synchronize (False, context_editor.progress_dialog)
					else
						synchronize (False, Void)
					end
			end
			labels_shown := xml_boolean (an_element, "LABELS_SHOWN")
			inheritance_links_displayed := xml_boolean (an_element, "INHERITANCE_LINKS_DISPLAYED")
			client_links_displayed := xml_boolean (an_element, "CLIENT_LINKS_DISPLAYED")
			if labels_shown then
				show_labels
			else
				hide_labels
			end
			point.set_x (xml_integer (an_element, "X_POS"))
			point.set_y (xml_integer (an_element, "Y_POS"))
			a_cursor := an_element.new_cursor
			from
				a_cursor.go_i_th (valid_tags + 1)
			until
				a_cursor.after
			loop
				node ?= a_cursor.item
				if node /= Void then
					if node.name.is_equal ("CLUSTER_FIGURE") then
						if not node.attributes.is_empty then
							cluster_name := clone (node.attributes.first.value)
							cluster_name.to_upper
							clf := cluster_figure_by_cluster_name (cluster_name)
							if clf /= Void then
								clf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_cluster.name + ".ead: Cluster name expected")
							error_window.show
						end
					elseif node.name.is_equal ("CLASS_FIGURE") then
						if not node.attributes.is_empty then
							class_name := clone (node.attributes.first.value)
							class_name.to_upper
							cf := class_figure_by_class_name (class_name)
							if cf /= Void then
								cf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_cluster.name + ".ead: Class name expected")
							error_window.show
						end
					elseif node.name.is_equal ("INHERITANCE_FIGURE") then
						if not node.attributes.is_empty then
							a_source_name := clone (node.attributes.item ("SRC").value)
							a_source_name.to_upper
							cf := class_figure_by_class_name (a_source_name)
							a_target_name := clone (node.attributes.item ("TRG").value)
							a_target_name.to_upper
							cf2 := class_figure_by_class_name (a_target_name)
							hf ?= inherit_link (cf, cf2)
							if hf /= Void then
								hf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_cluster.name + ".ead: Class name expected")
							error_window.show
						end		
					elseif node.name.is_equal ("CLIENT_SUPPLIER_FIGURE") then
						if not node.attributes.is_empty then
							a_source_name := clone (node.attributes.item ("SRC").value)
							a_source_name.to_upper
							cf := class_figure_by_class_name (a_source_name)
							a_target_name := clone (node.attributes.item ("TRG").value)
							a_target_name.to_upper
							cf2 := class_figure_by_class_name (a_target_name)
							csf ?= client_link (cf, cf2)
							if csf /= Void then
								csf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_cluster.name + ".ead: Class name expected")
							error_window.show
						end		
					elseif node.name.is_equal ("INCLUDED_FIGURES") then
						include_cursor := node.new_cursor
						from
							include_cursor.start
						until	
							include_cursor.after
						loop
							child_node ?= include_cursor.item
							if child_node /= Void then
								if child_node.name.is_equal ("CLUSTER") then 
									if not child_node.attributes.is_empty then 			
										cluster_name := clone (child_node.attributes.item ("NAME").value) 
										cluster_name.to_upper 
										clf := cluster_figure_by_cluster_name (cluster_name) 
										if clf = Void then 
											cluster_name.to_lower 
											if Eiffel_universe.has_cluster_of_name (cluster_name) then 
												include_cluster (Eiffel_universe.cluster_of_name (cluster_name), False) 
											else	
												create error_window
												error_window.set_text ("Cluster " + cluster_name + " not in the system")
												error_window.show
											end 
										 end 
									 else 
										create error_window
										error_window.set_text ("File " + center_cluster.name + ".ead: Cluster name expected") 
										error_window.show
									 end 
								elseif child_node.name.is_equal ("CLASS") then
									if not child_node.attributes.is_empty then
										class_name := clone (child_node.attributes.item ("NAME").value)
										class_name.to_upper
										cf := class_figure_by_class_name (class_name)
										if cf = Void then
											class_name.to_lower
											classes_found := Eiffel_universe.classes_with_name (class_name)
											if not classes_found.is_empty then
													--| FIXME: What to do if classes_found.count > 1?
												include_class (classes_found.first) 
											else
												create error_window
												error_window.set_text ("Class " + class_name + " not in the system")
												error_window.show
											end 
										end
									else
										create error_window
										error_window.set_text ("File " + center_cluster.name + ".ead: Class name expected")
										error_window.show
									end
								else
									create error_window
									error_window.set_text ("File " + center_cluster.name + ".ead: Tag " + node.name + " unknown")
									error_window.show
								end
							end
							include_cursor.forth
						end
					elseif node.name.is_equal ("EXCLUDED_FIGURES") then	
						exclude_cursor := node.new_cursor
						from
							exclude_cursor.start
						until	
							exclude_cursor.after
						loop
							child_node ?= exclude_cursor.item
							if child_node /= Void then
								if child_node.name.is_equal ("CLUSTER") then 
									if not child_node.attributes.is_empty then 			
										cluster_name := clone (child_node.attributes.item ("NAME").value) 
										cluster_name.to_upper 
										clf := cluster_figure_by_cluster_name (cluster_name) 
										if clf /= Void then 
											clf.recursive_remove_from_diagram (True)
										 end 
									 else 
									 	create error_window
										error_window.set_text ("File " + center_cluster.name + ".ead: Cluster name expected") 
										error_window.show
									 end 
								elseif child_node.name.is_equal ("CLASS") then
									if not child_node.attributes.is_empty then
										class_name := clone (child_node.attributes.item ("NAME").value)
										class_name.to_upper
										cf := class_figure_by_class_name (class_name)
										if cf /= Void then
											cf.remove_from_diagram (True)
										end
									else
										create error_window
										error_window.set_text ("File " + center_cluster.name + ".ead: Class name expected")
										error_window.show
									end
								else
									create error_window
									error_window.set_text ("File " + center_cluster.name + ".ead: Tag " + node.name + " unknown")
									error_window.show
								end
							end
							exclude_cursor.forth
						end			
					else
						create error_window
						error_window.set_text ("File " + center_cluster.name + ".ead: Tag " + node.name + " unknown")
						error_window.show
					end
				end
				a_cursor.forth
			end
		end

feature {DIAGRAM_COMPONENT} -- Implementation

	include_cluster (a_cluster: CLUSTER_I; on_top: BOOLEAN) is
			-- Include `a_cluster' in the diagram, on user request.
		local
			fig: CLUSTER_FIGURE
		do
			add_cluster (a_cluster, on_top)
			fig := cluster_figure_by_cluster (a_cluster)
			excluded_figures.prune_all (fig)
			if not included_figures.has (fig) then
				included_figures.extend (fig)
			end
		end

	add_cluster (a_cluster: CLUSTER_I; on_top: BOOLEAN) is
			-- Add `a_cluster' to the diagram.
		local
			fig: CLUSTER_FIGURE
		do
			fig := cluster_figure_by_cluster (a_cluster)
			if fig = Void then
				fig := new_cluster_figure (a_cluster)
				add_cluster_figure (fig, on_top)
			end
		end

	exclude_cluster (a_cluster: CLUSTER_I) is
			-- Exclude `a_cluster' in the diagram, on user request.
		local
			fig: CLUSTER_FIGURE
		do
			fig := cluster_figure_by_cluster (a_cluster)
			included_figures.prune_all (fig)
			if not excluded_figures.has (fig) then
				excluded_figures.extend (fig)
			end
			remove_cluster (a_cluster)
		end

	remove_cluster (a_cluster: CLUSTER_I) is
			-- Exclude `a_cluster' from the diagram.
		local
			fig: CLUSTER_FIGURE
			p: CLUSTER_FIGURE
		do
			fig := cluster_figure_by_cluster (a_cluster)
			if fig /= Void then
				cluster_figures.prune_all (fig)
				cluster_layer.prune_all (fig)
				cluster_mover_layer.prune_all (fig.resizer_bottom_right)
				cluster_mover_layer.prune_all (fig.resizer_top_left)
				cluster_mover_layer.prune_all (fig.resizer_top_right)
				cluster_mover_layer.prune_all (fig.resizer_bottom_left)
				cluster_mover_layer.prune_all (fig.name_mover)
				p ?= fig.parent
				if p /= Void then	
					p.remove_subcluster (fig)
				end
			end			
		end

	include_class (a_class: CLASS_I) is
			-- Include `a_class' in the diagram, on user request.
		local
			fig: CLASS_FIGURE
		do
			fig := class_figure_by_class (a_class)
			if fig = Void then
				fig := excluded_class_figure_by_class (a_class)
				if fig = Void then
					fig := new_class_figure (a_class)
				end
				add_class_figure (fig)
				fig.ancestor_figures.wipe_out
				fig.descendant_figures.wipe_out
				fig.client_figures.wipe_out
				fig.supplier_figures.wipe_out
				if a_class.compiled then
					add_ancestor_relations (fig)
					add_descendant_relations (fig)
					add_client_relations (fig)
					add_supplier_relations (fig)
				end
				fig.update
			end
			excluded_figures.prune_all (fig)
			if not included_figures.has (fig) then
				included_figures.extend (fig)
			end
		end

	add_class (a_class: CLASS_I) is
			-- Include `a_class' in the diagram.
			-- Add any relations `a_class' may have with
			-- all items in `class_figures' and `cluster_figures'.
		local
			fig: CLASS_FIGURE
		do
			fig := class_figure_by_class (a_class)
			if fig = Void then
				fig := new_class_figure (a_class)
				add_class_figure (fig)
				if a_class.compiled then
					add_ancestor_relations (fig)
					add_descendant_relations (fig)
					add_client_relations (fig)
					add_supplier_relations (fig)
				end
			end
		end

	remove_included_figures is
			-- Remove elements in `included_figures' from Current.
		local
			clf: CLUSTER_FIGURE
		do
			Precursor
			from
				included_figures.start
			until
				included_figures.after
			loop
				clf ?= included_figures.item
				if clf /= Void then
					clf.remove_from_diagram (False)
				end
				included_figures.forth
			end
		end

	include_cluster_figure (fig: CLUSTER_FIGURE) is
			-- Include `fig' in the diagram, on user request.
		do
			add_cluster_figure (fig, True)
			excluded_figures.prune_all (fig)
			if not included_figures.has (fig) then
				included_figures.extend (fig)
			end
		end

	add_cluster_figure (f: CLUSTER_FIGURE; on_top: BOOLEAN) is
			-- Extend structure with `f'.
		local
			clf: CLUSTER_FIGURE
			parent_cluster: CLUSTER_I
		do
			if on_top then
				f.point.set_origin (point)
				cluster_figures.extend (f)
				cluster_layer.put_front (f)
				f.set_parent (Void)
			else
				cluster_layer.extend (f)
			end
			f.enable_needed_on_diagram
			cluster_mover_layer.extend (f.resizer_bottom_right)
			cluster_mover_layer.extend (f.resizer_top_left)			
			cluster_mover_layer.extend (f.resizer_top_right)
			cluster_mover_layer.extend (f.resizer_bottom_left)			
			cluster_mover_layer.extend (f.name_mover)
			parent_cluster := f.cluster_i.parent_cluster
			if parent_cluster /= Void then
				clf :=  cluster_figure_by_cluster (parent_cluster)
				if clf /= Void then
					clf.add_subcluster (f)
				end
			end
		end

	add_class_figure (f: CLASS_FIGURE) is
			-- Extend structure with `f'.
		local
			clf: CLUSTER_FIGURE
		do
			f.point.set_origin (point)
			if f.point.x = 0 and then f.point.y = 0 then
				f.point.set_position (f.width, f.height)
			end
			class_layer.extend (f)
			f.enable_needed_on_diagram
			clf := cluster_figure_by_cluster (f.class_i.cluster)
			if clf /= Void then
				clf.add_class (f)
			end
		end

feature {EB_CONTEXT_EDITOR} -- Implementation

	notify_clusters_of_origin_moved (x_delta, y_delta: INTEGER) is
			-- `point' has just moved due to resizing of area.
			-- Notify clusters.
		local
			bcf: BON_CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				cluster_layer.after
			loop
				bcf ?= cluster_layer.item
				bcf.on_origin_moved (x_delta, y_delta)
				cluster_layer.forth
			end
		end
		
feature {NONE} -- Implementation

	add_clusters is
			-- Add clusters containing `class_layer' elements.
		do
			if not cancelled and context_editor /= Void then
				context_editor.put_progress_string ("Exploring superclusters of " + center_cluster.name, 2)
			end
			explore_superclusters (center_cluster.cluster_i, supercluster_depth)
			if not cancelled and context_editor /= Void then
				context_editor.put_progress_string ("Exploring subclusters of " + center_cluster.name, 3)
			end
			explore_subclusters (center_cluster.cluster_i, subcluster_depth)
		end

	explore_superclusters (a_cluster: CLUSTER_I; depth: INTEGER) is
			-- Add superclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			new_cluster: CLUSTER_I
			current_fig, fig: CLUSTER_FIGURE
		do
			if not cancelled then
				if depth > 0 then
					new_cluster := a_cluster.parent_cluster
					if new_cluster /= Void then
						add_cluster (new_cluster, True)
						fig := cluster_figure_by_cluster (new_cluster)
						include_classes_of_cluster (fig, False)
						if not cancelled then
							current_fig := cluster_figure_by_cluster (a_cluster)
							fig.add_subcluster (current_fig)
							cluster_figures.prune_all (current_fig)
							explore_superclusters (new_cluster, depth - 1)
						end
					end
				end
			end
		end

	explore_subclusters (a_cluster: CLUSTER_I; depth: INTEGER) is
			-- Add subclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			new_cluster: CLUSTER_I
			fig: CLUSTER_FIGURE
		do
			if not cancelled then
				if depth > 0 then
					sub_clusters := a_cluster.sub_clusters
					from
						sub_clusters.start
					until
						cancelled or sub_clusters.after
					loop
						new_cluster := sub_clusters.item
						add_cluster (new_cluster, False)
						fig := cluster_figure_by_cluster (new_cluster)
						include_classes_of_cluster (fig, False)
						if fig.classes.is_empty then
								-- Give a decent size to new cluster.
							fig.set_size (0, 20)
						end						
						if not cancelled then
							cluster_figures.prune_all (fig)
							cluster_figure_by_cluster (a_cluster).add_subcluster (fig)
							explore_subclusters (new_cluster, depth - 1)
							sub_clusters.forth
						end
					end
				end
			end
		end

	clear_figures is
			-- Clear structures.
		do
			Precursor
			cluster_layer.wipe_out
			cluster_mover_layer.wipe_out
		end

	update_minimum_sizes is
			-- Update minimum sizes of clusters.
		local
			clf: CLUSTER_FIGURE
		do
			from
				cluster_layer.start
			until
				cluster_layer.after
			loop
				clf ?= cluster_layer.item
				clf.update_minimum_size
				cluster_layer.forth
			end
		end

	arrange_clusters is
			-- Items of `cluster_figures' need to be moved.
		do
			layout.arrange_clusters (Current)
		end

	include_new_dropped_class (a_create_class_dialog: EB_CREATE_CLASS_DIALOG; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		local
			a_class: CLASS_I
			new_cluster_i: CLUSTER_I
			cf: CLASS_FIGURE
			new_clf: CLUSTER_FIGURE
		do
			if not a_create_class_dialog.cancelled then
				a_class := a_create_class_dialog.class_i
				if a_class /= Void then
					cf := class_figure_by_class (a_class)
					if cf = Void then
						cf := new_class_figure (a_class)	
					end
					check cf_not_void: cf /= Void end

					new_cluster_i := a_create_class_dialog.cluster
					new_clf := cluster_figure_by_cluster (new_cluster_i)
					if new_clf = Void then
						new_clf := new_cluster_figure (new_cluster_i)
					end
					check new_clf_not_void: new_clf /= Void end
					context_editor.history.do_named_undoable (
						Interface_names.t_Diagram_include_class_cmd,
						~include_dropped_class_in_cluster (cf, a_x, a_y, new_clf, True),
						~remove_dropped_class_in_cluster (cf, new_clf))
				end
			end
		end

	include_dropped_class_in_cluster (
		a_class: CLASS_FIGURE;
		a_x, a_y: INTEGER;
		new_cluster: CLUSTER_FIGURE;
		first_include: BOOLEAN) is
			-- Add `a_class' to the diagram if not already present.
			-- Do not re-create class if not `first_include'.
		require
			a_class_not_void: a_class /= Void
		local
			new_cluster_i: CLUSTER_I
			new_clf: CLUSTER_FIGURE
		do	
			new_cluster_i := a_class.class_i.cluster
			if first_include then
				include_class_figure (a_class)
			else
				a_class.put_back_on_diagram (Current)
				included_figures.extend (a_class)
			end
			if new_cluster /= Void then
				if not cluster_layer.has (new_cluster) then
					include_cluster_figure (new_cluster)
					new_cluster.point.set_position (
						a_x - new_cluster.point.origin.x_abs,
						a_y - new_cluster.point.origin.y_abs)
				else
				end
				new_cluster.add_class (a_class)
				a_class.point.set_position (a_class.width, a_class.height)
				new_cluster.update_minimum_size
				a_class.update
				context_editor.update_bounds (Current)
			else
				new_clf := cluster_figure_by_cluster (new_cluster_i)
				a_class.point.set_position (a_class.width, a_class.height)
				a_class.update
			end
			a_class.invalidate
			refresh
			update_display
		end

	remove_dropped_class_in_cluster (a_class: CLASS_FIGURE; new_cluster: CLUSTER_FIGURE) is
			-- Undo `include_dropped_class'.
		local
			parent_group: EV_FIGURE_GROUP
		do
			if new_cluster /= Void then
				parent_group := new_cluster.group
			else
				parent_group := a_class.group
			end
			if parent_group = Void then
				parent_group := world
			end
			a_class.remove_from_diagram (False)
			included_figures.prune_all (a_class)
			if new_cluster /= Void then
				new_cluster.recursive_remove_from_diagram (False) 
			end
			parent_group.invalidate
			refresh
			update_display
		end
		
feature {NONE} -- Events

	on_cluster_drop (a_stone: CLUSTER_STONE) is
			-- `a_stone' was dropped on `Current'.
			-- Add to diagram if not already present.
		local
			clf: CLUSTER_FIGURE
			drop_x, drop_y: INTEGER
		do
			context_editor.development_window.window.set_pointer_style (Default_pixmaps.Wait_cursor)
			drop_x := context_editor.pointer_position.x
			drop_y := context_editor.pointer_position.y
			clf := cluster_figure_by_cluster (a_stone.cluster_i)
			if clf = Void then
				include_cluster (a_stone.cluster_i, True)
				clf := cluster_figure_by_cluster (a_stone.cluster_i)
				include_classes_of_cluster (clf, True)
				layout.arrange_all (clf)
				clf.point.set_position (
					((drop_x - clf.point.origin.x_abs) / point.scale_x).rounded,
					((drop_y - clf.point.origin.y_abs) / point.scale_y).rounded)
				clf.update_minimum_size
				if clf.classes.is_empty then
						-- Give a decent minimal size to new cluster.
					clf.set_size (0, 20)
				end
			else
				clf.point.set_position (
					((drop_x - clf.point.origin.x_abs) / point.scale_x).rounded,
					((drop_y - clf.point.origin.y_abs) / point.scale_y).rounded)
					--| FIXME not undoable
			end
			check
				clf_not_void: clf /= Void
			end
			context_editor.reset_history
			context_editor.update_bounds (Current)
			refresh
			context_editor.projector.full_project
			context_editor.development_window.window.set_pointer_style (Default_pixmaps.Standard_cursor)
		end

	on_class_drop (a_stone: CLASSI_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Add to diagram if not already present.
		local
			cf: CLASS_FIGURE
			drop_x, drop_y: INTEGER
			new_cluster_i: CLUSTER_I
			new_clf: CLUSTER_FIGURE
		do
			drop_x := (x_to_grid (context_editor.pointer_position.x) / point.scale_x).rounded
			drop_y := (y_to_grid (context_editor.pointer_position.y) / point.scale_y).rounded
			cf := class_figure_by_class (a_stone.class_i)
			if cf = Void then
				cf := new_class_figure (a_stone.class_i)
				check cf_not_void: cf /= Void end
				new_cluster_i := a_stone.class_i.cluster
				new_clf := cluster_figure_by_cluster (new_cluster_i)
				if new_clf = Void then
					new_clf := new_cluster_figure (new_cluster_i)
				else
						-- No need to add a cluster.
					new_clf := Void
				end
				include_dropped_class_in_cluster (cf, drop_x, drop_y, new_clf,True)
				context_editor.history.register_named_undoable (
					Interface_names.t_Diagram_include_class_cmd,
					~include_dropped_class_in_cluster (cf, drop_x, drop_y, new_clf, False),
					~remove_dropped_class_in_cluster (cf, new_clf))
				context_editor.update_bounds (Current)
			end
		end

	on_new_class_drop (a_stone: CREATE_CLASS_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Display create class dialog and add to diagram.
		local
			dial: EB_CREATE_CLASS_DIALOG
			drop_x, drop_y: INTEGER
			clf: CLUSTER_FIGURE
		do
			drop_x := (x_to_grid (context_editor.pointer_position.x) / point.scale_x).rounded
			drop_y := (y_to_grid (context_editor.pointer_position.y) / point.scale_y).rounded
			clf := smallest_cluster_containing_point (drop_x, drop_y)
			create dial.make_default (context_editor.development_window)
			if clf /= Void then
				dial.preset_cluster (clf.cluster_i)
			end
			dial.call ("New_class")
			include_new_dropped_class (dial, drop_x, drop_y)
		end

	on_move_cluster_end (clf: CLUSTER_FIGURE; new_cluster: CLUSTER_FIGURE) is
			-- `clf' has moved to `new_cluster'.
			-- If `new_cluster' is Void, `clf' is now a top-level cluster.
		require
			clf_not_void: clf /= Void
		local
			current_cluster: CLUSTER_FIGURE
		do
			current_cluster := clf.cluster_figure
			if new_cluster /= Void then
				if current_cluster /= Void and then 
					not new_cluster.name.is_equal (current_cluster.name) then
						current_cluster.remove_subcluster (clf)
						new_cluster.add_subcluster (clf)
				else
					new_cluster.add_subcluster (clf)
				end
			else
				if current_cluster /= Void then
					current_cluster.remove_subcluster (clf)
					clf.point.set_origin (point)
				end
			end
		end

	on_move_class_end (cf: CLASS_FIGURE; new_cluster: CLUSTER_FIGURE) is
			-- `cf' has moved in `new_cluster'.
		require
			cf_not_void: cf /= Void
			cluster_not_void: new_cluster /= Void
		local
			current_cluster: CLUSTER_FIGURE
		do
			current_cluster := cf.cluster_figure
			if not current_cluster.name.is_equal (new_cluster.name) then
				manager.move_class (cf.class_i, current_cluster.cluster_i, new_cluster.cluster_i)
			end
		end

feature -- Observer pattern.

	on_class_moved (a_class: CLASS_I; old_cluster: CLUSTER_I) is
			-- `a_class' has been moved away from `old_cluster'.
		local
			new_cluster, current_cluster: CLUSTER_FIGURE
			cf: CLASS_FIGURE
		do
			cf ?= class_figure_by_class (a_class)
			if cf /= Void then 
				new_cluster := cluster_figure_by_cluster (a_class.cluster)
				current_cluster := cluster_figure_by_cluster (old_cluster)
				if new_cluster /= Void 
					and then current_cluster /= Void
					and then not new_cluster.name.is_equal (current_cluster.name) 
					then 
						current_cluster.remove_class (cf)
						new_cluster.add_class (cf)
						cf.point.set_position (new_cluster.width // 2, new_cluster.height // 2)
				end
			end
		end

	on_class_removed (a_class: CLASS_I) is
			-- `a_class' has been removed.
		do
			--| FIXME: to be implemented.
		end
		
feature -- Inapplicable

	include_dropped_class (a_class: CLASS_FIGURE; a_x, a_y: INTEGER) is
			-- Never called.
		do
			check False end
		end

	remove_dropped_class (a_class: CLASS_FIGURE) is
			-- Never called.
		do
			check False end
		end

end -- class CLUSTER_DIAGRAM



