indexing
	description: ""
	
class
	TREE_VIEW_CTL

inherit 
	WINFORMS_FORM
		rename
			make as make_form,
			refresh as refresh_winform
		undefine
			to_string, finalize, equals, get_hash_code
		redefine
			dispose_boolean
		end

	ANY


create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			l_dec: DECIMAL
		do
			initialize_components
			
			fill_directory_tree
			image_list_combo_box.set_selected_index (1)
--			indent_up_down.set_value ((create {DECIMAL}).op_implicit_integer (directory_tree.indent))
			
			feature {WINFORMS_APPLICATION}.run_form (Current)
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container	
			
	directory_tree: WINFORMS_TREE_VIEW
			-- System.Windows.Forms.TreeView directory_tree
	
	image_list_1, image_list_2: WINFORMS_IMAGE_LIST
			-- System.Windows.Forms.ImageList 

	grp_tree_view: WINFORMS_GROUP_BOX
			-- System.Windows.Forms.GroupBox 
			
	check_box_1, check_box_2, check_box_3, check_box_4, check_box_5, check_box_6, check_box_7 :WINFORMS_CHECK_BOX
			-- System.Windows.Forms.CheckBox 
	
	image_list_combo_box: WINFORMS_COMBO_BOX	
			-- System.Windows.Forms.ComboBox 
			
	label_1, label_2: WINFORMS_LABEL
			-- System.Windows.Forms.Label

	indent_up_down: WINFORMS_NUMERIC_UP_DOWN
			-- System.Windows.Forms.NumericUpDown
			
	tool_tip: WINFORMS_TOOL_TIP
			-- System.Windows.Forms.ToolTip

