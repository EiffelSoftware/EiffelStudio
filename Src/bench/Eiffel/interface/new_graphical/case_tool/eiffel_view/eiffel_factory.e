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
	
feature -- Access

	world: EIFFEL_WORLD
	
	name_string: STRING is "NAME"
	cluster_name_string: STRING is "CLUSTER_NAME"
	source_string: STRING is "SOURCE"
	target_string: STRING is "TARGET"
	source_cluster_string: STRING is "SOURCE_CLUSTER"
	target_cluster_string: STRING is "TARGET_CLUSTER"
		-- Xml string constants
	
	model_from_xml (node: XM_ELEMENT): EG_ITEM is
			-- Create an EG_ITEM from `node' if possible.
		local
			node_name, class_name, cluster_name, source_name, target_name, target_cluster_name, source_cluster_name: STRING
			cluster_found, source_cluster, target_cluster: CLUSTER_I
			class_found, target_found, source_found: CLASS_I
			source, target, new_class: ES_CLASS
			new_cluster: ES_CLUSTER
			l_world: like world
			l_universe: like universe
		do
			l_world := world
			l_universe := universe
			node_name := node.name
			if node_name.is_equal (xml_class_figure_node_name) then
				class_name := node.attribute_by_name (name_string).value
				if class_name /= Void then				
					cluster_name := node.attribute_by_name (cluster_name_string).value
					if cluster_name /= Void then
						cluster_found := l_universe.cluster_of_name (cluster_name)
						if cluster_found /= Void then
							class_found := l_universe.class_named (class_name, cluster_found)
							if class_found /= Void then
								new_class := l_world.model.class_from_interface (class_found)
								if new_class = Void then
									create {ES_CLASS} Result.make (class_found)
								else
									new_class.links.wipe_out
								end
							else
								put_class_not_exist_warning (class_name)
							end
						else
							put_cluster_not_exist_warning (cluster_name)
						end
					else
						xml_routines.display_error_message ("class " + class_name + " CLUSTER_NAME attribute expected")
					end
				else
					xml_routines.display_error_message ("class? NAME attribute expected")
				end
			elseif node_name.is_equal (xml_cluster_figure_node_name) then
				cluster_name := node.attribute_by_name (name_string).value
				if cluster_name /= Void then
					cluster_found := l_universe.cluster_of_name (cluster_name)
					if cluster_found /= Void then
						new_cluster := l_world.model.cluster_from_interface (cluster_found)
						if new_cluster = Void then
							create {ES_CLUSTER} Result.make (cluster_found)
						else
							new_cluster.links.wipe_out
							new_cluster.linkables.wipe_out
						end
					else
						put_cluster_not_exist_warning (cluster_name)
					end
				else
					xml_routines.display_error_message ("cluster? NAME attribute expected")
				end
			elseif node_name.is_equal (xml_client_supplier_figure_node_name) or else node_name.is_equal (xml_inheritance_figure_node_name) then
				source_name := node.attribute_by_name (source_string).value
				if source_name /= Void then
					target_name := node.attribute_by_name (target_string).value
					if target_name /= Void then
						source_cluster_name := node.attribute_by_name (source_cluster_string).value
						if source_cluster_name /= Void then
							target_cluster_name := node.attribute_by_name (target_cluster_string).value
							if target_cluster_name /= Void then
								source_cluster := l_universe.cluster_of_name (source_cluster_name)
								target_cluster := l_universe.cluster_of_name (target_cluster_name)
								if source_cluster /= Void and target_cluster /= Void then
									source_found := l_universe.class_named (source_name, source_cluster)
									target_found := l_universe.class_named (target_name, target_cluster)
									if source_found /= Void and target_found /= Void then
										source := l_world.model.class_from_interface (source_found)
										target := l_world.model.class_from_interface (target_found)
										if source /= Void and then target /= Void then
											if node_name.is_equal (xml_client_supplier_figure_node_name) then
												if source.has_supplier (target) then
													Result := l_world.model.client_supplier_link_connecting (source, target)
													if Result = Void then
														create {ES_CLIENT_SUPPLIER_LINK} Result.make (source, target)
													end
												end
											else
												Result := l_world.model.inheritance_link_connecting (source, target)
												if Result = Void then
													create {ES_INHERITANCE_LINK} Result.make_with_classes (source, target)
												end
											end
										end
									end
								end
							else
								xml_routines.display_error_message ("TARGET_CLUSTER name attribute expected")
							end
						else
							xml_routines.display_error_message ("SOURCE_CLUSTER name attribute expected")
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
		
	put_class_not_exist_warning (class_name: STRING) is
			-- Put a waring on the screen that class with `class_name' does not exist in the system.
		local
			l_text: STRUCTURED_TEXT
		do
			create l_text.make
			l_text.add_indexing_string ("Loading diagram:")
			l_text.add_new_line
			l_text.add_indent
			l_text.add_string ("Class " + class_name + " is not in the system anymore.")
			l_text.add_new_line
			world.context_editor.development_window.output_manager.process_text (l_text)
		end
		
	put_cluster_not_exist_warning (cluster_name: STRING) is
			-- Put a warning on the screen saying that class with `cluster_name' 
		local
			l_text: STRUCTURED_TEXT
		do
			create l_text.make
			l_text.add_indexing_string ("Loading diagram:")
			l_text.add_new_line
			l_text.add_indent
			l_text.add_string ("Cluster " + cluster_name + " is not in the system anymore.")
			l_text.add_new_line
			world.context_editor.development_window.output_manager.process_text (l_text)
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

end -- class EIFFEL_FACTORY
