note
	description: "Objects that generate an html file representing a diagram%N%
			% , to be included in html documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIAGRAM_HTML_GENERATOR

inherit
	SHARED_EIFFEL_PROJECT

	XML_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		undefine
			default_create
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create
		end

create
	make_for_documentation,
	make_for_wizard

feature {NONE} -- Initialization

	make_for_documentation (a_cluster: CONF_GROUP; a_view: detachable STRING_32; doc: DOCUMENTATION)
			-- Initialize for `a_cluster' and `doc'.
		require
			a_cluster_not_void: a_cluster /= Void
			doc_not_void: doc /= Void
		do
			documentation := doc
			cluster := a_cluster
			view_name := a_view
			cluster_path := doc.relative_path (cluster)
			base_path := doc.base_relative_path (cluster)
			target_file_name := doc.root_directory.path
			if cluster_path /= Void then
				target_file_name := target_file_name.extended_path (cluster_path)
			end
			target_file_name := target_file_name.extended ("diagram.html")
			initialize
		end

	make_for_wizard (a_cluster: CONF_GROUP)
			-- Initialize for `a_cluster'.
			-- Does not allow calls to `execute'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			cluster := a_cluster
		end

	initialize
			-- Build `diagram'.
		do
			create {BON_CLUSTER_DIAGRAM} diagram.make_without_interactions (create {ES_CLUSTER_GRAPH})
			create world_cell.make_with_world (diagram)
			projector := world_cell.projector
		end

feature {NONE} -- Access

	projector: EIFFEL_PROJECTOR
			-- Projector of generated diagram on `pixmap'.

	world_cell: EIFFEL_FIGURE_WORLD_CELL

	border: INTEGER = 5

