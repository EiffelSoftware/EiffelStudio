indexing
	description: "Graphical representation of Clusters tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_CLUSTERS_TAB

inherit
	EV_VERTICAL_BOX

	EB_SYSTEM_TAB
		rename
			make as tab_make
		undefine
			default_create, is_equal, copy
		redefine
			reset, post_store_reset
		end

	EIFFEL_ENV
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end
	
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
	
create
	make

feature -- Access

	name: STRING is "Clusters"
			-- Name of tab in System Window.

	clusters: HASH_TABLE [CLUSTER_SD, STRING]
			-- Cluster data indexed by name

	current_cluster: STRING
			-- Name of cluster being analyzed.

feature -- Override cluster access

	has_override_cluster: BOOLEAN
			-- Has a cluster been selected to be the override cluster.
	
	override_cluster_check: EV_CHECK_BUTTON
			-- Override cluster option.
	
	override_cluster_name: STRING
			-- Name of override cluster if any.
			-- Void otherwise
	
feature -- Location access

	cluster_name: EV_TEXT_FIELD
			-- Name of cluster
			
	cluster_path: EV_PATH_FIELD
			-- Location of cluster

	all_check, library_check: EV_CHECK_BUTTON
			-- Is cluster using `all' or `library' specification.

feature -- Option access

	override_default_assertions, check_check, require_check, ensure_check,
	loop_check, invariant_check: EV_CHECK_BUTTON
			-- Assertion levels for current system.

	override_default_trace, trace_check: EV_CHECK_BUTTON
	trace_box: EV_BOX
			-- Trace option and box containing them.
			
	override_default_profile, profile_check: EV_CHECK_BUTTON
	profile_box: EV_BOX
			-- Profile option and box containing them.

feature -- Visible access

	visible_list: EV_ADD_REMOVE_LIST
			-- List of visible classes.

feature -- File access

	exclude_list: EV_ADD_REMOVE_LIST
			-- List of exclude clauses
			
	include_list: EV_ADD_REMOVE_LIST
			-- List of incluide clauses
			
	use_field: EV_TEXT_FIELD
			-- Use file for current cluster.

feature -- Cluster tree

	cluster_tree: EV_TREE
			-- Tree representing all clusters in system.
			
feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			l_clusters: LACE_LIST [CLUSTER_SD]
			copy_clusters: like clusters
			clus_name: ID_SD
		do
				-- Default options
			defaults := root_ast.defaults
			if defaults = Void then
					-- No default option, we need to create them.
				create defaults.make (10)
				root_ast.set_defaults (defaults)
			end

				-- Update last selected cluster info.
			if cluster_tree.selected_item /= Void then
				check
					has_text: not cluster_tree.selected_item.text.is_empty
					has_cluster_of_name: clusters.has (cluster_tree.selected_item.text)
				end
				store_cluster (cluster_tree.selected_item)
			end

				-- Save clusters
			copy_clusters := clone (clusters)
			l_clusters := root_ast.clusters
			if l_clusters = Void then
					-- No cluster option, we need to create them
				create l_clusters.make (copy_clusters.count)
				root_ast.set_clusters (l_clusters)
			end

				-- Insert cluster in the order in which they were entered
				-- originally.
			from
				l_clusters.start
			until
				l_clusters.after
			loop
				clus_name := l_clusters.item.cluster_name
				if copy_clusters.has (clus_name) then
					l_clusters.put (copy_clusters.item (clus_name))
					copy_clusters.remove (clus_name)
					l_clusters.forth
				else
					l_clusters.remove
				end
			end

				-- Insert at the end new clusters.
			if not copy_clusters.is_empty then
				from
					copy_clusters.start
				until
					copy_clusters.after
				loop
					l_clusters.extend (copy_clusters.item_for_iteration)
					copy_clusters.forth
				end
			end

				-- Mark override cluster if set.
			if has_override_cluster then
				defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.override_cluster,
					override_cluster_name, False))
			end
		end

	post_store_reset is
			-- Action to be done after a store has been done.
			-- If a cluster was selected we reread its content.
		do
			if cluster_tree.selected_item /= Void then
				check
					has_text: not cluster_tree.selected_item.text.is_empty
					has_cluster_of_name: clusters.has (cluster_tree.selected_item.text)
				end
				display_cluster (cluster_tree.selected_item)
			end
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		local
			defaults: LACE_LIST [D_OPTION_SD]
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					initialize_with_default_option (defaults.item)
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			end
			initialize_from_ast (root_ast)
		end

