indexing
	description: "BON view for a CLASS_GRAPH."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLASS_DIAGRAM

inherit
	EIFFEL_WORLD
		redefine
			default_create,
			model,
			xml_element,
			xml_node_name,
			set_with_xml_element,
			recycle
		end
		
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create
		end
	
feature {NONE} -- Initialization

	default_create is
			-- Create a EIFFEL_CLASS_GRAPH.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.extend (agent on_class_drop)
			drop_actions.extend (agent on_new_class_drop)
		end
		
feature -- Access

	model: ES_CLASS_GRAPH
			-- Model for current view.
			
feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.prune_all (agent on_class_drop)
			drop_actions.prune_all (agent on_new_class_drop)
		end
			
feature {EB_CONTEXT_EDITOR} -- Save/Restore

	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "EIFFEL_CLASS_DIAGRAM"
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			node.add_attribute ("NAME", xml_namespace, current_view)
			node.put_last (Xml_routines.xml_node (node, "ANCESTOR_DEPTH", model.ancestor_depth.out))
			node.put_last (Xml_routines.xml_node (node, "DESCENDANT_DEPTH", model.descendant_depth.out))
			node.put_last (Xml_routines.xml_node (node, "CLIENT_DEPTH", model.client_depth.out))
			node.put_last (Xml_routines.xml_node (node, "SUPPLIER_DEPTH", model.supplier_depth.out))
			node.put_last (Xml_routines.xml_node (node, "ALL_CLASSES_IN_CLUSTER", model.include_all_classes_of_cluster.out))
			node.put_last (Xml_routines.xml_node (node, "ONLY_CLASSES_IN_CLUSTER", model.include_only_classes_of_cluster.out))
			node.put_last (xml_routines.xml_node (node, "CENTER_CLASS_NAME", model.center_class.class_i.name_in_upper))
			node.put_last (xml_routines.xml_node (node, "CENTER_CLASS_CLUSTER_NAME", model.center_class.class_i.cluster.cluster_name))

			Result := Precursor {EIFFEL_WORLD} (node)
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			ccn, cccn: STRING
			cc: CLASS_I
			cl: CLUSTER_I
			esc: ES_CLASS
		do
			node.forth
			model.set_ancestor_depth (xml_routines.xml_integer (node, "ANCESTOR_DEPTH"))
			model.set_descendant_depth (xml_routines.xml_integer (node, "DESCENDANT_DEPTH"))
			model.set_client_depth (xml_routines.xml_integer (node, "CLIENT_DEPTH"))
			model.set_supplier_depth (xml_routines.xml_integer (node, "SUPPLIER_DEPTH"))
			model.set_include_all_classes_of_cluster (xml_routines.xml_boolean (node, "ALL_CLASSES_IN_CLUSTER"))
			model.set_include_only_classes_of_cluster (xml_routines.xml_boolean (node, "ONLY_CLASSES_IN_CLUSTER"))
			ccn := xml_routines.xml_string (node, "CENTER_CLASS_NAME")
			cccn := xml_routines.xml_string (node, "CENTER_CLASS_CLUSTER_NAME")
			
			Precursor {EIFFEL_WORLD} (node)
			
			cl := universe.cluster_of_name (cccn)
			cc := universe.class_named (ccn, cl)
			
			esc := model.class_from_interface (cc)
			check
				esc_in_graph: esc /= Void
			end
			model.set_center_class (esc)
		end
		
feature {NONE} -- Implementation

	on_class_drop (a_stone: CLASSI_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Add to diagram if not already present.
		local
			drop_x, drop_y, old_x, old_y: INTEGER
			cf: EIFFEL_CLASS_FIGURE
			cm: ES_CLASS
			remove_links: LIST [ES_ITEM]
		do
			if not model.is_empty then
				cm := model.class_from_interface (a_stone.class_i)
				if cm = Void or else not cm.is_needed_on_diagram  then
					-- add it
					if cm = Void then
						create cm.make (a_stone.class_i)
						model.add_node (cm)
					else
						cm.enable_needed_on_diagram
						enable_all_links (cm)
						model.add_ancestor_relations (cm)
						model.add_descendant_relations (cm)
						model.add_client_relations (cm)
						model.add_supplier_relations (cm)
					end
					cf ?= figure_from_model (cm)
					check
						class_was_inserted: cf /= Void
					end
					drop_x := context_editor.pointer_position.x
					drop_y := context_editor.pointer_position.y
					cf.set_port_position (drop_x, drop_y)
					remove_links := cm.needed_links
					update_cluster_legend
					context_editor.history.register_named_undoable (
						Interface_names.t_Diagram_include_class_cmd (cm.name),
						[<<agent reinclude_class (cf, remove_links, drop_x, drop_y), agent update_cluster_legend>>],
						[<<agent remove_class_virtual (cf, remove_links), agent update_cluster_legend>>])
				else
					-- move it
					cf ?= figure_from_model (cm)
					check
						class_was_inserted: cf /= Void
					end
					drop_x := context_editor.pointer_position.x
					drop_y := context_editor.pointer_position.y
					old_x := cf.port_x
					old_y := cf.port_y
					cf.set_port_position (drop_x, drop_y)
					context_editor.history.register_named_undoable (
						interface_names.t_diagram_move_class_cmd (cm.name),
						agent cf.set_port_position (drop_x, drop_y),
						agent cf.set_port_position (old_x, old_y))
				end
				if is_right_angles then
					apply_right_angles
				end
			end
		end		

	on_new_class_drop (a_stone: CREATE_CLASS_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Display create class dialog and add to diagram.
		local
			dial: EB_CREATE_CLASS_DIALOG
			drop_x, drop_y: INTEGER
		do
			drop_x := context_editor.pointer_position.x
			drop_y := context_editor.pointer_position.y
			create dial.make_default (context_editor.development_window)
			dial.preset_cluster (model.center_class.class_i.cluster)
			dial.call_default
			include_new_dropped_class (dial, drop_x, drop_y)
		end
		
	include_new_dropped_class (a_create_class_dialog: EB_CREATE_CLASS_DIALOG; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		require
			a_create_class_dialog: a_create_class_dialog /= Void
		local
			a_class: CLASS_I
			cf: EIFFEL_CLASS_FIGURE
			es_class: ES_CLASS
			remove_links: LIST [ES_ITEM]
		do
			if not a_create_class_dialog.cancelled then
				a_class := a_create_class_dialog.class_i
				if a_class /= Void then
					es_class := model.class_from_interface (a_class)
					if es_class = Void then
						create es_class.make (a_class)
						model.add_node (es_class)
					else
						es_class.enable_needed_on_diagram
						enable_all_links (es_class)
						model.add_ancestor_relations (es_class)
						model.add_descendant_relations (es_class)
						model.add_client_relations (es_class)
						model.add_supplier_relations (es_class)
					end
					cf ?= figure_from_model (es_class)
					check cf_not_void: cf /= Void end
					cf.set_port_position (a_x, a_y)
					remove_links := es_class.needed_links
					update_cluster_legend
					context_editor.history.register_named_undoable (
						interface_names.t_diagram_include_class_cmd (es_class.name),
						[<<agent reinclude_class (cf, remove_links, a_x, a_y), agent update_cluster_legend>>],
						[<<agent remove_class_virtual (cf, remove_links), agent update_cluster_legend>>])
				end
				if is_right_angles then
					apply_right_angles
				end
			end
		end

end -- class EIFFEL_CLASS_DIAGRAM
