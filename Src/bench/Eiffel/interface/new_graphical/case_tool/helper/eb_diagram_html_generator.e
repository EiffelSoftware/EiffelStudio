indexing
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

	XM_CALLBACKS_FILTER_FACTORY
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

	CONF_REFACTORING
		undefine
			default_create
		end

create
	make_for_documentation,
	make_for_wizard

feature {NONE} -- Initialization

	make_for_documentation (a_cluster: CLUSTER_I; a_view: STRING; doc: DOCUMENTATION) is
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
			create target_file_name.make_from_string (doc.root_directory.name)
			if cluster_path /= Void then
				target_file_name.extend (cluster_path)
			end
			target_file_name.extend ("diagram")
			target_file_name.add_extension ("html")
			initialize
		end

	make_for_wizard (a_cluster: CLUSTER_I) is
			-- Initialize for `a_cluster'.
			-- Does not allow calls to `execute'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			cluster := a_cluster
		end

	initialize is
			-- Build `diagram'.
		do
			create {BON_CLUSTER_DIAGRAM} diagram.make_without_interactions (create {ES_CLUSTER_GRAPH})
			create world_cell.make_with_world (diagram)
			projector := world_cell.projector
		end

feature {CONTEXT_DIAGRAM} -- Access

	projector: EIFFEL_PROJECTOR
			-- Projector of generated diagram on `pixmap'.


	world_cell: EIFFEL_FIGURE_WORLD_CELL

	border: INTEGER is 5

