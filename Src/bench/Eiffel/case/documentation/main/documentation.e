indexing
	description: "Project Documentation"
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION

inherit
	SHARED_WORKBENCH
		rename
			system as bench_system
		end

	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_HANDLER

	EIFFEL_ENV

	CLASS_FORMAT_CONSTANTS
		export
			{NONE} all
		end

	DOCUMENTATION_ROUTINES
		export
			{NONE} all
			{ANY} set_excluded_indexing_items
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Documentation Module.
		do
			filter_name := "html-stylesheet"
			create doc_universe.make
		end

feature -- Status setting

	set_filter (a_filter: STRING) is
			-- Change text filter to `a_filter'.
		require
			a_filter_not_void: a_filter /= Void
		do
			filter_name := a_filter
		end

	set_universe (a_universe: DOCUMENTATION_UNIVERSE) is
			-- Change `doc_universe' to `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
		do
			doc_universe := a_universe
		end

feature -- Access

	filter_name: STRING
			-- Text filter used for output.

	doc_universe: DOCUMENTATION_UNIVERSE
			-- Cluster selection to include in the generation.

feature -- Actions

	generate (deg: DEGREE_OUTPUT) is
			-- Generate documentation, according to the user selection.
		local
			cl_name: STRING
			cf: CLASS_FORMAT
			af: LINEAR [INTEGER]
			cancelled: BOOLEAN
			ir_error: INTERRUPT_ERROR
		do
			if not cancelled then
				deg.put_initializing_documentation

				classes := doc_universe.classes
				create filter.make (filter_name)
				filter.set_universe (doc_universe)
				base_path := ""
				filter.set_keyword (kw_Class, "")
				if filter.is_html then
					filter.set_keyword ("html_meta", html_meta_for_system)
				else
					filter.set_keyword ("html_meta", "")
				end

				class_links := Void
				feature_links := Void
				set_defaults

				if class_links /= Void then
					if filter_name.is_equal ("html-stylesheet") then
						copy_additional_file ("default.css")
						generate_goto_html
					end
	
					prepare_for_file (Void, "index")
					set_document_title (Eiffel_system.name + " documentation")
					generate_index
	
					if class_list_generated then
						deg.put_string ("Building class list")
						prepare_for_file (Void, "class_list")
						set_document_title (Eiffel_system.name + " class dictionary")
						generate_dictionary
					end
	
					if cluster_list_generated then
						deg.put_string ("Building cluster list")
						prepare_for_file (Void, "cluster_list")
						set_document_title (Eiffel_system.name + " alphabetical cluster list")
						generate_cluster_list
					end
	
					if cluster_hierarchy_generated then
						deg.put_string ("Building cluster hierarchy")
						prepare_for_file (Void, "cluster_hierarchy")
						set_document_title (Eiffel_system.name + " cluster hierarchy")
						generate_cluster_hierarchy
					end
	
					if cluster_chart_generated then
						from
							clusters.start
						until
							clusters.after
						loop
							deg.put_string ("Building cluster chart for " + clusters.item.cluster_name)
							if filter.is_html then
								filter.set_keyword ("html_meta", html_meta_for_cluster (clusters.item))
							end
							set_base_cluster (clusters.item)
							prepare_for_file (clusters.item.relative_path ('%U'), "index")
							set_document_title ("cluster " + clusters.item.cluster_name)
							generate_cluster_index (clusters.item)
							clusters.forth
						end
					end
	
					if filter.is_html and then cluster_diagram_generated then
						from
							clusters.start
						until
							clusters.after
						loop
							deg.put_string ("Building cluster diagram for " + clusters.item.cluster_name)
							generate_cluster_diagram (clusters.item)
							clusters.forth
						end
					end
	
					if any_class_format_generated then
						deg.put_start_documentation (classes.count, generated_class_formats_string)
						from
							classes.start
						until
							classes.after
						loop
							deg.put_case_class_message (classes.item.compiled_class)
							set_base_cluster (classes.item.cluster)
							cl_name := clone (classes.item.name)
							cl_name.to_upper
							set_class_name (cl_name)
							if filter.is_html then
								filter.set_keyword ("html_meta", html_meta_for_class (classes.item))
							end
							af := all_class_formats.linear_representation
							from af.start until af.after loop
								create cf.make (af.item)
								af.forth
								if cf.is_generated then
		--							if pd /= Void then
		--								pd.set_current_degree (cf.description)
		--							end
									prepare_for_file (
										classes.item.cluster.relative_path ('%U'),
										classes.item.name + cf.file_extension
									)
									set_document_title (cl_name + " " + cf.description)
									generate_class (classes.item, cf)
								end
							end
							classes.forth
						end
					end
	
				end
			end
			deg.finish_degree_output
		rescue
			if Error_handler.error_list /= Void and then
				not Error_handler.error_list.is_empty then
				ir_error ?= Error_handler.error_list.first
				if ir_error /= Void then
					cancelled := True
					Error_handler.error_list.wipe_out
					retry
				end
			end
		end

	any_class_format_generated: BOOLEAN is
			-- Are any of the class formats requested?
		local
			af: LINEAR [INTEGER]
			cf: CLASS_FORMAT
		do
			af := all_class_formats.linear_representation
			from af.start until af.after loop
				create cf.make (af.item)
				af.forth
				if cf.is_generated then
					Result := True
				end
			end
		end

	generated_class_formats_string: STRING is
			-- To display when user is wasting time watching slow progressing.
		local
			af: LINEAR [INTEGER]
			cf: CLASS_FORMAT
		do
			af := all_class_formats.linear_representation
			create Result.make (10)
			from af.start until af.after loop
				create cf.make (af.item)
				af.forth
				if cf.is_generated then
					if not Result.is_empty then
						Result.extend ('/')
					end
					Result.append (cf.description)
				end
			end
		end

	create_directories (tl_clusters: LIST [CLUSTER_I]) is
			-- Create directories where documentation is 
			-- to be generated.
		require
			root_directory /= Void
		local
			d: DIRECTORY
			fi: FILE_NAME
			fa: STRING
		do
			from
				tl_clusters.start
			until
				tl_clusters.after
			loop
				create fi.make_from_string (root_directory.name)
				fa := tl_clusters.item.relative_path ('%U')
				fi.extend (fa)
				create d.make (fi)
				if not d.exists then
					d.create_dir
				end
				create_directories (tl_clusters.item.sub_clusters)
				tl_clusters.forth
			end
		end

	copy_additional_file (fn: STRING) is
			-- Copy `fn' to directory where documentation is to be generated.
		require
			fn_not_void: fn /= Void
		local
			fi: FILE_NAME
			rf, wf: PLAIN_TEXT_FILE
		do
			create fi.make_from_string (filter_path)
			fi.extend (fn)
			create rf.make_open_read (fi)
			rf.read_stream (rf.count)

			create fi.make_from_string (root_directory.name)
			fi.extend (fn)
			create wf.make_open_write (fi)
			wf.put_string (rf.last_string)
		rescue
			io.put_string (fn + " not found in filters directory.%N")
		end

feature -- Settings

	set_directory (p: DIRECTORY) is
			-- Assign `p' to `root_directory'.
			-- This is the location where the documentation will be generated.
		require
			p_not_void: p /= Void
		do
			root_directory := p
			if not root_directory.exists then
				root_directory.create_dir
			end
			create_directories (Eiffel_system.sub_clusters)
		ensure
			root_directory_assigned: root_directory = p
			directory_exists: p.exists
			directory_is_writable: p.is_writable
		end

	set_all_universe is
		do
			doc_universe.include_all
		end

	set_class_formats (clickable, flat, short, flatshort,
		relational, chart: BOOLEAN) is
			-- Set boolean values to the different possible class formats.
		local
			cf: CLASS_FORMAT
		do
			create cf.make (cf_Chart)
			cf.set_generated (chart)
			cf.set_type (cf_Diagram)
			cf.set_generated (relational)
			cf.set_type (cf_Clickable)
			cf.set_generated (clickable)
			cf.set_type (cf_Flat)
			cf.set_generated (flat)
			cf.set_type (cf_Short)
			cf.set_generated (short)
			cf.set_type (cf_Flatshort)
			cf.set_generated (flatshort)
		end

	set_cluster_formats (a_clusters_charts, a_cluster_diagrams: BOOLEAN) is
			-- Specify whether cluster charts and diagrams should be generated.
		do
			cluster_chart_generated := a_clusters_charts
			cluster_diagram_generated := a_cluster_diagrams
		end

	set_system_formats (a_classes, a_clusters, a_cluster_hierarchy: BOOLEAN) is
			-- Assign flags to systemwide formats.
		do
			class_list_generated := a_classes
			cluster_list_generated := a_clusters
			cluster_hierarchy_generated := a_cluster_hierarchy
		end

	set_diagram_views (views: HASH_TABLE [STRING, STRING]) is
			-- Assign `views' to `diagram_views'.
		do
			diagram_views := views
		end

