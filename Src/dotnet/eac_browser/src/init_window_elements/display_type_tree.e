indexing
	description: "Print in output the eiffel type with all its eiffel features corresponding to the given dotnet type name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_TYPE_TREE

inherit
	ICON_PATH
	SIGNATURE

create
	make

feature {NONE} -- Initialization

	make (a_parent_window: MAIN_WINDOW_IMP) is
			-- Initialiaze attributes with `a_parent_window'.
		require
			non_void_a_parent_window: a_parent_window /= Void
		do
			parent_window := a_parent_window
			right_tree := a_parent_window.right_tree
		ensure
			parent_window_set: parent_window = a_parent_window
			right_tree_set: right_tree = a_parent_window.right_tree
		end

feature -- Access

	parent_window: MAIN_WINDOW_IMP
			-- parent window.

	right_tree: EV_TREE
			-- right tree to print type.
	
	assembly_of_type: CONSUMED_ASSEMBLY
			-- Assembly_of_type.
		
feature -- Basic Operations

	print_type (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_full_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
		do
			assembly_of_type := assembly_of_dotnet_type
			display (assembly_of_dotnet_type, a_full_dotnet_type_name)
		end

	print_type_imediat_features (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_full_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
		local
			i: INTEGER
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			l_node: EV_COMPARABLE_TREE_ITEM
			l_entities: ARRAY [CONSUMED_ENTITY]
			l_feature, l_field: CONSUMED_MEMBER
			l_property: CONSUMED_PROPERTY
			l_event: CONSUMED_EVENT
			l_fields: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
			l_features: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
			l_properties: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
			l_events: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
			assembly_of_type := assembly_of_dotnet_type
			
			right_tree.wipe_out
			create eac
			ct := eac.consumed_type (assembly_of_dotnet_type, a_full_dotnet_type_name);

				-- Set current type.
			(create {SESSION}).set_current_type (ct);
				-- Enable sensitive informations tag.
			parent_window.notebook.i_th (4).enable_sensitive

			l_entities := ct.entities
			from
				i := 1
				create l_features.make
				create l_properties.make
				create l_events.make
			until
				i > l_entities.count
			loop
				if l_entities.item (i).is_method or l_entities.item (i).is_field then
					l_feature ?= l_entities.item (i)
					if l_feature /= Void then
						l_node := initialize_tree_item_feature (l_feature, a_full_dotnet_type_name)
						l_features.extend (l_node)
					end
				elseif l_entities.item (i).is_property then
					l_property ?= l_entities.item (i)
					if l_property /= Void then
						l_node := initialize_tree_item_property (l_property, a_full_dotnet_type_name)
						l_properties.extend (l_node)
					end
				elseif l_entities.item (i).is_field then
					l_field ?= l_entities.item (i)
					if l_feature /= Void then
						l_node := initialize_tree_item_feature (l_field, a_full_dotnet_type_name)
						l_features.extend (l_node)
					end
				elseif l_entities.item (i).is_event then
					l_event ?= l_entities.item (i)
					if l_event /= Void then
						l_node := initialize_tree_item_event (l_event, a_full_dotnet_type_name)
						l_events.extend (l_node)
					end
				end

				i := i + 1
			end
			right_tree.append (classify_tree_nodes (l_features))
			right_tree.append (classify_tree_nodes (l_properties))
			right_tree.append (classify_tree_nodes (l_events))
		end

	print_type_inherited_features (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_full_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
		local
			i: INTEGER
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			l_node: EV_COMPARABLE_TREE_ITEM
			l_inherited_entities: ARRAY [CONSUMED_ENTITY]
			l_entity: CONSUMED_ENTITY
			l_property: CONSUMED_PROPERTY
			l_event: CONSUMED_EVENT
			l_feature: CONSUMED_MEMBER
			l_inherited_features: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
			assembly_of_type := assembly_of_dotnet_type
			
			right_tree.wipe_out
			create eac
			ct := eac.consumed_type (assembly_of_dotnet_type, a_full_dotnet_type_name)
			l_inherited_entities := ct.inherited_entities
			from
				i := 1
				create l_inherited_features.make
			until
				i > l_inherited_entities.count
			loop
				l_feature ?= l_inherited_entities.item (i)
				if l_feature /= Void then
					l_node := initialize_tree_item_feature (l_feature, a_full_dotnet_type_name)
				else
					l_property ?= l_inherited_entities.item (i)
					if l_property /= Void then
						l_node := initialize_tree_item_property (l_property, a_full_dotnet_type_name)
					else
						l_event ?= l_inherited_entities.item (i)
						if l_event /= Void then
							l_node := initialize_tree_item_event (l_event, a_full_dotnet_type_name)
						end
					end
				end
				if l_node /= Void then
					l_inherited_features.extend (l_node)
				end
				i := i + 1
			end
			right_tree.append (classify_tree_nodes (l_inherited_features))				
		end

	print_constructors (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_full_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
		local
			i: INTEGER
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			l_constructor_node: EV_COMPARABLE_TREE_ITEM
			l_ico: EV_PIXMAP
			l_constructors_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
			assembly_of_type := assembly_of_dotnet_type
			
			right_tree.wipe_out
			create eac
			ct := eac.consumed_type (assembly_of_dotnet_type, a_full_dotnet_type_name)
			if ct /= Void then
				l_ico := load_icon (Path_icon_constructor)
				from
					i := 1
					create l_constructors_list.make
				until
					ct.constructors = Void
					or else i > ct.constructors.count
				loop
					create l_constructor_node.make_with_text (eiffel_signature_constructor (assembly_of_dotnet_type, ct.constructors.item (i)))
					l_constructor_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_constructor_information (assembly_of_type, ct.constructors.item (i), a_full_dotnet_type_name))
					if l_ico /= Void then
						l_constructor_node.set_pixmap (l_ico)
					end
					
					l_constructors_list.extend (l_constructor_node)
					i := i + 1
				end
				right_tree.append (classify_tree_nodes (l_constructors_list))
			end
		end

	print_all_features (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_full_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
		local
			i: INTEGER
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			l_tree_item: EV_COMPARABLE_TREE_ITEM
			path: CACHE_PATH
			l_methods_list, l_properties_list, l_events_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
			assembly_of_type := assembly_of_dotnet_type

			right_tree.wipe_out
			create eac
			create path
			ct := eac.consumed_type (assembly_of_dotnet_type, a_full_dotnet_type_name)
			if ct /= Void then
				from
					i := 1
					create l_methods_list.make
				until
					ct.fields = Void
					or else i > ct.fields.count
				loop
					l_tree_item := initialize_tree_item_feature (ct.fields.item (i), a_full_dotnet_type_name)
	
					l_methods_list.extend (l_tree_item)
					i := i + 1
				end

				from
					i := 1
				until
					ct.procedures = Void
					or else i > ct.procedures.count
				loop
					if not ct.procedures.item (i).is_property_or_event then
						l_tree_item := initialize_tree_item_feature (ct.procedures.item (i), a_full_dotnet_type_name)
						l_methods_list.extend (l_tree_item)
					end

					i := i + 1
				end

				from
					i := 1
				until
					ct.functions = Void
					or else i > ct.functions.count
				loop
					if not ct.functions.item (i).is_property_or_event then
						l_tree_item := initialize_tree_item_feature (ct.functions.item (i), a_full_dotnet_type_name)
						l_methods_list.extend (l_tree_item)
					end
	
					i := i + 1
				end
				right_tree.append (classify_tree_nodes (l_methods_list))

				from
					i := 1
					create l_properties_list.make
				until
					ct.properties = Void
					or else i > ct.properties.count
				loop
					l_tree_item := initialize_tree_item_property (ct.properties.item (i), a_full_dotnet_type_name)
	
					l_properties_list.extend (l_tree_item)
					i := i + 1
				end
				right_tree.append (classify_tree_nodes (l_properties_list))

				from
					i := 1
					create l_events_list.make
				until
					ct.events = Void
					or else i > ct.events.count
				loop
					l_tree_item := initialize_tree_item_event (ct.events.item (i), a_full_dotnet_type_name)
	
					l_events_list.extend (l_tree_item)
					i := i + 1
				end
				right_tree.append (classify_tree_nodes (l_events_list))
			end
		end


feature {NONE} -- Implementation

	display (an_assembly: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- add feature contained in `a_dotnet_type_name' to `right_tree'.
			-- add double click action on each type_item to be editable.
		require
		local
			i: INTEGER
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			l_ico: EV_PIXMAP
			l_tree_item: EV_COMPARABLE_TREE_ITEM
			path: CACHE_PATH
			l_constructors_node, l_attributes_node, l_features_node, l_properties_node, l_events_node: EV_TREE_ITEM
			l_constructors_list, l_fields_list, l_procedures_list, l_functions_list, l_properties_list, l_events_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
			l_procedures: ARRAY [CONSUMED_PROCEDURE]
			l_functions: ARRAY [CONSUMED_FUNCTION]
		do
			right_tree.wipe_out
			create eac
			create path
			ct := eac.consumed_type (an_assembly, a_full_dotnet_type_name)
			if ct /= Void then
				from
					i := 1
					create l_constructors_list.make
				until
					ct.constructors = Void
					or else i > ct.constructors.count
				loop
					l_tree_item := initialize_tree_item_constructor (ct.constructors.item (i), a_full_dotnet_type_name)
					
					l_constructors_list.extend (l_tree_item)
					i := i + 1
				end
				create l_constructors_node.make_with_text ("Constructors")
				l_ico := load_icon (Path_icon_constructor)
				if l_ico /= Void then
					l_constructors_node.set_pixmap (l_ico)
				end
				l_constructors_node.append (classify_tree_nodes (l_constructors_list))
				right_tree.extend (l_constructors_node)
				
				from
					i := 1
					create l_fields_list.make
				until
					ct.fields = Void
					or else i > ct.fields.count
				loop
					l_tree_item := initialize_tree_item_feature (ct.fields.item (i), a_full_dotnet_type_name)
	
					l_fields_list.extend (l_tree_item)
					i := i + 1
				end
				create l_attributes_node.make_with_text ("Attributes")
				l_ico := load_icon (Path_icon_public_attribute)
				if l_ico /= Void then
					l_attributes_node.set_pixmap (l_ico)
				end
				l_attributes_node.append (classify_tree_nodes (l_fields_list))
				right_tree.extend (l_attributes_node)

				from
					i := 1
					create l_procedures_list.make
					l_procedures := ct.procedures
				until
					ct.procedures = Void
					or else i > l_procedures.count
				loop
					if not l_procedures.item (i).is_property_or_event then
						l_tree_item := initialize_tree_item_feature (l_procedures.item (i), a_full_dotnet_type_name)
						l_procedures_list.extend (l_tree_item)
					end
	
					i := i + 1
				end
				create l_features_node.make_with_text ("Features")
				l_ico := load_icon (Path_icon_constructor)
				if l_ico /= Void then
					l_features_node.set_pixmap (l_ico)
				end
				l_features_node.append (classify_tree_nodes (l_procedures_list))

				from
					i := 1
					create l_functions_list.make
					l_functions := ct.functions
				until
					ct.functions = Void
					or else i > l_functions.count
				loop
					if not l_functions.item (i).is_property_or_event then
						l_tree_item := initialize_tree_item_feature (l_functions.item (i), a_full_dotnet_type_name)
						l_functions_list.extend (l_tree_item)
					end
	
					i := i + 1
				end
				l_ico := load_icon (Path_icon_constructor)
				if l_ico /= Void then
					l_features_node.set_pixmap (l_ico)
				end
				l_features_node.append (classify_tree_nodes (l_functions_list))
				right_tree.extend (l_features_node)

				from
					i := 1
					create l_properties_list.make
				until
					ct.properties = Void
					or else i > ct.properties.count
				loop
					l_tree_item := initialize_tree_item_property (ct.properties.item (i), a_full_dotnet_type_name)
	
					l_properties_list.extend (l_tree_item)
					i := i + 1
				end
				create l_properties_node.make_with_text ("Properties")
				l_ico := load_icon (Path_icon_public_property)
				if l_ico /= Void then
					l_properties_node.set_pixmap (l_ico)
				end
				l_properties_node.append (classify_tree_nodes (l_properties_list))
				right_tree.extend (l_properties_node)

				from
					i := 1
					create l_events_list.make
				until
					ct.events = Void
					or else i > ct.events.count
				loop
					l_tree_item := initialize_tree_item_event (ct.events.item (i), a_full_dotnet_type_name)
	
					l_events_list.extend (l_tree_item)
					i := i + 1
				end
				create l_events_node.make_with_text ("Events")
				l_ico := load_icon (Path_icon_public_event)
				if l_ico /= Void then
					l_events_node.set_pixmap (l_ico)
				end
				l_events_node.append (classify_tree_nodes (l_events_list))
				right_tree.extend (l_events_node)
			end
		end

	initialize_tree_item_constructor (a_member: CONSUMED_CONSTRUCTOR; a_full_dotnet_type_name: STRING): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_a_member: a_member /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			not_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_icon_path: STRING
			l_ico: EV_PIXMAP
		do
			create Result.make_with_text (eiffel_signature_constructor (assembly_of_type, a_member))

			l_icon_path := Path_icon_constructor
			
				-- Add action to node
			Result.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_constructor_information (assembly_of_type, a_member, a_full_dotnet_type_name))

				-- Add type icon.
			l_ico := load_icon (l_icon_path)
			if l_ico /= Void then
				Result.set_pixmap (l_ico)
			end
		ensure
			non_void_result: Result /= Void		
		end

	initialize_tree_item_feature (a_member: CONSUMED_MEMBER; a_full_dotnet_type_name: STRING): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_a_member: a_member /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			not_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_icon_path: STRING
			l_tree_node: EV_TREE_ITEM
			l_ico: EV_PIXMAP
			l_assembly_member: CONSUMED_ASSEMBLY
		do
			create Result.make_with_text (signature_member (a_member))

			create l_tree_node.make_with_text (eiffel_signature_member (assembly_of_type, a_member))
			Result.extend (l_tree_node)
			l_ico := load_icon (Path_eiffel_feature)
			if l_ico /= Void then
				l_tree_node.set_pixmap (l_ico)
			end
			
			if a_member.is_public then
				if a_member.is_attribute then
					if a_member.is_constant then
						l_icon_path := Path_icon_public_constant
					else
						l_icon_path := Path_icon_public_attribute
					end
				elseif a_member.is_event then
					l_icon_path := Path_icon_public_event
				elseif a_member.is_method then
					l_icon_path := Path_icon_public_function
				elseif a_member.is_property then
					l_icon_path := Path_icon_public_property
				end
			else
					-- Protected feature
				if a_member.is_attribute then
					if a_member.is_constant then
						l_icon_path := Path_icon_protected_constant
					else
						l_icon_path := Path_icon_protected_attribute
					end
				elseif a_member.is_event then
					l_icon_path := Path_icon_protected_event
				elseif a_member.is_method then
					l_icon_path := Path_icon_protected_function
				elseif a_member.is_property then
					l_icon_path := Path_icon_protected_property
				end
			end
			
				-- Add action to nodes
			Result.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_feature_information (assembly_of_type, a_member, a_full_dotnet_type_name))
			Result.expand_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_feature_information (assembly_of_type, a_member, a_full_dotnet_type_name))
			l_tree_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_feature_information (assembly_of_type, a_member, a_full_dotnet_type_name))

				-- Add type icon.
			l_ico := load_icon (l_icon_path)
			if l_ico /= Void then
				Result.set_pixmap (l_ico)
			end
		ensure
			non_void_result: Result /= Void		
		end

	initialize_tree_item_property (a_property: CONSUMED_PROPERTY; a_full_dotnet_type_name: STRING): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_a_property: a_property /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			not_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_icon_path: STRING
			l_tree_node: EV_TREE_ITEM
			l_ico: EV_PIXMAP
		do
			create Result.make_with_text (a_property.dotnet_name)

			l_ico := load_icon (Path_eiffel_feature)
			if a_property.getter /= Void then
				create l_tree_node.make_with_text (eiffel_signature_member (assembly_of_type, a_property.getter))
				Result.extend (l_tree_node)
				if l_ico /= Void then
					l_tree_node.set_pixmap (l_ico)
				end
					-- Add action to node
				l_tree_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_property_information (assembly_of_type, a_property, a_full_dotnet_type_name))
			end
			if a_property.setter /= Void then
				create l_tree_node.make_with_text (eiffel_signature_member (assembly_of_type, a_property.setter))
				Result.extend (l_tree_node)	
				if l_ico /= Void then
					l_tree_node.set_pixmap (l_ico)
				end
					-- Add action to node
				l_tree_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_property_information (assembly_of_type, a_property, a_full_dotnet_type_name))
			end
			
				-- Add action to principal node
			Result.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_property_information (assembly_of_type, a_property, a_full_dotnet_type_name))
			Result.expand_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_property_information (assembly_of_type, a_property, a_full_dotnet_type_name))

			if a_property.is_public then
				l_icon_path := Path_icon_public_property
			else
				l_icon_path := Path_icon_protected_property
			end
				-- Add type icon.
			l_ico := load_icon (l_icon_path)
			if l_ico /= Void then
				Result.set_pixmap (l_ico)
			end
		ensure
			non_void_result: Result /= Void		
		end

	initialize_tree_item_event (an_event: CONSUMED_EVENT; a_full_dotnet_type_name: STRING): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_an_event: an_event /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			not_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_icon_path: STRING
			l_ico: EV_PIXMAP
			l_tree_node: EV_TREE_ITEM
		do
			create Result.make_with_text (an_event.dotnet_name)

			l_ico := load_icon (Path_eiffel_feature)
			if an_event.raiser /= Void then
				create l_tree_node.make_with_text (eiffel_signature_member (assembly_of_type, an_event.raiser))
				Result.extend (l_tree_node)
				if l_ico /= Void then
					l_tree_node.set_pixmap (l_ico)
				end
					-- Add action to node
				l_tree_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_event_information (assembly_of_type, an_event, a_full_dotnet_type_name))
			end
			if an_event.remover /= Void then
				create l_tree_node.make_with_text (eiffel_signature_member (assembly_of_type, an_event.remover))				
				Result.extend (l_tree_node)
				if l_ico /= Void then
					l_tree_node.set_pixmap (l_ico)
				end
					-- Add action to node
				l_tree_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_event_information (assembly_of_type, an_event, a_full_dotnet_type_name))
			end
			if an_event.adder /= Void then
				create l_tree_node.make_with_text (eiffel_signature_member (assembly_of_type, an_event.adder))
				Result.extend (l_tree_node)
				if l_ico /= Void then
					l_tree_node.set_pixmap (l_ico)
				end
					-- Add action to node
				l_tree_node.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_event_information (assembly_of_type, an_event, a_full_dotnet_type_name))
			end

				-- Add action to principal node
			Result.select_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_event_information (assembly_of_type, an_event, a_full_dotnet_type_name))
			Result.expand_actions.extend (agent (create {DISPLAY_COMMENTS}.make (parent_window.edit_comments_area)).display_event_information (assembly_of_type, an_event, a_full_dotnet_type_name))

			if an_event.is_public then
				l_icon_path := Path_icon_public_event
			else
				l_icon_path := Path_icon_protected_event
			end
				-- Add type icon.
			l_ico := load_icon (l_icon_path)
			if l_ico /= Void then
				Result.set_pixmap (l_ico)
			end
		ensure
			non_void_result: Result /= Void		
		end

	classify_tree_nodes (nodes: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]): LINKED_LIST [EV_COMPARABLE_TREE_ITEM] is
			-- Classify `nodes'.
		require
			non_void_nodes: nodes /= Void
		local
			l_sortable_nodes: SORTABLE_ARRAY [EV_COMPARABLE_TREE_ITEM]
			counter: INTEGER
		do
			create l_sortable_nodes.make (1, nodes.count)
			from
				nodes.start
				counter := 1
			until
				nodes.after
			loop
				l_sortable_nodes.put (nodes.item, counter)
				counter := counter + 1
				nodes.forth
			end
			
			l_sortable_nodes.sort;
			
			from
				counter := 1
				create Result.make
			until
				counter > l_sortable_nodes.count
			loop
				Result.extend (l_sortable_nodes.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
			same_number_nodes: nodes.count = Result.count
		end

invariant
	non_void_parent_window: parent_window /= Void
	non_void_right_tree: right_tree /= Void

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


end -- class DISPLAY_TYPE_TREE

