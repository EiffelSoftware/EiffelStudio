indexing
	description: "Objects that generate an html file representing a diagram%N%
			% , to be included in html documentation"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIAGRAM_HTML_GENERATOR
	
inherit
	SHARED_EIFFEL_PROJECT

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
		local
			cell: CELL [EV_DRAWABLE]
		do
			create {BON_CLUSTER_DIAGRAM} diagram.make (Void)
			create pixmap
			create {EV_PIXMAP_PROJECTOR} projector.make (diagram, pixmap)			
			create cell.put (pixmap)
			diagram.set_drawable_cell_and_position (cell, create {EV_COORDINATE})
			diagram.set_projector (projector)
			diagram.set_cluster (cluster)
			diagram.reset
			diagram.client_supplier_layer.hide
			diagram.client_supplier_layer.disable_sensitive
			diagram.disable_client_links_displayed		
		end

feature {CONTEXT_DIAGRAM} -- Access

	projector: EV_WIDGET_PROJECTOR
			-- Projector of generated diagram on `pixmap'.
		
	pixmap: EV_PIXMAP
			-- Area where generated diagram is drawn.
			-- Only for PNG output.

feature {EB_DOCUMENTATION_WIZARD} -- Basic operations

	available_views: LINKED_LIST [STRING] is
			-- Names of available views of `cluster'.
		local
			diagram_file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
			diagram_input, node: XML_ELEMENT
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]			
		do
			create Result.make
			create diagram_file.make (diagram_file_name)
			if diagram_file.exists then
				diagram_file.open_read
				create parser.make
				diagram_file.read_stream (diagram_file.count)
				s := diagram_file.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				diagram_file.close
				if parser.is_correct then
					diagram_input := parser.root_element
					if diagram_input.name.is_equal ("CLUSTER_DIAGRAM") then
						a_cursor := diagram_input.new_cursor
						from
							a_cursor.start
						until
							a_cursor.after
						loop
							node ?= a_cursor.item
							if node /= Void then
								if node.name.is_equal ("VIEW") then
									Result.extend (node.attributes.item ("NAME").value)
								end
							end
							a_cursor.forth
						end
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
			t: EB_DIMENSIONS
			minimum_pixmap: EV_PIXMAP
			size: EV_RECTANGLE
		do
			check
				for_documentation: documentation /= Void
			end
			if view_name /= Void then
				diagram.change_view (view_name, diagram_file_name)
				if not diagram.inheritance_links_displayed then
					diagram.inheritance_layer.hide
					diagram.inheritance_layer.disable_sensitive
				end	
				if diagram.client_links_displayed then
					diagram.client_supplier_layer.show
					diagram.client_supplier_layer.enable_sensitive
				end
			end
			t := diagram.minimum_size
			pixmap.set_size (t.width, t.height)
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
			
			projector.full_project
			size := diagram.bounds
			create minimum_pixmap.make_with_size (size.width, size.height)
			minimum_pixmap.draw_sub_pixmap (0, 0, pixmap, size)
			minimum_pixmap.save_to_named_file (png_format, png_file)
			
				-- Remove references.
			pixmap.destroy
			projector.widget.pointer_motion_actions.wipe_out
			projector.widget.pointer_button_press_actions.wipe_out
			projector.widget.pointer_double_press_actions.wipe_out
			projector.widget.pointer_button_release_actions.wipe_out
			projector.widget.pointer_leave_actions.wipe_out
			projector := Void
			diagram.recycle
			diagram := Void
		end

feature {NONE} -- Implementation

	cluster: CLUSTER_I
			-- Center of generated diagram.
		
	diagram: CLUSTER_DIAGRAM
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
			Result.add_extension ("ead")			
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
		
	image_map (cd: CLUSTER_DIAGRAM): STRING is
			-- HTML image map for `cd'.
			-- Class bubbles are links to html class charts.
			-- Empty space inside clusters are links to html cluster charts.
		require
			cd_not_void: cd /= Void
		local
			class_figures: EV_FIGURE_GROUP
			cluster_figures, local_cluster_figures, subs: LINKED_LIST [CLUSTER_FIGURE]
			cf: BON_CLASS_FIGURE
			clf: BON_CLUSTER_FIGURE
			item_file: STRING
			path: FILE_NAME
			only_leaf_clusters: BOOLEAN
			bounds: EV_RECTANGLE
		do
			bounds := cd.bounds
			Result := "<map name=%"diagram_map%">%N"
			class_figures := cd.class_layer
			from
				class_figures.start
			until
				class_figures.after
			loop
				cf ?= class_figures.item
				if cf.class_i.compiled and documentation.doc_universe.is_class_generated (cf.class_i) then
					item_file := clone (base_path)
					path := documentation.relative_path (cf.cluster_figure.cluster_i)
					if path /= Void then
						item_file.append_character ('/')
						item_file.append (path)
					end
					item_file.append_character ('/')
					item_file.append (cf.class_i.name+ "_chart")
					item_file.append (".html")
					Result.append ("<area shape=rect coords=%""
						+ (cf.left - bounds.x).out + ","
						+ (cf.top - bounds.y).out + ","
						+ (cf.right - bounds.x).out + ","
						+ (cf.bottom - bounds.y).out + "%"%
						% href=%""
						+ item_file
						+ "%">%N")
				else
					cf.set_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
				end
				class_figures.forth
			end
			from
				cluster_figures := cd.cluster_figures
				create local_cluster_figures.make
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
					if clf.subclusters.is_empty then
						local_cluster_figures.forth
					else
						only_leaf_clusters := False
						local_cluster_figures.remove
						subs := clf.subclusters
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
					if documentation.doc_universe.is_cluster_generated (clf.cluster_i) then
						item_file := clone (base_path)
						path := documentation.relative_path (clf.cluster_i)
						if path /= Void then
							item_file.append_character ('/')
							item_file.append (path)
						end
						item_file.append ("/index.html")
						Result.append ("<area shape=rect coords=%""
							+ (clf.left - bounds.x).out + ","
							+ (clf.top - bounds.y).out + ","
							+ (clf.right - bounds.x).out + ","
							+ (clf.bottom - bounds.y).out + "%"%
							% href=%""
							+ item_file
							+ "%">%N")
					end
					local_cluster_figures.remove
					if clf.cluster_figure /= Void and then
						not local_cluster_figures.has (clf.cluster_figure) then
							local_cluster_figures.put_front (clf.cluster_figure)
					end
				end
			end
			Result.append ("</map>%N")
		end
	
end -- class EB_DIAGRAM_HTML_GENERATOR