feature -- Access

	cluster_chart_generated: BOOLEAN
			-- Is Cluster Chart format generated ?

	cluster_diagram_generated: BOOLEAN
			-- Is Cluster diagram generated ?

	class_list_generated: BOOLEAN
			-- Is class dictionary generated ?

	cluster_list_generated: BOOLEAN
			-- Is Cluster repository generated ?

	cluster_hierarchy_generated: BOOLEAN
			-- Is Cluster repository generated ?

	root_directory: DIRECTORY
			-- Directory where the documentation is going
			-- to be generated.

feature {NONE} -- Implementation

	set_defaults is
		local
			cf: CLASS_FORMAT
			i: INTEGER
		do
			doc_universe.set_any_cluster_format_generated (cluster_chart_generated)
			from i := cf_Flatshort until i < cf_Chart loop
				create cf.make (i)
				if cf.is_generated then
					set_default_class_redirect (cf.file_extension)
				end
				i := i - 1
			end
			doc_universe.set_any_class_format_generated (class_links /= Void)
			from i := cf_Flatshort until i < cf_Clickable loop
				create cf.make (i)
				if cf.is_generated then
					set_default_feature_redirect (cf.file_extension)
				end
				i := i - 1
			end
			doc_universe.set_any_feature_format_generated (feature_links /= Void)
		end

	classes: SORTED_TWO_WAY_LIST [CLASS_I]
			-- Classes to be generated.

	clusters: SORTED_TWO_WAY_LIST [CLUSTER_I] is
			-- Clusters to be generated.
		do
			Result := doc_universe.clusters
		end

	diagram_views: HASH_TABLE [STRING, STRING]
			-- (View name, cluster name) couples for `clusters'.
			-- Void if not `cluster_diagrams_generated'.
	
	generate_goto_html is
			-- Generate HTML file that contains the JavaScript function
			-- `go_to' wich takes 2 arguments. The first one is the base
			-- path and the second is a class name. It looks up the address
			-- of the class and if it exists, redirects the browser to the
			-- preferred class view. Creates the file in the documentation root
			-- directory. An example file is given at the bottom.
		local
			s, class_array, location_array, goto_text: STRING
			textfile: PLAIN_TEXT_FILE
			fn: FILE_NAME
		do
			create class_array.make (5000)
			create location_array.make (8000)
			from
				classes.start
			until
				classes.after
			loop
				s := clone (classes.item.name)
				s.to_upper
				class_array.append ("%T%T%"" + s + "%"")
				s.to_lower
				s := "" + classes.item.cluster.relative_path ('/') +
					"/" + s + class_links + ".html"
				location_array.append ("%T%T%"" + s + "%"")
				classes.forth
				if not classes.after then
					class_array.append (",%N")
					location_array.append (",%N")
				end
			end

			goto_text := "<!--%N%
				%	classList = new Array (%N%
				%" + class_array + "%N%
				%	);%N%
				%%N%
				%	locationList = new Array (%N%
				%" + location_array + "%N%
				%	);%N%
				%%N%
				%	function indexOfClass (name) {%N%
				%		for (i = 0; i < classList.length; i++) {%N%
				%			if (name == classList[i]) return i;%N%
				%		}%N%
				%		return -1;%N%
				%	}%N%
				%%N%
				%	function go_to (baseLocation, className) {%N%
				%		var index = indexOfClass (className.toUpperCase ());%N%
				%		if (index >= 0) {%N%
				%			window.location = baseLocation + locationList[index];%N%
				%		} else {%N%
				%			alert (%"Class %" + className.toUpperCase () + %" does not exist in system%");%N%
				%		}%N%
				%	}%N%
				%// -->%N"

			create fn.make_from_string (root_directory.name)
			fn.extend ("goto.html")
			create textfile.make_open_write (fn)
			textfile.put_string (goto_text)
			textfile.close
		end

--	<!--
--		classList = new Array (
--			"ARRAYED_LIST",
--			"LINKED_LIST"
--		);
--	
--		locationList = new Array (
--			"libraries/base/arrayed_list.html",
--			"libraries/base/linked_list.html"
--		);
--	
--		function indexOfClass (name) {
--			for (i = 0; i < classList.length; i++) {
--				if (name == classList[i]) return i;
--			}
--			return -1;
--		}
--	
--		function go_to (baseLocation, className) {
--			var index = indexOfClass (className.toUpperCase ());
--			if (index >= 0) {
--				window.location = baseLocation + locationList[index];
--			} else {
--				alert ("Class " + className.toUpperCase () + " does not exist in system");
--			}
--		}
--	// -->

feature {NONE} -- Filtered generation

	set_target_file_name (f: FILE_NAME) is
		do
			target_file_name := f
			target_file_name.add_extension (filter.file_suffix)
		end

	set_base_cluster (c: CLUSTER_I) is
		do
			base_path := c.base_relative_path (filter.file_separator)
			filter.set_base_path (base_path)
		end

	set_default_class_redirect (p: STRING) is
			-- In case of a class link outside a class format,
			-- link to format `p'.
		do
			class_links := p
			filter.prepend_to_file_suffix (class_links)
		end

	set_default_feature_redirect (p: STRING) is
			-- In case of a feature link outside a feature format,
			-- link to format `p'.
		do
			feature_links := p
			filter.set_feature_redirect (feature_links)
		end

	set_document_title (a_title: STRING) is
			-- Set "$title$" keyword in `filter'.
		do
			filter.set_keyword (kw_Title, a_title)
		end

	set_class_name (a_class: STRING) is
			-- Set "$class$" keyword in `filter'.
		do
			filter.set_keyword (kw_Class, a_class)
		end

feature -- Access

	filter: TEXT_FILTER
			-- Filter to process formatted text.

	target_file_name: FILE_NAME
			-- Location.

	base_path: STRING
			-- Relative path to documentation root dir.

	class_links: STRING
			-- Class format linked to by class links.

	feature_links: STRING
			-- Class format linked to by feature links.

	relative_to_base (rel_filename: STRING): STRING is
			-- Path of `rel_filename' relative to documentation root dir.
		local
			fn: EB_FILE_NAME
		do
			create fn.make_from_string (base_path)
			if filter.file_separator /= '%U' then
				fn.set_separator (filter.file_separator)
			end
			fn.extend (rel_filename)
			Result := fn
		end