feature {NONE} -- Implementation

	initialize_components is
			--
		local
			l_array: NATIVE_ARRAY [SYSTEM_STRING]
			resources: RESOURCE_MANAGER
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
			l_decimal: DECIMAL
			l_image: DRAWING_BITMAP
		do
			create resources.make_from_resource_source (Current.get_type)

			create components.make
			create check_box_7.make
			create directory_tree.make
			create check_box_5.make
			create label_2.make
			create indent_up_down.make
			create image_list_2.make
			create tool_tip.make
			create check_box_6.make
			create check_box_1.make
			create check_box_3.make
			create image_list_1.make
			create image_list_combo_box.make
			create check_box_4.make
			create grp_tree_view.make
			create check_box_2.make
			create label_1.make

			check_box_7.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 160)
			check_box_7.set_location (l_point)
			check_box_7.set_tab_index (6)
			check_box_7.set_check_state (feature {WINFORMS_CHECK_STATE}.checked)
			check_box_7.set_text (("hideSelected").to_cil)
			l_size.make_from_width_and_height (100, 23)
			check_box_7.set_size (l_size)
			check_box_7.set_checked (True)
			tool_tip.set_tool_tip (check_box_7, ("Removes highlight from selected node when the control doesn\'t have focus.").to_cil)
			check_box_7.add_click (create {EVENT_HANDLER}.make (Current, $check_box_7_click))

			directory_tree.set_image_list (image_list_1)
			directory_tree.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			l_point.make_from_x_and_y (24, 16)
			directory_tree.set_location (l_point)
			directory_tree.set_allow_drop (True)
			directory_tree.set_tab_index (0)
			directory_tree.set_indent (19)
			directory_tree.set_text (("treeView1").to_cil)
			directory_tree.set_selected_image_index (1)
			l_size.make_from_width_and_height (200, 264)
			directory_tree.set_size (l_size)
			tool_tip.set_tool_tip (directory_tree, ("Indicates whether lines are shown between sibling nodes and b etween parent and children nodes").to_cil)
			directory_tree.add_after_select (create {WINFORMS_TREE_VIEW_EVENT_HANDLER}.make (Current, $directory_tree_after_select))
			directory_tree.add_before_expand (create {WINFORMS_TREE_VIEW_CANCEL_EVENT_HANDLER}.make (Current, $directory_tree_before_expand))

			check_box_5.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 112)
			check_box_5.set_location (l_point)
			check_box_5.set_tab_index (4)
			check_box_5.set_check_state (feature {WINFORMS_CHECK_STATE}.checked)
			check_box_5.set_text (("showPlusMinus").to_cil)
			l_size.make_from_width_and_height (120, 23)
			check_box_5.set_size (l_size)
			check_box_5.set_checked (True)
			tool_tip.set_tool_tip (check_box_5, ("Indicates if plus/minus button are shown next to parents.").to_cil)
			check_box_5.add_click (create {EVENT_HANDLER}.make (Current, $check_box_5_click))

			l_point.make_from_x_and_y (16, 224)
			label_2.set_location (l_point)
			label_2.set_tab_index (9)
			label_2.set_tab_stop (False)
			label_2.set_text (("indent:").to_cil)
			l_size.make_from_width_and_height (48, 16)
			label_2.set_size (l_size)

			l_point.make_from_x_and_y (88, 224)
			indent_up_down.set_location (l_point)
			l_decimal.make_from_value (150)
			indent_up_down.set_maximum (l_decimal)
			l_decimal.make_from_value (18)
			indent_up_down.set_minimum (l_decimal)
			indent_up_down.set_tab_index (10)
			indent_up_down.set_text (("18").to_cil)
			indent_up_down.set_decimal_places (0)
			l_size.make_from_width_and_height (120, 20)
			indent_up_down.set_size (l_size)
			tool_tip.set_tool_tip (indent_up_down, ("The indentation width of a child node in pixels.").to_cil)
			indent_up_down.add_value_changed (create {EVENT_HANDLER}.make (Current, $indent_up_down_value_changed))

			image_list_2.set_transparent_color (feature {DRAWING_COLOR}.transparent)
			image_list_2.images.add (create {DRAWING_BITMAP}.make_from_filename (("diamond.bmp").to_cil))
			image_list_2.images.add (create {DRAWING_BITMAP}.make_from_filename (("club.bmp").to_cil))
			
			l_size.make_from_width_and_height (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (502, 293)
			set_client_size (l_size)
			set_text (("TreeView").to_cil)

			tool_tip.set_active (True)

			check_box_6.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 136)
			check_box_6.set_location (l_point)
			check_box_6.set_tab_index (5)
			check_box_6.set_text (("checkBoxes").to_cil)
			l_size.make_from_width_and_height (100, 23)
			check_box_6.set_size (l_size)
			tool_tip.set_tool_tip (check_box_6, ("Indicates wheter checkboxes are displayed beside nodes").to_cil)
			check_box_6.add_click (create {EVENT_HANDLER}.make (Current, $check_box_6_click))

			check_box_1.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 16)
			check_box_1.set_location (l_point)
			check_box_1.set_tab_index (0)
			check_box_1.set_text (("sorted").to_cil)
			l_size.make_from_width_and_height (100, 23)
			check_box_1.set_size (l_size)
			tool_tip.set_tool_tip (check_box_1, ("Indicates whether nodes are sorted.").to_cil)
			check_box_1.add_click (create {EVENT_HANDLER}.make (Current, $check_box1_add_click))

			check_box_3.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 64)
			check_box_3.set_location (l_point)
			check_box_3.set_tab_index (2)
			check_box_3.set_check_state (feature {WINFORMS_CHECK_STATE}.checked)
			check_box_3.set_text (("showLines").to_cil)
			l_size.make_from_width_and_height (100, 23)
			check_box_3.set_size (l_size)
			check_box_3.set_checked (True)
			tool_tip.set_tool_tip (check_box_3, ("Indicates whether lines are displayed between sibling nodes and between parent and children nodes.").to_cil)
			check_box_3.add_click (create {EVENT_HANDLER}.make (Current, $check_box_3_click))

			image_list_1.set_transparent_color (feature {DRAWING_COLOR}.transparent)
			image_list_1.images.add (create {DRAWING_BITMAP}.make_from_filename (("clsdfold.bmp").to_cil))
			image_list_1.images.add (create {DRAWING_BITMAP}.make_from_filename (("openfold.bmp").to_cil))

			image_list_combo_box.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			l_point.make_from_x_and_y (88, 192)
			image_list_combo_box.set_location (l_point)
			image_list_combo_box.set_tab_index (8)
			image_list_combo_box.set_text (("").to_cil)
			l_size.make_from_width_and_height (120, 21)
			image_list_combo_box.set_size (l_size)
			image_list_combo_box.add_selected_index_changed (create {EVENT_HANDLER}.make (Current, $image_list_combo_box_selected_index_changed))
			create l_array.make (3)
			l_array.put (0, ("(none)").to_cil)
			l_array.put (1, ("system images").to_cil)
			l_array.put (2, ("bitmaps").to_cil)
			image_list_combo_box.items.add_range (l_array)

			check_box_4.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 88)
			check_box_4.set_location (l_point)
			check_box_4.set_tab_index (3)
			check_box_4.set_check_state (feature {WINFORMS_CHECK_STATE}.checked)
			check_box_4.set_text (("showRootLines").to_cil)
			l_size.make_from_width_and_height (120, 23)
			check_box_4.set_size (l_size)
			check_box_4.set_checked (True)
			tool_tip.set_tool_tip (check_box_4, ("Indicates whether lines are displayed between root nodes.").to_cil)
			check_box_4.add_click (create {EVENT_HANDLER}.make (Current, $check_box_4_click))

			l_point.make_from_x_and_y (248, 16)
			grp_tree_view.set_location (l_point)
			grp_tree_view.set_tab_index (1)
			grp_tree_view.set_tab_stop (False)
			grp_tree_view.set_text (("TreeView").to_cil)
			l_size.make_from_width_and_height (248, 264)
			grp_tree_view.set_size (l_size)

			check_box_2.set_text_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make_from_x_and_y (16, 40)
			check_box_2.set_location (l_point)
			check_box_2.set_tab_index (1)
			check_box_2.set_text (("hotTracking").to_cil)
			l_size.make_from_width_and_height (100, 23)
			check_box_2.set_size (l_size)
			tool_tip.set_tool_tip (check_box_2, ("Indicates whether nodes give feedback when the mouse is moved over them.").to_cil)
			check_box_2.add_click (create {EVENT_HANDLER}.make (Current, $check_box_2_click))

			l_point.make_from_x_and_y (16, 194)
			label_1.set_location (l_point)
			label_1.set_tab_index (7)
			label_1.set_tab_stop (False)
			label_1.set_text (("imageList:").to_cil)
			l_size.make_from_width_and_height (56, 16)
			label_1.set_size (l_size)

			grp_tree_view.controls.add (check_box_7)
			grp_tree_view.controls.add (check_box_6)
			grp_tree_view.controls.add (check_box_5)
			grp_tree_view.controls.add (check_box_4)
			grp_tree_view.controls.add (check_box_3)
			grp_tree_view.controls.add (check_box_2)
			grp_tree_view.controls.add (label_2)
			grp_tree_view.controls.add (indent_up_down)
			grp_tree_view.controls.add (label_1)
			grp_tree_view.controls.add (image_list_combo_box)
			grp_tree_view.controls.add (check_box_1)
			
			controls.add (grp_tree_view)
			controls.add (directory_tree)
		end


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
		end

	add_directories (node: WINFORMS_TREE_NODE) is
			-- For a given root directory (or drive), add the directories to the
			-- directory_tree.
		local
			i: INTEGER
			rescued: BOOLEAN
			directory: DIRECTORY_INFO
			sub_directories: NATIVE_ARRAY [DIRECTORY_INFO]
			directory_name: SYSTEM_STRING
			dummy: INTEGER
		do
			if not rescued then
				create directory.make (path_from_node (node))
				sub_directories := directory.get_directories
				from
					i := 0
				until
					i = sub_directories.count
				loop
					directory_name := sub_directories.item (i).name
					dummy := node.nodes.add_tree_node (create {DIRECTORY_NODE}.make_from_text (directory_name))
					i := i + 1
				end
			end
		rescue
			rescued := True
			retry
		end

	add_sub_directories(node: DIRECTORY_NODE) is
			-- For a given node, add the sub-directories for node's children in the
			-- directory_tree.
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = node.nodes.count
			loop
				add_directories (node.nodes.item (i))
				i := i + 1
			end
			node.set_sub_directories_added (True)
		end

	directory_tree_after_select(source: SYSTEM_OBJECT; e: WINFORMS_TREE_VIEW_EVENT_ARGS) is
			-- Event handler for the afterSelect event on the directory_tree. Change the
			-- title bar to show the path of the selected directoryNode.
		do
			set_text (text.concat_string_string ((("Windows.Forms File Explorer - ").to_cil), e.node.text))
		end

	directory_tree_before_expand(source: SYSTEM_OBJECT; e: WINFORMS_TREE_VIEW_EVENT_ARGS) is
			-- Event handler for the beforeExpand event on the directory_tree. If the
			-- node is not already expanded, expand it.
		local
			node_expanding: DIRECTORY_NODE
		do
			node_expanding ?= e.node
