note
	description: "Guides the user through the options for project documentation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOCUMENTATION_WIZARD

inherit
	EB_DIALOG
		redefine
			initialize
		end

	SHARED_EIFFEL_PROJECT
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

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {EV_ANY} -- Initialization

	initialize
			-- Set defaults.
		local
			vb: EV_VERTICAL_BOX
			hsep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor
			set_title (interface_names.t_project_documentation)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			set_default_settings
			create vb
			create button_bar
			button_bar.extend (create {EV_CELL})
			create cancel_button.make_with_text (interface_names.b_cancel)
			cancel_button.select_actions.extend (agent cancel)
			extend_button (button_bar, cancel_button)
			create previous_button.make_with_text (interface_names.b_arrow_back)
			previous_button.select_actions.extend (agent previous)
			extend_button (button_bar, previous_button)
			create next_button.make_with_text (interface_names.b_arrow_next)
			next_button.select_actions.extend (agent next)
			extend_button (button_bar, next_button)
			create finish_button.make_with_text (interface_names.b_finish)
			finish_button.select_actions.extend (agent finish)
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

feature {NONE} -- Implementation

	set_default_settings
			-- Initialize user selection.
		local
			b: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			create list_area
			create filter_combo_box
			filter_combo_box.select_actions.extend (
				agent
					do
						if filter_combo_box.selected_item /= Void then
							next_button.enable_sensitive
						end
					end
			)
			filter_combo_box.deselect_actions.extend (
				agent
					do
						if filter_combo_box.selected_item = Void then
							next_button.disable_sensitive
						end
					end
			)
			list_area.extend (filter_combo_box)
			create cluster_include
			cluster_include.set_pixmap_function (agent pixmap_from_group_data)
			create indexing_include
			if attached preferences.flat_short_data.excluded_indexing_items as xstrs then
				indexing_include.set_excluded_items_from_strings (xstrs)
			end
			create option_page
			fill_option_box (option_page)
			create view_page
			create hb
			create directory_area
			directory_area.extend (create {EV_CELL})
			directory_area.extend (hb)
			directory_area.disable_item_expand (hb)
			create directory_field.make_with_text (Eiffel_system.document_path.name)
			directory_field.return_actions.extend (agent on_directory_return_pressed)
			hb.extend (directory_field)
			create b.make_with_text (interface_names.b_browse)
			b.select_actions.extend (agent on_browse)
			hb.extend (b)
			hb.disable_item_expand (b)
			directory_area.extend (create {EV_CELL})
			directory_area.extend (create {EV_LABEL}.make_with_text (
				interface_names.l_finish_to_generate
			))
		end

feature -- Access

	filter: STRING_32
			-- User selection.
		local
			si: DYNAMIC_LIST [EV_LIST_ITEM]
		do
