indexing
	description: "Guides the user through the options for project documentation."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOCUMENTATION_WIZARD

inherit
	EV_DIALOG
		redefine
			initialize
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create, copy
		end

	EIFFEL_ENV
		undefine
			default_create, copy
		end

	CLASS_FORMAT_CONSTANTS
		undefine
			default_create, copy
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_ERROR_HANDLER
		undefine
			default_create, copy
		end
		
	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create, copy
		end
	
	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Set defaults.
		local
			vb: EV_VERTICAL_BOX
			hsep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor
			set_title ("Project documentation")
			set_default_settings
			create vb
			create button_bar
			button_bar.extend (create {EV_CELL})
			create cancel_button.make_with_text ("Cancel")
			cancel_button.select_actions.extend (~cancel)
			extend_button (button_bar, cancel_button)
			create previous_button.make_with_text ("Previous")
			previous_button.select_actions.extend (~previous)
			extend_button (button_bar, previous_button)
			create next_button.make_with_text ("Next")
			next_button.select_actions.extend (~next)
			extend_button (button_bar, next_button)
			create finish_button.make_with_text ("Finish")
			finish_button.select_actions.extend (~finish)
			extend_button (button_bar, finish_button)
			create wizard_area
			wizard_area.align_text_center
			vb.extend (wizard_area)
			create hsep
			vb.extend (hsep)
			vb.disable_item_expand (hsep)
			vb.extend (button_bar)
			button_bar.set_padding (Layout_constants.Small_padding_size)
			vb.disable_item_expand (button_bar)
			extend (vb)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Default_border_size)
			set_default_cancel_button (cancel_button)
		end

	set_default_settings is
			-- Initialize user selection.
		local
			b: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			create list_area
			create filter_combo_box
			list_area.extend (filter_combo_box)
			create cluster_include
			create indexing_include
			indexing_include.exclude_list.set_strings (
				(create {EB_FLAT_SHORT_DATA}).excluded_indexing_items
			)
			create option_page
			fill_option_box (option_page)
			create view_page
			create hb
			create directory_area
			directory_area.extend (create {EV_CELL})
			directory_area.extend (hb)
			directory_area.disable_item_expand (hb)
			create directory_field.make_with_text (Eiffel_system.document_path)
			directory_field.return_actions.extend (~on_directory_return_pressed)
			hb.extend (directory_field)
			create b.make_with_text ("Browse...")
			b.select_actions.extend (~on_browse)
			hb.extend (b)
			hb.disable_item_expand (b)
			directory_area.extend (create {EV_CELL})
			directory_area.extend (create {EV_LABEL}.make_with_text (
				"Click `Finish' to generate the documentation."
			))
		end
	
feature -- Access

	filter: STRING is
			-- User selection.
		local
			si: DYNAMIC_LIST [EV_LIST_ITEM]
		do
		--	Result := filter_combo_box.text
			si := filter_combo_box.selected_items
			if not si.is_empty then
				Result := si.first.text
			end
		end

	documentation_universe: DOCUMENTATION_UNIVERSE is
			-- User selection.
		local
			l: EV_LIST
			cl: CLUSTER_I
		do
			create Result.make
			l := cluster_include.include_list
			from l.start until l.after loop
				cl ?= l.item.data
				Result.include_cluster (cl, False)
				l.forth
			end
		end

	excluded_indexing_items: LINKED_LIST [STRING] is
			-- Indexing items user does not want generated in HTML meta clauses.
		do
			Result := indexing_include.exclude_list.strings
		end

	diagram_views: HASH_TABLE [STRING, STRING]
			-- Contains (view_name, cluster_name) couples for every included cluster.

	class_list_selected: BOOLEAN is
			-- Does the user want a class list?
		do
			Result := class_list_button.is_selected
		end

	cluster_list_selected: BOOLEAN is
			-- Does the user want a cluster list?
		do
			Result := cluster_list_button.is_selected
		end

	cluster_hierarchy_selected: BOOLEAN is
			-- Does the user want a cluster hierarchy?
		do
			Result := cluster_hierarchy_button.is_selected
		end

	cluster_charts_selected: BOOLEAN is
			-- Does the user want cluster charts?
		do
			Result := cluster_charts_button.is_selected
		end

	cluster_diagrams_selected: BOOLEAN is
			-- Does the user want cluster diagrams?
		do
			Result := cluster_diagrams_button.is_selected
		end
		
	directory: DIRECTORY is
			-- Location where documentation should be generated.
		local
			dir_name: STRING
		do
			dir_name := directory_field.text
			create Result.make (dir_name)
		end

	cancelled: BOOLEAN
			-- Has the user pressed "Cancel"?

	html_css_filter_name: STRING is "html-stylesheet"
			-- Name of html-css filter, which should be selected
			-- by default when wizard shows up.

