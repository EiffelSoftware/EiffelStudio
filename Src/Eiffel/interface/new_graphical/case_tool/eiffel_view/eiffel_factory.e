note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_BENCH_NAMES
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Access

	world: EIFFEL_WORLD

	model_from_xml (node: like xml_element_type): EG_ITEM
			-- Create an EG_ITEM from `node' if possible.
		local
			node_name, class_name, source_name, target_name: STRING_32
			cluster_id, class_id, group_id: STRING_32
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
			if node_name.same_string (xml_class_figure_node_name) then
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
						xml_routines.display_error_message (warnings.w_class_attribute_expected (class_name, group_id))
					end
				else
					xml_routines.display_error_message (warnings.w_class_attributes_expected (name_string, class_id_string))
				end
			elseif node_name.same_string (xml_cluster_figure_node_name) then
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
					xml_routines.display_error_message (warnings.w_cluster_attribute_expected (group_id_string, cluster_id_string))
				end
			elseif node_name.same_string (xml_client_supplier_figure_node_name) or else node_name.same_string (xml_inheritance_figure_node_name) then
				source_name := node.attribute_by_name (source_string).value
				if source_name /= Void then
					target_name := node.attribute_by_name (target_string).value
					if target_name /= Void then
						source := l_world.model.class_of_name (source_name)
						target := l_world.model.class_of_name (target_name)
						if source /= Void and target /= Void then
							if node_name.same_string (xml_client_supplier_figure_node_name) then
								if source.has_supplier (target) then
									create {ES_CLIENT_SUPPLIER_LINK} Result.make (source, target)
								end
							else
								create {ES_INHERITANCE_LINK} Result.make (source, target, True)
							end
						end
					else
						xml_routines.display_error_message (warnings.w_target_name_attribute_expected)
					end
				else
					xml_routines.display_error_message (warnings.w_source_name_attribute_expected)
				end
			end
		end

feature {NONE} -- Implementation

	xml_class_figure_node_name: STRING
			-- Name of xml nodes describing class figures.
		deferred
		end

	xml_cluster_figure_node_name: STRING
			-- Name of xml nodes describing cluster figures.
		deferred
		end

	xml_client_supplier_figure_node_name: STRING
			-- Name of xml nodes describing client supplier links.
		deferred
		end

	xml_inheritance_figure_node_name: STRING
			-- Name of xml nodes describing inheritance links.
		deferred
		end

	put_class_not_exist_warning (class_name: STRING; group_id: STRING)
			-- Put a waring on the screen that class with `class_name' does not exist in the system.
		local
			l_formatter: like general_formatter
		do
			if attached general_output as l_output then
				l_output.lock

				l_formatter := general_formatter
				l_formatter.add_indexing_string (names.l_loading_diagram)
				l_formatter.add_new_line
				l_formatter.add_indent
				l_formatter.add_string (names.l_class_is_not_in_anymore (class_name, group_id))
				l_formatter.add_new_line

				l_output.unlock
			end
		end

	put_cluster_not_exist_warning (cluster_name: STRING)
			-- Put a warning on the screen saying that class with `cluster_name'
		local
			l_formatter: like general_formatter
		do
			if attached general_output as l_output then
				l_output.lock

				l_formatter := general_formatter
				l_formatter.add_indexing_string (names.l_Loading_diagram)
				l_formatter.add_new_line
				l_formatter.add_indent
				l_formatter.add_string (names.l_cluster_is_not_in_the_system_anymore (cluster_name))
				l_formatter.add_new_line

				l_output.unlock
			end
		end

feature {NONE} -- Constants

	name_string: STRING = "NAME"
	cluster_name_string: STRING = "CLUSTER_NAME"
	source_string: STRING = "SOURCE"
	target_string: STRING = "TARGET"
	source_cluster_string: STRING = "SOURCE_CLUSTER"
	target_cluster_string: STRING = "TARGET_CLUSTER"
	class_id_string: STRING = "CLASS_FIGURE_ID"
	group_id_string: STRING = "GROUP_ID"
	cluster_id_string: STRING = "CLUSTER_ID"
		-- Xml string constants

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
