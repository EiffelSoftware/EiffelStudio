indexing
	description: "Print in output the eiffel type with all its eiffelfeatures corresponding to given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_FACTORY

inherit
	CACHE_PATH
	ICON_PATH
--	TREE_ACTION
--	CACHE

create
	make
	
feature {NONE} -- Initialization

 	make (a_window: MAIN_WINDOW_IMP) is
 			-- Initialize `parent_window'.
 		require
 			non_void_a_window: a_window /= Void
 		do
 			parent_window := a_window
 		ensure
 			current_window_set: parent_window = a_window implies parent_window /= Void
 		end
 		
 feature {NONE}	-- Access

	parent_window: MAIN_WINDOW_IMP
			-- current window.
			
	edit: EDIT_FACTORY is
			-- edtion area.
		once
			create Result.make (parent_window)
		end

feature {MAIN_WINDOW} -- Initialization tree

	initialize is
			-- Add widgets to `widget_tree'.
		local
			tree_item, tree_item1: EV_COMPARABLE_TREE_ITEM
			eac: EAC_BROWSER
			ci: CACHE_INFO
			counter: INTEGER
			path: CACHE_PATH
--			cache: CACHE
			l_ico: EV_PIXMAP
			unclassified_assemblies: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
--			create tree_item.make_with_text ("Eiffel Assembly Cache")
			create tree_item
			tree_item.set_text ("Eiffel Assembly Cache")
			tree_item.select_actions.extend (agent edit.edit_info_assemblies)
			create l_ico
			l_ico.set_with_named_file (Path_icon_eac) 
			tree_item.set_pixmap (l_ico)
			parent_window.widget_tree.extend (tree_item)
			
			create eac
			create path
--			create cache
			ci := eac.info
			from 
				counter := 1
				create unclassified_assemblies.make
			until
				ci = Void
				or else counter > ci.assemblies.count
			loop
				tree_item1 := initialize_tree_item_assembly (ci.assemblies.item (counter)) 
				unclassified_assemblies.extend (tree_item1)
--				cache.Assemblies.extend (ci.assemblies.item (counter))

				counter := counter + 1
			end

			tree_item.append (classify_assemblies (unclassified_assemblies))

			tree_item.expand
			edit.edit_info_assemblies
			
				-- Set accelerator when enter or F2 are pressed.
			parent_window.widget_tree.key_press_actions.extend (agent on_key_pressed (?))
		end