feature {NONE} -- Filling

	initialize_from_ast (root_ast: ACE_SD) is
			-- Initialize window with all data taken from `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		local
			cl: LACE_LIST [CLUSTER_SD]
			cluster: CLUSTER_SD
			node, parent_node: EV_TREE_ITEM
			cl_name: ID_SD
			tree_table: HASH_TABLE [EV_TREE_ITEM, STRING]
		do
			cl := root_ast.clusters
			if cl /= Void then
					-- Initialize tree view with data from `root_ast'.
					-- We use `tree_table' to remember position of
					-- parent cluster if any. For each tree item, we
					-- associate an action that will display information
					-- about a cluster and that will store the information.
				from
						-- Detached store information from original.
					cl := cl.duplicate

						-- Initialize graphical information
					create tree_table.make (cl.count)
					cl.start
				until
					cl.after
				loop
					cluster := cl.item
					cl_name := cluster.cluster_name
					node := new_cluster_item (cl_name)
					if cluster.has_parent then
						parent_node := tree_table.item (cluster.parent_name)
						if parent_node /= Void then
								-- If we do not find a parent, it means
								-- that parent has been wrongly specified
								-- in Ace file
							parent_node.extend (node)
						end
					else
						cluster_tree.extend (node)
					end
					clusters.put (cluster, cl_name)
					tree_table.put (node, cl_name)
					cl.forth
				end
				
				cluster_tree.i_th (1).enable_select
				
				tree_table := Void
			end
		end

	initialize_with_default_option (a_opt: D_OPTION_SD) is
			-- Initialize check buttons and text field associated with `a_opt'.
		require
			a_opt_not_void: a_opt /= Void
			a_opt_has_option: a_opt.option /= Void
			a_opt_has_value: a_opt.value /= Void
		local
			opt: OPTION_SD
			free_option: FREE_OPTION_SD
			val: OPT_VAL_SD
		do
			is_item_removable := False
			opt := a_opt.option
			val := a_opt.value
			if opt.is_free_option then
				free_option ?= opt
				if free_option.code = feature {FREE_OPTION_SD}.override_cluster then
					has_override_cluster := True
					override_cluster_name := val.value
					is_item_removable := True
				end
			end

		end