feature -- Widgets

	button_bar: EV_HORIZONTAL_BOX
			-- Bar containing "Cancel", "Previous", "Next", "Finish".

	wizard_area: EV_FRAME
			-- Area dedicated to a specific page in the wizard.

	cancel_button: EV_BUTTON
			-- Button to close the wizard.
	
	previous_button: EV_BUTTON
			-- Button to go back one page.

	next_button: EV_BUTTON
			-- Button to go forth one page.

	finish_button: EV_BUTTON
			-- Button to confirm current selection.

feature -- Status report

	is_html: BOOLEAN is
			-- Is an HTML filter selected?
		do
			Result := filter /= Void and then filter.substring_index ("html", 1) > 0
		end

	update_filters: BOOLEAN
			-- Does the filter view need updating?	

	update_clusters: BOOLEAN
			-- Does the cluster view need updating?

	update_indexes: BOOLEAN
			-- Does the indexing view need updating?

feature -- Miscellaneous

	start is
			-- Show the first page.
		do
			cancelled := False
			current_page := 1
			update_clusters := True
			update_filters := True
			update_indexes := True
			set_size (wizard_width, wizard_height)
			finish_button.disable_sensitive
			go_to_page (current_page)
			show
		end

	next is
			-- Show next page.
		do
			current_page := current_page + 1
			if not is_html and then html_specific_page (current_page) then
				current_page := current_page + 1
			end
			if not (cluster_diagrams_selected and is_html) and then diagram_specific_page (current_page) then
				current_page := current_page + 1
			end
			go_to_page (current_page)
		end

	previous is
			-- Revert to previous page.
		do
			current_page := current_page - 1
			if not is_html and then html_specific_page (current_page) then
				current_page := current_page - 1
			end
			if not (cluster_diagrams_selected and is_html) and then diagram_specific_page (current_page) then
				current_page := current_page - 1
			end			
			go_to_page (current_page)
		end

	cancel is
			-- Close the wizard and do nothing.
		do
			hide
			cancelled := True
		end

	finish is
			-- Close the wizard and work with current selection.
		do
			hide
		end