feature {NONE} -- Add element to tree

	add_namespaces_branches (an_assembly: CONSUMED_ASSEMBLY; tree_item_parent: EV_TREE_ITEM) is
			-- initialize widget_tree if not allready done.
			-- Add classes in cache.
			-- add click action on each assembly_item to see its informations in `edit_area'.
			-- add expand action on each assembly_item to see its namesapces in the tree.
		require
			non_void_assembly: an_assembly /= Void
			non_void_tree_item_parent: tree_item_parent /= Void
		local
			counter: INTEGER
			l_item: EV_COMPARABLE_TREE_ITEM
			tree_buffer: SORTABLE_ARRAY [STRING]
			eac: EAC_BROWSER
			cat: CONSUMED_ASSEMBLY_TYPES
			full_dotnet_type_name: STRING
			path: CACHE_PATH
			a_file_name: STRING
			cache: CACHE
			des_dlg: DESERIALIZATION_DIALOG
		do
				-- Is it allready initilized?
			if tree_item_parent.is_empty or tree_item_parent.count = 1 then
				create des_dlg
				des_dlg.show_relative_to_window (parent_window);
				(create {EV_ENVIRONMENT}).application.process_events

				if tree_item_parent.count = 1 then
						-- remove element that served to show the cross to expand tree.
					tree_item_parent.first.destroy
				end
				
				create eac
				create path
				a_file_name := path.absolute_info_assembly_path (an_assembly)
				cat := eac.consumed_assembly (an_assembly)
				from
					counter := 1
					create cache
					create tree_buffer.make (1, cat.dotnet_names.count)
				until
					counter > cat.dotnet_names.count
				loop
					des_dlg.set_progress_bar ((counter * 80 / cat.dotnet_names.count).rounded)

					full_dotnet_type_name := cat.dotnet_names.item (counter)
					tree_buffer.put (full_dotnet_type_name, counter)
						-- add type in cache
					if not cache.Types.has (full_dotnet_type_name) then
						cache.Types.extend (cat.eiffel_names.item (counter), full_dotnet_type_name)
					end
					counter := counter + 1
				end
				
				tree_item_parent.append (find_namespaces (an_assembly, tree_buffer))

				des_dlg.destroy
			end
--			edit.edit_info_assembly (an_assembly)
		end		

	find_namespaces (an_assembly: CONSUMED_ASSEMBLY; a_tree: SORTABLE_ARRAY [STRING]): LINKED_LIST [EV_TREE_ITEM] is
			-- add branches corresponding to namespaces contained in `tree' to `parent_node'.
			-- add is in alphabetical order through `classify_namespaces'.
			-- add click action on each namespace_item to see its features in the tree.
		require
			non_void_a_tree: a_tree /= Void
			not_empty_a_tree: a_tree.count > 0
		local
			counter: INTEGER
			full_dotnet_type_name: STRING
			tree_item_namespace, tree_item_type: EV_COMPARABLE_TREE_ITEM
			namespaces: HASH_TABLE [LINKED_LIST [EV_COMPARABLE_TREE_ITEM], STRING]
			index_of_last_point: INTEGER
			namespace_name: STRING
			a_types_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
			l_ico: EV_PIXMAP
			unclassified_namespaces: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
			create namespaces.make (100)
			from
				counter := 1
			until
				counter > a_tree.count
			loop
				full_dotnet_type_name := a_tree.item (counter)
				index_of_last_point := full_dotnet_type_name.last_index_of ('.', full_dotnet_type_name.count)
				namespace_name := full_dotnet_type_name.substring (1, index_of_last_point - 1)
				if namespaces.has (namespace_name) then
					tree_item_type := initialize_tree_item_type (an_assembly, a_tree.item (counter))
					namespaces.item (namespace_name).extend (tree_item_type)
				else
					namespaces.put (create {LINKED_LIST [EV_COMPARABLE_TREE_ITEM]}.make, namespace_name)
					tree_item_type := initialize_tree_item_type (an_assembly, a_tree.item (counter))
					namespaces.item (namespace_name).extend (tree_item_type)
				end

				counter := counter + 1
			end
			
			from
				namespaces.start
				create unclassified_namespaces.make
			until
				namespaces.after
			loop
				a_types_list := namespaces.item_for_iteration
				if a_types_list /= Void then
					create tree_item_namespace
					tree_item_namespace.set_text (namespaces.key_for_iteration)
					add_types_branches (tree_item_namespace, a_types_list)
			
						-- Add namespace icone.
					create l_ico
					l_ico.set_with_named_file (Path_icon_namespace)
					tree_item_namespace.set_pixmap (l_ico)
					
					unclassified_namespaces.extend (tree_item_namespace)
				end
				namespaces.forth
			end
			
			Result := classify_namespaces (unclassified_namespaces)
		ensure
			non_void_result: Result /= Void
		end

	add_types_branches (a_tree_item_namespace: EV_TREE_ITEM; a_types_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]) is
			-- add type contained in `tree' to `tree_item_parent'.
			-- add click action on each type_item to see its contain in edit_area.
			-- add expand action on each type_item to see its features in the tree.
		require
			non_void_tree_item_namespace: a_tree_item_namespace /= Void
			non_void_a_types_list: a_types_list /= Void
		do
			a_tree_item_namespace.append (classify_types (a_types_list))
		end