feature {NONE} -- Cluster display and saving

	display_cluster (tree_item: EV_TREE_NODE) is
			-- Display data from cluster `cl_name'.
		require
			tree_item: tree_item /= Void
			tree_item_has_text: not tree_item.text.is_empty
			has_cluster_of_name: clusters.has (tree_item.text)
		local
			cl: CLUSTER_SD
			incl: LACE_LIST [INCLUDE_SD]
			excl: LACE_LIST [EXCLUDE_SD]
			visib: LACE_LIST [CLAS_VISI_SD]
			default_options: LACE_LIST [D_OPTION_SD]
			l_item: EV_LIST_ITEM
			cl_name: STRING
		do
			reset_cluster_info

			cl_name := tree_item.text
			current_cluster := cl_name
			
			cl := clusters.item (cl_name)
			cluster_name.set_text (cl.cluster_name)
			cluster_path.set_text (cl.directory_name)

			is_in_select_action := True
			if has_override_cluster then
				set_selected (override_cluster_check, 
					override_cluster_name.is_equal (cl_name))
			else
				disable_select (override_cluster_check)
			end
		
			set_selected (all_check, cl.is_recursive)
			set_selected (library_check, cl.is_library)

			is_in_select_action := False

			if cl.cluster_properties /= Void then
				if cl.cluster_properties.use_name /= Void then
					use_field.set_text (cl.cluster_properties.use_name)
				end
				
				incl := cl.cluster_properties.include_option
				if incl /= Void then
					from
						incl.start
					until
						incl.after
					loop
						create l_item.make_with_text (incl.item.file__name)
						l_item.select_actions.extend (
							(include_list.text_field)~set_text(incl.item.file__name))
						include_list.list.extend (l_item)
						incl.forth
					end
				end
				
				excl := cl.cluster_properties.exclude_option
				if excl /= Void then
					from
						excl.start
					until
						excl.after
					loop
						create l_item.make_with_text (excl.item.file__name)
						l_item.select_actions.extend (
							(exclude_list.text_field)~set_text(excl.item.file__name))
						exclude_list.list.extend (l_item)
						excl.forth
					end
				end
			
				visib := cl.cluster_properties.visible_option
				if visib /= Void then
					from
						visib.start
					until
						visib.after
					loop
						create l_item.make_with_text (visib.item.class_name)
						l_item.select_actions.extend (
							(visible_list.text_field)~set_text(visib.item.class_name))
						visible_list.list.extend (l_item)
						visib.forth
					end
				end

				default_options := cl.cluster_properties.default_option
				if default_options /= Void then
					from
						default_options.start
					until
						default_options.after
					loop
						is_item_removable := False
						if default_options.item.option.is_assertion then
							retrieve_cluster_assertions (default_options.item.value)
						elseif default_options.item.option.is_free_option then
							retrieve_cluster_free_options (default_options.item)
						elseif default_options.item.option.is_trace then
							enable_select (override_default_trace)
							set_selected (trace_check, default_options.item.value.is_yes)
							is_item_removable := True
						end
						if is_item_removable then
							default_options.remove
						else
							default_options.forth
						end
					end
				end
			end
		end

	retrieve_cluster_free_options (opt: D_OPTION_SD) is
			-- Retrieve free option of current cluster.
		require
			opt_not_void: opt /= Void
			opt_is_free_option: opt.option.is_free_option
		local
			free_option: FREE_OPTION_SD
			val: OPT_VAL_SD
		do
			free_option ?= opt.option
			val := opt.value
			if free_option.code = feature {FREE_OPTION_SD}.profile then
				is_item_removable := True
				enable_select (override_default_profile)
				set_selected (profile_check, val.is_yes)
			end
		end

	retrieve_cluster_assertions (val: OPT_VAL_SD) is
			-- Set graphical display with info contained in `opt'.
		require
			val_not_void: val /= Void
		do
			is_item_removable := True
			enable_select (override_default_assertions)
			if val.is_check then
				enable_select (check_check)
			elseif val.is_require then
				enable_select (require_check)
			elseif val.is_ensure then
				enable_select (ensure_check)
			elseif val.is_loop then
				enable_select (loop_check)
			elseif val.is_invariant then
				enable_select (invariant_check)
			elseif val.is_all then
				enable_select (check_check)
				enable_select (require_check)
				enable_select (ensure_check)
				enable_select (loop_check)
				enable_select (invariant_check)
			end
		end

	store_cluster (tree_item: EV_TREE_NODE) is
			-- Store displayed data from cluster represented by `tree_item'.
		require
			tree_item: tree_item /= Void
			tree_item_has_text: not tree_item.text.is_empty
			has_cluster_of_name: clusters.has (tree_item.text)
		local
			cl: CLUSTER_SD
			prop: CLUST_PROP_SD
			l_include: LACE_LIST [INCLUDE_SD]
			l_exclude: LACE_LIST [EXCLUDE_SD]
			l_visible: LACE_LIST [CLAS_VISI_SD]
			default_options: LACE_LIST [D_OPTION_SD]
			cl_name: STRING
		do
				-- Setting cluster basics.
			cl_name := tree_item.text
			cl := clusters.item (cl_name)

			if not cluster_name.text.is_empty then
				if not cluster_name.text.is_equal (cl_name) then
						-- If name of cluster changed, we need to update the
						-- tree view entry and our internal data.
					tree_item.set_text (cluster_name.text)
					clusters.remove (cl_name)
					clusters.force (cl, cluster_name.text)
				end
				cl.set_cluster_name (new_id_sd (cluster_name.text, False))
			else
				cl.set_cluster_name (new_id_sd ("Invalid_name", False))
			end

			if not cluster_path.text.is_empty then
				cl.set_directory_name (new_id_sd (cluster_path.text, True))
			else
				cl.set_directory_name (new_id_sd ("Invalid_path", True))
			end

			cl.set_is_recursive (all_check.is_selected)
			cl.set_is_library (library_check.is_selected)

				-- Setting cluster properties.
			prop := cl.cluster_properties
			if prop = Void then
				prop := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, Void, Void) 
				cl.set_cluster_properties (prop)
			end

			if not use_field.text.is_empty then
				cl.cluster_properties.set_use_name (new_id_sd (use_field.text, True))
			end

			if not include_list.is_empty then
				l_include := prop.include_option
				if l_include = Void then
					l_include := new_lace_list_include_sd (include_list.count)
					prop.set_include_option (l_include)
				end

				fill_list (l_include, include_list.list, ~new_include_sd (?), True)
			end

			if not exclude_list.is_empty then
				l_exclude := prop.exclude_option
				if l_exclude = Void then
					l_exclude := new_lace_list_exclude_sd (exclude_list.count)
					prop.set_exclude_option (l_exclude)
				end

				fill_list (l_exclude, exclude_list.list, ~new_exclude_sd (?), True)
			end

			if visible_list.is_sensitive and then not visible_list.is_empty then
				l_visible := prop.visible_option
				if l_visible = Void then
					l_visible := new_lace_list_clas_visi_sd (visible_list.count)
					prop.set_visible_option (l_visible)
				end

				fill_list (l_visible, visible_list.list, ~new_clas_visi_sd (?, Void, Void, Void, Void), False)
			end

			if default_options = Void then
				create default_options.make (10)
				prop.set_default_option (default_options)
			end

			store_cluster_assertions (prop)

			if override_default_profile.is_selected then
				default_options.extend (new_special_option_sd (feature {FREE_OPTION_SD}.profile, Void, profile_check.is_selected))
			end

			if override_default_trace.is_selected then
				default_options.extend (new_trace_option_sd (trace_check.is_selected))
			end
		end

	store_cluster_assertions (prop: CLUST_PROP_SD) is
			-- Store assertions of current cluster
		require
			prop_not_void: prop /= Void 
			has_default_option: prop.default_option /= Void
		local
			d_option: D_OPTION_SD
			ass: ASSERTION_SD
			v: OPT_VAL_SD
			had_assertion: BOOLEAN
			default_options: LACE_LIST [D_OPTION_SD]
		do
			if override_default_assertions.is_selected then
				default_options := prop.default_option
				if check_check.is_selected then
					had_assertion := True
					v := new_check_sd (new_id_sd ("check", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					default_options.extend (d_option)
				end
				if require_check.is_selected then
					had_assertion := True
					v := new_require_sd (new_id_sd ("require", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					default_options.extend (d_option)
				end
				if ensure_check.is_selected then
					had_assertion := True
					v := new_ensure_sd (new_id_sd ("ensure", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					default_options.extend (d_option)
				end
				if loop_check.is_selected then
					had_assertion := True
					v := new_loop_sd (new_id_sd ("loop", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					default_options.extend (d_option)
				end
				if invariant_check.is_selected then
					had_assertion := True
					v := new_invariant_sd (new_id_sd ("invariant", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					default_options.extend (d_option)
				end
				if not had_assertion then
					v := new_no_sd (new_id_sd ("no", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					default_options.extend (d_option)
				end
			end
		end
	
	fill_optional_options is
			-- Store displayed information and fill graphical user interface
			-- with optional options.
		do

		end

	fill_default_options is
			-- 	Store displayed information and fill graphical user interface
			-- with default options.
		do
			
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Initialization

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			cluster_tree.wipe_out
			clusters.wipe_out
			has_override_cluster := False
			is_in_select_action := True
			reset_cluster_info
			override_cluster_name := Void
			disable_select (override_cluster_check)
			is_in_select_action := False
		ensure then
			clusters_empty: clusters.is_empty
			cluster_tree_is_empty: cluster_tree.is_empty
			no_more_override_cluster: not has_override_cluster and override_cluster_name = Void
			override_cluster_check_not_selected: not override_cluster_check.is_selected
			library_check_not_selected: not library_check.is_selected
			all_check_not_selected: not all_check.is_selected
			override_default_assertions_not_selected: not override_default_assertions.is_selected
			check_check_not_sensitive: not check_check.is_sensitive
			check_check_not_selected: not check_check.is_selected
			require_check_not_selected: not require_check.is_selected
			require_check_not_sensitive: not require_check.is_sensitive
			ensure_check_not_selected: not ensure_check.is_selected
			ensure_check_not_sensitive: not ensure_check.is_sensitive
			loop_check_not_selected: not loop_check.is_selected
			loop_check_not_sensitive: not loop_check.is_sensitive
			invariant_check_not_selected: not invariant_check.is_selected
			invariant_check_not_sensitive: not invariant_check.is_sensitive
			override_default_profile_not_selected: not override_default_profile.is_selected
			profile_check_not_selected: not profile_check.is_selected
			override_default_trace_not_selected: not override_default_trace.is_selected
			trace_check_not_selected: not trace_check.is_selected
			use_field_voided: use_field.text.is_empty
			cluster_name_voided: cluster_name.text.is_empty
			cluster_path_voided: cluster_path.text.is_empty
		end

feature {NONE} -- Initialization

	reset_cluster_info is
			-- Clean cluster frame from data currently displayed
		do
				-- Cluster type
			disable_select (library_check)
			disable_select (all_check)

				-- Cluster assertion
			disable_select (override_default_assertions)
			disable_select (check_check)
			disable_select (require_check)
			disable_select (ensure_check)
			disable_select (loop_check)
			disable_select (invariant_check)

				-- Cluster option
			disable_select (override_default_profile)
			disable_select (profile_check)
			disable_select (override_default_trace)
			disable_select (trace_check)
			use_field.remove_text
			visible_list.reset
			exclude_list.reset
			include_list.reset

				-- Cluster identification
			cluster_name.remove_text
			cluster_path.remove_text

			current_cluster := Void
		end
	
feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		local
			split: EB_HORIZONTAL_SPLIT_AREA
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			notebook: EV_NOTEBOOK
			widget: EV_WIDGET
			button: EV_BUTTON
		do
			system_window := top
			create clusters.make (10)

			tab_make
			default_create

			set_border_width (5)
	
			create split
			create vbox

			create hbox
			hbox.set_border_width (5)
			hbox.set_padding (5)
			hbox.extend (create {EV_CELL})

			create button.make_with_text_and_action ("Add", ~add_cluster)
			hbox.extend (button)
			hbox.disable_item_expand (button)

			create button.make_with_text_and_action ("Delete", ~delete_cluster)
			hbox.extend (button)
			hbox.disable_item_expand (button)
			
			hbox.extend (create {EV_CELL})

			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			create cluster_tree
			cluster_tree.set_minimum_width (175)
			vbox.extend (cluster_tree)

			split.set_first (vbox)
			split.enable_flat_separator
			
			create vbox
			vbox.set_border_width (5)
			vbox.set_padding (5)

			create label.make_with_text ("Cluster name:")
			label.align_text_left
			vbox.extend (label)
			vbox.disable_item_expand (label)

			create cluster_name
			vbox.extend (cluster_name)
			vbox.disable_item_expand (cluster_name)

			create cluster_path.make_with_text_and_parent ("Cluster path:", system_window.window)
			vbox.extend (cluster_path)
			vbox.disable_item_expand (cluster_path)
			
			create hbox
			override_cluster_check := new_check_button (hbox, "override")
			override_cluster_check.select_actions.extend (~select_current_for_override)

			hbox.extend (create {EV_CELL})
			library_check := new_check_button (hbox, "library")
			library_check.select_actions.extend (~select_for_library)
			hbox.extend (create {EV_CELL})
			all_check := new_check_button (hbox, "all")
			all_check.select_actions.extend (~select_for_all)
			
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			create notebook
			
			widget := options_frame
			notebook.extend (widget)
			notebook.set_item_text (widget, "Options")
			
			create visible_list.make
			notebook.extend (visible_list)
			notebook.set_item_text (visible_list, "Visible classes")
		
			widget := file_frame
			notebook.extend (widget)
			notebook.set_item_text (widget, "Exclude/include")
			
			vbox.extend (notebook)
			
			split.set_second (vbox)
			extend (split)

				-- Add C specific widgets
			c_specific_widgets.extend (visible_list)
			c_specific_widgets.extend (trace_box)	
			c_specific_widgets.extend (profile_box)	
		end

	options_frame: EV_VERTICAL_BOX is
			-- Frame which contains options of cluster
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
-- 			label: EV_LABEL
-- 			type: EV_COMBO_BOX
-- 			l_item: EV_LIST_ITEM
		do
			create Result
			Result.set_border_width (3)
			Result.set_padding (3)
			
-- 			create hbox
-- 			hbox.set_padding (3)
-- 			create label.make_with_text ("type: ")
-- 			label.align_text_left
-- 			hbox.extend (label)
-- 			hbox.disable_item_expand (label)
-- 			create type
-- 			type.disable_edit
-- 			create l_item.make_with_text ("Default")
-- 			l_item.select_actions.extend (~fill_default_options)
-- 			type.extend (l_item)
-- 			create l_item.make_with_text ("Optional")
-- 			l_item.select_actions.extend (~fill_optional_options)
-- 			type.extend (l_item)
-- 			hbox.extend (type)
-- 			
-- 			Result.extend (hbox)
-- 			Result.disable_item_expand (hbox)
			
			create hbox
			create vbox
			override_default_assertions := new_check_button (vbox, "override default assertions")
			check_check := new_check_button (vbox, "check")
			require_check := new_check_button (vbox, "require")
			ensure_check := new_check_button (vbox, "ensure")
			loop_check := new_check_button (vbox, "loop")
			invariant_check := new_check_button (vbox, "class invariant")
			hbox.extend (vbox)
		
				-- Set up exclusive between `override_default_assertions' and other
				-- assertion checks.
			assertions_list.do_all (agent {EV_CHECK_BUTTON}.disable_sensitive)
			override_default_assertions.select_actions.extend (~list_desactivation_action
				(override_default_assertions, assertions_list))

			create vbox

				-- Set up exclusive between `override_default_trace' and
				-- `trace_check'. `trace_box' is just there so that both
				-- check boxes are disable in non-C generation.
			create {EV_VERTICAL_BOX} trace_box
			override_default_trace := new_check_button (trace_box, "override trace")
			trace_check := new_check_button (trace_box, "trace")
			trace_check.disable_sensitive
			override_default_trace.select_actions.extend (~desactivation_action
				(override_default_trace, trace_check))
			vbox.extend (trace_box)

				-- Set up exclusive between `override_default_profile' and
				-- `profile_check'. `profile_box' is just there so that both
				-- check boxes are disable in non-C generation.
			create {EV_VERTICAL_BOX} profile_box
			override_default_profile := new_check_button (profile_box, "override profile")
			profile_check := new_check_button (profile_box, "profile")
			profile_check.disable_sensitive
			override_default_profile.select_actions.extend (~desactivation_action
				(override_default_profile, profile_check))
			if Has_profiler then
				vbox.extend (profile_box)
			end

			hbox.extend (vbox)
		
			Result.extend (hbox)
			Result.disable_item_expand (hbox)
		end
	
	file_frame: EV_VERTICAL_BOX is
			-- Frame which contains options "exclude", "include"
			-- and "use".
		local
