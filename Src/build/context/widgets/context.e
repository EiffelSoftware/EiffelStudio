indexing
	description: "General notion of a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class CONTEXT  

inherit

--	SHARED_EVENTS

	EB_TREE [EV_ANY]
		rename
			item as gui_object,
			make as tree_create
		redefine
			parent
		end

	TEXT_GENERATION

	WINDOWS

	CONSTANTS

	TYPE_DATA

	EB_HASHABLE

--	CALLBACK_GENE

	REMOVABLE

	NAMABLE
		redefine
			title_label
		end

	DEFERRED_CREATOR

	EDITABLE
		rename
			label as title_label
		end

--	PAINTER
--		undefine
--			init_toolkit
--		end	

--	UNDO_REDO_ACCELERATOR

feature -- Context creation

	create_context (a_parent: CONTEXT): like Current is
			-- Create a context of the same type
		local
			create_command: CONTEXT_CREATE_CMD
		do
			Result := New
			Result.set_parent (a_parent)
			Result.generate_internal_name
			Result.oui_create (a_parent.gui_object)
				-- Void GUI object if context created for context catalog
			if gui_object /= Void then
				-- Copy the attributes of the source
				copy_attributes (Result)
			end
			create create_command.make (Result)
			create_command.work
			create_command.update_history
		end

feature -- Removable

	remove_yourself is
		local
			cmd: CONTEXT_CUT_CMD
			par: CONTEXT
		do
			par := parent
				-- After cut, the parent field is Void
			create cmd.make (Current)
				-- Applied on original stone because of
				-- the bulletin_c that can be transformed
				-- in group_c
			cmd.work
			cmd.update_history
--			tree.display (a_parent)
		end

feature -- Editable

	create_editor is
			-- Create the context editor or raise it if exists.
		local
--			other_editor: CONTEXT_EDITOR
--			ed: CONTEXT_EDITOR_TOP_SHELL
--			editor_form: INTEGER
		do
--			editor_form := default_option_number
--			other_editor := context_catalog.editor 
--					(Current, editor_form)
--				--! Check to see if there is already an 
--				--! editor for editor_form.
--			if other_editor = Void then
--				ed := window_mgr.context_editor
--				window_mgr.display (ed)
--				ed.set_edited_context (Current)	
--			else
--				other_editor.raise
--			end
		end

-- 	default_option_number: INTEGER is
-- 			-- Default option list number
-- 		local
-- 			i: INTEGER
-- 			opt_list: ARRAY [INTEGER]
-- 		do
-- 			opt_list := option_list
-- 			from
-- 				i := 1
-- 			until
-- 				Result /= 0 or else
-- 					i > opt_list.count
-- 			loop
-- 				Result := opt_list.item (i)
-- 				i := i + 1
-- 			end
-- 		end

	update_instance_name_in_editor is
			-- Update the command instance name
			-- in the context editor (behaviour editor)
		local
--			other_editor: CONTEXT_EDITOR
		do
--			other_editor := context_catalog.editor 
--					(Current, Context_const.behavior_form_nbr)
--			if other_editor /= Void then	
--				other_editor.reset_behavior_editor
--			end
		end

	eiffel_type: STRING is
			-- Name of the class associated
			-- with current data
		deferred
		end

	is_valid_parent (parent_context: HOLDER_C): BOOLEAN is
			-- Is `parent_context' a valid parent?
			--| Valid if parent is not MENU_CONTAINER_C
		local
--			menu_c: MENU_CONTAINER_C
		do
			Result := (parent_context /= Void) -- and then
--						(not parent_context.is_group_composite)
--			menu_c ?= parent_context
--			Result := (menu_c = Void) and then 
--				not parent_context.is_group_composite
		end

feature -- Namable

	visual_name: STRING
			-- Name shown in the interface, given by the user
	
	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
			else
				visual_name := clone (s)
			end
			update_tree_element
		end

	reset_name is
			-- Reset the internal namer.
		do
			namer.reset
			integer_generator.reset
		end

feature {NONE} -- Internal namer

	namer: NAMER is
			-- Name generator for each type of context
		deferred
		end

	integer_generator: INT_GENERATOR is
			-- Integer generator for each type of context
		once
			create Result
		end

feature {NONE} -- Initialization

	initialize is
			-- Define the name and the identifier
		do
			tree_create (Void)
			set_next_identifier
		end
	
feature -- EB Tree

	parent: CONTEXT
			-- Parent of current context

	link_to_parent is
		require 
			parent_not_void: parent /= Void
		do
			parent.child_finish
			parent.put_child_right (Current)
		end

	root: CONTEXT is
			-- Root of context tree (window to
			-- which the context belongs)
		require
			parent_not_void: parent /= Void
		do
			Result := parent.root
		end

	-- *************************
	-- * Context tree features *
	-- *************************

feature

	hide_tree_elements is
			-- Remove the tree_elements from the context tree
		do
--			if tree_element.show_children then
				from
					child_start
				until
					child_offright
				loop
					child.tree_element.destroy
					child.hide_tree_elements
					child_forth
				end
--			end
		end

	show_tree_elements is
			-- Add the tree_elements in the context tree
		do
--			if tree_element.expand then
				from
					child_start
				until
					child_offright
				loop
					child.tree_element.destroy
					child.show_tree_elements
					child_forth
				end
--			end
		end

feature {GROUP_CMD}

	remove_tree_element is
		do
			tree_element.destroy
		end

feature {GROUP, CONTEXT} -- Update group name in context tree

--	update_group_name_in_tree (g: GROUP) is
--			-- Update the eiffel_type for group_c in context
--			-- tree using group `g'.
--		require
--			valid_g: g /= Void
--		local
--			group_c: GROUP_C
--		do
--			from
--				child_start
--			until
--				child_offright
--			loop
--				if child.is_a_group then
--					group_c ?= child
--					if group_c.group_type = g then
--						group_c.update_tree_element
--					end
--				end
--				child.update_group_name_in_tree (g)
--				child_forth
--			end
--		end