feature {NONE} -- Widgets

	filter_combo_box: EV_LIST
			-- Where `filter' is selected.

	list_area: EV_CELL
			-- Bug workaround where EV_LIST does not like to be unparented.

	cluster_include: EB_INCLUDE_EXCLUDE
			-- Where cluster selection is made.

	indexing_include: EB_INCLUDE_EXCLUDE
			-- Where indexing tag selection is made.

	option_page: EV_VERTICAL_BOX
			-- Where options are set.

	view_page: EV_VERTICAL_BOX
			-- Where views are set.

	view_mcl: EV_MULTI_COLUMN_LIST
			-- Displays clusters and their associated views.

	view_label: EV_LABEL
			-- Displays information about selecting views.
			
	view_list: EV_LIST
			-- Displays available views for one cluster.
			
	set_view_button: EV_BUTTON
			-- Assign view selected in `view_list' to current cluster.

	directory_field: EV_TEXT_FIELD
			-- Where target directory is specified.

	directory_area: EV_VERTICAL_BOX
			-- Area containing `directory_field' and a browse button.

	class_list_button: EV_CHECK_BUTTON
	cluster_list_button: EV_CHECK_BUTTON
	cluster_hierarchy_button: EV_CHECK_BUTTON
	cluster_charts_button: EV_CHECK_BUTTON
	cluster_diagrams_button: EV_CHECK_BUTTON

feature {NONE} -- Implementation

	current_page: INTEGER
			-- Index of page currently opened.

	html_specific_page (i: INTEGER): BOOLEAN is
			-- Index of page allowing to choose metatags.
		do
			Result := i = 3
		end
		
	diagram_specific_page (i: INTEGER): BOOLEAN is
			-- Index of page allowing to choose diagram views.
		do
			Result := i = 5
		end
	
	go_to_page (i: INTEGER) is
			-- Display page with `i' as index.
		do
			inspect i when 1 then
				previous_button.disable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_filter_selection
			when 2 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_cluster_selection
			when 3 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_indexing_selection
			when 4 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_option_selection
			when 5 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_view_selection
			when 6 then
				previous_button.enable_sensitive
				next_button.disable_sensitive
				finish_button.enable_sensitive
				set_default_push_button (finish_button)
				show_directory_selection
			end
		end

	show_filter_selection is
		do
			if update_filters then
				fill_filter_box (filter_combo_box)
				update_filters := False			
			end
			wizard_area.replace (list_area)
			wizard_area.set_text ("Select format for output")
		end

	show_cluster_selection is
		do
			wizard_area.wipe_out
			wizard_area.set_text ("Select clusters to generate documentation for")
			if update_clusters then
				set_pointer_style (Default_pixmaps.Wait_cursor)
				fill_cluster_box (cluster_include)
				update_clusters := False
				set_pointer_style (Default_pixmaps.Standard_cursor)
			end
			wizard_area.replace (cluster_include)
		end

	show_indexing_selection is
		local
			dial: EV_WARNING_DIALOG
			err: SYNTAX_ERROR
			retried: BOOLEAN
		do
			if not retried then
				wizard_area.wipe_out
				wizard_area.set_text ("Select indexing items to include in HTML meta tags")
				if update_indexes then
					set_pointer_style (Default_pixmaps.Wait_cursor)
					fill_indexing_box (indexing_include)
					update_indexes := False
					set_pointer_style (Default_pixmaps.Standard_cursor)
				end
				wizard_area.replace (indexing_include)
			else
				cancel
			end
		rescue
			if not Error_handler.error_list.is_empty then
				err ?= Error_handler.error_list.first
					if err /= void then
						Error_handler.error_list.wipe_out
						create dial.make_with_text ("Indexing clause has syntax error")
						dial.show_modal_to_window (Window_manager.last_focused_development_window.window)
					end
			end
			retried := True
			retry
		end

	show_option_selection is
		do
			wizard_area.replace (option_page)
			wizard_area.set_text ("Select the formats to use")
		end

	show_view_selection is
		do
			set_pointer_style (Default_pixmaps.Wait_cursor)
			fill_view_page (view_page)
			set_pointer_style (Default_pixmaps.Standard_cursor)
			wizard_area.replace (view_page)
			wizard_area.set_text ("Select the diagrams to generate")
			set_size (wizard_width, wizard_height)
		end

	show_directory_selection is
		do
			wizard_area.replace (directory_area)
			wizard_area.set_text ("Select directory to generate the documentation in")
		end

