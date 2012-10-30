note
	description: "Project Documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_HANDLER

	CLASS_FORMAT_CONSTANTS
		export
			{NONE} all
		end

	DOCUMENTATION_ROUTINES
		export
			{NONE} all
			{ANY} set_excluded_indexing_items
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Documentation Module.
		do
			filter_name := "html-stylesheet"
			create doc_universe.make
		end

feature -- Status setting

	set_filter (a_filter: STRING)
			-- Change text filter to `a_filter'.
		require
			a_filter_not_void: a_filter /= Void
		do
			filter_name := a_filter
		end

	set_universe (a_universe: DOCUMENTATION_UNIVERSE)
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

	generate (deg: DEGREE_OUTPUT)
			-- Generate documentation, according to the user selection.
		local
			cl_name: STRING
			cf: CLASS_FORMAT
			af: LINEAR [INTEGER]
			cancelled: BOOLEAN
			ir_error: INTERRUPT_ERROR
			l_groups: like groups
			l_group: CONF_GROUP
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_cursor: CURSOR
			l_class: CONF_CLASS
			l_context_group: CONF_GROUP
			l_filter: like filter
		do
			eiffel_system.system.set_current_class (any_class)
			deg.put_start_output
			if not cancelled then
				deg.put_initializing_documentation

				create l_filter.make (filter_name)
				filter := l_filter
				l_filter.set_universe (doc_universe)
				classes := doc_universe.classes
				base_path := ""
				l_filter.set_keyword (kw_Class, {STRING_32}"")
				if l_filter.is_html then
					l_filter.set_keyword ({STRING_32}"html_meta", html_meta_for_system.as_string_32)
				else
					l_filter.set_keyword ({STRING_32}"html_meta", {STRING_32}"")
				end

				class_links := Void
				feature_links := Void
				set_defaults

				if class_links /= Void then

					prepare_for_file (Void, "index")
					set_document_title (Eiffel_system.name + " documentation")
					generate_index

					if filter_name.same_string_general ("html-stylesheet") then
						copy_additional_file ("default.css")
						generate_goto_html
					end

					if class_list_generated then
						deg.put_string ({STRING_32}"Building class list")
						prepare_for_file (Void, "class_list")
						set_document_title (Eiffel_system.name + " class dictionary")
						generate_dictionary
					end

					if cluster_list_generated then
						deg.put_string ({STRING_32}"Building cluster list")
						prepare_for_file (Void, "cluster_list")
						set_document_title (Eiffel_system.name + " alphabetical cluster list")
						generate_cluster_list
					end

					if cluster_hierarchy_generated then
						deg.put_string ({STRING_32}"Building cluster hierarchy")
						prepare_for_file (Void, "cluster_hierarchy")
						set_document_title (Eiffel_system.name + " cluster hierarchy")
						generate_cluster_hierarchy
					end

					l_groups := groups
					if cluster_chart_generated then
						from
							l_groups.start
						until
							l_groups.after
						loop
							l_group := l_groups.item
							deg.put_string ({STRING_32}"Building cluster chart for " + group_name_presentation ({STRING_32}".", {STRING_32}"", l_group))
							deg.flush_output
							if l_filter.is_html then
								l_filter.set_keyword ({STRING_32}"html_meta", html_meta_for_cluster (l_group).as_string_32)
							end
							set_base_cluster (l_group)
							prepare_for_file (relative_path (l_group), "index")
							set_document_title ("cluster " + l_group.name)
							generate_cluster_index (l_group)
							l_groups.forth
						end
					end

					if l_filter.is_html and then cluster_diagram_generated then
						from
							l_groups.start
						until
							l_groups.after
						loop
							l_group := l_groups.item
							deg.put_string ({STRING_32}"Building cluster diagram for " + group_name_presentation ({STRING_32}".", {STRING_32}"", l_group))
							deg.flush_output
							generate_cluster_diagram (l_group)
							l_groups.forth
						end
					end

					if any_class_format_generated then
						deg.put_start_documentation (doc_universe.classes.count, generated_class_formats_string.as_string_8)
						l_context_group := l_filter.context_group
						from
							l_groups.start
						until
							l_groups.after
						loop
							l_group := l_groups.item
							l_groups.forth
							l_classes := l_group.classes
							if l_classes /= Void then
								l_cursor := l_classes.cursor
								from
									l_classes.start
								until
									l_classes.after
								loop
									l_class := l_classes.item_for_iteration
									l_filter.set_context_group (l_class.group)
									if l_class.is_compiled then
										deg.put_case_class_message (l_class)
										deg.flush_output
										set_base_cluster (l_group)
										cl_name := l_class.name.as_lower
										set_class_name (cl_name)
										if l_filter.is_html then
											l_filter.set_keyword ({STRING_32}"html_meta", html_meta_for_class (l_classes.item_for_iteration).as_string_32)
										end
										af := all_class_formats.linear_representation
										from af.start until af.after loop
											create cf.make (af.item)
											af.forth
											if cf.is_generated then
												prepare_for_file (
													create {FILE_NAME}.make_from_string (relative_path (l_group)),
													cl_name + cf.file_extension
												)
												set_document_title (cl_name + " " + cf.description)
												generate_class (l_class, cf)
											end
										end
									end
									l_classes.forth
								end
								l_classes.go_to (l_cursor)
							end
						end
						l_filter.set_context_group (l_context_group)
					end
				end
			end
			deg.put_end_output
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

	any_class_format_generated: BOOLEAN
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

	generated_class_formats_string: STRING_32
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
						Result.append_character ({CHARACTER_32}'/')
					end
					if attached cf.description as desc then
						Result.append_string_general (desc)
					end
				end
			end
		end

	create_directories
			-- Create directories where documentation is
			-- to be generated.
		require
			root_directory /= Void
		local
			l_groups: like groups
		do
			l_groups := groups
			from
				l_groups.start
			until
				l_groups.after
			loop
				create_directory_for_group (l_groups.item_for_iteration)
				l_groups.forth
			end
		end

	create_directory_for_group (a_group: CONF_GROUP)
			--
		require
			root_directory /= Void
		local
			d: DIRECTORY
			fi: DIRECTORY_NAME
			l_string: STRING
		do
			l_string := relative_path (a_group).out
			create fi.make_from_string (root_directory.name)
			fi.extend (l_string)
			create d.make (fi)
			if not d.exists then
				d.recursive_create_dir
			end
		end

	copy_additional_file (fn: STRING)
			-- Copy `fn' to directory where documentation is to be generated.
		require
			fn_not_void: fn /= Void
		local
			fi: FILE_NAME
			rf, wf: PLAIN_TEXT_FILE
		do
			create fi.make_from_string (eiffel_layout.filter_path_8)
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

	set_directory (p: DIRECTORY)
			-- Assign `p' to `root_directory'.
			-- This is the location where the documentation will be generated.
		require
			p_not_void: p /= Void
		do
			root_directory := p
			if not root_directory.exists then
				root_directory.create_dir
			end
			create_directories
		ensure
			root_directory_assigned: root_directory = p
			directory_exists: p.exists
			directory_is_writable: p.is_writable
		end

	set_all_universe
		do
			doc_universe.include_all
		end

	set_class_formats (clickable, flat, short, flatshort,
		relational, chart: BOOLEAN)
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

	set_cluster_formats (a_clusters_charts, a_cluster_diagrams: BOOLEAN)
			-- Specify whether cluster charts and diagrams should be generated.
		do
			cluster_chart_generated := a_clusters_charts
			cluster_diagram_generated := a_cluster_diagrams
		end

	set_system_formats (a_classes, a_clusters, a_cluster_hierarchy: BOOLEAN)
			-- Assign flags to systemwide formats.
		do
			class_list_generated := a_classes
			cluster_list_generated := a_clusters
			cluster_hierarchy_generated := a_cluster_hierarchy
		end

	set_diagram_views (views: HASH_TABLE [STRING, STRING])
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

	set_defaults
		local
			cf: CLASS_FORMAT
			i: INTEGER
		do
			doc_universe.set_any_group_format_generated (cluster_chart_generated)
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

	classes: ARRAYED_LIST [CONF_CLASS]
			-- Classes to be generated.

	groups: ARRAYED_LIST [CONF_GROUP]
			-- Groups to be generated.
		do
			Result := doc_universe.groups
		end

	diagram_views: HASH_TABLE [STRING, STRING]
			-- (View name, cluster name) couples for `clusters'.
			-- Void if not `cluster_diagrams_generated'.

	generate_goto_html
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
			l_add: BOOLEAN
			l_index: INTEGER
			l_classes: like classes
			l_class: CONF_CLASS
		do
			create class_array.make (5000)
			create location_array.make (8000)
			l_classes := classes
			l_index := l_classes.index
			from
				l_classes.start
			until
				classes.after
			loop
				l_class := l_classes.item_for_iteration
				if l_class.is_compiled then
					s := l_class.name.as_upper
					class_array.append ("%T%T%"" + s + "%"")
					s.to_lower
					s := "" + relative_path (l_class.group) +
						"/" + s + class_links + ".html"
					location_array.append ("%T%T%"" + s + "%"")
					l_add := True
				end
				l_classes.forth
				if l_add and then not l_classes.after then
					class_array.append (",%N")
					location_array.append (",%N")
					l_add := False
				end
			end
			l_classes.go_i_th (l_index)

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
				%	};%N%
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
--		};
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

	format: CLASS_FORMAT
			-- Class format