--	add_namespaces_branches (an_assembly: CONSUMED_ASSEMBLY; tree_item_parent: EV_TREE_ITEM) is
--			-- initialize widget_tree if not allready done.
--			-- Add classes in cache.
--			-- add click action on each assembly_item to see its informations in `edit_area'.
--			-- add expand action on each assembly_item to see its namesapces in the tree.
--		require
--			non_void_assembly: an_assembly /= Void
--			non_void_tree_item_parent: tree_item_parent /= Void
--		local
--			counter: INTEGER
--			tree_buffer: SORTABLE_ARRAY [STRING]
--			eac: EAC_BROWSER
--			cat: CONSUMED_ASSEMBLY_TYPES
--			full_dotnet_type_name: STRING
--			path: CACHE_PATH
--			a_file_name: STRING
--			cache: CACHE
--			des_dlg: DESERIALIZATION_DIALOG
--		do
--				-- Is it allready initilized?
--			if tree_item_parent.is_empty or tree_item_parent.count = 1 then
--				create des_dlg
--				des_dlg.show_relative_to_window (parent_window);
--				(create {EV_ENVIRONMENT}).application.process_events
--
--				if tree_item_parent.count = 1 then
--						-- remove element that served to show the cross to expand tree.
--					tree_item_parent.first.destroy
--				end
--				
--				create eac
--				create path
--				a_file_name := path.absolute_info_assembly_path (an_assembly)
--				cat := eac.consumed_assembly (a_file_name)
--				from
--					counter := 1
--					create cache
--					create tree_buffer.make (1, cat.dotnet_names.count)
--				until
--					counter > cat.dotnet_names.count
--				loop
--					des_dlg.set_progress_bar ((counter * 80 / cat.dotnet_names.count).rounded)
--
--					full_dotnet_type_name := cat.dotnet_names.item (counter)
--					tree_buffer.put (full_dotnet_type_name, counter)
--						-- add type in cache
--					if not cache.Types.has (full_dotnet_type_name) then
--						cache.Types.extend (cat.eiffel_names.item (counter), full_dotnet_type_name)
--					end
--					counter := counter + 1
--				end
--				
--				tree_item_parent.append (find_namespaces (an_assembly, tree_buffer))
--
--				des_dlg.destroy
--			end
--			edit.edit_info_assembly (an_assembly)
--		end		
--
--	find_namespaces (an_assembly: CONSUMED_ASSEMBLY; a_tree: SORTABLE_ARRAY [STRING]): LINKED_LIST [EV_TREE_ITEM] is
--			-- add branches corresponding to namespaces contained in `tree' to `parent_node'.
--			-- add is in alphabetical order through `classify_namespaces'.
--			-- add click action on each namespace_item to see its features in the tree.
--		require
--			non_void_a_tree: a_tree /= Void
--			not_empty_a_tree: a_tree.count > 0
--		local
--			counter: INTEGER
--			full_dotnet_type_name: STRING
--			tree_item_namespace, tree_item_type: EV_COMPARABLE_TREE_ITEM
--			namespaces: HASH_TABLE [LINKED_LIST [EV_COMPARABLE_TREE_ITEM], STRING]
--			index_of_last_point: INTEGER
--			namespace_name: STRING
--			a_types_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
--			l_ico: EV_PIXMAP
--			unclassified_namespaces: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
--		do
--			create namespaces.make (100)
--			from
--				counter := 1
--			until
--				counter > a_tree.count
--			loop
--				full_dotnet_type_name := a_tree.item (counter)
--				index_of_last_point := full_dotnet_type_name.last_index_of ('.', full_dotnet_type_name.count)
--				namespace_name := full_dotnet_type_name.substring (1, index_of_last_point - 1)
--				if namespaces.has (namespace_name) then
--					tree_item_type := initialize_tree_item_type (an_assembly, a_tree.item (counter))
--					namespaces.item (namespace_name).extend (tree_item_type)
--				else
--					namespaces.put (create {LINKED_LIST [EV_COMPARABLE_TREE_ITEM]}.make, namespace_name)
--					tree_item_type := initialize_tree_item_type (an_assembly, a_tree.item (counter))
--					namespaces.item (namespace_name).extend (tree_item_type)
--				end
--
--				counter := counter + 1
--			end
--			
--			from
--				namespaces.start
--				create unclassified_namespaces.make
--			until
--				namespaces.after
--			loop
--				a_types_list := namespaces.item_for_iteration
--				if a_types_list /= Void then
--					create tree_item_namespace
--					tree_item_namespace.set_text (namespaces.key_for_iteration)
--					add_types_branches (tree_item_namespace, a_types_list)
--			
--						-- Add namespace icone.
--					create l_ico
--					l_ico.set_with_named_file (Path_icon_namespace)
--					tree_item_namespace.set_pixmap (l_ico)
--					
--					unclassified_namespaces.extend (tree_item_namespace)
--				end
--				namespaces.forth
--			end
--			
--			Result := classify_namespaces (unclassified_namespaces)
--		ensure
--			non_void_result: Result /= Void
--		end
--
--	add_types_branches (a_tree_item_namespace: EV_TREE_ITEM; a_types_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]) is
--			-- add type contained in `tree' to `tree_item_parent'.
--			-- add click action on each type_item to see its contain in edit_area.
--			-- add expand action on each type_item to see its features in the tree.
--		require
--			non_void_tree_item_namespace: a_tree_item_namespace /= Void
--			non_void_a_types_list: a_types_list /= Void
--		do
--			a_tree_item_namespace.append (classify_types (a_types_list))
--		end
		
	add_features_branches (an_assembly: CONSUMED_ASSEMBLY; tree_item_parent: EV_TREE_ITEM; full_dotnet_type_name: STRING) is
			-- add feature contained in `a_dotnet_type_name' to `tree_item_parent'.
			-- add double click action on each type_item to be editable.
		require
		local
			i: INTEGER
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			a_file_name: STRING
			tree_item: EV_COMPARABLE_TREE_ITEM
			path: CACHE_PATH
			l_constructors_list, l_fields_list, l_procedures_list, l_functions_list: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]
		do
				-- Is it allready initilized?
			if tree_item_parent.is_empty or tree_item_parent.count = 1 then
				if tree_item_parent.count = 1 then
						-- remove element that served to show the cross to expand tree.
					tree_item_parent.first.destroy
				end

				create eac
				create path
				a_file_name := path.absolute_type_path (path.relative_assembly_path (an_assembly), full_dotnet_type_name)
				ct := eac.consumed_type (an_assembly, full_dotnet_type_name)
				if ct /= Void then
					from
						i := 1
						create l_constructors_list.make
					until
						ct.constructors = Void
						or else i > ct.constructors.count
					loop
						tree_item := initialize_tree_item_feature (an_assembly, full_dotnet_type_name, ct.constructors.item (i).eiffel_name, Path_icon_constructor)
						
						l_constructors_list.extend (tree_item)
						i := i + 1
					end
					tree_item_parent.append (classify_tree_nodes (l_constructors_list))
					
					from
						i := 1
						create l_fields_list.make
					until
						ct.fields = Void
						or else i > ct.fields.count
					loop
						tree_item := initialize_tree_item_feature (an_assembly, full_dotnet_type_name, ct.fields.item (i).eiffel_name, Path_icon_attribute)
		
						l_fields_list.extend (tree_item)
						i := i + 1
					end
					tree_item_parent.append (classify_tree_nodes (l_fields_list))

					from
						i := 1
						create l_procedures_list.make
					until
						ct.procedures = Void
						or else i > ct.procedures.count
					loop
						tree_item := initialize_tree_item_feature (an_assembly, full_dotnet_type_name, ct.procedures.item (i).eiffel_name, Path_icon_procedure)
		
					l_procedures_list.extend (tree_item)
						i := i + 1
					end
					tree_item_parent.append (classify_tree_nodes (l_procedures_list))

					from
						i := 1
						create l_functions_list.make
					until
						ct.functions = Void
						or else i > ct.functions.count
					loop
						tree_item := initialize_tree_item_feature (an_assembly, full_dotnet_type_name, ct.functions.item (i).eiffel_name, Path_icon_function)
		
						l_functions_list.extend (tree_item)
						i := i + 1
					end
					tree_item_parent.append (classify_tree_nodes (l_functions_list))
				end
			end
			edit.edit_type (an_assembly, full_dotnet_type_name)
		end