feature {CONTEXT, TREE_ELEMENT, SHOW_WINDOW_HOLE}

	update_tree_element is
		do
			tree_element.set_text (title_label)
--?			tree.display (data)
			update_visual_name_in_editor
--			context_catalog.update_name_in_editors (Current)
--			App_editor.update_context_name_in_editors (Current)
		end

	update_visual_name_in_editor is
			-- Update the format page of Current
			-- editor when visual name is changed
			-- (By default, does nothing).
		do
		end

	tree_element: TREE_ELEMENT
			-- Text element associated with the context
			-- in the context tree window

	-- *********************************
	-- * choices in the context editor *
	-- *********************************

feature

-- 	option_list: ARRAY [INTEGER] is
-- 			-- Array of the different forms
-- 			-- which define the attributes of
-- 			-- the context
-- 		do
-- 			!! Result.make (1, Context_const.number_of_formats)
-- 			add_to_option_list (Result)
-- 			Result.put (Context_const.behavior_form_nbr, 
-- 				Context_const.behaviour_format_nbr)
-- 			if is_bulletin then
-- 				Result.put (Context_const.alignment_form_nbr, 
-- 					Context_const.align_format_nbr)
-- 				Result.put (Context_const.grid_form_nbr, 
-- 					Context_const.grid_format_nbr)
-- 			end
-- 			if resize_policy /= Void then
-- 				Result.put (Context_const.bulletin_resize_form_nbr, 
-- 				Context_const.resize_format_nbr)
-- 			end
-- 			Result.put (Context_const.color_form_nbr, 
-- 				Context_const.color_format_nbr)
-- 			if is_fontable then
-- 				Result.put (Context_const.font_form_nbr, 
-- 					Context_const.font_format_nbr)
-- 			end
-- 		ensure
-- 			valid_result: Result /= Void
-- 			result_not_empty: not Result.empty
-- 			valid_result_count: Result.count = 9
-- 		end

-- 	add_to_option_list (opt_list: ARRAY [INTEGER]) is
-- 			-- List of specific forms for Current
-- 			-- Context
-- 		require
-- 			valid_opt_list: opt_list /= Void
-- 			option_list_has_correct_count: 
-- 					opt_list.count = Context_const.number_of_formats
-- 		deferred
-- 		end

feature

	select_tree_element_if_parent_selected is
		do
			if parent /= Void and then
				parent.tree_element.selected and then
				not tree_element.selected
			then
				tree_element.select_figure
			end
		end

