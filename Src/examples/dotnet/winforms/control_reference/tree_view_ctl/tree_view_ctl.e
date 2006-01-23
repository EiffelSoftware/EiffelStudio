indexing
	description: "Tree view example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
class
	TREE_VIEW_CTL

inherit 
	WINFORMS_FORM
		rename
			make as make_form,
			refresh as refresh_winform
		redefine
			dispose_boolean
		end

	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make is
			-- | Call `initialize_components' then `fill_directory_tree'.
			-- Entry point.
		do
			initialize_components
			
			fill_directory_tree
			image_list_combo_box.set_selected_index (1)
			
			{WINFORMS_APPLICATION}.run_form (Current)
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
			-- Initialize graphical components
		local
			l_array: NATIVE_ARRAY [SYSTEM_STRING]
			resources: RESOURCE_MANAGER
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
			l_decimal: DECIMAL
			l_bitmap: DRAWING_BITMAP
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

			check_box_7.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 160)
			check_box_7.set_location (l_point)
			check_box_7.set_tab_index (6)
			check_box_7.set_check_state ({WINFORMS_CHECK_STATE}.checked)
			check_box_7.set_text ("hideSelected")
			l_size.make (100, 23)
			check_box_7.set_size (l_size)
			check_box_7.set_checked (True)
			tool_tip.set_tool_tip (check_box_7, "Removes highlight from selected node when the control doesn\'t have focus.")
			check_box_7.add_click (create {EVENT_HANDLER}.make (Current, $check_box_7_click))

			directory_tree.set_image_list (image_list_1)
			directory_tree.set_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			l_point.make (24, 16)
			directory_tree.set_location (l_point)
			directory_tree.set_tab_index (0)
			directory_tree.set_indent (19)
			directory_tree.set_text ("treeView1")
			directory_tree.set_selected_image_index (1)
			l_size.make (200, 264)
			directory_tree.set_size (l_size)
			tool_tip.set_tool_tip (directory_tree, "Indicates whether lines are shown between sibling nodes and b etween parent and children nodes")
			directory_tree.add_after_select (create {WINFORMS_TREE_VIEW_EVENT_HANDLER}.make (Current, $directory_tree_after_select))
			directory_tree.add_before_expand (create {WINFORMS_TREE_VIEW_CANCEL_EVENT_HANDLER}.make (Current, $directory_tree_before_expand))

			check_box_5.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 112)
			check_box_5.set_location (l_point)
			check_box_5.set_tab_index (4)
			check_box_5.set_check_state ({WINFORMS_CHECK_STATE}.checked)
			check_box_5.set_text ("showPlusMinus")
			l_size.make (120, 23)
			check_box_5.set_size (l_size)
			check_box_5.set_checked (True)
			tool_tip.set_tool_tip (check_box_5, "Indicates if plus/minus button are shown next to parents.")
			check_box_5.add_click (create {EVENT_HANDLER}.make (Current, $check_box_5_click))

			l_point.make (16, 224)
			label_2.set_location (l_point)
			label_2.set_tab_index (9)
			label_2.set_tab_stop (False)
			label_2.set_text ("indent:")
			l_size.make (48, 16)
			label_2.set_size (l_size)

			l_point.make (88, 224)
			indent_up_down.set_location (l_point)
			l_decimal.make_from_value (150)
			indent_up_down.set_maximum (l_decimal)
			l_decimal.make_from_value (18)
			indent_up_down.set_minimum (l_decimal)
			indent_up_down.set_tab_index (10)
			indent_up_down.set_text ("18")
			indent_up_down.set_decimal_places (0)
			l_size.make (120, 20)
			indent_up_down.set_size (l_size)
			tool_tip.set_tool_tip (indent_up_down, "The indentation width of a child node in pixels.")
			indent_up_down.add_value_changed (create {EVENT_HANDLER}.make (Current, $indent_up_down_value_changed))

			image_list_2.set_transparent_color ({DRAWING_COLOR}.transparent)
			l_bitmap := loaded_bitmap ("club")
			if l_bitmap /= Void then
				image_list_2.images.add (l_bitmap)
			end
			l_bitmap := loaded_bitmap ("diamond")
			if l_bitmap /= Void then
				image_list_2.images.add (l_bitmap)
			end
			l_size.make (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make (502, 293)
			set_client_size (l_size)
			set_text ("TreeView")

			tool_tip.set_active (True)

			check_box_6.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 136)
			check_box_6.set_location (l_point)
			check_box_6.set_tab_index (5)
			check_box_6.set_text ("checkBoxes")
			l_size.make (100, 23)
			check_box_6.set_size (l_size)
			tool_tip.set_tool_tip (check_box_6, "Indicates wheter checkboxes are displayed beside nodes")
			check_box_6.add_click (create {EVENT_HANDLER}.make (Current, $check_box_6_click))

			check_box_1.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 16)
			check_box_1.set_location (l_point)
			check_box_1.set_tab_index (0)
			check_box_1.set_text ("sorted")
			l_size.make (100, 23)
			check_box_1.set_size (l_size)
			tool_tip.set_tool_tip (check_box_1, "Indicates whether nodes are sorted.")
			check_box_1.add_click (create {EVENT_HANDLER}.make (Current, $check_box1_add_click))

			check_box_3.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 64)
			check_box_3.set_location (l_point)
			check_box_3.set_tab_index (2)
			check_box_3.set_check_state ({WINFORMS_CHECK_STATE}.checked)
			check_box_3.set_text ("showLines")
			l_size.make (100, 23)
			check_box_3.set_size (l_size)
			check_box_3.set_checked (True)
			tool_tip.set_tool_tip (check_box_3, "Indicates whether lines are displayed between sibling nodes and between parent and children nodes.")
			check_box_3.add_click (create {EVENT_HANDLER}.make (Current, $check_box_3_click))

			image_list_1.set_transparent_color ({DRAWING_COLOR}.transparent)
			l_bitmap := loaded_bitmap ("clsdfold")
			if l_bitmap /= Void then
				image_list_1.images.add (l_bitmap)
			end
			l_bitmap := loaded_bitmap ("openfold")
			if l_bitmap /= Void then
				image_list_1.images.add (l_bitmap)
			end

			image_list_combo_box.set_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			l_point.make (88, 192)
			image_list_combo_box.set_location (l_point)
			image_list_combo_box.set_tab_index (8)
			image_list_combo_box.set_text ("")
			l_size.make (120, 21)
			image_list_combo_box.set_size (l_size)
			image_list_combo_box.add_selected_index_changed (create {EVENT_HANDLER}.make (Current, $image_list_combo_box_selected_index_changed))
			create l_array.make (3)
			l_array.put (0, "(none)")
			l_array.put (1, "system images")
			l_array.put (2, "bitmaps")
			image_list_combo_box.items.add_range (l_array)

			check_box_4.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 88)
			check_box_4.set_location (l_point)
			check_box_4.set_tab_index (3)
			check_box_4.set_check_state ({WINFORMS_CHECK_STATE}.checked)
			check_box_4.set_text ("showRootLines")
			l_size.make (120, 23)
			check_box_4.set_size (l_size)
			check_box_4.set_checked (True)
			tool_tip.set_tool_tip (check_box_4, "Indicates whether lines are displayed between root nodes.")
			check_box_4.add_click (create {EVENT_HANDLER}.make (Current, $check_box_4_click))

			l_point.make (248, 16)
			grp_tree_view.set_location (l_point)
			grp_tree_view.set_tab_index (1)
			grp_tree_view.set_tab_stop (False)
			grp_tree_view.set_text ("TreeView")
			l_size.make (248, 264)
			grp_tree_view.set_size (l_size)

			check_box_2.set_text_align ({DRAWING_CONTENT_ALIGNMENT}.middle_left)
			l_point.make (16, 40)
			check_box_2.set_location (l_point)
			check_box_2.set_tab_index (1)
			check_box_2.set_text ("hotTracking")
			l_size.make (100, 23)
			check_box_2.set_size (l_size)
			tool_tip.set_tool_tip (check_box_2, "Indicates whether nodes give feedback when the mouse is moved over them.")
			check_box_2.add_click (create {EVENT_HANDLER}.make (Current, $check_box_2_click))

			l_point.make (16, 194)
			label_1.set_location (l_point)
			label_1.set_tab_index (7)
			label_1.set_tab_stop (False)
			label_1.set_text ("imageList:")
			l_size.make (56, 16)
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
		ensure
			non_void_components: components /= Void
			non_void_directory_tree: directory_tree /= Void
			non_void_indent_up_down: indent_up_down /= Void
			non_void_tool_tip: tool_tip /= Void
			non_void_label_1: label_1 /= Void
			non_void_label_2: label_2 /= Void
			non_void_check_box_1: check_box_1 /= Void
			non_void_check_box_2: check_box_2 /= Void
			non_void_check_box_3: check_box_3 /= Void
			non_void_check_box_4: check_box_4 /= Void
			non_void_check_box_5: check_box_5 /= Void
			non_void_check_box_6: check_box_6 /= Void
			non_void_check_box_7: check_box_7 /= Void
			non_void_image_list_1: image_list_1 /= Void
			non_void_image_list_2: image_list_2 /= Void
			non_void_image_list_combo_box: image_list_combo_box /= Void
			non_void_grp_tree_view: grp_tree_view /= Void
		end

feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		do
			if a_disposing then
				if components /= Void then
					components.dispose
					components := Void
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		end

	loaded_bitmap (a_bitmap_name: STRING): DRAWING_BITMAP is
			-- Load bitmap corresponding to `a_bitmap_name'.
		require
			non_void_a_bitmap_name: a_bitmap_name /= Void
			not_empty_a_bitmap_name: not a_bitmap_name.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result.make_from_filename (a_bitmap_name + ".bmp")
			end
		rescue
			retried := True
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
			return: INTEGER
			res: WINFORMS_DIALOG_RESULT
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
					return := node.nodes.add_tree_node (create {DIRECTORY_NODE}.make_from_text (directory_name))
					i := i + 1
				end
			end
		rescue
			res := {WINFORMS_MESSAGE_BOX}.show (tag_name)
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
		local
			l_text: STRING
		do
			l_text := "Windows.Forms File Explorer - "
			l_text.append (e.node.text)
			set_text (l_text)
		end

	directory_tree_before_expand (source: SYSTEM_OBJECT; e: WINFORMS_TREE_VIEW_CANCEL_EVENT_ARGS) is
			-- Event handler for the beforeExpand event on the directory_tree. If the
			-- node is not already expanded, expand it.
		local
			node_expanding: DIRECTORY_NODE
		do
			node_expanding ?= e.node
			check
				is_node: node_expanding /= Void
			end
            if not node_expanding.sub_directories_added then
            	add_sub_directories (node_expanding)
			end
		end

	fill_directory_tree is
			-- For initializing the directory_tree upon creation of the TreeViewCtl form.
		local
			i: INTEGER
			drives: NATIVE_ARRAY [SYSTEM_STRING]
			root: DIRECTORY_NODE
			return: INTEGER
			l_drive: STRING
			l_ext: EXTERNALS
			l_ptr: POINTER
		do
			drives := {ENVIRONMENT}.get_logical_drives
			create l_ext
			from
			until
				i = drives.count
			loop
				l_drive := drives.item (i)
				l_ptr := {MARSHAL}.string_to_h_global_ansi (l_drive)
				if l_ext.get_drive_type (l_ptr) = Drive_fixed then
					create root.make_from_text (drives.item (i))
					return := directory_tree.nodes.add_tree_node (root)
					add_directories (root)
				end
				{MARSHAL}.free_h_global (l_ptr)
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
				Result := {PATH}.combine (path_from_node (node.parent), node.text)
			end
		end

	check_box1_add_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to be performed when 'sorted' list is clicked.
		local
			i: INTEGER
		do
			directory_tree.set_sorted (check_box_1.checked)
			from
				i := 0
			until
				i = directory_tree.nodes.count
			loop
				i := i + 1
			end
		end

	image_list_combo_box_selected_index_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to be performed when combo box index changes
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

	check_box_2_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to enable hot tracking 
		do
			directory_tree.set_hot_tracking (check_box_2.checked)
		end

	check_box_3_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to enable showing of lines in tree
		do
			directory_tree.set_show_lines (check_box_3.checked)
		end

	check_box_4_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to enable showinf or root drive lines in tree
		do
			directory_tree.set_show_root_lines (check_box_4.checked)
		end

	check_box_5_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to enable showing of plus/minus in tree
		do
			directory_tree.set_show_plus_minus (check_box_5.checked)
		end

	check_box_6_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to enable check boxes in tree
		do
			directory_tree.set_check_boxes (check_box_6.checked)
		end

	check_box_7_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event to disable showing of selection when tree loses focus
		do
			directory_tree.set_hide_selection (check_box_7.checked)
		end

	indent_up_down_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Event when indent is changed
		do
			directory_tree.set_indent (
				{DECIMAL}.to_integer_32 (indent_up_down.value))
		end

	Drive_fixed: INTEGER is 3
			-- Value of a fixed, non removable disk drive.

invariant
	non_void_components: components /= Void
	non_void_directory_tree: directory_tree /= Void
	non_void_indent_up_down: indent_up_down /= Void
	non_void_tool_tip: tool_tip /= Void
	non_void_label_1: label_1 /= Void
	non_void_label_2: label_2 /= Void
	non_void_check_box_1: check_box_1 /= Void
	non_void_check_box_2: check_box_2 /= Void
	non_void_check_box_3: check_box_3 /= Void
	non_void_check_box_4: check_box_4 /= Void
	non_void_check_box_5: check_box_5 /= Void
	non_void_check_box_6: check_box_6 /= Void
	non_void_check_box_7: check_box_7 /= Void
	non_void_image_list_1: image_list_1 /= Void
	non_void_image_list_2: image_list_2 /= Void
	non_void_image_list_combo_box: image_list_combo_box /= Void
	non_void_grp_tree_view: grp_tree_view /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TREE_VIEW_CTL