feature {NONE} -- Implementation

	fill_filter_box (list: like filter_combo_box) is
		local
			filter_dir: DIRECTORY
			file_name, file_suffix: STRING
			name_count: INTEGER
			filter_names: SORTED_TWO_WAY_LIST [STRING]
			str_element: EV_LIST_ITEM
			selected: INTEGER
		do
			create filter_dir.make (filter_path)
			if not filter_dir.exists then
				list.wipe_out
				create str_element
				list.extend (str_element)
			elseif not filter_dir.is_readable then
				list.wipe_out
				create str_element
				list.extend (str_element)
			else
				create filter_names.make
				filter_dir.open_read
				from
					filter_dir.start
					filter_dir.readentry
					file_name := filter_dir.lastentry
				until
					file_name = Void
				loop
					name_count := file_name.count
					if name_count > 4 then 
						file_suffix := file_name.substring (name_count - 3, name_count)
						file_suffix.to_lower
						if file_suffix.is_equal (".fil") then
							file_name.head (name_count - 4)
							filter_names.extend (file_name)
						end
					end
					filter_dir.readentry
					file_name := filter_dir.lastentry
				end
				filter_dir.close
				list.wipe_out
				selected := 1
				if filter_names.is_empty then
					create str_element
					list.extend (str_element)
				else
					from
						filter_names.start
					until
						filter_names.after
					loop
						create str_element.make_with_text (filter_names.item)
						list.extend (str_element)
						str_element.pointer_double_press_actions.force_extend (str_element~enable_select)
						str_element.pointer_double_press_actions.force_extend (~next)
						if filter_names.item.is_equal (html_css_filter_name) then
							selected := list.count
						end
						filter_names.forth
					end
				end
			end
			if not list.is_empty then
				list.i_th (selected).enable_select
			end
		end

	fill_cluster_box (ie: EB_INCLUDE_EXCLUDE) is
			-- Fill `ie.include_list' with all clusters in system.
			-- We assume that new added clusters go into the "include" part.
		local
			li: EV_LIST_ITEM
			cl: LINKED_LIST [CLUSTER_I]
			cl_name: STRING
			old_exclude: LINKED_LIST [STRING]
		do
			old_exclude := ie.exclude_list.strings
			old_exclude.compare_objects
			ie.exclude_list.wipe_out
			ie.include_list.wipe_out
			cl := Eiffel_universe.clusters
			from cl.start until cl.after loop
				cl_name := clone (cl.item.cluster_name)
				create li.make_with_text (cl_name)
				li.set_data (cl.item)
				if old_exclude.has (cl_name) then
					ie.exclude_list.extend (li)
				else
					ie.include_list.extend (li)
				end
				cl.forth
			end
		end

	fill_indexing_box (ie: EB_INCLUDE_EXCLUDE) is
			-- Fill `ie.include_list' with all indexing tags.
			-- Except the ones in `exclude_indexing_items'.
		local
			li: EV_LIST_ITEM
			cl: LINKED_LIST [CLUSTER_I]
			classes: EXTEND_TABLE [CLASS_I, STRING]
			all_tags: LINKED_LIST [STRING]
			old_exclude: LINKED_LIST [STRING]
			l_cluster: CLUSTER_I
			l_class: CLASS_I
		do
			create all_tags.make
			all_tags.extend ("keywords")
			all_tags.compare_objects
			cl := Eiffel_universe.clusters
			from cl.start until cl.after loop
				l_cluster := cl.item
				add_indexes (l_cluster.indexes, all_tags)
				classes := l_cluster.classes
				if classes /= Void then
					from classes.start until classes.after loop
						l_class := classes.item_for_iteration
						if l_class.compiled then
							add_indexes (l_class.compiled_class.ast.top_indexes, all_tags)	
							add_indexes (l_class.compiled_class.ast.bottom_indexes, all_tags)	
						end
						classes.forth
					end
				end
				cl.forth
			end
			
			old_exclude := ie.exclude_list.strings
			old_exclude.compare_objects
			ie.exclude_list.wipe_out
			ie.include_list.wipe_out
			from all_tags.start until all_tags.after loop
				create li.make_with_text (all_tags.item)
				if old_exclude.has (all_tags.item) then
					ie.exclude_list.extend (li)
				else
					ie.include_list.extend (li)
				end
				all_tags.forth
			end
		end

	add_indexes (i: EIFFEL_LIST [INDEX_AS]; l: LINKED_LIST [STRING]) is
		local
			t: STRING
		do
			if i /= Void then
				from i.start until i.after loop
					t := i.item.tag
					if t /= Void and then not l.has (t) then
						l.extend (clone (t))
					end
					i.forth
				end
			end
		end

	fill_option_box (p: EV_VERTICAL_BOX) is
		local
			cb: EV_CHECK_BUTTON
			vs: EV_HORIZONTAL_SEPARATOR
			cf: CLASS_FORMAT
			af: LINEAR [INTEGER]
		do
			create class_list_button.make_with_text ("Alphabetical class list")
			class_list_button.enable_select
			p.extend (class_list_button)
			create cluster_list_button.make_with_text ("Alphabetical cluster list")
			cluster_list_button.enable_select
			p.extend (cluster_list_button)
			create cluster_hierarchy_button.make_with_text ("Cluster hierarchy")
			cluster_hierarchy_button.enable_select
			p.extend (cluster_hierarchy_button)

			create vs
			p.extend (vs)
			p.disable_item_expand (vs)

			create cluster_charts_button.make_with_text ("Cluster charts")
			cluster_charts_button.enable_select
			p.extend (cluster_charts_button)

			create cluster_diagrams_button.make_with_text ("Cluster diagrams %
				%  (may take a long time !)")
			cluster_diagrams_button.disable_select
			p.extend (cluster_diagrams_button)

			create vs
			p.extend (vs)
			p.disable_item_expand (vs)

			af := all_class_formats.linear_representation
			from af.start until af.after loop
				create cf.make (af.item)
				create cb.make_with_text (cf.description)
				cb.select_actions.extend (~on_cf_toggle (cf, cb))
				if cf.is_generated then
					cb.enable_select
				end
				p.extend (cb)
				af.forth
			end
		end

	fill_view_page (vb: EV_VERTICAL_BOX) is
			-- Initialize `view_page'.
		require
			vb_not_void: vb /= Void
		local
			cluster_row: EV_MULTI_COLUMN_LIST_ROW
			right_vb: EV_VERTICAL_BOX
			main_hb, button_hb: EV_HORIZONTAL_BOX
			cluster_list: EV_LIST
			ci: CLUSTER_I
			g: EB_DIAGRAM_HTML_GENERATOR
			views: LINKED_LIST [STRING]
		do
			vb.wipe_out
			create diagram_views.make (10)
			create main_hb
			create view_mcl
			create right_vb
			create button_hb
			create view_list
			create set_view_button.make_with_text_and_action ("Set", ~on_set_view_button_pressed)
			set_view_button.disable_sensitive
			create view_label.make_with_text ("Select a cluster to display available views")
			cluster_list := cluster_include.include_list
			from
				cluster_list.start
			until
				cluster_list.after
			loop
				ci ?= cluster_list.item.data
				if ci /= Void then
					create g.make_for_wizard (ci)
					create cluster_row
					cluster_row.extend (ci.cluster_name)
					cluster_row.extend ("DEFAULT")
					views := g.available_views
					cluster_row.set_data (views)
					cluster_row.select_actions.extend (~on_cluster_selected (cluster_row))
					view_mcl.extend (cluster_row)
					
					if not views.is_empty then
						diagram_views.put ("DEFAULT", ci.cluster_name)
					end
				end	
				cluster_list.forth
			end
			view_mcl.set_column_title ("Cluster", 1)
			view_mcl.set_column_title ("View", 2)
			view_mcl.resize_column_to_content (1)
			view_mcl.set_minimum_width (240)
			main_hb.extend (view_mcl)
			main_hb.extend (right_vb)
			button_hb.extend (create {EV_CELL})
			extend_button (button_hb, set_view_button)
			button_hb.extend (create {EV_CELL})
			right_vb.extend (view_label)
			right_vb.extend (view_list)
			right_vb.extend (button_hb)
			right_vb.disable_item_expand (button_hb)
			right_vb.set_padding (Layout_constants.Small_padding_size)
			right_vb.set_border_width (Layout_constants.Default_border_size)
			vb.extend (main_hb)
		end
		
	on_cluster_selected (row: EV_MULTI_COLUMN_LIST_ROW) is
			-- `row' has been selected.
			-- Display available views for corresponding cluster in `view_list'.
			-- Update `view_label'.
		local
			views: LINKED_LIST [STRING]
			view_name: STRING
		do
			views ?= row.data
			if views /= Void then
				view_list.wipe_out
				from
					views.start
				until
					views.after
				loop
					view_name ?= views.item
					view_list.extend (create {EV_LIST_ITEM}.make_with_text (views.item))
					views.forth
				end
				if views.is_empty then
					view_label.set_text ("No views are available for this cluster")
					set_view_button.disable_sensitive
				else
					view_label.set_text ("Select the view you want to use")
					set_view_button.enable_sensitive
				end
			end
		end
		
	on_set_view_button_pressed is
			-- `set_view_button' was pressed.
			-- Update `view_mcl'.
		local
			cluster_name: STRING
			selected_row: EV_MULTI_COLUMN_LIST_ROW
		do
			if view_list.selected_item /= Void then
				selected_row := view_mcl.selected_item
				cluster_name := selected_row.first
				selected_row.finish
				selected_row.remove
				selected_row.extend (view_list.selected_item.text)
				diagram_views.replace (view_list.selected_item.text, cluster_name)
			end
		end
		
	on_directory_return_pressed is
			-- Return was pressed after typing a directory name.
			-- Press `finish_button'.
		do
			finish_button.select_actions.call ([])
		end
			
	on_cf_toggle (cf: CLASS_FORMAT; state: EV_CHECK_BUTTON) is
			-- Set the generated state of `cf' to the selected state of `state'.
		do
			cf.set_generated (state.is_selected)
		end

	on_browse is
			-- User pressed "browse" button.
		local
			d: EV_DIRECTORY_DIALOG
			path: STRING
		do
			create d
			d.ok_actions.extend (~on_directory_change (d))
			path := directory_field.text
			if not path.is_empty and then (create {DIRECTORY}.make (path)).exists then
				d.set_start_directory (path)
			end
			d.show_modal_to_window (Current)
		end

	on_directory_change (d: EV_DIRECTORY_DIALOG) is
		do
			if d.directory.is_empty then
				directory_field.remove_text
			else
				directory_field.set_text (d.directory)
			end
		end

	wizard_width: INTEGER is 420
		-- Nicest value for width of Current.

	wizard_height: INTEGER is 350
		-- Nicest value for height of Current.

end -- class EB_DOCUMENTATION_WIZARD
