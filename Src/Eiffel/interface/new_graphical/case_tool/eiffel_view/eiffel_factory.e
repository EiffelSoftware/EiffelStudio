indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_FACTORY

inherit
	EG_FIGURE_FACTORY
		rename
			new_node_figure as new_class_figure
		redefine
			world
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_XML_ROUTINES
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

feature -- Access

	world: EIFFEL_WORLD

	name_string: STRING is "NAME"
	cluster_name_string: STRING is "CLUSTER_NAME"
	source_string: STRING is "SOURCE"
	target_string: STRING is "TARGET"
	source_cluster_string: STRING is "SOURCE_CLUSTER"
	target_cluster_string: STRING is "TARGET_CLUSTER"
	class_id_string: STRING is "CLASS_FIGURE_ID"
	group_id_string: STRING is "GROUP_ID"
	cluster_id_string: STRING is "CLUSTER_ID"
		-- Xml string constants

	model_from_xml (node: XM_ELEMENT): EG_ITEM is
			-- Create an EG_ITEM from `node' if possible.
		local
			node_name, class_name, source_name, target_name: STRING
			cluster_id, class_id, group_id: STRING
			cluster_found: CONF_GROUP
			class_found: CLASS_I
			source, target: ES_CLASS
			l_world: like world
			l_universe: like universe
			l_classes: LINKED_SET [CONF_CLASS]
		do
			l_world := world
			l_universe := universe
			node_name := node.name
			if node_name.is_equal (xml_class_figure_node_name) then
				class_name := node.attribute_by_name (name_string).value
				class_id := node.attribute_by_name (class_id_string).value
				if class_name /= Void and class_id /= Void then
					group_id := node.attribute_by_name (group_id_string).value
					if group_id /= Void then
						cluster_found := group_of_id (group_id)
						if cluster_found /= Void then
							l_classes := cluster_found.class_by_name (class_name, False)
							if not l_classes.is_empty then
								class_found ?= l_classes.first
							end
							if class_found /= Void then
								create {ES_CLASS} Result.make_with_id (class_found, class_id)
							else
								put_class_not_exist_warning (class_name, group_id)
							end
						else
							put_cluster_not_exist_warning (group_id)
						end
					else
						xml_routines.display_error_message ("class " + class_name + " " + group_id_string + " attribute expected")
					end
				else
					xml_routines.display_error_message ("class? " + name_string + ", " + class_id_string + " attributes expected")
				end
			elseif node_name.is_equal (xml_cluster_figure_node_name) then
				group_id := node.attribute_by_name (group_id_string).value
				cluster_id := node.attribute_by_name (cluster_id_string).value
				if group_id /= Void and then cluster_id /= Void then
					cluster_found := group_of_id (group_id)
					if cluster_found /= Void then
						create {ES_CLUSTER} Result.make_with_id (cluster_found, cluster_id)
					else
						put_cluster_not_exist_warning (group_id)
					end
				else
					xml_routines.display_error_message ("cluster? " + group_id_string + ", " + cluster_id_string + " attribute expected")
				end
			elseif node_name.is_equal (xml_client_supplier_figure_node_name) or else node_name.is_equal (xml_inheritance_figure_node_name) then
				source_name := node.attribute_by_name (source_string).value
				if source_name /= Void then
					target_name := node.attribute_by_name (target_string).value
					if target_name /= Void then
						source := l_world.model.class_of_id (source_name)
						target := l_world.model.class_of_id (target_name)
						if source /= Void and target /= Void then
							if node_name.is_equal (xml_client_supplier_figure_node_name) then
								if source.has_supplier (target) then
									create {ES_CLIENT_SUPPLIER_LINK} Result.make (source, target)
								end
							else
								create {ES_INHERITANCE_LINK} Result.make_with_classes (source, target)
							end
						end
					else
						xml_routines.display_error_message ("TARGET name attribute expected")
					end
				else
					xml_routines.display_error_message ("SOURCE name attribute expected")
				end
			end
		end

feature {NONE} -- Implementation

	xml_class_figure_node_name: STRING is
			-- Name of xml nodes describing class figures.
		deferred
		end

	xml_cluster_figure_node_name: STRING is
			-- Name of xml nodes describing cluster figures.
		deferred
		end

	xml_client_supplier_figure_node_name: STRING is
			-- Name of xml nodes describing client supplier links.
		deferred
		end

	xml_inheritance_figure_node_name: STRING is
			-- Name of xml nodes describing inheritance links.
		deferred
		end

	put_class_not_exist_warning (class_name: STRING; group_id: STRING) is
			-- Put a waring on the screen that class with `class_name' does not exist in the system.
		local
			l_output_manager: EB_OUTPUT_MANAGER
		do
			l_output_manager := world.context_editor.development_window.output_manager
			l_output_manager.add_indexing_string ("Loading diagram:")
			l_output_manager.add_new_line
			l_output_manager.add_indent
			l_output_manager.add_string ("Class " + class_name + " is not in " + group_id + " anymore.")
			l_output_manager.add_new_line
		end

	put_cluster_not_exist_warning (cluster_name: STRING) is
			-- Put a warning on the screen saying that class with `cluster_name'
		local
			l_output_manager: EB_OUTPUT_MANAGER
		do
			l_output_manager := world.context_editor.development_window.output_manager
			l_output_manager.add_indexing_string ("Loading diagram:")
			l_output_manager.add_new_line
			l_output_manager.add_indent
			l_output_manager.add_string ("Cluster " + cluster_name + " is not in the system anymore.")
			l_output_manager.add_new_line
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

end -- class EIFFEL_FACTORY