feature {NONE} -- Filtered generation

	set_target_file_name (f: FILE_NAME)
		do
			target_file_name := f
			target_file_name.add_extension (filter.file_suffix)
		end

	set_base_cluster (c: CONF_GROUP)
		do
			base_path := base_relative_path (c).out
			filter.set_base_path (base_path)
		end

	set_default_class_redirect (p: STRING)
			-- In case of a class link outside a class format,
			-- link to format `p'.
		do
			class_links := p
			filter.prepend_to_file_suffix (class_links)
		end

	set_default_feature_redirect (p: STRING)
			-- In case of a feature link outside a feature format,
			-- link to format `p'.
		do
			feature_links := p
			filter.set_feature_redirect (feature_links)
		end

	set_document_title (a_title: STRING)
			-- Set "$title$" keyword in `filter'.
		do
			filter.set_keyword (kw_Title, a_title)
		end

	set_class_name (a_class: STRING)
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

	relative_to_base (rel_filename: STRING): STRING
			-- Path of `rel_filename' relative to documentation root dir.
		local
			l_filter: like filter
		do
			create Result.make_from_string (base_path)
			if not base_path.is_empty then
				Result.append_character (operating_environment.directory_separator)
			end
			Result.append (rel_filename)

			l_filter := filter
			if l_filter.file_separator /= Void and then not l_filter.file_separator.is_equal ("%U") then
				Result.replace_substring_all (operating_environment.directory_separator.out, l_filter.file_separator.as_string_8)
			end
		end