-- feature {NONE} -- Hole
-- 
-- 	compatible (st: STONE): BOOLEAN is
-- 		do
-- 			Result := st.stone_type = Stone_types.attribute_type
-- 					or st.stone_type = Stone_types.command_type
-- 		end
-- 
-- 	process_attribute (dropped: ATTRIB_STONE) is
-- 			-- Process stone in current hole.
-- 			-- By default, process only the attrib_stones
-- 		do
-- 			dropped.copy_attribute (data)
-- 		end
-- 
-- 	current_state: BUILD_STATE is
-- 			-- Current state on the main panel.
-- 		do
-- 			Result := main_panel.current_state
-- 		end
-- 
-- 	process_instance (dropped: CMD_INST_STONE) is
-- 			-- Add command associated to `dropped' in current
-- 			-- state defined on the main panel.
-- 		local
-- 			the_stone: COMMAND_TOOL_HOLE
-- 			the_behavior: BEHAVIOR
-- 		do
-- 			the_stone ?= dropped
-- 			if the_stone /= Void then
-- 				if current_state = Void then
-- 					main_panel.set_current_state (app_editor.initial_state_circle.data)
-- 				end
-- 				current_state.find_input (Current)
-- 				if current_state.after then					
-- 					!! the_behavior.make
-- 					the_behavior.set_context (Current)
-- 					the_behavior.set_internal_name ("")
-- 					current_state.add (Current, the_behavior)
-- 				else
-- 					the_behavior := current_state.output.data
-- 				end
-- 				the_behavior.set_input_data (default_event)
-- 				the_behavior.set_output_data (the_stone.data)
-- 				the_behavior.drop_pair
-- 				the_behavior.reset_input_data
-- 				the_behavior.reset_output_data
-- 			end
-- 		end

feature {GENERATE_OBJECT_TOOL_CMD}

-- 	associate_instance (inst: CMD_INSTANCE) is
-- 			-- Associate an `inst' to Current in the `currrent_state'.
-- 		local
-- 			the_behavior: BEHAVIOR
-- 		do
-- 			if current_state = Void then
-- 				main_panel.set_current_state (app_editor.initial_state_circle.data)
-- 			end
-- 			current_state.find_input (Current)
-- 			if current_state.after then					
-- 				!! the_behavior.make
-- 				the_behavior.set_context (Current)
-- 				the_behavior.set_internal_name ("")
-- 				current_state.add (Current, the_behavior)
-- 			else
-- 				the_behavior := current_state.output.data
-- 			end
-- 			the_behavior.set_input_data (default_event)
-- 			the_behavior.set_output_data (inst)
-- 			the_behavior.drop_pair
-- 			the_behavior.reset_input_data
-- 			the_behavior.reset_output_data	
-- 		end

	-- ************************
	-- * Hash coding features *
	-- ************************

feature -- Hashable

	entity_name_in_lower_case: STRING is
		do
			Result := clone (entity_name)
			Result.to_lower
		end

	group_name: STRING is
		local
--			con_group: GROUP_C
		do
--			con_group ?= Current
--			Result := parent.group_name
--			if Result /= Void then
--				Result.append (entity_name_in_lower_case)
--				Result.append ("_")
--			elseif con_group /= Void then
--				!!Result.make (0)
--				Result.append (entity_name_in_lower_case)
--				Result.append ("_")
--			end
		end

	hash_code: INTEGER is
		do
			Result := entity_name.hash_code
		end

	same (other: like Current): BOOLEAN is
		do
			Result := (other = Current)
		end

	-- ********************
	-- * PND data section *
	-- ********************

feature -- Type data

	entity_name: STRING
			-- Eiffel entity name of context
			-- associated with the current stone

	identifier: INTEGER
			-- Unique identifier

	label: STRING is
			-- Text label representing current stone
		do
			if (visual_name = Void) then
				Result := entity_name
			else
				Result := visual_name
			end
		end

	title_label: STRING is
		do
			if (visual_name = Void) then
				Result := clone (entity_name)
				Result.append (" (")	
				Result.append (eiffel_type)
				Result.extend (')')	
			else
				Result := clone (visual_name)
				Result.append (" (")	
				Result.append (eiffel_type)
				Result.extend (')')	
			end
		end

--	type: CONTEXT_TYPE is
--		deferred
--		end

feature -- Status report

	is_container: BOOLEAN is
			-- Is `gui_object' a container ?
		do
		end


	is_invisible_container: BOOLEAN is
			-- Is `gui_object' an invisible container ?
		do
		end

	is_fixed: BOOLEAN is
			-- Is `gui_object' a descendant of EV_FIXED ?
		do
		end

	is_window: BOOLEAN is
			-- Is `gui_object' a window (base, perm or temp window)?
		do
		end

	is_perm_window: BOOLEAN is
			-- Is current context a permanent window (PERM_WIND_C)?
		do
		end

	is_resizable: BOOLEAN is
			-- Is Current able to be resized?
		do
			Result := True
		end

	is_movable: BOOLEAN is
			-- Is Current able to be positioned?
		do
			Result := True
		end

	is_fontable: BOOLEAN is
			-- Is curent context fontable ?.
		do
			Result := False
		end

	is_group_composite: BOOLEAN is
			-- Is current context a special composite for
			-- groups of widgets (i.e. radio_box, check_box, ...)
		do
		end

	is_a_group: BOOLEAN is
			-- Is Current context a group?
		do
		end

	is_in_a_group: BOOLEAN is
			-- Is Current context in a group?
		do
			Result := parent.is_a_group
			if not Result then
				Result := parent.is_in_a_group
			end
		end

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current context able to be grouped? (False by default).
		do
		end

	grouped: BOOLEAN
			-- Is current context in the group list

	deleted: BOOLEAN is
		do
			Result := (parent = Void) or else parent.deleted
		end

	shown: BOOLEAN is
		deferred
		end

