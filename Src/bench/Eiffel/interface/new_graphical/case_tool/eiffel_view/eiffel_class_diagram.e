indexing
	description: "BON view for a CLASS_GRAPH."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EB_CLUSTER_MANAGER_OBSERVER
		undefine
			default_create
		redefine
			on_class_added
		end

create
	default_create

create {EIFFEL_CLASS_DIAGRAM}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create a EIFFEL_CLASS_GRAPH.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.extend (agent on_class_drop)
			drop_actions.extend (agent on_new_class_drop)
			manager.add_observer (Current)
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
			manager.remove_observer (Current)
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

				-- Check if cluster still exists
			cl := universe.cluster_of_name (cccn)
			if cl /= Void then
				cc := universe.class_named (ccn, cl)
					-- Check if class still exists
				if cc /= Void then
					esc := model.class_from_interface (cc)
					if esc = Void then
						create esc.make (cc)
						model.add_node (esc)
					end
					model.set_center_class (esc)
				end
			end
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
						if a_stone.class_i.is_compiled then
							model.add_ancestor_relations (cm)
							model.add_descendant_relations (cm)
							model.add_client_relations (cm)
							model.add_supplier_relations (cm)
						end
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
			is_new_dropped := True
			drop_x := context_editor.pointer_position.x
			drop_y := context_editor.pointer_position.y
			create dial.make_default (context_editor.development_window)
			dial.preset_cluster (model.center_class.class_i.cluster)
			dial.call_default
			if not dial.cancelled then
				include_new_class (dial.class_i, drop_x, drop_y)
			end
			is_new_dropped := False
		end

	is_new_dropped: BOOLEAN
			-- Is new added class to system dropped by user onto the diagram tool?

	include_new_class (a_class: CLASS_I; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		require
			a_class_exists: a_class /= Void
		local
			cf: EIFFEL_CLASS_FIGURE
			es_class: ES_CLASS
			remove_links: LIST [ES_ITEM]
		do
			if a_class /= Void then
				es_class := model.class_from_interface (a_class)
				if es_class = Void then
					create es_class.make (a_class)
					model.add_node (es_class)
				else
					es_class.enable_needed_on_diagram
					enable_all_links (es_class)
					if a_class.is_compiled then
						model.add_ancestor_relations (es_class)
						model.add_descendant_relations (es_class)
						model.add_client_relations (es_class)
						model.add_supplier_relations (es_class)
					end
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

	on_class_added (a_class: CLASS_I) is
			-- `a_class' was added to the system.
		local
			ax, ay: INTEGER
		do
			if not is_new_dropped and then model.center_class /= Void then
				ax := context_editor.widget.width // 2 + context_editor.projector.area_x
				ay := context_editor.widget.height // 2 + context_editor.projector.area_y
				include_new_class (a_class, ax, ay)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EIFFEL_CLASS_DIAGRAM