feature {EB_DIAGRAM_HTML_GENERATOR, DOCUMENTATION_ROUTINES} -- Access

	relative_path (a_cluster: CLUSTER_I): FILE_NAME is
			-- Path of `a_cluster' relative to `root_directory'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			Result := a_cluster.relative_path (filter.file_separator)
		end

	base_relative_path (a_cluster: CLUSTER_I): FILE_NAME is
			-- Path from `a_cluster' to `root_directory'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			Result := a_cluster.base_relative_path (filter.file_separator)
		end

feature -- Specific Generation

	prepare_for_file (base_dir: FILE_NAME; file_name: STRING) is
			-- Set `target_file_name' to relative `base_dir' and `file_name'.
		local
			final_name: FILE_NAME
		do
			create final_name.make_from_string (root_directory.name)
			if base_dir /= Void then
				final_name.extend (base_dir)
			end
			final_name.extend (file_name)
			set_target_file_name (final_name)
		end

	generate_from_structured_text (text: STRUCTURED_TEXT) is
			-- Output `ctxt.text' using `filter' to `target_file_name'.
		local
			fi: PLAIN_TEXT_FILE
		do
			filter.process_text (text)
			create fi.make_create_read_write (target_file_name)
			fi.put_string(filter.image)
			fi.close
			filter.wipe_out_image
		end

	generate_index is
			-- Write project index to `target_file_name'.
		local
			text: STRUCTURED_TEXT
		do
			text := index_text
			insert_global_menu_bars (text, True, True, True)
			filter.prepend_to_file_suffix (class_links)
			generate_from_structured_text (text)
		end

	generate_dictionary is
			-- Write project class list to `target_file_name'.
		local
			text: STRUCTURED_TEXT
		do
			text := class_list_text (doc_universe)
			insert_global_menu_bars (text, False, True, True)
			filter.prepend_to_file_suffix (class_links)
			generate_from_structured_text (text)
			filter.set_feature_redirect (Void)
		end

	generate_cluster_list is
			-- Write project cluster list to `target_file_name'.
		local
			text: STRUCTURED_TEXT
		do
			text := cluster_list_text (doc_universe)
			insert_global_menu_bars (text, True, False, True)
			filter.prepend_to_file_suffix (class_links)
			generate_from_structured_text (text)
		end

	generate_cluster_hierarchy is
			-- Write project cluster hierarchy to `target_file_name'.
		local
			text: STRUCTURED_TEXT
		do
			text := cluster_hierarchy_text (doc_universe)
			insert_global_menu_bars (text, True, True, False)
			filter.prepend_to_file_suffix (class_links)
			generate_from_structured_text (text)
		end

	generate_cluster_index (cluster: CLUSTER_I) is
			-- Write project cluster index to `target_file_name'.
		local
			text: STRUCTURED_TEXT
		do
			text := cluster_index_text (
				cluster,
				doc_universe.classes_in_cluster (cluster),
				filter.is_html and cluster_diagram_generated)
			insert_global_menu_bars (text, True, True, True)
			filter.prepend_to_file_suffix (class_links)
			generate_from_structured_text (text)
		end

	generate_cluster_diagram (cluster: CLUSTER_I) is
			-- Write project cluster diagram to `target_file_name'.
		local
			g: EB_DIAGRAM_HTML_GENERATOR
			view_name: STRING
		do
			check
				views_exist: diagram_views /= Void
			end
			view_name := diagram_views.item (cluster.cluster_name)
			if view_name /= Void then
				create g.make_for_documentation (cluster, view_name, Current)
			else
				create g.make_for_documentation (cluster, Void, Current)
			end
			g.execute
		end
	
	generate_class (class_i: CLASS_I; format: CLASS_FORMAT) is
			-- Write project class `format' to `target_file_name'.
		require
			class_i_not_void: class_i /= Void
			format_not_void: format /= Void
			format_generated: format.is_generated
		local
			text: STRUCTURED_TEXT
			class_c: CLASS_C
		do
			class_c := class_i.compiled_class
			inspect
				format.type
			when cf_Chart then
				text := class_chart_text (class_c)
			when cf_Diagram then
				text := class_relations_text (class_c)
			when cf_Clickable then
				text := class_text (class_c, False, False)
				filter.set_feature_redirect (Void)
			when cf_Flat then
				text := class_text (class_c, True, False)
				filter.set_feature_redirect (Void)
			when cf_Short then
				text := class_text (class_c, False, True)
				filter.set_feature_redirect (Void)
			when cf_Flatshort then
				text := class_text (class_c, True, True)
				filter.set_feature_redirect (Void)
			end
			filter.prepend_to_file_suffix (format.file_extension)
			insert_class_menu_bars (text, class_i.name, format)
			generate_from_structured_text (text)
			filter.set_feature_redirect (feature_links)
		end