feature {EB_DOCUMENTATION_WIZARD} -- Basic operations

	available_views: LINKED_LIST [STRING] is
			-- Names of available views of `cluster'.
		local
			l_parser: XM_EIFFEL_PARSER
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_file: KL_BINARY_INPUT_FILE
			l_xm_concatenator: XM_CONTENT_CONCATENATOR
			diagram_input, node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
		do
			create Result.make
			create l_file.make (diagram_file_name)
			l_file.open_read
			if l_file.is_open_read then
				create l_parser.make
				create l_tree_pipe.make
				create l_xm_concatenator.make_null
				l_parser.set_callbacks (standard_callbacks_pipe (<<l_xm_concatenator, l_tree_pipe.start>>))
				l_parser.parse_from_stream (l_file)
				l_file.close
				if l_parser.is_correct then
					diagram_input := l_tree_pipe.document.root_element
					check
						valid_file: diagram_input.name.is_equal ("EIFFEL_CLUSTER_DIAGRAM")
					end
					a_cursor := diagram_input.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						check
							valid_node: node.has_attribute_by_name ("NAME")
						end
						Result.extend (node.attribute_by_name ("NAME").value)
						a_cursor.forth
					end
				end
			end
		end

feature {DOCUMENTATION} -- Basic operations

	execute is
			-- Write diagram for `cluster' in `target_file_name'.
		local
			png_format: EV_PNG_FORMAT
			png_file: FILE_NAME
			str: STRING
			ptf: PLAIN_TEXT_FILE
			minimum_pixmap: EV_PIXMAP
			wd: EV_WARNING_DIALOG
			layout: EIFFEL_INHERITANCE_LAYOUT
		do
			check
				for_documentation: documentation /= Void
			end
			if view_name /= Void then
				diagram.change_view (view_name, diagram_file_name)
			else
				diagram.model.set_center_cluster (create {ES_CLUSTER}.make (cluster))
				diagram.model.explore_center_cluster
				create layout.make_with_world (diagram)
				layout.layout
			end
			world_cell.crop
			create png_format
			create png_file.make_from_string (documentation.root_directory.name)
			if cluster_path /= Void then
				png_file.extend (cluster_path)
			end
			png_file.extend ("diagram")
			png_file.add_extension ("png")

			create ptf.make_open_write (target_file_name)
			str := "<HTML><HEAD>%
						%<TITLE>Cluster " + cluster.cluster_name + "</TITLE>%N"
			if documentation.filter_name.is_equal ("html-stylesheet") then
				str.append ("<LINK REL=%"stylesheet%" HREF=%"" +
					base_path +
					"/default.css%" TYPE=%"text/css%">%N%
					%<SCRIPT TYPE=%"text/javascript%" SRC=%"" +
					base_path +
					"/goto.html%"></SCRIPT>%N")
			end
			str.append ("</HEAD>%N%
							%<BODY BGCOLOR=%"white%">%N%
							%<P ALIGN=%"CENTER%">Automatic generation produced by ISE Eiffel</P>%N")
			if documentation.filter_name.is_equal ("html-stylesheet") then
				str.append (form_code)
			elseif documentation.filter_name.is_equal ("html") then
				str.append (table_code)
			end
			str.append ("<img src=%"./diagram.png%" usemap=%"#diagram_map%" border=0>%N")
			str.append (image_map (diagram))
			if documentation.filter_name.is_equal ("html-stylesheet") then
				str.append (form_code)
			elseif documentation.filter_name.is_equal ("html") then
				str.append (table_code)
			end
			str.append ("<P ALIGN=%"CENTER%"> &#045;&#045; Generated by ISE Eiffel &#045;&#045 </P>%N%
							%<P ALIGN=%"CENTER%">For more details: <A HREF=%"http://www.eiffel.com%">www.eiffel.com</A></P>%N%
							%</BODY>%N%
							%</HTML>%N")
			ptf.put_string (str)
			ptf.close

			minimum_pixmap := projector.world_as_pixmap (border)
			if projector.is_world_too_large then
				create wd.make_with_text (Warning_messages.W_cannot_generate_png+"%N"+cluster.cluster_name)
				create minimum_pixmap.make_with_size (1, 1)
			end
			minimum_pixmap.save_to_named_file (png_format, png_file)
				-- Remove references.
			minimum_pixmap.destroy
			projector.widget.pointer_motion_actions.wipe_out
			projector.widget.pointer_button_press_actions.wipe_out
			projector.widget.pointer_double_press_actions.wipe_out
			projector.widget.pointer_button_release_actions.wipe_out
			projector.widget.pointer_leave_actions.wipe_out
			projector := Void
			diagram := Void
		end

feature {NONE} -- Implementation

	cluster: CLUSTER_I
			-- Center of generated diagram.

	diagram: EIFFEL_CLUSTER_DIAGRAM
			-- Diagram to be generated.

	documentation: DOCUMENTATION
			-- Associated documentation generator.

	view_name: STRING
			-- Name of view to use to generate `diagram'.

	cluster_path: FILE_NAME
			-- `cluster' path relative to `documentation.root_directory'.

	base_path: FILE_NAME
			-- Path from `cluster' to documentation root directory.

	target_file_name: FILE_NAME
			-- Output file for generated diagram.

	diagram_file_name: FILE_NAME is
			-- Where views for `diagram' are stored.	
		do
			create Result.make_from_string (Eiffel_system.context_diagram_path)
			Result.extend (cluster.cluster_name)
			Result.add_extension ("xml")
		end

	form_code: STRING is
			-- For html-stylesheet format.
		do
			Result := "<FORM ONSUBMIT=%"go_to('" +
				base_path +
				"/',this.c.value);return false;%">%N%
				%<TABLE CELLSPACING=%"5%" CELLPADDING=%"4%"><TR>%N%
				%<TD CLASS=%"link1%"><A CLASS=%"link1%" HREF=%"" +
				base_path +
				"/class_list.html%">Classes</A></TD>%N%
				%<TD CLASS=%"link1%"><A CLASS=%"link1%" HREF=%"" +
				base_path +
				"/cluster_list.html%">Clusters</A></TD>%N%
				%<TD CLASS=%"link1%"><A CLASS=%"link1%" HREF=%"" +
				base_path +
				"/cluster_hierarchy.html%">Cluster hierarchy</A></TD>%N%
				%<TD CLASS=%"link2%">Go to: <INPUT NAME=%"c%" VALUE=%"%"></TD>%N%
				%</TR></TABLE></FORM>%N"
		end

	table_code: STRING is
			-- For html format.
		do
			Result := "<TABLE BORDER=%"1%" ALIGN=%"CENTER%"><TR>%N%
				%<TD><A HREF=%"" +
				base_path + "/class_list.html%">Classes</A></TD>%N%
				%<TD><A HREF=%"" +
				base_path + "/cluster_list.html%">Clusters</A></TD>%N%
				%<TD><A HREF=%"" +
				base_path + "/cluster_hierarchy.html%">Cluster hierarchy</A></TD></TR></TABLE>%N"
		end

	image_map (cd: EIFFEL_CLUSTER_DIAGRAM): STRING is
			-- HTML image map for `cd'.
			-- Class bubbles are links to html class charts.
			-- Empty space inside clusters are links to html cluster charts.
		require
			cd_not_void: cd /= Void
		local
			class_figures: LIST [EG_LINKABLE_FIGURE]
			cluster_figures, subs: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			local_cluster_figures: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			cf: EIFFEL_CLASS_FIGURE
			bcf: BON_CLASS_FIGURE
			clf: EIFFEL_CLUSTER_FIGURE
			item_file: STRING
			path: FILE_NAME
			only_leaf_clusters: BOOLEAN
			bounds, bbox: EV_RECTANGLE
		do
			bounds := cd.bounding_box
			bounds.grow_left (border)
			bounds.grow_top (border)
			bounds.grow_right (border)
			bounds.grow_bottom (border)
			Result := "<map name=%"diagram_map%">%N"
			class_figures := cd.flat_classes
			from
				class_figures.start
			until
				class_figures.after
			loop
				cf ?= class_figures.item
				if cf.model.class_i.compiled and documentation.doc_universe.is_class_generated (cf.model.class_i) then
					item_file := base_path.twin
					conf_todo
					path := documentation.relative_path (cf.model.class_i.group)
--					path := cf.model.class_i.group.location.evaluated_directory
					if path /= Void then
						item_file.append_character ('/')
						item_file.append (path)
					end
--					item_file.append_character ('/')
					item_file.append (cf.model.class_i.name.as_lower)
					item_file.append ("_chart.html")
					bbox := cf.bounding_box
					Result.append ("<area shape=rect coords=%""
						+ (bbox.left - bounds.x).out + ","
						+ (bbox.top - bounds.y).out + ","
						+ (bbox.right - bounds.x).out + ","
						+ (bbox.bottom - bounds.y).out + "%"%
						% href=%""
						+ item_file
						+ "%">%N")
				else
					bcf ?= cf
					if bcf /= Void then
						bcf.set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
					end
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
					clf ?= local_cluster_figures.item
					subs := clf.subclusters
					if subs.is_empty then
						local_cluster_figures.forth
					else
						only_leaf_clusters := False
						local_cluster_figures.remove
						local_cluster_figures.merge_left (subs)
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
					clf ?= local_cluster_figures.item
					conf_todo
--					if documentation.doc_universe.is_cluster_generated (clf.model.cluster_i) then
--						item_file := base_path.twin
--						path := documentation.relative_path (clf.model.cluster_i)
--						if path /= Void then
--							item_file.append_character ('/')
--							item_file.append (path)
--						end
--						item_file.append ("/index.html")
--						bbox := clf.bounding_box
--						Result.append ("<area shape=rect coords=%""
--							+ (bbox.left - bounds.x).out + ","
--							+ (bbox.top - bounds.y).out + ","
--							+ (bbox.right - bounds.x).out + ","
--							+ (bbox.bottom - bounds.y).out + "%"%
--							% href=%""
--							+ item_file
--							+ "%">%N")
--					end
					local_cluster_figures.remove
					if clf.cluster /= Void and then
						not local_cluster_figures.has (clf.cluster) then
							local_cluster_figures.put_front (clf.cluster)
					end
				end
			end
			Result.append ("</map>%N")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_DIAGRAM_HTML_GENERATOR