--			Result := filter_combo_box.text
			si := filter_combo_box.selected_items
			if not si.is_empty then
				Result := si.first.text
			end
		end

	documentation_universe: DOCUMENTATION_UNIVERSE
			-- User selection.
		do
			create Result.make
			if attached cluster_include.included_items_data as l then
				from l.start until l.after loop
					if attached {CONF_GROUP} l.item as cl then
						Result.include_group (cl)
					end
					l.forth
				end
			end
		end

	excluded_indexing_items: ARRAYED_LIST [STRING_32]
			-- Indexing items user does not want generated in HTML meta clauses.
		do
			Result := indexing_include.excluded_items
		end

	diagram_views: HASH_TABLE [STRING_32, STRING_32]
			-- Contains (view_name, cluster_name) couples for every included cluster.

	class_list_selected: BOOLEAN
			-- Does the user want a class list?
		do
			Result := class_list_button.is_selected
		end

	cluster_list_selected: BOOLEAN
			-- Does the user want a cluster list?
		do
			Result := cluster_list_button.is_selected
		end

	cluster_hierarchy_selected: BOOLEAN
			-- Does the user want a cluster hierarchy?
		do
			Result := cluster_hierarchy_button.is_selected
		end

	cluster_charts_selected: BOOLEAN
			-- Does the user want cluster charts?
		do
			Result := cluster_charts_button.is_selected
		end

	cluster_diagrams_selected: BOOLEAN
			-- Does the user want cluster diagrams?
		do
			Result := cluster_diagrams_button.is_selected
		end

	directory: DIRECTORY
			-- Location where documentation should be generated.
		local
			dir_name: STRING_32
		do
			dir_name := directory_field.text
			create Result.make (dir_name)
		end

	cancelled: BOOLEAN
			-- Has the user pressed "Cancel"?

	html_css_filter_name: STRING = "html-stylesheet"
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

	is_html: BOOLEAN
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

	start
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

	next
			-- Show next page.
		do
			current_page := current_page + 1
			if not is_html and then html_specific_page (current_page) then
				current_page := current_page + 1
			end
			if not cluster_diagrams_selected and then diagram_specific_page (current_page) then
				current_page := current_page + 1
			end
			go_to_page (current_page)
		end

	previous
			-- Revert to previous page.
		do
			current_page := current_page - 1
			if not is_html and then html_specific_page (current_page) then
				current_page := current_page - 1
			end
			if not cluster_diagrams_selected and then diagram_specific_page (current_page) then
				current_page := current_page - 1
			end
			go_to_page (current_page)
		end

	cancel
			-- Close the wizard and do nothing.
		do
			hide
			cancelled := True
		end

	finish
			-- Close the wizard and work with current selection.
		do
			hide
		end