feature {NONE} -- Menu bars

	insert_class_menu_bars (text: STRUCTURED_TEXT; class_name: STRING; f: CLASS_FORMAT) is
			-- Put a menu bar at top and bottom of `text'.
		do
			text.start
			text.search (ti_Before_class_declaration)
			check
				not_exhausted: not text.exhausted
			end
			text.forth

			text.put_left (ti_Before_menu_bar)
			insert_class_menu_bar (text, class_name, f)
			text.put_left (ti_After_menu_bar)

			text.search (ti_After_class_declaration)
			check
				not_exhausted: not text.exhausted
			end

			text.put_left (ti_Before_menu_bar)
			insert_class_menu_bar (text, class_name, f)
			text.put_left (ti_After_menu_bar)
		end

	insert_global_menu_bars (text: STRUCTURED_TEXT; d, l, h: BOOLEAN) is
			-- Put a menu bar at top and bottom of `text'.
		do
			text.start
			text.search (ti_Before_class_declaration)
			check
				not_exhausted: not text.exhausted
			end
			text.forth

			text.put_left (ti_Before_menu_bar)
			insert_global_menu_bar (text, d, l, h)
			text.put_left (ti_After_menu_bar)

			text.search (ti_After_class_declaration)
			check
				not_exhausted: not text.exhausted
			end

			text.put_left (ti_Before_menu_bar)
			insert_global_menu_bar (text, d, l, h)
			text.put_left (ti_After_menu_bar)
		end

	insert_global_menu_bar (text: STRUCTURED_TEXT; d, l, h: BOOLEAN) is
			-- Append a menu bar to `text'.
		do
			insert_menu_item (text, "class_list", "Classes", d, class_list_generated)
			insert_menu_item (text, "cluster_list", "Clusters", l, cluster_list_generated)
			insert_menu_item (text, "cluster_hierarchy", "Cluster hierarchy", h, cluster_hierarchy_generated)
		end

	insert_class_menu_bar (text: STRUCTURED_TEXT; class_name: STRING; f: CLASS_FORMAT) is
			-- Append a menu bar to `text'.
		local
			af: LINEAR [INTEGER]
		do
			insert_global_menu_bar (text, True, True, True)
			af := all_class_formats.linear_representation
			from af.start until af.after loop
				insert_class_menu_item (text, class_name, create {CLASS_FORMAT}.make (af.item), f)
				af.forth
			end
		end

	insert_menu_item (text: STRUCTURED_TEXT; link, label: STRING; enabled, generated: BOOLEAN) is
			-- Insert in `text', a menu item `label' with `link', if `generated' `True'.
			-- Insert as disabled if not `enabled'.
			-- `link' is a file relative to root dir without extension.
		local
			path: STRING
		do
			if enabled then
				path := relative_to_base (link)
			end
			if generated then
				text.put_left (create {MENU_TEXT}.make (path, label))
			end
		end

	insert_class_menu_item (text: STRUCTURED_TEXT; class_name: STRING; format, class_format: CLASS_FORMAT) is
			-- Insert in `text', a menu item for `class_name' for `format'.
		local
			path: STRING
		do
			if format.type /= class_format.type then
				path := class_name + format.file_extension
			end
			if format.is_generated then
				text.put_left (create {CLASS_MENU_TEXT}.make (path, format.description))
			end
		end

end -- class DOCUMENTATION
