indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_FACTORY

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

feature -- Basic operations

	new_class_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE is
			-- Create a node figure for `a_node'.
		local
			ec: ES_CLASS
		do
			ec ?= a_node
			if ec /= Void then
				Result := create {UML_CLASS_FIGURE}.make_with_model (ec)
				if not ec.is_needed_on_diagram then
					Result.hide
					Result.disable_sensitive
				end
			else
				Result := create {EG_SIMPLE_NODE}.make_with_model (a_node)
			end
		end
		
	new_cluster_figure (a_cluster: EG_CLUSTER): EG_CLUSTER_FIGURE is
			-- Create a cluster figure for `a_cluster'.
		local
			ec: ES_CLUSTER
		do
			ec ?= a_cluster
			if ec /= Void then
				Result := create {UML_CLUSTER_FIGURE}.make_with_model (ec)
				if not ec.is_needed_on_diagram then
					Result.hide
					Result.disable_sensitive
				end
			else
				Result := create {EG_SIMPLE_CLUSTER}.make_with_model (a_cluster)
			end
		end
		
	model_from_xml (node: XM_ELEMENT): EG_ITEM is
			-- Create an EG_ITEM from `node' if possible.
		local
			node_name, class_name, cluster_name, source_name, target_name, target_cluster_name, source_cluster_name: STRING
			cluster_found, source_cluster, target_cluster: CLUSTER_I
			class_found, target_found, source_found: CLASS_I
			source, target, new_class: ES_CLASS
			new_cluster: ES_CLUSTER
		do
			node_name := node.name
			if node_name.is_equal ("UML_CLASS_FIGURE") then
				class_name := node.attribute_by_name ("NAME").value
				if class_name /= Void then				
					cluster_name := node.attribute_by_name ("CLUSTER_NAME").value
					if cluster_name /= Void then
						cluster_found := universe.cluster_of_name (cluster_name)
						if cluster_found /= Void then
							class_found := universe.class_named (class_name, cluster_found)
							if class_found /= Void then
								new_class := world.model.class_from_interface (class_found)
								if new_class = Void then
									create {ES_CLASS} Result.make (class_found)
								else
									new_class.links.wipe_out
								end
							else
								xml_routines.display_warning_message ("Class " + class_name + " not in the system")
							end
						else
							xml_routines.display_warning_message ("Cluster " + cluster_name + " not in the system")
						end
					else
						xml_routines.display_error_message ("class " + class_name + " CLUSTER_NAME attribute expected")
					end
				else
					xml_routines.display_error_message ("class? NAME attribute expected")
				end
			elseif node_name.is_equal ("UML_CLUSTER_FIGURE") then
				cluster_name := node.attribute_by_name ("NAME").value
				if cluster_name /= Void then
					cluster_found := universe.cluster_of_name (cluster_name)
					if cluster_found /= Void then
						new_cluster := world.model.cluster_from_interface (cluster_found)
						if new_cluster = Void then
							create {ES_CLUSTER} Result.make (cluster_found)
						else
							new_cluster.links.wipe_out
							new_cluster.linkables.wipe_out
						end
					else
						xml_routines.display_warning_message ("Cluster " + cluster_name + " not in the system")
					end
				else
					xml_routines.display_error_message ("cluster? NAME attribute expected")
				end
			elseif node_name.is_equal ("UML_CLIENT_SUPPLIER_FIGURE") or else node_name.is_equal ("UML_INHERITANCE_FIGURE") then
				source_name := node.attribute_by_name ("SOURCE").value
				if source_name /= Void then
					target_name := node.attribute_by_name ("TARGET").value
					if target_name /= Void then
						source_cluster_name := node.attribute_by_name ("SOURCE_CLUSTER").value
						if source_cluster_name /= Void then
							target_cluster_name := node.attribute_by_name ("TARGET_CLUSTER").value
							if target_cluster_name /= Void then
								source_cluster := universe.cluster_of_name (source_cluster_name)
								target_cluster := universe.cluster_of_name (target_cluster_name)
								if source_cluster /= Void and target_cluster /= Void then
									source_found := universe.class_named (source_name, source_cluster)
									target_found := universe.class_named (target_name, target_cluster)
									if source_found /= Void and target_found /= Void then
										source := world.model.class_from_interface (source_found)
										target := world.model.class_from_interface (target_found)
										if source /= Void and then target /= Void then
											if node_name.is_equal ("UML_CLIENT_SUPPLIER_FIGURE") then
												Result := world.model.client_supplier_link_connecting (source, target)
												if Result = Void then
													create {ES_CLIENT_SUPPLIER_LINK} Result.make (source, target)
												end
											else
												Result := world.model.inheritance_link_connecting (source, target)
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
		
	new_link_figure (a_link: EG_LINK): EG_LINK_FIGURE is
			-- Create a link figure for `a_link'.
		local
			eih: ES_INHERITANCE_LINK
			ecs: ES_CLIENT_SUPPLIER_LINK
		do
			eih ?= a_link
			if eih /= Void then
				Result := new_inheritance_figure (eih)
				if not eih.is_needed_on_diagram then
					Result.hide
					Result.disable_sensitive
				end
			else
				ecs ?= a_link
				if ecs /= Void then
					Result := new_client_supplier_figure (ecs)
					if not ecs.is_needed_on_diagram then
						Result.hide
						Result.disable_sensitive
					end
				else
					Result := create {EG_SIMPLE_LINK}.make_with_model (a_link)
				end
			end
		end
		
	new_inheritance_figure (eih: ES_INHERITANCE_LINK): UML_INHERITANCE_FIGURE is
			-- Create an inheritance figure.
		require
			eih_not_void: eih /= Void
		do
			create Result.make_with_model (eih)
		ensure
			result_not_void: Result /= Void
		end
		
	new_client_supplier_figure (ecs: ES_CLIENT_SUPPLIER_LINK): UML_CLIENT_SUPPLIER_FIGURE is
			-- Create a client supplier figure.
		require
			ecs_not_void: ecs /= Void
		do
			create Result.make_with_model (ecs)
		ensure
			result_not_void: Result /= Void
		end

end -- class UML_FACTORY
