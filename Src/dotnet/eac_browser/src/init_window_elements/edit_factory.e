indexing
	description: "Print in output the eiffel type with all its eiffelfeatures corresponding to given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	EDIT_FACTORY
	
create
	make

feature {NONE} -- Initialization

 	make (a_window: MAIN_WINDOW_IMP) is
 			-- Initialize `parent_window' and `tree'.
 		require
 			non_void_a_window: a_window /= Void
 		do
 			parent_window := a_window
 		ensure
 			parent_window_set: parent_window = a_window implies parent_window /= Void
 		end
 		
feature {NONE}	-- Access
 
	parent_window: MAIN_WINDOW_IMP
			-- current window.

feature -- Access

	edit_info_assemblies is
			-- print info of all assemblies in `assemblies'.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_list: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			cache: CACHE
			tree_factory: TREE_FACTORY
		do
			parent_window.notebook.select_item (parent_window.assemblies)
			
			parent_window.assemblies.wipe_out
			
				-- Set EV_MULTI_COLUMN_LIST
			parent_window.assemblies.set_column_titles (<<"Name", "Version", "Culture", "Key">>)
			
			create tree_factory.make (parent_window)
			from
				create cache
				cache.Assemblies.start
				create l_list.make
			until
				cache.Assemblies.after				
			loop
				create l_row
				l_row.extend (cache.Assemblies.item.name)
				l_row.extend (cache.Assemblies.item.version)
				l_row.extend (cache.Assemblies.item.culture)
				l_row.extend (cache.Assemblies.item.key)
				l_row.pointer_double_press_actions.force_extend (agent tree_factory.expand_assembly (cache.Assemblies.item))
				l_row.set_data (cache.Assemblies.item)
				l_list.extend (l_row)
				cache.Assemblies.forth
			end
			parent_window.assemblies.append (l_list)

			parent_window.assemblies.resize_column_to_content (1)
			parent_window.assemblies.resize_column_to_content (2)
			parent_window.assemblies.resize_column_to_content (3)
			parent_window.assemblies.resize_column_to_content (4)
			parent_window.assemblies.align_text_right (2)
			parent_window.assemblies.align_text_right (4)
		end		

	edit_info_assembly (an_assembly: CONSUMED_ASSEMBLY) is
			-- print info of all assemblies and select assembly corresponding to `an_assembly'.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			parent_window.notebook.select_item (parent_window.assemblies)
			
			edit_info_assemblies
			l_row := parent_window.assemblies.item_by_data (an_assembly)
			if l_row /= Void then
				l_row.enable_select
			end
			
			parent_window.edit_comments_area.enable_edit
			parent_window.edit_comments_area.remove_text
			parent_window.edit_comments_area .append_text ("Assembly name : " + an_assembly.name )
			parent_window.edit_comments_area.append_text ("%N%N")
			parent_window.edit_comments_area.append_text ("Assembly version : " + an_assembly.version )
			parent_window.edit_comments_area.append_text ("%N%N")
			parent_window.edit_comments_area.append_text ("Assembly culture : " + an_assembly.culture )
			parent_window.edit_comments_area.append_text ("%N%N")
			parent_window.edit_comments_area.append_text ("Assembly key : " + an_assembly.key )
			parent_window.edit_comments_area.disable_edit
		end

	edit_result_search_eiffel_type_name (dotnet_types: LINKED_LIST [SPECIFIC_TYPE]) is
			-- Print in `l_text_1' the features corresponding to `a_dotnet_type_name'.
		require
			non_void_dotnet_types: dotnet_types /= Void
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_list: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			tree_factory: TREE_FACTORY
			popup_not_found: POPUP_NOT_FOUND
		do
			parent_window.notebook.select_item (parent_window.search)

			if dotnet_types.count = 0 then
				-- msg popup window with "not found."
				create popup_not_found
				popup_not_found.show_modal_to_window (parent_window)
				--parent_window.search.hide_title_row
			else
				parent_window.search.show_title_row

					-- Set EV_MULTI_COLUMN_LIST
				parent_window.search.set_column_titles (<<"Eiffel name", "Dotnet name", "Assembly">>)
				
				create tree_factory.make (parent_window)
				from
					dotnet_types.start
					create l_list.make
				until
					dotnet_types.after				
				loop
					create l_row
					l_row.extend (dotnet_types.item.type.eiffel_name)
					l_row.extend (dotnet_types.item.type.dotnet_name)
					l_row.extend (dotnet_types.item.assembly.name)
					l_row.pointer_double_press_actions.force_extend (agent color_edit_type (dotnet_types.item.assembly, dotnet_types.item.type.dotnet_name))
					l_row.pointer_double_press_actions.force_extend (agent tree_factory.expand_type (dotnet_types.item.assembly, dotnet_types.item.type))
					l_list.extend (l_row)
					dotnet_types.forth
				end
				parent_window.search.append (l_list)
	
				parent_window.search.resize_column_to_content (1)
				parent_window.search.resize_column_to_content (2)
				parent_window.search.resize_column_to_content (3)
			end
		end		