feature {EB_DOCUMENTATION_WIZARD} -- Basic operations

	available_views: LINKED_LIST [STRING_32]
			-- Names of available views of `cluster'.
		local
			l_parser: XML_STOPPABLE_PARSER
			l_tree: XML_CALLBACKS_NULL_FILTER_DOCUMENT
			l_file: RAW_FILE
			l_concatenator: XML_CONTENT_CONCATENATOR
			diagram_input: XML_ELEMENT
			a_cursor: XML_COMPOSITE_CURSOR
		do
			create Result.make
			l_file := diagram_file
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				check is_open_read: l_file.is_open_read end
				create l_parser.make
				create l_tree.make_null
				create l_concatenator.make_null
				l_parser.set_callbacks (standard_callbacks_pipe ({ARRAY [XML_CALLBACKS_FILTER]} <<l_concatenator, l_tree>>))
				l_parser.parse_from_file (l_file)
				l_file.close
				if l_parser.is_correct then
					diagram_input := l_tree.document.root_element
					check
						valid_file: diagram_input.has_same_name ("EIFFEL_CLUSTER_DIAGRAM")
					end
					a_cursor := diagram_input.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						if attached {XML_ELEMENT} a_cursor.item as node then
							check
								valid_node: node.has_attribute_by_name ("NAME")
							end
							Result.extend (node.attribute_by_name ("NAME").value)
						else
							check node_is_element: False end
						end
						a_cursor.forth
					end
				end
			end
		end

feature {DOCUMENTATION} -- Basic operations

	execute
			-- Write diagram for `cluster' in `target_file_name'.
		local
			l_diagram: like diagram
			png_format: EV_PNG_FORMAT
			png_file: PATH
			str: STRING_32
			ptf: PLAIN_TEXT_FILE
			minimum_pixmap: EV_PIXMAP
			l_layout: EIFFEL_INHERITANCE_LAYOUT
			l_filter_name: like documentation.filter_name
			l_cluster_name: like cluster.name
			l_is_html_stylesheet: BOOLEAN
			l_is_html: BOOLEAN
			l_projector_widget: like projector.widget
		do
			check
				for_documentation: documentation /= Void
			end
			l_diagram := diagram
			if attached view_name as l_view_name then
				l_diagram.change_view (l_view_name, diagram_file)
			else
				l_diagram.model.set_center_cluster (create {ES_CLUSTER}.make (cluster))
				l_diagram.model.explore_center_cluster
				create l_layout.make_with_world (l_diagram)
				l_layout.layout
			end
			world_cell.crop
			create png_format
			png_file := documentation.root_directory.path
			if attached cluster_path as l_cluster_path then
				png_file := png_file.extended_path (l_cluster_path)
			end
			png_file := png_file.extended ("diagram.png")

			l_filter_name := documentation.filter_name
			l_is_html_stylesheet := l_filter_name.same_string ("html-stylesheet")
			l_is_html := l_filter_name.same_string ("html")

			l_cluster_name := cluster.name

			create ptf.make_with_path (target_file_name)
			ptf.open_write
			str := "<html><head>%N<title>Cluster " + l_cluster_name + "</title>%N"

			if l_is_html_stylesheet then
				str.append ({STRING_32} "<link rel=%"stylesheet%" href=%"" + base_path + {STRING_32} "/default.css%" type=%"text/css%">%N%
								%<script type=%"text/javascript%" src=%"" + base_path + "/goto.html%"></script>%N")
			end
			str.append ("</head>%N%
							%<body bgcolor=%"white%">%N%
							%<p align=%"center%">Automatic generation produced by ISE Eiffel</p>%N")
			if l_is_html_stylesheet then
				str.append (form_code)
			elseif l_is_html then
				str.append (table_code)
			end
			str.append ("<img src=%"./diagram.png%" usemap=%"#diagram_map%" border=0>%N")
			str.append (image_map (l_diagram))
			if l_is_html_stylesheet then
				str.append (form_code)
			elseif l_is_html then
				str.append (table_code)
			end
			str.append ("<p align=%"center%"> -- Generated by ISE Eiffel -- </p>%N%
							%<p align=%"center%">For more details: <a href=%"http://www.eiffel.com%">www.eiffel.com</a></p>%N%
							%</body>%N%
							%</html>%N")
			ptf.put_string (str)
			ptf.close

			if attached {EV_MODEL_BUFFER_PROJECTOR} projector as l_buffer_projector then
				minimum_pixmap := l_buffer_projector.world_as_pixmap (border)
				if l_buffer_projector.is_world_too_large then
					prompts.show_warning_prompt (Warning_messages.W_cannot_generate_png + " " + l_cluster_name, Void, Void)
					create minimum_pixmap.make_with_size (1, 1)
				end
				minimum_pixmap.save_to_named_path (png_format, png_file)
					-- Remove references.
				minimum_pixmap.destroy
			end

			l_projector_widget := projector.widget
			l_projector_widget.pointer_motion_actions.wipe_out
			l_projector_widget.pointer_button_press_actions.wipe_out
			l_projector_widget.pointer_double_press_actions.wipe_out
			l_projector_widget.pointer_button_release_actions.wipe_out
			l_projector_widget.pointer_leave_actions.wipe_out
			projector := Void
			diagram := Void
		end

feature {NONE} -- Implementation

	cluster: CONF_GROUP
			-- Center of generated diagram.

	diagram: EIFFEL_CLUSTER_DIAGRAM
			-- Diagram to be generated.

	documentation: DOCUMENTATION
			-- Associated documentation generator.

	view_name: detachable STRING_32
			-- Name of view to use to generate `diagram'.

	cluster_path: PATH
			-- `cluster' path relative to `documentation.root_directory'.

	base_path: STRING_32
			-- Path from `cluster' to documentation root directory.

	target_file_name: PATH
			-- Output file for generated diagram.

	diagram_file: RAW_FILE
			-- File where views for `diagram' are stored.	
		do
			create Result.make_with_path (Eiffel_system.context_diagram_path.extended (id_of_group (cluster) + ".xml"))
		end

	form_code: STRING_32
			-- For html-stylesheet format.
		local
			l_base_path: like base_path
		do
			l_base_path := base_path
			create Result.make_from_string ("<form onsubmit=%"go_to('"); Result.append (l_base_path); Result.append ("/',this.c.value);return false;%">%N")
			Result.append ("<table cellspacing=%"5%" cellpadding=%"4%"><tr>%N%
				%<td class=%"link1%"><a class=%"link1%" href=%""); Result.append (l_base_path); Result.append ("/class_list.html%">Classes</a></td>%N%
				%<td class=%"link1%"><a class=%"link1%" href=%""); Result.append (l_base_path); Result.append ("/cluster_list.html%">Clusters</a></td>%N%
				%<td class=%"link1%"><a class=%"link1%" href=%""); Result.append (l_base_path); Result.append ("/cluster_hierarchy.html%">Cluster hierarchy</a></td>%N%
				%<td class=%"link2%">Go to: <input name=%"c%" value=%"%"></td>%N%
				%</tr></table></form>%N")
		end

	table_code: STRING_32
			-- For html format.
		local
			l_base_path: like base_path
		do
			l_base_path := base_path
			create Result.make_from_string ("<table border=%"1%" align=%"center%"><tr>%N%
				%<td><a href=%""); Result.append (l_base_path); Result.append ("/class_list.html%">Classes</a></td>%N%
				%<td><a href=%""); Result.append (l_base_path); Result.append ("/cluster_list.html%">Clusters</a></td>%N%
				%<td><a href=%""); Result.append (l_base_path); Result.append ("/cluster_hierarchy.html%">Cluster hierarchy</a></td>%N%
				%</tr></table>%N")
		end

	image_map (cd: EIFFEL_CLUSTER_DIAGRAM): STRING_32
			-- HTML image map for `cd'.
			-- Class bubbles are links to html class charts.
			-- Empty space inside clusters are links to html cluster charts.
		require
			cd_not_void: cd /= Void
		local
			l_border: like border
			class_figures: LIST [EG_LINKABLE_FIGURE]
			cluster_figures: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			local_cluster_figures: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			item_file: STRING_32
			path: STRING_32
			only_leaf_clusters: BOOLEAN
			bounds, bbox: EV_RECTANGLE
			l_base_path: like base_path
			l_class_i: CLASS_I
			l_documentation: like documentation
			l_doc_universe: like documentation.doc_universe
			l_group: CONF_GROUP
		do
			bounds := cd.bounding_box
			l_border := border
			bounds.grow_left (l_border)
			bounds.grow_top (l_border)
			bounds.grow_right (l_border)
			bounds.grow_bottom (l_border)

			Result := "<map name=%"diagram_map%">%N"

			l_base_path := base_path
			l_documentation := documentation
			l_doc_universe := l_documentation.doc_universe

			class_figures := cd.flat_classes
			from
				class_figures.start
			until
				class_figures.after
			loop
				if attached {EIFFEL_CLASS_FIGURE} class_figures.item as cf then
					l_class_i := cf.model.class_i
					if l_class_i.is_compiled and l_doc_universe.is_class_generated (l_class_i) then
						item_file := l_base_path.twin
						path := l_documentation.relative_path_using_sep (l_class_i.group, "/")
						if path /= Void then
							item_file.append_character ('/')
							item_file.append (path)
							item_file.append_character ('/')
						end
						item_file.append ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_class_i.name).as_lower)
						item_file.append ("_chart.html")
						bbox := cf.bounding_box
						Result.append ("<area shape=rect coords=%"")
						Result.append_integer (bbox.left - bounds.x);   Result.append_character (',')
						Result.append_integer (bbox.top - bounds.y);    Result.append_character (',')
						Result.append_integer (bbox.right - bounds.x);  Result.append_character (',')
						Result.append_integer (bbox.bottom - bounds.y); Result.append_character ('%"')
						Result.append (" href=%""); Result.append (item_file); Result.append ("%">%N")
					elseif attached {BON_CLASS_FIGURE} cf as bcf then
						bcf.set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
					end
				else
					check is_eiffel_class_figure: False end
				end
				class_figures.forth
			end
			from
				cluster_figures := cd.root_clusters
				create local_cluster_figures.make (cluster_figures.count)
				from
					cluster_figures.start
				until
					cluster_figures.after
				loop
					local_cluster_figures.extend (cluster_figures.item)
					cluster_figures.forth
				end
				only_leaf_clusters := False
			until
				only_leaf_clusters
			loop
				only_leaf_clusters := True
				from
					local_cluster_figures.start
				until
					local_cluster_figures.after
				loop
					if
						attached {EIFFEL_CLUSTER_FIGURE} local_cluster_figures.item as clf and then
						attached clf.subclusters as subs and then
						not subs.is_empty
					then
						only_leaf_clusters := False
						local_cluster_figures.remove
						local_cluster_figures.merge_left (subs)
					else
						check is_eiffel_cluster_figure: attached {EIFFEL_CLUSTER_FIGURE} local_cluster_figures.item end
						local_cluster_figures.forth
					end
				end
			end
			from
			until
				local_cluster_figures.is_empty
			loop
				from
					local_cluster_figures.start
				until
					local_cluster_figures.after
				loop
					if attached {EIFFEL_CLUSTER_FIGURE} local_cluster_figures.item as clf then
						l_group := clf.model.group
						if l_doc_universe.is_group_generated (l_group) then
							item_file := l_base_path.twin
							path := l_documentation.relative_path_using_sep (l_group, "/")
							if path /= Void then
								item_file.append_character ('/')
								item_file.append (path)
							end
							item_file.append ("/index.html")
							bbox := clf.bounding_box
							Result.append ("<area shape=rect coords=%"")
							Result.append_integer (bbox.left - bounds.x); Result.append_character (',')
							Result.append_integer (bbox.top - bounds.y); Result.append_character (',')
							Result.append_integer (bbox.right - bounds.x); Result.append_character (',')
							Result.append_integer (bbox.bottom - bounds.y); Result.append_character ('%"')
							Result.append (" href=%""); Result.append (item_file); Result.append ("%">%N")
						end
						local_cluster_figures.remove
						if
							attached clf.cluster as l_clf_cluster and then
							not local_cluster_figures.has (l_clf_cluster)
						then
							local_cluster_figures.put_front (l_clf_cluster)
						end
					else
						check is_eiffel_cluster_figure: False end
						local_cluster_figures.remove
					end
				end
			end
			Result.append ("</map>%N")
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end

