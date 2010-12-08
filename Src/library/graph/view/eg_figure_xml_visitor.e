note
	description: "Summary description for {EG_FIGURE_XML_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_FIGURE_XML_VISITOR

inherit
	EG_FIGURE_VISITOR

	XML_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent)
		require
			a_parent_attached: a_parent /= Void
		do
			parent := a_parent
		end

feature -- Access

	parent: XML_COMPOSITE

	last_xml_element: detachable XML_ELEMENT

feature -- Element change

	set_last_xml_element (a_last_xml_element: like last_xml_element)
			-- Set `last_xml_element' to `a_last_xml_element'
		do
			last_xml_element := a_last_xml_element
		end

feature -- Visiting

	process_figure_world (a_figure_world: EG_FIGURE_WORLD)
			-- Process figure world `a_figure_world'
		local
			node: like last_xml_element
			l_fig: like last_xml_element
			l_item: EG_FIGURE
			l_root_elements: like last_xml_element
			l_old_parent: like parent
		do
			node := last_xml_element
			if node = Void then
				if attached {XML_DOCUMENT} parent as parent_document then
					create node.make_root (parent_document, "VIEW", xml_namespace)
				else
					check should_not_occur: False end
					create node.make (parent, "VIEW", xml_namespace)
				end
			end
			node.put_last (Xml_routines.xml_node (node, "SCALE_FACTOR", a_figure_world.scale_factor.out))

			create l_root_elements.make (node, "ROOT_ELEMENTS", xml_namespace)
			l_old_parent := parent
			parent := l_root_elements
			if attached a_figure_world.root_clusters as l_root_cluster then
				from
					l_root_cluster.start
				until
					l_root_cluster.after
				loop
					l_item := l_root_cluster.item
					if l_item.is_storable then
						last_xml_element := Void
						process_figure (l_item)
						if attached last_xml_element as le then
							l_root_elements.put_last (le)
						else
							check last_xml_element_attached: last_xml_element /= Void end
						end
					end
					l_root_cluster.forth
				end
			else
				check root_cluster_attached: False end
			end
			if attached a_figure_world.links as l_links then
				from
					l_links.start
				until
					l_links.after
				loop
					l_item := l_links.item
					if l_item.is_storable then
						last_xml_element := Void
						process_figure (l_item)
						if attached last_xml_element as le then
							l_root_elements.put_last (le)
						else
							check last_xml_element_attached: last_xml_element /= Void end
						end
					end
					l_links.forth
				end
			else
				check links_attached: False end
			end
			node.put_last (l_root_elements)

			last_xml_element := node
		ensure then
			last_xml_element_attached: last_xml_element /= Void
		end

	process_figure (a_figure: EG_FIGURE)
			-- Process figure `a_figure'
		local
			node: like last_xml_element
			l_xml: like last_xml_element
			l_xml_routines: like xml_routines
		do
			node := last_xml_element
			if node = Void then
				create node.make (parent, a_figure.xml_node_name, xml_namespace)
			end

			l_xml_routines := xml_routines
			if attached a_figure.model as l_model then
				if attached l_model.name as l_name then
					node.add_attribute (a_figure.name_string, xml_namespace, l_name)
				end
			else
				check
					model_attached: False
				end
			end
			node.put_last (l_xml_routines.xml_node (node, a_figure.is_selected_string, boolean_representation (a_figure.is_selected)))
			node.put_last (l_xml_routines.xml_node (node, a_figure.is_label_shown_string, boolean_representation (a_figure.is_label_shown)))

			last_xml_element := node
		ensure then
			last_xml_element_attached: last_xml_element /= Void
		end

	process_linkable_figure (a_linkable_figure: EG_LINKABLE_FIGURE)
		local
			node: like last_xml_element
			l_xml_routines: like xml_routines
			vis: EG_FIGURE_XML_VISITOR
		do
			node := last_xml_element
			if node = Void then
				create node.make (parent, a_linkable_figure.xml_node_name, xml_namespace)
			end

			last_xml_element := node
			process_figure (a_linkable_figure)

			l_xml_routines := xml_routines
			node.put_last (l_xml_routines.xml_node (node, a_linkable_figure.is_fixed_string, boolean_representation (a_linkable_figure.is_fixed)))
			node.put_last (l_xml_routines.xml_node (node, a_linkable_figure.port_x_string, a_linkable_figure.port_x.out))
			node.put_last (l_xml_routines.xml_node (node, a_linkable_figure.port_y_string, a_linkable_figure.port_y.out))

			last_xml_element := node
		ensure then
			last_xml_element_attached: last_xml_element /= Void
		end

	process_link_figure (a_link_figure: EG_LINK_FIGURE)
		local
			node: like last_xml_element
		do
			node := last_xml_element
			if node = Void then
				create node.make (parent, a_link_figure.xml_node_name, xml_namespace)
			end

			last_xml_element := node
			process_figure (a_link_figure)

			if attached a_link_figure.model as l_model then
				node.add_attribute (once "SOURCE", xml_namespace, l_model.source.link_name)
				node.add_attribute (once "TARGET", xml_namespace, l_model.target.link_name)
				node.put_last (Xml_routines.xml_node (node, a_link_figure.is_directed_string, boolean_representation (l_model.is_directed)))
			else
				check model_attached: False end
			end
			last_xml_element := node
		ensure then
			last_xml_element_attached: last_xml_element /= Void
		end

	process_cluster_figure (a_cluster_figure: EG_CLUSTER_FIGURE)
		local
			l_old_parent: like parent
			node: like last_xml_element
			l_fig, l_elements: like last_xml_element
		do
			node := last_xml_element
			if node = Void then
				create node.make (parent, a_cluster_figure.xml_node_name, xml_namespace)
			end

			last_xml_element := node
			process_linkable_figure (a_cluster_figure)

			l_old_parent := parent
			create l_elements.make (node, once "ELEMENTS", xml_namespace)
			parent := l_elements
			from
				a_cluster_figure.start
			until
				a_cluster_figure.after
			loop
				if attached {EG_LINKABLE_FIGURE} a_cluster_figure.item as eg_fig then
					last_xml_element := Void
					process_linkable_figure (eg_fig)
					if attached last_xml_element as le then
						l_elements.put_last (le)
					else
						check last_xml_element_attached: last_xml_element /= Void end
					end
				end
				a_cluster_figure.forth
			end
			parent := l_old_parent
			node.put_last (l_elements)
			last_xml_element := node
		ensure then
			last_xml_element_attached: last_xml_element /= Void
		end

feature {NONE} -- Implementation

	boolean_representation (a_boolean: BOOLEAN): STRING
			-- Optimized string representation of `a_boolean'.
		do
			if a_boolean then
				Result := once "True"
			else
				Result := once "False"
			end
		end

	xml_namespace: XML_NAMESPACE
		once
			create Result.make_default
		end

	Xml_routines: XML_GRAPH_ROUTINES
			-- Access the common xml routines.
		once
			create Result.default_create
		ensure
			non_void_Xml_routines: Xml_routines /= Void
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