-- 			label: EV_LABEL
			frame: EV_FRAME
		do
			create Result
			Result.set_border_width (5)
			Result.set_padding (5)
			
-- FIXME: Manu 06/16/2001: Disabled "use" entry
-- 			create label.make_with_text ("Use:")
-- 			label.align_text_left
-- 			Result.extend (label)
-- 			Result.disable_item_expand (label)
 			
			create use_field
--			Result.extend (use_field)
--			Result.disable_item_expand (use_field)
			
			create exclude_list.make
			create frame.make_with_text ("Exclude")
			frame.extend (exclude_list)
			Result.extend (frame)

			create include_list.make
			create frame.make_with_text ("Include")
			frame.extend (include_list)
			Result.extend (frame)
		end

feature {NONE} -- Actions

	add_cluster is
			-- Add new cluster to current cluster tree.
		local
			clus_window: EB_SYSTEM_CLUSTER_WINDOW
		do
			create clus_window.make (cluster_tree)
			clus_window.show_modal_to_window (window_manager.last_focused_window.window)
			if clus_window.is_selected then
					-- A new cluster has been added
				add_cluster_name (clus_window.parent_cluster,
					clus_window.cluster_name, clus_window.cluster_path)
			end
		end

	delete_cluster is
			-- Remove currently selected cluster.
		local
			l_item, node: EV_TREE_ITEM
			found: BOOLEAN
			clus_name: STRING
		do
			l_item ?= cluster_tree.selected_item
			if l_item /= Void then
				clus_name := cluster_tree.selected_item.text
				check
					has_text: not clus_name.is_empty
					has_cluster_of_name: clusters.has (cluster_tree.selected_item.text)
				end
				reset_cluster_info
				from
					cluster_tree.start
				until
					cluster_tree.after or found
				loop
					node ?= cluster_tree.item
					check
						node_not_void: node /= Void
					end
					if node = l_item then
						found := True
						if not node.is_empty then
							remove_subtree_info (node)
						end
						cluster_tree.remove
					else
						remove_tree_item (node, l_item)
						cluster_tree.forth
					end
				end
				clusters.remove (clus_name)
			end
		end

	remove_tree_item (tree: EV_TREE_ITEM; element: EV_TREE_ITEM) is
			-- Remove `element' from `tree' if `tree' has `element'.
		require
			tree_not_void: tree /= Void
			element_not_void: element /= Void
		local
			node: EV_TREE_ITEM
			found: BOOLEAN
		do
			from
				tree.start
			until
				tree.after or found
			loop
				node ?= tree.item
				check
					node_not_void: node /= Void
				end
				if node = element then
					found := True
					if not node.is_empty then
						remove_subtree_info (node)
					end
					tree.remove
				else
					remove_tree_item (node, element)
					tree.forth
				end
			end
		end

	remove_subtree_info (tree: EV_TREE_NODE) is
		require
			tree_not_void: tree /= Void
			tree_not_empty: not tree.is_empty
		local
			node: EV_TREE_NODE
		do
			from
				tree.start
			until
				tree.after
			loop
				node := tree.item
				if not node.is_empty then
					remove_subtree_info (node)
				else
					clusters.remove (node.text)
				end
				tree.forth
			end
		end

	select_current_for_override is
			-- Handle click on `override' check box.
		require
			override_cluster_check_not_void: override_cluster_check /= Void
		local
			ck: like override_cluster_check
		do
			if not is_in_select_action then
				ck := override_cluster_check	
				if ck.is_selected then
					if not has_override_cluster then
						has_override_cluster := True
						override_cluster_name := cluster_name.text
					else
							--| FIXME: We are changing the override cluster, we need
							--| to display a warning.
						override_cluster_name := cluster_name.text
					end
					if override_cluster_name.is_empty then
						override_cluster_name := Void
					end
				else
					has_override_cluster := False
					override_cluster_name := Void
				end
			end
		end

	select_for_library is
			-- Handle click on `library' check box.
		require
			library_check_not_void: library_check /= Void
		do
			if not is_in_select_action then
				is_in_select_action := True
				if library_check.is_selected then
					disable_select (all_check)
				end
				is_in_select_action := False
			end
		end

	select_for_all is
			-- Handle click on `all' check box.
		require
			all_check_not_void: all_check /= Void
		do
			if not is_in_select_action then
				is_in_select_action := True
				if all_check.is_selected then
					disable_select (library_check)
				end
				is_in_select_action := False
			end
		end

	is_in_select_action: BOOLEAN
			-- To avoid recursion in select action between library and all.