feature {EB_DIAGRAM_HTML_GENERATOR, DOCUMENTATION_ROUTINES} -- Access

	relative_path (a_cluster: CONF_GROUP): FILE_NAME
			-- Path of `a_cluster' relative to `root_directory'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_string: STRING
		do
			l_string := path_representation (operating_environment.directory_separator.out, a_cluster.name, a_cluster, False)
			create Result.make_from_string (l_string)
		end

	base_relative_path (a_cluster: CONF_GROUP): FILE_NAME
			-- Path from `a_cluster' to `root_directory'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_string: STRING
			l_sep: detachable STRING_32
		do
			l_sep := filter.file_separator
			if l_sep = Void then
				l_sep := operating_environment.directory_separator.out
			end
			l_string := path_representation (l_sep, "..", a_cluster, True)
			create Result.make_from_string (l_string)
		end

feature -- Specific Generation

	prepare_for_file (base_dir: FILE_NAME; file_name: STRING)
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

	generate_from_text_filter (text: TEXT_FILTER)
			-- Output `ctxt.text' using `filter' to `target_file_name'.
		local
			fi: PLAIN_TEXT_FILE
			u: UTF_CONVERTER
		do
			create fi.make_with_name (target_file_name)
			if not fi.exists then
				fi.create_read_write
			elseif fi.is_writable then
				fi.open_write
			else
				check file_writable: False end
			end
			if fi.is_open_write then
					-- FIXME 2012/10/29: Shouldn't we put some kind of BOM in the file?
				fi.put_string (u.utf_32_string_to_utf_8_string_8 (text.image))
				fi.close
			end
			filter.wipe_out_image
		end

	generate_index
			-- Write project index to `target_file_name'.
		local
			l_filter: like filter
		do
			l_filter := filter
			l_filter.prepend_to_file_suffix (class_links)
			index_text (l_filter)
			generate_from_text_filter (l_filter)
		end

	generate_dictionary
			-- Write project class list to `target_file_name'.
		local
			l_filter: like filter
		do
			l_filter := filter
			l_filter.prepend_to_file_suffix (class_links)
			class_list_text (doc_universe, l_filter)
			generate_from_text_filter (l_filter)
			l_filter.set_feature_redirect (Void)
		end

	generate_cluster_list
			-- Write project cluster list to `target_file_name'.
		local
			l_filter: like filter
		do
			l_filter := filter
			l_filter.prepend_to_file_suffix (class_links)
			cluster_list_text (doc_universe, l_filter)
			generate_from_text_filter (l_filter)
		end

	generate_cluster_hierarchy
			-- Write project cluster hierarchy to `target_file_name'.
		local
			l_filter: like filter
		do
			l_filter := filter
			l_filter.prepend_to_file_suffix (class_links)
			cluster_hierarchy_text (doc_universe, l_filter)
			generate_from_text_filter (l_filter)
		end

	generate_cluster_index (a_group: CONF_GROUP)
			-- Write project a_group index to `target_file_name'.
		local
			l_group: CONF_GROUP
			l_filter: like filter
		do
			l_filter := filter
			l_group := l_filter.context_group
			l_filter.set_context_group (a_group)
			l_filter.prepend_to_file_suffix (class_links)
			group_index_text (
					a_group,
					doc_universe.classes_in_group (a_group),
					l_filter.is_html and cluster_diagram_generated,
					l_filter
				)
			l_filter.set_context_group (l_group)
			generate_from_text_filter (l_filter)
		end

	generate_cluster_diagram (cluster: CONF_GROUP)
			-- Write project cluster diagram to `target_file_name'.
		local
			g: EB_DIAGRAM_HTML_GENERATOR
		do
			check
				views_exist: diagram_views /= Void
			end
			if attached diagram_views.item (id_of_group (cluster)) as view_name then
				create g.make_for_documentation (cluster, view_name, Current)
			else
				create g.make_for_documentation (cluster, Void, Current)
			end
			g.execute
		end

	generate_class (a_class: CONF_CLASS; a_format: CLASS_FORMAT)
			-- Write project class `format' to `target_file_name'.
		require
			a_class_not_void: a_class /= Void
			format_not_void: a_format /= Void
			format_generated: a_format.is_generated
		local
			class_c: CLASS_C
			retried: BOOLEAN
			l_filter: like filter
		do
			if attached {CLASS_I} a_class as l_class_i then
				check
					l_class_i.is_compiled
				end
				format := a_format
				l_filter := filter
				l_filter.prepend_to_file_suffix (format.file_extension)
				if not retried then
					class_c := l_class_i.compiled_class
					inspect
						format.type
					when cf_Chart then
						class_chart_text (class_c, l_filter)
					when cf_Diagram then
						class_relations_text (class_c, l_filter)
					when cf_Clickable then
						l_filter.set_feature_redirect (Void)
						class_text (class_c, False, False, l_filter)
					when cf_Flat then
						l_filter.set_feature_redirect (Void)
						class_text (class_c, True, False, l_filter)
					when cf_Short then
						l_filter.set_feature_redirect (Void)
						class_text (class_c, False, True, l_filter)
					when cf_Flatshort then
						l_filter.set_feature_redirect (Void)
						class_text (class_c, True, True, l_filter)
					end
				else
						-- An error occurred due to an internal bug while doing the formal for
						-- `class_c'. Instead of failing the whole documentation generation process,
						-- we generate an empty class and continue to the next class.
						-- Note: we need to insert `ti_before_class_declaration' and
						-- `ti_after_class_declaration' so that `insert_class_menu_bars'
						-- works properly.
					l_filter.process_filter_item (f_menu_bar, True)
					insert_class_menu_bar (l_filter, l_class_i.name.as_lower)
					l_filter.process_filter_item (f_menu_bar, False
					)
					l_filter.process_filter_item (f_class_declaration, True)
					l_filter.add_new_line
					l_filter.add_string ("Internal compiler error while generating documentation for class ")
					l_filter.add_class (l_class_i)
					l_filter.add_new_line

					l_filter.process_filter_item (f_menu_bar, True)
					insert_class_menu_bar (l_filter, l_class_i.name.as_lower)
					l_filter.process_filter_item (f_menu_bar, False)

					l_filter.process_filter_item (f_class_declaration, False)
				end
				generate_from_text_filter (l_filter)
				l_filter.set_feature_redirect (feature_links)
			elseif not retried then
				check is_a_class_i: False end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Menu bars

	insert_global_menu_bar (text: TEXT_FORMATTER; d, l, h: BOOLEAN)
			-- Append a menu bar to `text'.
		do
			insert_menu_item (text, "class_list", "Classes", d, class_list_generated)
			insert_menu_item (text, "cluster_list", "Clusters", l, cluster_list_generated)
			insert_menu_item (text, "cluster_hierarchy", "Cluster hierarchy", h, cluster_hierarchy_generated)
		end

	insert_class_menu_bar (text: TEXT_FORMATTER; class_name: STRING)
			-- Append a menu bar to `text'.
		local
			af: LINEAR [INTEGER]
		do
			insert_global_menu_bar (text, True, True, True)
			af := all_class_formats.linear_representation
			from af.start until af.after loop
				insert_class_menu_item (text, class_name, create {CLASS_FORMAT}.make (af.item), format)
				af.forth
			end
		end

	insert_menu_item (text: TEXT_FORMATTER; link, label: STRING; enabled, generated: BOOLEAN)
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
				text.process_menu_text (label, path)
			end
		end

	insert_class_menu_item (text: TEXT_FORMATTER; class_name: STRING; a_format, class_format: CLASS_FORMAT)
			-- Insert in `text', a menu item for `class_name' for `format'.
		local
			path: STRING
		do
			if a_format.type /= class_format.type then
				path := class_name + a_format.file_extension
			end
			if a_format.is_generated then
				text.process_class_menu_text (a_format.description, path)
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class DOCUMENTATION