feature {NONE} -- Classify

	classify_assemblies (assemblies: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]): LINKED_LIST [EV_COMPARABLE_TREE_ITEM] is
			-- Classify `assemblies'.
		require
			non_void_assemblies: assemblies /= Void
		local
			l_sortable_assemblies: SORTABLE_ARRAY [EV_COMPARABLE_TREE_ITEM]
			counter: INTEGER
			cache: CACHE
			l_assembly: CONSUMED_ASSEMBLY
		do
			create cache
			create l_sortable_assemblies.make (1, assemblies.count)
			from
				assemblies.start
				counter := 1
			until
				assemblies.after
			loop
				l_sortable_assemblies.put (assemblies.item, counter)
				counter := counter + 1
				assemblies.forth
			end
			
			l_sortable_assemblies.sort;
			
			from
				counter := 1
				create Result.make
			until
				counter > l_sortable_assemblies.count
			loop
				Result.extend (l_sortable_assemblies.item (counter))
				l_assembly ?= l_sortable_assemblies.item (counter).data
				if l_assembly /= Void then
					cache.Assemblies.extend (l_assembly)
				end
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
			same_number_assemblies: assemblies.count = Result.count
		end

	classify_namespaces (namespaces: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]): LINKED_LIST [EV_COMPARABLE_TREE_ITEM] is
			-- Classify `namespaces'.
		require
			non_void_namespaces: namespaces /= Void
		local
			l_sortable_namespaces: SORTABLE_ARRAY [EV_COMPARABLE_TREE_ITEM]
			counter: INTEGER
		do
			create l_sortable_namespaces.make (1, namespaces.count)
			from
				namespaces.start
				counter := 1
			until
				namespaces.after
			loop
				l_sortable_namespaces.put (namespaces.item, counter)
				counter := counter + 1
				namespaces.forth
			end
			
			l_sortable_namespaces.sort;
			
			from
				counter := 1
				create Result.make
			until
				counter > l_sortable_namespaces.count
			loop
				Result.extend (l_sortable_namespaces.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
			same_number_namespaces: namespaces.count = Result.count
		end

	classify_types (types: LINKED_LIST [EV_COMPARABLE_TREE_ITEM]): LINKED_LIST [EV_COMPARABLE_TREE_ITEM] is
			-- Classify `types'.
		require
			non_void_types: types /= Void
		local
			l_sortable_types: SORTABLE_ARRAY [EV_COMPARABLE_TREE_ITEM]
			counter: INTEGER
		do
			create l_sortable_types.make (1, types.count)
			from
				types.start
				counter := 1
			until
				types.after
			loop
				l_sortable_types.put (types.item, counter)
				counter := counter + 1
				types.forth
			end
			
			l_sortable_types.sort;
			
			from
				counter := 1
				create Result.make
			until
				counter > l_sortable_types.count
			loop
				Result.extend (l_sortable_types.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
			same_number_types: types.count = Result.count
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
		

feature {NONE} -- Initialization of tree elements

	initialize_tree_item_assembly (an_assembly: CONSUMED_ASSEMBLY): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			index_of_last_point: INTEGER
			l_ico: EV_PIXMAP
		do
			create Result
			Result.set_text (an_assembly.name)
				-- Add data associated to item.
			Result.set_data (an_assembly)
				-- Add assembly icon.
			create l_ico
			l_ico.set_with_named_file (Path_icon_assembly)
			Result.set_pixmap (l_ico)

				-- Add action to item.			
			Result.expand_actions.extend (agent add_namespaces_branches (an_assembly, Result))
			Result.pointer_button_press_actions.force_extend (agent edit.edit_info_assembly (an_assembly))

				-- Add a fictive element for a cross to appear.
			Result.extend (create {EV_TREE_ITEM})
		ensure
			non_void_result: Result /= Void		
		end

	initialize_tree_item_type (an_assembly: CONSUMED_ASSEMBLY; full_dotnet_type_name: STRING): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_full_dotnet_type_name: full_dotnet_type_name /= Void
			no_empty_full_dotnet_type_name: not full_dotnet_type_name.is_empty
		local
			index_of_last_point: INTEGER
			l_ico: EV_PIXMAP
		do
			index_of_last_point := full_dotnet_type_name.last_index_of ('.', full_dotnet_type_name.count)

			create Result
			Result.set_text (full_dotnet_type_name.substring (index_of_last_point + 1, full_dotnet_type_name.count))

				-- Add data associated to item.
			Result.set_data (full_dotnet_type_name)
	
				-- Add action to item.
			Result.pointer_button_press_actions.force_extend (agent edit.color_edit_type (an_assembly, full_dotnet_type_name))
--			Result.pointer_button_press_actions.force_extend (agent edit.edit_type (an_assembly, full_dotnet_type_name))
			Result.expand_actions.extend (agent edit.color_edit_type (an_assembly, full_dotnet_type_name))
--			Result.expand_actions.extend (agent edit.edit_type (an_assembly, full_dotnet_type_name))
			Result.expand_actions.extend (agent add_features_branches (an_assembly, Result, full_dotnet_type_name))

				-- Add a fictive element for a cross to appear
			Result.extend (create {EV_TREE_ITEM})
			
				-- Add type icon.
			create l_ico
			l_ico.set_with_named_file (Path_icon_class)
			Result.set_pixmap (l_ico)
		ensure
			non_void_result: Result /= Void		
		end
		
	initialize_tree_item_feature (an_assembly: CONSUMED_ASSEMBLY; full_dotnet_type_name: STRING; eiffel_feature_name: STRING; icon_path: STRING): EV_COMPARABLE_TREE_ITEM is
			-- init a_tree_item_type.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_full_dotnet_type_name: full_dotnet_type_name /= Void
			not_empty_full_dotnet_type_name: not full_dotnet_type_name.is_empty
			non_void_eiffel_feature_name: eiffel_feature_name /= Void
			not_empty_eiffel_feature_name: not eiffel_feature_name.is_empty
			non_void_icon_path: icon_path /= Void
		local
			l_ico: EV_PIXMAP
		do
			create Result
			Result.set_text (eiffel_feature_name)
			
				-- Mouse actions
			Result.pointer_button_press_actions.force_extend (agent edit.color_edit_type_with_feature_selected (an_assembly, full_dotnet_type_name, eiffel_feature_name))
			Result.pointer_double_press_actions.force_extend (agent edit.color_edit_type_with_feature_selected (an_assembly, full_dotnet_type_name, eiffel_feature_name))
			Result.pointer_double_press_actions.force_extend (agent edit_feature (?, ?, ?, ?, ?, ?, ?, ?, an_assembly, Result))

			Result.set_data (eiffel_feature_name)
			
				-- Add type icon.
			create l_ico
			l_ico.set_with_named_file (icon_path)
			Result.set_pixmap (l_ico)
		ensure
			non_void_result: Result /= Void		
		end

feature {NONE} -- Edit

	edit_feature (a, b, c: INTEGER; d, e, f: DOUBLE; g, h: INTEGER; an_assembly: CONSUMED_ASSEMBLY; eiffel_feature_item: EV_COMPARABLE_TREE_ITEM) is
			--
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_eiffel_feature_item: eiffel_feature_item /= Void
		local
			edit_box: EV_EDIT_FEATURE_BOX
		do
			create edit_box
			edit_box.set_title ("New Eiffel feature name:")
			edit_box.set_x_position (g - 40)
			edit_box.set_y_position (h - 15)
			edit_box.set_feature (eiffel_feature_item.text)
			edit_box.show_modal_to_window (parent_window)
			--edit_box.show_relative_to_window (parent_window)
--			edit_box.focus_out_actions.extend (agent edit_box.destroy)
		end

	on_key_pressed (a_key: EV_KEY) is
			-- feature performed when the focus is in tree and a key is pressed.
		local
			key_constant: EV_KEY_CONSTANTS
			l_tree_item: EV_COMPARABLE_TREE_ITEM
			l_tree_node: EV_TREE_NODE
			l_parent_tree_item: EV_TREE_ITEM
			an_assembly: CONSUMED_ASSEMBLY
			a_dotnet_type_name: STRING
			an_eiffel_feature_name: STRING
			temp_string: STRING
		do
			create key_constant
			if a_key.code = key_constant.key_enter then
				l_tree_node := parent_window.widget_tree.selected_item
				l_tree_item ?= parent_window.widget_tree.selected_item
				if l_tree_item /= Void then
					if l_tree_item.data /= Void and then l_tree_item.text.same_type (l_tree_item.data) then
					   	temp_string ?= l_tree_item.data
					   	if temp_string /= Void and then l_tree_item.text.is_equal (temp_string) then
							l_parent_tree_item ?= l_tree_item.parent
							if l_parent_tree_item /= Void then
								a_dotnet_type_name ?= l_parent_tree_item.data
								l_parent_tree_item ?= l_parent_tree_item.parent
								if l_parent_tree_item /= Void then
									an_assembly ?= l_parent_tree_item.parent.data
								end
							end
							an_eiffel_feature_name ?= l_tree_item.data
							if an_assembly /= Void and then
							   a_dotnet_type_name /= Void and then
							   an_eiffel_feature_name /= Void then
								Edit.color_edit_type_with_feature_selected (an_assembly, a_dotnet_type_name, an_eiffel_feature_name)
								edit_feature (0,0,0, 0,0,0, 200,200, an_assembly, l_tree_item)
							end
						end
					end
				end
			end
		end
		
feature -- Action

	expand_assembly (an_assembly: CONSUMED_ASSEMBLY) is
			--
		require
			non_void_an_assembly: an_assembly /= Void
		local
			l_assembly_node: EV_TREE_NODE
		do
			l_assembly_node := parent_window.widget_tree.find_item_recursively_by_data (an_assembly)
			if l_assembly_node /= Void then
				l_assembly_node.expand
				l_assembly_node.parent_tree.ensure_item_visible (l_assembly_node)
				l_assembly_node.enable_select
			end
		end

	expand_type (an_assembly: CONSUMED_ASSEMBLY; a_type: CONSUMED_TYPE) is
			--
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type: a_type /= Void
		local
			l_assembly_node: EV_TREE_NODE
			l_type_node: EV_TREE_NODE
			l_namespace_item: EV_TREE_ITEM
		do
			l_assembly_node := parent_window.widget_tree.find_item_recursively_by_data (an_assembly)
			if l_assembly_node /= Void then
				l_assembly_node.expand
				l_type_node := parent_window.widget_tree.find_item_recursively_by_data (a_type.dotnet_name)
				if l_type_node /= Void then
					l_namespace_item ?= l_type_node.parent
					if l_namespace_item /= Void then
						l_namespace_item.expand
					end
					--l_type_node.expand
					l_type_node.parent_tree.ensure_item_visible (l_type_node)
					l_type_node.enable_select
				end
			end
		end

invariant
	non_void_current_window: parent_window /= Void
		
end -- TREE_FACTORY