--			if node_expanding /= Void and then not node_expanding.sub_directories_sdded then
--				add_sub_directories (node_expanding)
--			end
		end

	fill_directory_tree is
			-- For initializing the directory_tree upon creation of the TreeViewCtl form.
		local
			i: INTEGER
			drives: NATIVE_ARRAY [SYSTEM_STRING]
			root: DIRECTORY_NODE
			dummy: INTEGER
			l_drive: ANY
			l_drive_string: STRING
			l_ext: EXTERNALS
			l_ptr: POINTER
		do
			drives := feature {ENVIRONMENT}.get_logical_drives
			create l_ext
			from
			until
				i > drives.count
			loop
				create l_drive_string.make_from_cil (drives.item (i))
				l_ptr := feature {MARSHAL}.string_to_hglobal_ansi (l_drive_string.to_cil)
				if l_ext.get_drive_type (l_ptr) = Drive_fixed then
					create root.make_from_text (drives.item (i))
					dummy := directory_tree.nodes.add_tree_node (root)
					add_directories (root)
				end
				feature {MARSHAL}.free_hglobal (l_ptr)
				i := i + 1
			end
		rescue
			i := i + 1
			retry
		end

	path_from_node (node: WINFORMS_TREE_NODE): SYSTEM_STRING is
			-- Returns the directory path of the node.
		do
			if node.parent = Void then
				Result := node.text
			else
				--parent_path := path_from_node (node.parent)
				--Result := parent_path.concat_string_string_string (parent_path, ("\").to_cil, node.text)
				Result := feature {PATH}.combine (path_from_node (node.parent), node.text)
			end
		end

	refresh_get_expanded (node: WINFORMS_TREE_NODE; expanded_nodes: NATIVE_ARRAY [SYSTEM_STRING]; start_index: INTEGER): INTEGER is
			-- Refresh helper functions to get all expanded nodes under the given node.
		do
--			if (StartIndex < ExpandedNodes.Length) {
--				if (Node.IsExpanded) {
--					ExpandedNodes[StartIndex] = Node.Text
--					StartIndex++
--					for (int i = 0 i < Node.Nodes.Count i++) {
--						StartIndex = refresh_get_expanded(Node.Nodes[i],
--														 ExpandedNodes,
--														 StartIndex)
--					end
--				end
--				return StartIndex
--			end
			Result := -1
		end

	refresh_expand (node: WINFORMS_TREE_NODE; expanded_nodes: NATIVE_ARRAY [SYSTEM_STRING]) is
			-- Refresh helper function to expand all nodes whose paths are in parameter ExpandedNodes.
		do
--			for (int i = ExpandedNodes.Length - 1 i >= 0 i--) {
--				if (ExpandedNodes[i] == Node.Text) {
--					/*
--					* For the expand button to show properly, one level of
--					* invisible children have to be added to the tree.
--					*/
--					add_sub_directories((DirectoryNode) Node)
--					Node.Expand()
--	
--					/* If the node is expanded, expand any children that were
--					* expanded before the refresh.
--					*/
--					for (int j = 0 j < Node.Nodes.Count j++) {
--						refresh_expand(Node.Nodes[j], ExpandedNodes)
--					end
--	
--					return
--				end
--			end
		end

	refresh (node: WINFORMS_TREE_NODE) is
			-- Refreshes the view by deleting all the nodes and restoring them by
			-- reading the disk(s). Any expanded nodes in the directoryView will be
			-- expanded after the refresh.
		do
--			// Update the directory_tree
--			if (node.Nodes.Count > 0) {
--				if (node.IsExpanded) {
--					// Save all expanded nodes rooted at node, even those that are
--					// indirectly rooted.
--					string[] tooBigExpandedNodes = new string[node.GetNodeCount(True))]
--					int iExpandedNodes = refresh_get_expanded(node,
--						tooBigExpandedNodes,
--						0)
--					string[] expandedNodes = new string[iExpandedNodes]
--					Array.Copy(tooBigExpandedNodes, 0, expandedNodes, 0,
--						iExpandedNodes)
--
--					node.Nodes.Clear()
--					add_directories(node)
--
--					// so children with subdirectories show up with expand/collapse
--					//button.
--					add_sub_directories((DirectoryNode)node)
--					node.Expand()
--
--					/*
--					 * check all children. Some might have had sub-directories added
--					 * from an external application so previous childless nodes
--					 * might now have children.
--					 */
--					for (int j = 0 j < node.Nodes.Count  j++) {
--						if (node.Nodes[j].Nodes.Count > 0) {
--							// If the child has subdirectories. If it was expanded
--							// before the refresh, then expand after the refresh.
--							refresh_expand(node.Nodes[j], expandedNodes)
--						end
--					end
--				end else {
--					/*
--					 * If the node is not expanded, then there is no need to check
--					 * if any of the children were expanded. However, we should
--					 * update the tree by reading the drive in case an external
--					 * application add/removed any directories.
--					 */
--					node.Nodes.Clear()
--					add_directories(node)
--				end
--			end else {
--				/*
--				 * Again, if there are no children, then there is no need to
--				 * worry about expanded nodes but if an external application
--				 * add/removed any directories we should reflect that.
--				 */
--				node.Nodes.Clear()
--				add_directories(node)
--			end
		end

	check_box1_add_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		local
			i: INTEGER
		do
			directory_tree.set_sorted (check_box_1.checked)
			from
				i := 0
			until
				i = directory_tree.nodes.count
			loop
				refresh (directory_tree.nodes.item (i))
				i := i + 1
			end
		end

	image_list_combo_box_selected_index_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		local
			index: INTEGER
		do
			index := image_list_combo_box.selected_index
			if index = 0 then
				directory_tree.set_image_list (Void)
			elseif index = 1 then
				directory_tree.set_image_list (image_list_1)
			else
				directory_tree.set_image_list (image_list_2)
			end
		end

	indent_up_down_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			--directory_tree.set_indent (indent_up_down.value.to_int_32 (indent_up_down.value))
		end

	check_box_2_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			directory_tree.set_hot_tracking (check_box_2.checked)
		end

	check_box_3_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			directory_tree.set_show_lines (check_box_3.checked)
		end

	check_box_4_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			directory_tree.set_show_root_lines (check_box_4.checked)
		end

	check_box_5_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			directory_tree.set_show_plus_minus (check_box_5.checked)
		end

	check_box_6_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			directory_tree.set_check_boxes (check_box_6.checked)
		end

	check_box_7_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
			directory_tree.set_hide_selection (check_box_7.checked)
		end

	Drive_fixed: INTEGER is 3
			-- Value of a fixed, non removable disk drive.
		
end -- class DATE_TIME_PICKER_CTL