feature -- Color edit

	internal_color_output: CELL [DISPLAY_TYPE] is		
			-- Type to diplay.
		once
			create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end

	color_edit_type (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- Display in `color_edit_comments_area' the features corresponding to `a_dotnet_type_name'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
		do
			parent_window.l_vertical_scroll_bar_1.set_value (0)
			parent_window.l_horizontal_scroll_bar_1.set_value (0)
			color_edit_type_with_feature_selected (an_assembly, a_dotnet_type_name, "")
		end

	color_edit_type_with_feature_selected (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING; an_eiffel_feature_name: STRING) is
			-- Display in `color_edit_comments_area' the features corresponding to `a_dotnet_type_name'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
		local
			output: DISPLAY_TYPE
		do
			create output.make (parent_window)
			output.set_feature_selected (an_eiffel_feature_name)
			output.print_type (an_assembly, a_dotnet_type_name)

				-- keep the output for refresh.
			internal_color_output.put (output)
		end
		
	color_refresh_type is
			-- Refresh type displayed in `color_edit_comments_area'.
		local
			output: DISPLAY_TYPE
		do
			output := internal_color_output.item
			if output /= Void then
				output.refresh
			end
		end
		
feature -- Tree Edit

	display_tree_type (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- display type in a tree.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
		local
			tree_display: DISPLAY_TYPE_TREE
		do
			parent_window.notebook.select_item (parent_window.right_tree)

			create tree_display.make (parent_window)

			tree_display.print_type (an_assembly, a_dotnet_type_name)
		end
	
	display_imediat_features (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- display type in a tree.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
		local
			tree_display: DISPLAY_TYPE_TREE
		do
			parent_window.notebook.select_item (parent_window.right_tree)

			create tree_display.make (parent_window)
			tree_display.print_type (an_assembly, a_dotnet_type_name)
		end

	display_inherited_features (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- display type in a tree.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
		local
			tree_display: DISPLAY_TYPE_TREE
		do
			parent_window.notebook.select_item (parent_window.right_tree)

			create tree_display.make (parent_window)
			tree_display.print_type_inherited_features (an_assembly, a_dotnet_type_name)
		end

	display_tree_constructors (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- display type in a tree.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
		local
			tree_display: DISPLAY_TYPE_TREE
		do
			parent_window.notebook.select_item (parent_window.right_tree)

			create tree_display.make (parent_window)
			tree_display.print_constructors (an_assembly, a_dotnet_type_name)
		end
		
	display_tree_all_features (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- display type in a tree.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type_name: a_dotnet_type_name /= Void
			not_empty_a_type_name: not a_dotnet_type_name.is_empty
		local
			tree_display: DISPLAY_TYPE_TREE
		do
			parent_window.notebook.select_item (parent_window.right_tree)

			create tree_display.make (parent_window)
			tree_display.print_all_features (an_assembly, a_dotnet_type_name)
		end
	
invariant
	non_void_parent_window: parent_window /= Void

end -- EDIT_FACTORY