feature {NONE} -- Widgets

	pixmap_from_group_data (a_data: ANY): detachable EV_PIXMAP
			-- Pixmap for `a_data' is this is a CONF_GROUP
		do
			if attached {CONF_GROUP} a_data as cg then
				Result := pixmap_from_group (cg)
			end
		end

	filter_combo_box: EV_LIST
			-- Where `filter' is selected.

	list_area: EV_CELL
			-- Bug workaround where EV_LIST does not like to be unparented.

	cluster_include: ES_INCLUDE_EXCLUDE_GRID
			-- Where cluster selection is made.			

	indexing_include: ES_INCLUDE_EXCLUDE_GRID
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

	html_specific_page (i: INTEGER): BOOLEAN
			-- Index of page allowing to choose metatags.
		do
			Result := i = 3
		end

	diagram_specific_page (i: INTEGER): BOOLEAN
			-- Index of page allowing to choose diagram views.
		do
			Result := i = 5
		end

	go_to_page (i: INTEGER)
			-- Display page with `i' as index.
		do
			inspect i when 1 then
				previous_button.disable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				if is_displayed then
					next_button.set_focus
				end
				show_filter_selection
			when 2 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				next_button.set_focus
				show_cluster_selection
			when 3 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				next_button.set_focus
				show_indexing_selection
			when 4 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				next_button.set_focus
				show_option_selection
			when 5 then
				previous_button.enable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				next_button.set_focus
				show_view_selection
			when 6 then
				previous_button.enable_sensitive
				next_button.disable_sensitive
				finish_button.enable_sensitive
				finish_button.set_focus
				set_default_push_button (finish_button)
				show_directory_selection
			end
		end

	show_filter_selection
		do
			if update_filters then
				fill_filter_box (filter_combo_box)
				update_filters := False
			end
			wizard_area.replace (list_area)
			wizard_area.set_text (interface_names.l_select_format_for_output)
		end

	show_cluster_selection
		do
			wizard_area.wipe_out
			wizard_area.set_text (interface_names.l_select_cluster_to_generate)
			if update_clusters then
				set_pointer_style (Default_pixmaps.Wait_cursor)
				fill_cluster_grid (cluster_include)
				update_clusters := False
				set_pointer_style (Default_pixmaps.Standard_cursor)
			end
			wizard_area.replace (cluster_include)
		end

	show_indexing_selection
		local
			retried: BOOLEAN
		do
			if not retried then
				wizard_area.wipe_out
				wizard_area.set_text (interface_names.l_select_indexing_to_generate)
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
			if attached Error_handler.error_list as err_lst and then
				not err_lst.is_empty and then
				attached {SYNTAX_ERROR} err_lst.first as err
			then
				err_lst.wipe_out
				prompts.show_error_prompt (interface_names.l_indexing_clause_error, Void, Void)
			end
			retried := True
			retry
		end

	show_option_selection
		do
			wizard_area.replace (option_page)
			wizard_area.set_text (interface_names.l_select_format_to_use)
		end

	show_view_selection
		do
			set_pointer_style (Default_pixmaps.Wait_cursor)
			fill_view_page (view_page)
			set_pointer_style (Default_pixmaps.Standard_cursor)
			wizard_area.replace (view_page)
			wizard_area.set_text (interface_names.l_select_diagrams_to_generate)
			set_size (wizard_width, wizard_height)
		end

	show_directory_selection
		do
			wizard_area.replace (directory_area)
			wizard_area.set_text (interface_names.l_select_directory_to_generate)
		end

feature {NONE} -- Implementation

	fill_filter_box (list: like filter_combo_box)
		local
			filter_dir: DIRECTORY
			file_name: detachable STRING_32
			filter_entries: ARRAYED_LIST [PATH]
			filter_names: SORTED_TWO_WAY_LIST [STRING_32]
			str_element: EV_LIST_ITEM
			selected: INTEGER
			u: FILE_UTILITIES
		do
			create filter_dir.make_with_path (eiffel_layout.filter_path)
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
				filter_entries := u.ends_with (eiffel_layout.filter_path, ".fil", 0)
				across
					filter_entries as l_c
				loop
					if attached l_c.item.entry as l_e then
						file_name := l_e.name
						file_name.keep_head (file_name.count - 4)
						filter_names.extend (file_name)
					end
				end

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
						file_name := filter_names.item
						create str_element.make_with_text (file_name)
						list.extend (str_element)
						str_element.pointer_double_press_actions.force_extend (agent str_element.enable_select)
						str_element.pointer_double_press_actions.force_extend (agent next)
						if file_name.same_string_general (html_css_filter_name) then
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

	fill_cluster_grid (ie: like cluster_include)
			-- Fill `ie.include_list' with all groups in system.
			-- We assume that new added groups go into the "include" part.
		local
			old_exclude: ARRAYED_LIST [STRING_32]
		do
			old_exclude := ie.excluded_items
			old_exclude.compare_objects
			ie.clear_all
			add_groups_to_cluster_grid (ie, Eiffel_universe.groups, old_exclude, Void, True)
		end

	add_groups_to_cluster_grid (ie: like cluster_include; cg: LIST [CONF_GROUP]; a_exclusion: LIST [STRING_32]; a_parent: detachable CONF_GROUP; rec: BOOLEAN)
		local
			cg_name: STRING_32
			g: detachable CONF_GROUP
			p: detachable CONF_GROUP
			subs: detachable LIST [CONF_GROUP]
		do
			from cg.start until cg.after loop
				g := cg.item
				p := Void
				subs := Void
				if attached {CONF_CLUSTER} g as l_cluster then
					p := l_cluster.parent
				elseif rec and then attached {CONF_LIBRARY} g as l_library then
					subs := l_library.library_target.clusters.linear_representation
				elseif attached {CONF_ASSEMBLY} g as l_assembly then
					g := Void
				end

				if g /= Void and then (g.is_cluster or g.is_library or g.is_precompile) then
					if p = Void then
						p := a_parent
					end
					cg_name := g.name.twin
					if a_exclusion.has (cg_name) then
						ie.add_exclude_item_with_parent (cg_name, g, p)
					else
						ie.add_include_item_with_parent (cg_name, g, p)
					end
					if subs /= Void and then subs.count > 0 then
						add_groups_to_cluster_grid (ie, subs, a_exclusion, g, False)
					end
				end
				cg.forth
			end
		end

	fill_indexing_box (ie: like indexing_include)
			-- Fill `ie.include_list' with all indexing tags.
			-- Except the ones in `exclude_indexing_items'.
		local
			classes: CLASS_C_SERVER
			all_tags: LINKED_LIST [STRING_32]
			old_exclude: ARRAYED_LIST [STRING_32]
			l_class: CLASS_C
			i: INTEGER
			s: STRING_32
		do
			create all_tags.make
			all_tags.extend ("keywords")
			all_tags.compare_objects

				-- Do we have indexing for a group?
			--add_indexes (l_group, all_tags)
			classes := eiffel_system.system.classes
			if classes /= Void then
				from
					i := classes.lower
				until
					i > classes.upper
				loop
					l_class := classes.item (i)
					if l_class /= Void then
						add_indexes_to (l_class.ast.top_indexes, all_tags)
						add_indexes_to (l_class.ast.bottom_indexes, all_tags)
					end
					i := i + 1
				end
			end

			old_exclude := ie.excluded_items
			old_exclude.compare_objects
			ie.clear_all
			from all_tags.start until all_tags.after loop
				s := all_tags.item
				if old_exclude.has (s) then
					ie.add_exclude_item (s, Void)
				else
					ie.add_include_item (s, Void)
				end
				all_tags.forth
			end
		end

	add_indexes_to (i: EIFFEL_LIST [INDEX_AS]; l: LINKED_LIST [STRING_32])
		local
			t: STRING_32
		do
			if i /= Void then
				from i.start until i.after loop
					if i.item.tag /= Void then
						t := i.item.tag.name_32
					end
					if t /= Void and then not l.has (t) then
						l.extend (t.twin)
					end
					i.forth
				end
			end
		end

	fill_option_box (p: EV_VERTICAL_BOX)
		local
			cb: EV_CHECK_BUTTON
			vs: EV_HORIZONTAL_SEPARATOR
			cf: CLASS_FORMAT
			af: LINEAR [INTEGER]
		do
			create class_list_button.make_with_text (interface_names.b_alphabetical_class_list)
			class_list_button.enable_select
			p.extend (class_list_button)
			create cluster_list_button.make_with_text (interface_names.b_alphabetical_cluster_list)
			cluster_list_button.enable_select
			p.extend (cluster_list_button)
			create cluster_hierarchy_button.make_with_text (interface_names.b_cluster_hierarchy)
			cluster_hierarchy_button.enable_select
			p.extend (cluster_hierarchy_button)

			create vs
			p.extend (vs)
			p.disable_item_expand (vs)

			create cluster_charts_button.make_with_text (interface_names.b_cluster_charts)
			cluster_charts_button.enable_select
			p.extend (cluster_charts_button)

			create cluster_diagrams_button.make_with_text (interface_names.b_cluster_diagram)
			cluster_diagrams_button.disable_select
			p.extend (cluster_diagrams_button)

			create vs
			p.extend (vs)
			p.disable_item_expand (vs)

			af := all_class_formats.linear_representation
			from af.start until af.after loop
				create cf.make (af.item)
				create cb.make_with_text (cf.name)
				cb.select_actions.extend (agent on_cf_toggle (cf, cb))
				if cf.is_generated then
					cb.enable_select
				end
				p.extend (cb)
				af.forth
			end
		end

	fill_view_page (vb: EV_VERTICAL_BOX)
			-- Initialize `view_page'.
		require
			vb_not_void: vb /= Void
		local
			cluster_row: EV_MULTI_COLUMN_LIST_ROW
			right_vb: EV_VERTICAL_BOX
			main_hb, button_hb: EV_HORIZONTAL_BOX
			g: EB_DIAGRAM_HTML_GENERATOR
			views: LINKED_LIST [STRING_32]
			l_data: TUPLE [STRING_32, LINKED_LIST [STRING_32]]
		do
			vb.wipe_out
			create diagram_views.make (10)
			create main_hb
			create view_mcl
			create right_vb
			create button_hb
			create view_list
			create set_view_button.make_with_text_and_action (interface_names.b_set, agent on_set_view_button_pressed)
			set_view_button.disable_sensitive
			create view_label.make_with_text (interface_names.l_select_cluster_to_display)
			if attached cluster_include.included_items_data as cluster_list then
				from
					cluster_list.start
				until
					cluster_list.after
				loop
					if attached {CONF_GROUP} cluster_list.item as ci then
						create g.make_for_wizard (ci)
						create cluster_row
						cluster_row.extend (ci.name)
						cluster_row.extend ("DEFAULT")
						views := g.available_views
						l_data := [id_of_group (ci).as_string_32, views]
						cluster_row.set_data (l_data)
						cluster_row.select_actions.extend (agent on_cluster_selected (cluster_row))
						view_mcl.extend (cluster_row)

						if not views.is_empty then
							diagram_views.put ({STRING_32} "DEFAULT", id_of_group (ci).as_string_32)
						end
					end
					cluster_list.forth
				end
			end
			view_mcl.set_column_title (interface_names.l_cluster, 1)
			view_mcl.set_column_title (interface_names.l_view, 2)
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

	on_cluster_selected (row: EV_MULTI_COLUMN_LIST_ROW)
			-- `row' has been selected.
			-- Display available views for corresponding cluster in `view_list'.
			-- Update `view_label'.
		local
			l_data: TUPLE [group_id: STRING_32; views: LINKED_LIST [STRING_32]]
			views: LINKED_LIST [STRING_32]
		do
			l_data ?= row.data
			views := l_data.views
			if views /= Void then
				view_list.wipe_out
				from
					views.start
				until
					views.after
				loop
					view_list.extend (create {EV_LIST_ITEM}.make_with_text (views.item))
					views.forth
				end
				if views.is_empty then
					view_label.set_text (interface_names.l_no_views_are_available)
					set_view_button.disable_sensitive
				else
					view_label.set_text (interface_names.l_select_the_view)
					set_view_button.enable_sensitive
				end
			end
		end

	on_set_view_button_pressed
			-- `set_view_button' was pressed.
			-- Update `view_mcl'.
		local
			l_data: TUPLE [group_id: STRING_32; views: LINKED_LIST [STRING_32]]
			selected_row: EV_MULTI_COLUMN_LIST_ROW
			l_group_id: STRING_32
		do
			if view_list.selected_item /= Void then
				selected_row := view_mcl.selected_item
				l_data ?= selected_row.data
				l_group_id := l_data.group_id
				selected_row.finish
				selected_row.remove
				selected_row.extend (view_list.selected_item.text)
				diagram_views.replace (view_list.selected_item.text, l_group_id)
			end
		end

	on_directory_return_pressed
			-- Return was pressed after typing a directory name.
			-- Press `finish_button'.
		do
			finish_button.select_actions.call (Void)
		end

	on_cf_toggle (cf: CLASS_FORMAT; state: EV_CHECK_BUTTON)
			-- Set the generated state of `cf' to the selected state of `state'.
		do
			cf.set_generated (state.is_selected)
		end

	on_browse
			-- User pressed "browse" button.
		local
			d: EV_DIRECTORY_DIALOG
			path: PATH
			u: FILE_UTILITIES
		do
			create d
			d.ok_actions.extend (agent on_directory_change (d))
			create path.make_from_string (directory_field.text)
			if not path.is_empty and then u.directory_path_exists (path) then
				d.set_start_path (path)
			end
			d.show_modal_to_window (Current)
		end

	on_directory_change (d: EV_DIRECTORY_DIALOG)
		do
			if d.path.is_empty then
				directory_field.remove_text
			else
				directory_field.set_text (d.path.name)
			end
		end

	wizard_width: INTEGER = 420
		-- Nicest value for width of Current.

	wizard_height: INTEGER = 350;
		-- Nicest value for height of Current.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_DOCUMENTATION_WIZARD