feature -- Status setting

	set_parent (a_parent: CONTEXT) is
			--  Set `parent' to `a_parent' without updating the tree
		do
			parent := a_parent
		end

	set_identifier (i: INTEGER) is
		do
			identifier := i
			if integer_generator.value < i then
				integer_generator.set (i)
			end
		end

	set_next_identifier is
		do
			if identifier = 0 then
				integer_generator.next
				identifier := integer_generator.value
			end
		end

	set_internal_name (a_name: STRING) is
			-- Set `entity_name' to `a_name'
		do
			entity_name := a_name
		end

	generate_internal_name is
			-- Use the namer to generate a new `entity_name'
		do
			namer.next
			entity_name := namer.value
		end

	set_grouped (flag: BOOLEAN) is
			-- Set `grouped' to `flag'
		local
			a_context: CONTEXT
		do
			if flag then
				tree_element.select_figure
				from
					a_context := parent
				until
					(a_context = Void)
				loop
--					a_context.tree_element.expand
					a_context := a_context.parent
				end
			elseif grouped then
				tree_element.deselect
			end
			grouped := flag
		end

	hide is
		deferred
		end

	show is
		deferred
		end

feature -- GUI object creation

	oui_create (a_parent: EV_ANY) is
			-- Create the GUI object and
			-- its representative in the context tree.
		do
			retrieve_oui_create (a_parent)
			create tree_element.make (Current)
		end

	create_gui_object (a_parent: EV_ANY) is
			-- Deferred routine for the real creaton of the widget
		deferred
		end

	change_gui_object (table: HASH_TABLE [like gui_object, CONTEXT]) is
			-- Change the GUI object reference
		local
			an_object: like gui_object
		do
			an_object := gui_object
			gui_object := table.item (Current)
			table.force (an_object, Current)
		end

	save_gui_object (new_context: CONTEXT; table: HASH_TABLE [like gui_object, CONTEXT]) is
			-- Save 
		local
			found: BOOLEAN
		do
			table.put (new_context.gui_object, Current)
			from
				child_start
			until
				child_offright
			loop
				from
					new_context.child_start
				until
					new_context.child_offright or found
				loop
					if child.entity_name.is_equal (new_context.child.entity_name) then
						found := True
						child.save_gui_object (new_context.child, table)
					end
					new_context.child_forth
				end
				found := False
				child_forth
			end
		end

	set_position (new_x, new_y: INTEGER) is
			-- Set the position of the context to
			-- the absolute position (x_pos, y_pos)
		require
			valid_parent: parent /= Void
			parent_is_fixed: parent.is_fixed
--		local
--			new_x, new_y: INTEGER
		do
--			new_x := x_pos - parent.real_x
--			new_y := y_pos - parent.real_y
--			if new_x > parent.width or else new_x <= 0 then
--				new_x := 0
--			end
--			if new_y > parent.height or else new_y <= 0 then
--				new_y := 0
--			end
--			set_x_y (new_x, new_y)
		end