feature {NONE} -- Cluster addition implementation

	add_cluster_name (parent_name, cl_name, path: STRING) is
		require
			cl_name_not_void: cl_name /= Void
			cl_name_valid: valid_identifier (cl_name)
			parent_name_valid: parent_name /= Void implies valid_identifier (parent_name)
			has_parent: parent_name /= Void implies clusters.has (parent_name)
		local
			cluster_sd: CLUSTER_SD
			node: EV_TREE_ITEM
		do
			if parent_name = Void then
				cluster_tree.extend (new_cluster_item (cl_name))
				cluster_sd := new_cluster_sd (
					new_id_sd (cl_name, False), Void, new_id_sd (path, True), Void, False, False)
				clusters.put (cluster_sd, cl_name)
			else
				from
					cluster_tree.start
				until
					cluster_tree.after
				loop
					node ?= cluster_tree.item
					check
						node_not_void: node /= Void
					end
					add_cluster_recursive_traversal (node, parent_name, cl_name, path)
					cluster_tree.forth
				end
			end
		end

	add_cluster_recursive_traversal (tree: EV_TREE_ITEM; parent_name, cl_name, path: STRING) is
		require
			tree_not_void: tree /= Void
			cl_name_not_void: cl_name /= Void
			parent_name_not_void: parent_name /= Void
			cl_name_valid: valid_identifier (cl_name)
			parent_name_valid: valid_identifier (parent_name)
			has_parent: clusters.has (parent_name)
		local
			node: EV_TREE_ITEM
			cluster_sd: CLUSTER_SD

		do
			if tree.text.is_equal (parent_name) then
				tree.extend (new_cluster_item (cl_name))
				cluster_sd := new_cluster_sd (
					new_id_sd (cl_name, False), new_id_sd (parent_name, False),
					new_id_sd (path, True), Void, False, False)
				clusters.put (cluster_sd, cl_name)
			else
				from
					tree.start
				until
					tree.after
				loop
					node ?= tree.item
					check
						node_not_void: node /= Void
					end
					add_cluster_recursive_traversal (node, parent_name, cl_name, path)
					tree.forth
				end
			end
		end

	new_cluster_item (cl_name: STRING): EV_TREE_ITEM is
		require
			cl_name_not_void: cl_name /= Void
			cl_name_valid: valid_identifier (cl_name)
		do
			create Result.make_with_text (cl_name)
			Result.set_pixmap (Pixmaps.Icon_cluster_symbol @ 1)
			Result.select_actions.extend (~display_cluster (Result))
			Result.deselect_actions.extend (~store_cluster (Result))
		end

feature {NONE} -- List filling

	fill_list (target: LIST [ANY]; source: EV_LIST; item_creator: FUNCTION [ANY, TUPLE [ID_SD], AST_LACE]; is_string: BOOLEAN) is
			-- Take graphical list `source' and fills `target' with text
			-- element of `target'.
		require
			target_not_void: target /= Void
			source_not_void: source /= Void
			source_not_empty: not source.is_empty
			item_creator_not_void: item_creator /= Void
		do
			from
				target.wipe_out
				source.start
			until
				source.after
			loop
				target.extend (item_creator.item ([new_id_sd (source.item.text, is_string)]))
				source.forth
			end
		ensure
			target_filled: target.count = source.count
		end

feature {NONE} -- Assertion checks access through list

	assertions_list: ARRAYED_LIST [EV_CHECK_BUTTON] is
			-- List of assertion checks.
		do
			create Result.make (5)
			Result.extend (check_check)
			Result.extend (require_check)
			Result.extend (ensure_check)
			Result.extend (loop_check)
			Result.extend (invariant_check)
		end
		
invariant
	cluster_tree_not_void: cluster_tree /= Void
	
end -- class EB_SYSTEM_GENERAL_TAB