feature {NONE} -- GUI object callbacks

	add_gui_callbacks is
			-- Define the general behavior of the `gui_object'
		deferred
		end

	reset_gui_callbacks is
		do
			add_gui_callbacks
		end

	remove_gui_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		deferred
		end

feature -- Removing / Reseting callbacks

	remove_callbacks is
		do
			remove_gui_callbacks
			from
				child_start
			until
				child_offright
			loop
				child.remove_callbacks
				child_forth
			end
		end

	reset_callbacks is
		do
			reset_gui_callbacks
			from
				child_start
			until
				child_offright
			loop
				child.reset_callbacks
				child_forth
			end
		end

feature -- Possible commands to instanciate

--	default_commands_list: LINKED_LIST [CMD] is
--			-- List of possible command instances.
--		do
--			!! Result.make
--		end

feature {CONTEXT_TREE}

--	default_event: EVENT is
--			-- Default event.
--		deferred
--		end

feature {NONE} 

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'.
		deferred
		end

--feature {SELECTION_MANAGER}
--
--	is_selectionable: BOOLEAN is
--			-- Is current context selectionnable?
--		do
--			Result := True
--		end
--
--	is_selected: BOOLEAN
--			-- Is current context selected?
--	
--	set_selected (value: BOOLEAN) is
--			-- Select current context.
--		do
--			is_selected := value
--		end
--
--	display_resize_squares (logical_mode: INTEGER) is
--			-- Draw squares in the corners of the context, used to resize it.
--		local
--			x_position, y_position, corner_side: INTEGER
--			previous_logical_mode: INTEGER
--		do
--			if not is_window then
--				set_drawing (eb_screen)
--				previous_logical_mode := drawing_i.logical_mode
--				set_logical_mode (logical_mode)
--				set_subwindow_mode (1)
--				corner_side := Eb_selection_mgr.corner_side // 2
--				x_position := real_x + corner_side // 2
--				y_position := real_y + corner_side // 2
--				draw_squares (x_position, y_position)
--				x_position := x_position + width - corner_side
--				draw_squares (x_position, y_position)
--					y_position := y_position + height - corner_side
--				draw_squares (x_position, y_position)
--				x_position := real_x + corner_side // 2
--				draw_squares (x_position, y_position)
--				set_logical_mode (previous_logical_mode)
--			end
--		end
--
--feature {NONE}
--
--	draw_squares (x_position, y_position: INTEGER) is
--		local
--			context: CONTEXT
--			corner_side: INTEGER
--		do
--			corner_side := Eb_selection_mgr.corner_side // 2
--			from
--				context := parent
--			until
--				context.is_window
--			loop
--				context := context.parent
--			end
--			if x_position < context.real_x + context.width and then
--				y_position < context.real_y + context.height
--			then
--				fill_rectangle (x_position, y_position, corner_side, corner_side, 0.0)
--			end
--		end
--
-- 	Eb_selection_mgr: SELECTION_MANAGER is
-- 			-- Selection manager
-- 		once
-- 			!! Result.make
-- 		end

feature 

--	previous_bg_color: COLOR
--			-- Previous background color
--
--	set_selected_color is
--		local
--			parent_background_color_name: STRING
--		do
--			if bg_color_name = Void then
--				save_default_background_color
--			end
--			set_drawing (eb_screen)
--			previous_bg_color := widget.background_color
--			parent_background_color_name := widget.parent.background_color.name
--			if equal (previous_bg_color.name, Resources.selected_color.name) or
--			   equal (parent_background_color_name, Resources.selected_color.name)	
--			then
--				set_foreground (Resources.second_selected_color)
--			else	
--				set_foreground (Resources.selected_color)
--			end
--			display_resize_squares (3)
--		ensure
--			valid_previouse_color: previous_bg_color /= Void
--		end
--
--	deselect_color is
--		require
--			valid_previouse_color: previous_bg_color /= Void
--		do
--			widget.set_background_color (previous_bg_color)
--			previous_bg_color := Void
--		end

	group: LINKED_LIST [CONTEXT] is
			-- Selected group
		do
--			Result := Eb_selection_mgr.group
		end

	cut is
			-- Delete the context
		require
			parent_not_void: parent /= Void
		do
			if  not parent.is_a_group then
				parent.child_start
				parent.search_same_child (Current)
				parent.remove_child
			end
			if grouped then
				set_grouped (False)
			end
			tree_element.destroy
--			if tree_element.selected then
--				tree_element.deselect
--			end
--			context_catalog.clear_editors (Current)
			hide
		ensure
			gui_object_is_hidden: not shown
		end

	children_list_plus_current: LINKED_LIST [CONTEXT] is
			-- Current Context and all its children 
		do
			Result := cut_list
		end

	cut_list: LINKED_LIST [CONTEXT] is
			-- Current Context and all its children 
			-- that will be destroyed
		local
			a_child, new_child: CONTEXT
		do
			!!Result.make
			Result.put_right (Current)
			from
				a_child := first_child
			until
				(a_child = Void)
			loop
				new_child := a_child.right_sibling
				Result.merge_right (a_child.cut_list)
				a_child := new_child
			end
		ensure
			valid_result: Result /= Void
			has_current: Result.has (Current)
		end

	undo_cut is
			-- Undelete the context
		do
				-- If the parent is a group_c, the only link is
				-- the value of parent, the tree is not updated
				-- (but the context is in the subtree list of the parent)
			if (parent = Void) or else not parent.is_a_group then
				link_to_parent
			end
			create tree_element.make (Current)
--			if parent /= Void and then
--				parent.tree_element.selected and then
--				not tree_element.selected
--			then
--				tree_element.select_figure
--			end
			if not shown then
				show
			end
		ensure
			gui_object_shown: shown
		end

	reset_modified_flags is
			-- reset all the flags to false
			-- in a recursive way
			-- Useful for the code generation (groups)
		do
			from
				child_start
			until
				child_offright
			loop
				child.reset_modified_flags
				child_forth
			end
		end

	set_modified_flags is
			-- set all the flags to true
			-- in a recursive way
			-- Useful for the code generation (groups) after ungrouping
		do
			from
				child_start
			until
				child_offright
			loop
				child.set_modified_flags
				child_forth
			end
		end

	-- **************************
	-- * Eiffel code generation *
	-- **************************

feature {CONTEXT} -- Code Generation

	children_declaration: STRING is
			-- Generated string for the declaration of the
			-- children of the context
		do
			from
				!!Result.make (0)
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_declaration)
				child_forth
			end
		end

	eiffel_declaration: STRING is
			-- Generated string for the declaration of the context
			-- and all its children
		do
			!!Result.make (0)
			Result.append ("%T")
			Result.append (entity_name_in_lower_case)
			Result.append (": ")
			Result.append (eiffel_type)
			Result.append ("%N")
			Result.append (children_declaration)
			Result.append (comment_text)
			Result.append ("%N")
		end

	children_creation (parent_name: STRING): STRING is
			-- Generated string for the creation of all the
			-- children of current context
		do
			from
				!!Result.make (0)
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_creation (parent_name))
				child_forth
			end
		end

	eiffel_creation (parent_name: STRING): STRING is
			-- Generated string for the creation of current context
			-- and all its children
		do
			!!Result.make (0)
			Result.append ("%T%T%T!! ")
			Result.append (entity_name_in_lower_case)
			Result.extend ('.')
			Result.append (widget_creation_routine_name)
			Result.append (" (%"")
			Result.append (entity_name_in_lower_case)
			Result.append ("%", ")
			Result.append (parent_name)
			Result.append (")")
			Result.append ("%N")
			Result.append (children_creation (entity_name_in_lower_case))
		end

	widget_creation_routine_name: STRING is
		once
			Result := "make"
		end

	children_initialization: STRING is
			-- Generated string for the initialization of all the
			-- descendants of the context
		do
			!!Result.make (0)
			from
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_initialization)
				child_forth
			end
		end

feature -- Code Generation

	full_name: STRING is
			-- full name of the context i.e. with root, group, ...
		do
			Result := intermediate_name	
			if not Result.empty then
				Result.append (".")
			end
			Result.append (entity_name_in_lower_case)
		end

feature {CONTEXT} -- Code Generation

	intermediate_name: STRING is
			-- Intermediate name redefined for the elements
			-- of a group
		local
--			mc: MENU_PULL_C
--			opc: OPT_PULL_C
--			bul: BULLETIN_C
--			group_comp: GROUP_COMPOSITE_C
		do
--			mc ?= parent
--			opc ?= parent
--			bul ?= parent
--			group_comp ?= parent
--			if mc /= Void or else opc /= Void or else
--				 bul /= Void or else group_comp /= Void
--			then
--				Result := parent.intermediate_name
--			else
--				Result := parent.full_name
--			end
		end
	
feature {NONE}
			
	comment_text: STRING is
		do
			!!Result.make (0)
			if visual_name /= Void then
				Result.append ("%T%T%T-- ")
				Result.append (visual_name)
				Result.append ("%N")
			end
		end

	
feature {CONTEXT}

	eiffel_initialization: STRING is
			-- Generated string for the initialization of the context
			-- and all its descendants
		local
			context_name: STRING
			comment: STRING
		do
			!!Result.make (0)
			if group_name = Void then
				context_name := clone (entity_name_in_lower_case)
			else
				context_name := full_name
			end
			context_name.append (".")
			Result.append (context_initialization (context_name))
			Result.append (font_creation (context_name))
			Result.append (position_initialization (context_name))
			Result.append (children_initialization)
--			Result.append (bulletin_resize_text (context_name))
		end

feature {NONE}

-- 	bulletin_resize_text (context_name: STRING): STRING is
-- 		do
-- 			!!Result.make (0)
-- 			if is_fixed then
-- 				from
-- 					child_start
-- 				until
-- 					child_offright
-- 				loop
-- 					Result.append (child.resize_policy.generated_text (context_name))
-- 					child_forth
-- 				end
-- 			end
-- 		end

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
--			!!Result.make (0)
--			if parent.is_fixed and then
--					position_modified then
--				function_int_int_to_string (Result, context_name, 
--					"set_x_y", x, y)
--			end
--			if size_modified then
--				function_int_int_to_string (Result, context_name, 
--						"set_size", width, height)
--			end
		end

	
feature 

	children_color: STRING is
			-- Generated string for the creation of all the
			-- colors and pximaps of the children of current context
		local
			context_name: STRING
		do
			!!Result.make (0)
			from
				child_start
			until
				child_offright
			loop
				context_name := clone (child.full_name)
				context_name.append (".")
				Result.append (child.eiffel_color (context_name))
				child_forth
			end
		end

	
feature {CONTEXT}

	eiffel_color (context_name: STRING): STRING is
			-- Generated string for the creation of all the
			-- colors and pixmaps of the current context
			-- and all its children
		do
-- 			!!Result.make (0)
-- 			if bg_pixmap_modified then
-- 				Result.append ("%T%T%T!! a_pixmap.make%N%T%T%Ta_pixmap.read_from_file (%"")
-- 				Result.append (bg_pixmap_name)
-- 				Result.append ("%")%N%T%T%T")
-- 				Result.append (context_name)
-- 				Result.append ("set_background_pixmap (a_pixmap)%N")
-- 			end
-- 			if bg_color_modified then
-- 				Result.append ("%T%T%T!! a_color.make%N%T%T%Ta_color.set_name (%"")
-- 				Result.append (bg_color_name)
-- 				Result.append ("%")%N%T%T%T")
-- 				Result.append (context_name)
-- 				Result.append ("set_background_color (a_color)%N")
-- 			end
-- 			if fg_color_modified then
-- 				Result.append ("%T%T%T!! a_color.make%N%T%T%Ta_color.set_name (%"")
-- 				Result.append (fg_color_name)
-- 				Result.append ("%")%N%T%T%T")
-- 				Result.append (context_name)
-- 				Result.append ("set_foreground_color (a_color)%N")
-- 			end
-- 			--if not Result.empty then
-- 				--Result.prepend (comment_text)
-- 			--end
-- 			Result.append (children_color)
		end

	
feature {NONE}

	font_creation (context_name: STRING): STRING is
			-- Eiffel code for the specification of
			-- the font associated with current context
		do
-- 			!!Result.make (0)
-- 			if font_name_modified then
-- 				function_string_to_string (Result, context_name, "set_font_name", font_name)
-- 			end
		end

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
			-- Specific initialization string for each type of context,
			-- 'context_name' can be the name of the context followed by a dot
			-- or an empty string if the context is at the higher level
		do
			!!Result.make (0)
		end

	eiffel_callbacks: STRING is
		do
			!!Result.make (0)
--			if is_window or else callback_generator.has (Current) then
--				Result.append (callback_generator.eiffel_text (Current))
--			end
			Result.append (children_callbacks)
		end

	children_callbacks: STRING is
		do
			from
				!!Result.make (0)
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_callbacks)
				child_forth
			end	
		end

	
feature {CLBKS, CONTEXT}

	eiffel_callback_calls: STRING is
		local
			context_name: STRING
		do
			!!Result.make (0)
			if 
				(not is_window)
				-- and then callback_generator.has (Current)
			then
				if group_name = Void then
					context_name := clone (entity_name_in_lower_case)
					context_name.append ("_")
				else
					context_name := group_name
				end
				Result.append ("%T%T%Tset_")
				Result.append (context_name)
				Result.append ("callbacks")	
				if visual_name /= Void then
					Result.append ("%N%T%T%T-- (Widget's visual name is ")
					Result.append (visual_name)
					Result.append (")")
				end
				Result.append ("%N")
			end
			from
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_callback_calls)
				child_forth
			end		
		end

	
feature {NONE}

	creation_procedure_text: STRING is
		do
			!!Result.make (100)
			Result.append ("%N%Tmake (a_name: STRING; a_parent: SCREEN) is%N%T%Tdo%N")
			Result.append ("%T%T%TPrecursor (a_name, a_parent)%N")
		end

	
feature 

	eiffel_text: STRING is
			-- Text of the class generated for this context and
			-- all its descendants, including declaration, creation
			-- and initialization
		local
			class_name: STRING
			color_text: STRING
		do
			!!Result.make (0)

				-- ************
				-- Class header
				-- ************

			Result.append ("indexing%N%Tdescription: %"")
			Result.append (description_text)
			Result.append ("%"%N%Tdate: %"$Date$%"%N%Trevision: %"$Revision$%"%N%N")
			Result.append ("class ")
			class_name := clone (entity_name)
			class_name.to_upper
			Result.append (class_name)

				-- ***********
				-- Inheritance
				-- ***********
			Result.append ("%N%Ninherit%N%N%T")
			Result.append ("WINDOWS%N%N%TSTATES%N%N%T")
			Result.append (eiffel_type)
			Result.append ("%N%T%Tundefine%N%T%T%Tinit_toolkit")
			Result.append ("%N%T%Tredefine%N%T%T%Trealize,%N%T%T%Tmake%N%T%Tend")

				-- Creation
				--=========

			Result.append ("%N%Ncreation%N%N%Tmake")
			Result.append ("%N%Nfeature -- Creation%N")
			Result.append (creation_procedure_text)
			Result.append (children_creation ("Current"))
			Result.append ("%T%T%Tset_values%N")
			Result.append ("%T%Tend%N")


				-- Initialization
				--===============
			Result.append ("%N%Tset_values is%N%T%Tdo%N")
			Result.append (context_initialization (""))
			Result.append (font_creation (""))
			Result.append (children_initialization)
			Result.append (position_initialization (""))
--			Result.append (bulletin_resize_text (""))

				-- Colors

			color_text := eiffel_color ("")
			if not color_text.empty then
				Result.append ("%T%T%Tset_colors%N")
				Result.append ("%T%Tend%N")
				Result.append ("%N%Tset_colors is%N%T%Tlocal%N%T%T%Ta_color: COLOR%N%T%T%Ta_pixmap: PIXMAP%N%T%Tdo%N")
				Result.append (color_text)
			end
			Result.append ("%T%Tend%N")

				-- Declaration
				--============
			Result.append ("%Nfeature -- Attributes%N%N")
			Result.append (children_declaration)

				-- Realize
				--========

			Result.append ("feature -- Realization%N")
			Result.append ("%N%Trealize is%N%T%Tdo%N%T%T%Tset_callbacks%N%T%T%TPrecursor%N%T%Tend%N")

				-- Callbacks
				--==========
			Result.append (eiffel_callbacks)
			Result.append ("%Nend -- class ")
			Result.append (class_name)
			Result.extend ('%N')
		end

	description_text: STRING is
			-- Description of current class that appears in the indexing
			-- clause
		do
			!! Result.make (0)
		end

-- ******************************
-- Storage and retrieval features
-- ******************************

	retrieve_oui_create (a_parent: EV_ANY) is
			-- Create the widget and define the callbacks
			--| This oui_create does not create the
			--| tree element since it will be done
			--| after retrieving the attributes from
			--| the storer (an optimization)
		do
			initialize
			create_gui_object (a_parent)
			add_gui_callbacks
		end

--	retrieved_node: S_CONTEXT
--
--	stored_node: S_CONTEXT is
--		deferred
--		end
--
--	set_retrieved_node (a_node: S_CONTEXT) is
--		do
--			retrieved_node := a_node
--		end
--
--	retrieve_set_visual_name (s: STRING) is
--		require
--			valid_s: s /= Void
--		do
--			visual_name := clone (s)
--		end
--
--	retrieve_oui_widget is
--		local
--			parent_widget: COMPOSITE
--			temp_w: TEMP_WIND_C
--		do
--			if parent /= Void then
--				parent_widget ?= parent.widget
--			end
--			retrieve_oui_create (parent_widget)
--			retrieved_node.set_context_attributes (Current)
--			!! tree_element.make (Current)
--			if is_window then
--				realize
--				temp_w ?= Current
--				if temp_w /= Void then
--					show
--				end
--			else
--				widget.manage
--			end
--			from
--				child_start
--			until
--				child_offright
--			loop
--				child.retrieve_oui_widget
--				child_forth
--			end
--			retrieved_node := Void
--		end
--
--	import_oui_widget (group_table: INT_H_TABLE [INTEGER]) is
--		local
--			parent_widget: COMPOSITE
--			temp_w: TEMP_WIND_C
--		do
--			generate_internal_name
--			if parent /= Void then
--				parent_widget ?= parent.widget
--			end
--			retrieve_oui_create (parent_widget)
--			retrieved_node.set_context_attributes (Current)
--			!!tree_element.make (Current)
--			from
--				child_start
--			until
--				child_offright
--			loop
--				child.import_oui_widget (group_table)
--				child_forth
--			end
--			if is_window then
--				temp_w ?= Current
--				if temp_w /= Void then
--					show
--				end
--			else
--				widget.manage
--			end
--			retrieved_node := Void
--		end
--
--	full_type_name: STRING is
--			-- Name of type of current context.
--		deferred
--		end
--
end -- class CONTEXT

