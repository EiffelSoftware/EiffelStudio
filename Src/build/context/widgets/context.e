indexing
	description: "General notion of a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"


deferred class CONTEXT  

inherit
	SHARED_EVENTS
	SHARED_MODE
		rename
			current_mode as executing_or_editing_mode
		end
	MODE_CONSTANTS
	EB_TREE [WIDGET]
		rename
			item as widget,
			make as tree_create
		redefine
			parent
		end
	TEXT_GENERATION
	WINDOWS
	CONSTANTS
	COMMAND_ARGS
		rename
			First as first_arg,
			Second as second_arg
		end
	CONTEXT_STONE
	EB_HASHABLE
	CALLBACK_GENE
	HOLE
		rename
			target as widget
		redefine
			process_attribute, compatible, process_instance
		end
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
	DRAG_SOURCE
	TYPE_DATA

	
feature -- Guillaume

	set_insensitive is
		do
			widget.set_insensitive
		end

	set_sensitive is
		do
			widget.set_sensitive
		end

feature -- Editable

	create_editor is
		local
			other_editor: CONTEXT_EDITOR
			ed: CONTEXT_EDITOR_TOP_SHELL
			editor_form: INTEGER
		do
			editor_form := default_option_number
			other_editor := context_catalog.editor 
					(Current, editor_form)
				--! Check to see if there is already an 
				--! editor for editor_form.
			if other_editor = Void then
				ed := window_mgr.context_editor
				window_mgr.display (ed)
				ed.set_edited_context (Current)	
			else
				other_editor.raise
			end
		end

	default_option_number: INTEGER is
			-- Default option list number
		local
			i: INTEGER
			opt_list: ARRAY [INTEGER]
		do
			opt_list := option_list
			from
				i := 1
			until
				Result /= 0 or else
					i > opt_list.count
			loop
				Result := opt_list.item (i)
				i := i + 1
			end
		end

	update_instance_name_in_editor is
			-- Update the command instance name
			-- in the context editor (behaviour editor)
		local
			other_editor: CONTEXT_EDITOR
		do
			other_editor := context_catalog.editor 
					(Current, Context_const.behavior_form_nbr)
			if other_editor /= Void then	
				other_editor.reset_behavior_editor
			end
		end

	eiffel_type: STRING is
			-- Name of the class associated
			-- with current data
		deferred
		end

	is_valid_parent (parent_context: COMPOSITE_C): BOOLEAN is
			-- Is `parent_context' a valid parent?
			--| Valid if parent is not MENU_C
		local
			menu_c: MENU_C
		do
			menu_c ?= parent_context
			Result := menu_c = Void and then 
				not parent_context.is_group_composite
		end

feature {NONE, CONTEXT, SHOW_WINDOW_HOLE}

	update_tree_element is
		do
			tree_element.set_text (title_label)
			tree.display (data)
			update_visual_name_in_editor
			context_catalog.update_name_in_editors (Current)
			App_editor.update_context_name_in_editors (Current)
		end

	update_visual_name_in_editor is
			-- Update the format page of Current
			-- editor when visual name is changed
			-- (By default, does nothing).
		do
		end

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
	
feature -- Namable

	visual_name: STRING
	
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
		do
			namer.reset
			integer_generator.reset
		end

feature -- Removable

	remove_yourself is
		local
			command: CONTEXT_CUT_CMD
			a_parent: CONTEXT
		do
			a_parent := parent
				-- After cut, the parent field is Void
			!! command
				-- Applied on original stone because of
				-- the bulletin_c that can be transformed
				-- in group_c
			command.execute (data)
			tree.display (a_parent)
		end

	
feature {NONE}

	compatible (st: STONE): BOOLEAN is
		do
			Result := st.stone_type = Stone_types.attribute_type
					or st.stone_type = Stone_types.command_type
		end

	process_attribute (dropped: ATTRIB_STONE) is
			-- Process stone in current hole.
			-- By default, process only the attrib_stones
		do
			dropped.copy_attribute (data)
		end

	process_instance (dropped: CMD_INST_STONE) is
			-- Retarget the associted command tool creating
			-- a new instance of `dropped.data'.

		local
			the_stone: COMMAND_TOOL_HOLE
			the_behavior: BEHAVIOR
		do
			the_stone ?= dropped
			if the_stone /= Void then
				!! the_behavior.make
				the_behavior.set_context(Current)
				the_behavior.set_input_data(default_event)
				the_behavior.set_output_data(the_stone.data)
			--	the_behavior.drop_pair
			end
		end

	-- ************************
	-- * Hash coding features *
	-- ************************
	
feature 

	entity_name_in_lower_case: STRING is
		do
			Result := clone (entity_name)
			Result.to_lower
		end

	group_name: STRING is
		local
			con_group: GROUP_C
		do
			con_group ?= Current
			Result := parent.group_name
			if Result /= Void then
				Result.append (entity_name_in_lower_case)
				Result.append ("_")
			elseif con_group /= Void then
				!!Result.make (0)
				Result.append (entity_name_in_lower_case)
				Result.append ("_")
			end
		end

	hash_code: INTEGER is
		do
			Result := entity_name.hash_code
		end

	same (other: like Current): BOOLEAN is
		do
			Result := (other = Current)
		end

	-- *****************
	-- * Stone section *
	-- *****************

	entity_name: STRING
			-- Eiffel entity name of context
			-- associated wit the current stone

	identifier: INTEGER
			-- Unique identifier

	
feature {NONE}

	namer: NAMER is
			-- Name generator for each type of context
		deferred
		end
	
feature 

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

	source: WIDGET is
			-- Source of drag
		do
			Result := widget
		end

	data: CONTEXT is
			-- Canonical representative of current stone
		do
			Result := Current
		end

feature {NONE}

	integer_generator: INT_GENERATOR is
			-- Integer generator for each type of context
		once
			!!Result
		end
	
feature 

	type: CONTEXT_TYPE is
		deferred
		end

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
			-- Root  of context tree (window to
			-- which the context belongs)
		require
			parent_not_void: parent /= Void
		do
			Result := parent.root
		end

	is_bulletin: BOOLEAN is
			-- is widget a descendant of BULLETIN
		do
		end

	is_window: BOOLEAN is
			-- Is Current a window (perm or temp window)?
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

feature {NONE}

	initialize is
			-- Define the name and the identifier
		do
			tree_create (Void)
			set_next_identifier
		end
	
feature 
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

	oui_create (a_parent: COMPOSITE) is
			-- Create the widget and define the callbacks
		do
			retrieve_oui_create (a_parent)
			!!tree_element.make (Current)
		end

	create_oui_widget (a_parent: COMPOSITE) is
			-- Deferred routine for the real creaton of the widget
		deferred
		end

	raise is
		do
			widget.raise
		end

	set_widget (a_widget: WIDGET) is
		do
			widget := a_widget
		end

	change_widget (table: HASH_TABLE [WIDGET, CONTEXT]) is
			-- Change the widget reference
		local
			a_widget: WIDGET
		do
			a_widget := widget
			widget := table.item (Current)
			table.force (a_widget, Current)
		end

	save_widget (new_context: CONTEXT; table: HASH_TABLE [WIDGET, CONTEXT]) is
		local
			found: BOOLEAN
		do
			table.put (new_context.widget, Current)
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
						child.save_widget (new_context.child, table)
					end
					new_context.child_forth
				end
				found := False
				child_forth
			end
		end

	set_position (x_pos, y_pos: INTEGER) is
			-- Set the position of the context to
			-- the absolute position (x_pos, y_pos)
		require
			valid_parent: parent /= Void
			parent_is_bulletin: parent.is_bulletin
		local
			new_x, new_y: INTEGER
		do
			new_x := x_pos - parent.real_x
			new_y := y_pos - parent.real_y
			if new_x > parent.width or else new_x <= 0 then
				new_x := 0
			end
			if new_y > parent.height or else new_y <= 0 then
				new_y := 0
			end
			set_x_y (new_x, new_y)
		end

feature {NONE}

	add_widget_callbacks is
			-- Define the general behavior of the widget
		local
--			mode_backup: INTEGER
		do
--			mode_backup := executing_or_editing_mode
--			set_mode (editing_mode)
			if (parent = Void) or else not parent.is_group_composite then
					-- In a group, move is applied to the group,
					-- even if the cursor is on the children
				widget.add_enter_action (Eb_selection_mgr, Current)
			end
			add_common_callbacks (widget)
			initialize_transport
--			set_mode (mode_backup)
		end

	add_common_callbacks (a_widget: WIDGET) is
			-- General callbacks forall types of contexts
		do
				-- Move and resize actions
--			a_widget.set_several_modes (True)
			a_widget.set_action ("<Btn1Down>", Eb_selection_mgr, third)
			a_widget.set_action ("<Btn1Up>", Eb_selection_mgr, second_arg)
				-- Shift actions
			a_widget.set_action ("Shift<Btn1Down>", Eb_selection_mgr, fourth)
				-- Ctrl actions (group)
			a_widget.set_action ("Ctrl<Btn1Down>", Eb_selection_mgr, fifth)
				-- Callbacks for arrow keys
			a_widget.set_action ("<Key>osfLeft", Eb_selection_mgr, Sixth)
			a_widget.set_action ("<Key>osfRight", Eb_selection_mgr, Seventh)
			a_widget.set_action ("<Key>osfUp", Eb_selection_mgr, Eighth)
			a_widget.set_action ("<Key>osfDown", Eb_selection_mgr, Nineth)
				-- Cursor shape
			a_widget.add_pointer_motion_action (Eb_selection_mgr, first_arg)
		end

	reset_widget_callbacks is
		do
			add_widget_callbacks
			initialize_transport
		end

	remove_widget_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		do
			widget.remove_pointer_motion_action (Eb_selection_mgr, 
					first_arg)
			widget.remove_enter_action (Eb_selection_mgr, Current)
		end

feature -- Removing / Reseting callbacks

	remove_callbacks is
		do
			remove_widget_callbacks
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
			reset_widget_callbacks
			from
				child_start
			until
				child_offright
			loop
				child.reset_callbacks
				child_forth
			end
		end

feature 

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		local
			create_command: CONTEXT_CREATE_CMD
		do
			Result := New
			a_parent.append (Result)
			Result.generate_internal_name
			Result.oui_create (a_parent.widget)
				-- Void widget if context created for context catalog
			if widget /= Void then
				-- Copy the attributes of the source
				tree.disable_drawing
				copy_attributes (Result)
				tree.enable_drawing
			end
			!!create_command
			create_command.execute (Result)
		end

	tree_element: TREE_ELEMENT
			-- Text element associated with the context
			-- in the context tree window

	-- *********************************
	-- * choices in the context editor *
	-- *********************************

	option_list: ARRAY [INTEGER] is
			-- Array of the different forms
			-- which define the attributes of
			-- the context
		do
			!! Result.make (1, Context_const.number_of_formats)
			add_to_option_list (Result)
			if is_bulletin then
				Result.put (Context_const.alignment_form_nbr, 
					Context_const.align_format_nbr)
				Result.put (Context_const.grid_form_nbr, 
					Context_const.grid_format_nbr)
			end
			if resize_policy /= Void then
				Result.put (Context_const.bulletin_resize_form_nbr, 
				Context_const.resize_format_nbr)
			end
			Result.put (Context_const.color_form_nbr, 
				Context_const.color_format_nbr)
			if is_fontable then
				Result.put (Context_const.font_form_nbr, 
					Context_const.font_format_nbr)
			end
			Result.put (Context_const.behavior_form_nbr, 
				Context_const.behaviour_format_nbr)
		ensure
			valid_result: Result /= Void
			result_not_empty: not Result.empty
			valid_result_count: Result.count = 9
		end

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
			-- List of specific forms for Current
			-- Context
		require
			valid_opt_list: opt_list /= Void
			option_list_has_correct_count: 
					opt_list.count = Context_const.number_of_formats
		deferred
		end
	
feature {NONE}

	-- *********************
	-- * Widget attributes *
	-- *********************
	
feature 

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := widget.x
		end

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := widget.y
		end

	width: INTEGER is
			-- Width of widget
		do
			Result := widget.width
		end

	height: INTEGER is
			-- Height of widget
		do
			Result := widget.height
		end

	set_real_x_y (x_pos, y_pos: INTEGER) is
			-- Set the x and y coord from
			-- selection manager.
		require
			valid_parent: parent /= Void
			parent_is_bulletin: parent.is_bulletin
		local
			new_x, new_y: INTEGER
		do
			new_x := x_pos
			new_y := y_pos
			if new_x < 0 or else 
				new_x > parent.width 
			then
				new_x := 0
			end
			if new_y < 0 or else 
				new_y > parent.height 
			then
				new_y := 0
			end
			set_x_y (new_x, new_y)
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require
			valid_parent: parent /= Void
		local
			eb_bulletin: SCALABLE
			was_managed: BOOLEAN
		do
			position_modified := True
			if parent.is_bulletin then
				if widget.managed then
					was_managed := True
					widget.unmanage
				end
				widget.set_x_y (new_x, new_y)
				if was_managed then
					widget.manage
				end
				eb_bulletin ?= parent.widget
				eb_bulletin.update_ratios (widget)
			else
				widget.set_x_y (new_x, new_y)
			end
		end

	position_modified: BOOLEAN

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		require
			valid_parent: parent /= Void
		local
			eb_bulletin: SCALABLE
			not_managed: BOOLEAN
			group_composite: GROUP_COMPOSITE_C
		do
			size_modified := True
			if parent.is_bulletin then
				if widget.managed then
					not_managed := True
					widget.unmanage
				end
				widget.set_size (new_w, new_h)
				eb_bulletin ?= parent.widget
				eb_bulletin.update_ratios (widget)
				if not_managed then
					widget.manage
				end
			else
				widget.set_size (new_w, new_h)
			end
		end

	size_modified: BOOLEAN

	real_x: INTEGER is
			-- Vertical position relative to root window
		do
			Result := widget.real_x
		end

	real_y: INTEGER is
			-- horizontal position relative to root window
		do
			Result := widget.real_y
		end

	hide is
		do
			if widget.realized and then widget.shown then
				widget.hide
			end
		end

	shown: BOOLEAN is
		do
			Result := widget.shown
		end

	show is
		do
			if widget.realized then
				if not widget.shown then
					widget.show
				end
			else
				widget.realize
			end
		end

feature -- EiffelVision attributes

	bg_pixmap_name: STRING

	set_bg_pixmap_name (a_string: STRING) is
		local
			a_pixmap: PIXMAP
		do
			bg_pixmap_name := a_string
			bg_pixmap_modified := False
			if (a_string = Void or else a_string.empty) then 
				widget.set_background_pixmap (default_bg_pixmap)
			else
				!!a_pixmap.make
				a_pixmap.read_from_file (a_string)
				if a_pixmap.is_valid then
					widget.set_background_pixmap (a_pixmap)
					bg_pixmap_modified := True
				end
			end
		end

	bg_pixmap_modified: BOOLEAN

	default_bg_pixmap: PIXMAP is
		once
			Result := widget.background_pixmap
		ensure
--			valid_result: Result /= Void and then Result.is_valid
			valid_result: Result /= Void implies Result.is_valid
		end

	set_default_bg_pixmap is
			-- Perm window will call this first.
		require
			widget_is_window: is_window
		do
			if default_bg_pixmap = Void then end
		end

	set_grid (pix: PIXMAP) is
		require
			is_bulletin: is_bulletin
		do
			if pix = Void then
				if bg_pixmap_name /= Void then
					set_bg_pixmap_name (bg_pixmap_name)
				else
					widget.set_background_pixmap (default_bg_pixmap)
				end
			else
				if pix.is_valid then
					widget.set_background_pixmap (pix)
				end
			end
		end

feature -- Background color

	bg_color_name: STRING
	
	default_background_color: COLOR

	bg_color_modified: BOOLEAN

	set_bg_color_name (a_color_name: STRING) is
		local
			a_color: COLOR
		do
			if a_color_name = Void or else a_color_name.empty then
				bg_color_name := Void
				bg_color_modified := False
				-- reset to default
				a_color := default_background_color
				bg_color_modified := False
			else
				if bg_color_name = Void then
					save_default_background_color
				end
				bg_color_name := a_color_name
				!!a_color.make
				a_color.set_name (a_color_name)
				bg_color_modified := True
			end
			if a_color /= Void then
				if previous_bg_color = Void then
					widget.set_background_color (a_color)
				else
					previous_bg_color := a_color
				end
			end
		end

	save_default_background_color is
		require
			bg_color_is_void: bg_color_name = Void
		do
			if default_background_color = Void then
				default_background_color := widget.background_color
			end
			if fg_color_name = Void then
					--| This is done since setting background color
					--| could change the foreground color.
				save_default_foreground_color
			end
		end	

feature -- Foreground color

	fg_color_name: STRING
	
	default_foreground_color: COLOR

	fg_color_modified: BOOLEAN

	set_fg_color_name (a_color_name: STRING) is
		deferred
		end

	reset_default_foreground_color is
		require
			valid_default_foreground_color: default_foreground_color /= Void
		deferred
		end

	save_default_foreground_color is
		require
			fg_color_is_void: fg_color_name = Void
		deferred
		end	

feature -- Font

	font_name: STRING

	default_font: FONT

	save_default_font is
		require
			void_font_name: font_name = Void
			is_fontable: is_fontable
		local
			fontable: FONTABLE
		do
			if default_font = Void then
				fontable ?= widget
				default_font := fontable.font
			end
		end	

	font: FONT is
		local
			fontable: FONTABLE
		do
			if is_fontable then
				fontable ?= widget
				Result := fontable.font
			end	
		end

	set_font_named (s: STRING) is
		local
			fontable: FONTABLE
			old_w, old_h: INTEGER
			was_managed: BOOLEAN
		do
			font_name_modified := False
			if is_fontable then
				fontable ?= widget
				if s = Void or else s.empty then
					if default_font /= Void then
						was_managed := widget.managed
						if was_managed then
							old_w := width
							old_h := height
							widget.unmanage
						end
						fontable.set_font (default_font)		
						if was_managed then
							widget.set_size (old_w, old_h)
							widget.manage
						end
					end
					font_name_modified := False
					font_name := s
				else
					if font_name = Void then
						save_default_font
					end
					font_name := s
					font_name_modified := True
					was_managed := widget.managed
					if was_managed then
						old_w := width
						old_h := height
						widget.unmanage
					end
					fontable.set_font_name (s)
					if was_managed then
						widget.set_size (old_w, old_h)
						widget.manage
					end
				end
			end			
		end

	font_name_modified: BOOLEAN

	
feature {NONE} 

	default_event: EVENT is
			-- Default event.
		deferred
		end	

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'
		do
			if size_modified then
				other_context.set_size (width, height)
			end
			if font_name_modified then
				other_context.set_font_named (font_name)
			end
			if bg_color_modified then
				other_context.set_bg_color_name (bg_color_name)
			end
			if bg_pixmap_modified then
				other_context.set_bg_pixmap_name (bg_pixmap_name)
			end
			if fg_color_modified then
				other_context.set_fg_color_name (fg_color_name)
			end
		end

	-- ********************
	-- * Form attachments *
	-- ********************

--	attachments: FORM_ATTACHMENTS
--			-- Attachments of the context if its parent
--			-- is a form

--	set_attachments (new_attachments: FORM_ATTACHMENTS) is
--		do
--			attachments := new_attachments
--		end

	
feature 

	resize_policy: RESIZE_POLICY

	remove_resize_policy is
		do
			resize_policy := Void
		end

	set_resize_policy (new_elmt: like resize_policy) is
		do
			resize_policy := new_elmt
			resize_policy.update
		end

	set_parent (a_parent: CONTEXT) is
			--  Set `parent' to `a_parent' without updating the tree
		do
			parent := a_parent
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
			-- Is Current context able to be grouped?
		do
			Result := not is_in_a_group
		end

feature {SELECTION_MANAGER}

	is_selectionable: BOOLEAN is
			-- Is current context selectionnable
		do
			Result := True
		end

feature {NONE}

 	Eb_selection_mgr: SELECTION_MANAGER is
 			-- Selection manager
 		once
 			!!Result.make
 		end

feature {GROUP_CMD}

	remove_tree_element is
		do
			Tree.cut (tree_element)
		end

feature 

	grouped: BOOLEAN
			-- Is current context in the group list

	previous_bg_color: COLOR
			-- Previous background color

	set_selected_color is
		do
			if bg_color_name = Void then
				save_default_background_color
			end
			previous_bg_color := widget.background_color
			if equal (previous_bg_color.name, 
				Resources.selected_color.name) 
			then
				widget.set_background_color (Resources.second_selected_color)
			else	
				widget.set_background_color (Resources.selected_color)
			end
		ensure
			valid_previouse_color: previous_bg_color /= Void
		end

	deselect_color is
		require
			valid_previouse_color: previous_bg_color /= Void
		do
			widget.set_background_color (previous_bg_color)
			previous_bg_color := Void
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
					a_context.tree_element.set_children_visibility (True)
					a_context := a_context.parent
				end
			elseif grouped then
				tree_element.deselect
			end
			grouped := flag
		end

	deleted: BOOLEAN is
		do
			Result := (parent = Void) or else parent.deleted
		end

	group: LINKED_LIST [CONTEXT] is
			-- Selected group
		do
			Result := Eb_selection_mgr.group
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
			tree.cut (tree_element)
			if tree_element.selected then
				tree_element.deselect
			end
			context_catalog.clear_editors (Current)
			widget.set_managed (False)
		ensure
			widget_is_hidden: not widget.managed
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
			tree.append (tree_element)
			if parent /= Void and then
				parent.tree_element.selected and then
				not tree_element.selected
			then
				tree_element.select_figure
			end
			if not widget.managed then
				widget.set_managed (True)
			end
		ensure
			widget_shown: widget.managed
		end

	hide_tree_elements is
			-- Remove the tree_elements from the context tree
		do
			if tree_element.show_children then
				from
					child_start
				until
					child_offright
				loop
					tree.cut (child.tree_element)
					child.hide_tree_elements
					child_forth
				end
			end
		end

	show_tree_elements is
			-- Add the tree_elements in the context tree
		do
			if tree_element.show_children then
				from
					child_start
				until
					child_offright
				loop
					tree.append (child.tree_element)
					child.show_tree_elements
					child_forth
				end
			end
		end

	reset_modified_flags is
			-- reset all the flags to false
			-- in a recursive way
			-- Useful for the code generation (groups)
		do
			position_modified := False
			size_modified := False
			fg_color_modified := False
			bg_color_modified := False
			bg_pixmap_modified := False
			font_name_modified := False
			if not (resize_policy = Void) then
				resize_policy.reset_modified_flags
			end
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
			position_modified := True
			size_modified := True
			if fg_color_name /= Void and then not fg_color_name.empty then
				fg_color_modified := True
			end
			if bg_color_name /= Void and then not bg_color_name.empty then
				bg_color_modified := True
			end
			if bg_pixmap_name /= Void and then not bg_pixmap_name.empty then
				bg_pixmap_modified := True
			end
			if font_name /= Void and then not font_name.empty then
				font_name_modified := True
			end
			from
				child_start
			until
				child_offright
			loop
				child.set_modified_flags
				child_forth
			end
		end

feature {GROUP, CONTEXT} -- Update group name in context tree

	update_group_name_in_tree (g: GROUP) is
			-- Update the eiffel_type for group_c in context
			-- tree using group `g'.
		require
			valid_g: g /= Void
		local
			group_c: GROUP_C
		do
			from
				child_start
			until
				child_offright
			loop
				if child.is_a_group then
					group_c ?= child
					if group_c.group_type = g then
						group_c.update_tree_element
					end
				end
				child.update_group_name_in_tree (g)
				child_forth
			end
		end

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
			mc: MENU_PULL_C
			opc: OPT_PULL_C
			bul: BULLETIN_C
			group_comp: GROUP_COMPOSITE_C
		do
			mc ?= parent
			opc ?= parent
			bul ?= parent
			group_comp ?= parent
			if mc /= Void or else opc /= Void or else
				 bul /= Void or else group_comp /= Void
			then
				Result := parent.intermediate_name
			else
				Result := parent.full_name
			end
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
			Result.append (bulletin_resize_text (context_name))
		end

feature {NONE}

	bulletin_resize_text (context_name: STRING): STRING is
		do
			!!Result.make (0)
			if is_bulletin then
				from
					child_start
				until
					child_offright
				loop
					Result.append (child.resize_policy.generated_text (context_name))
					child_forth
				end
			end
		end

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0)
			if parent.is_bulletin and then
					position_modified then
				function_int_int_to_string (Result, context_name, 
					"set_x_y", x, y)
			end
			if size_modified then
				function_int_int_to_string (Result, context_name, 
						"set_size", width, height)
			end
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
			!!Result.make (0)
			if bg_pixmap_modified then
				Result.append ("%T%T%T!! a_pixmap.make%N%T%T%Ta_pixmap.read_from_file (%"")
				Result.append (bg_pixmap_name)
				Result.append ("%")%N%T%T%T")
				Result.append (context_name)
				Result.append ("set_background_pixmap (a_pixmap)%N")
			end
			if bg_color_modified then
				Result.append ("%T%T%T!! a_color.make%N%T%T%Ta_color.set_name (%"")
				Result.append (bg_color_name)
				Result.append ("%")%N%T%T%T")
				Result.append (context_name)
				Result.append ("set_background_color (a_color)%N")
			end
			if fg_color_modified then
				Result.append ("%T%T%T!! a_color.make%N%T%T%Ta_color.set_name (%"")
				Result.append (fg_color_name)
				Result.append ("%")%N%T%T%T")
				Result.append (context_name)
				Result.append ("set_foreground_color (a_color)%N")
			end
			--if not Result.empty then
				--Result.prepend (comment_text)
			--end
			result.append (children_color)
		end

	
feature {NONE}

	font_creation (context_name: STRING): STRING is
			-- Eiffel code for the specification of
			-- the font associated with current context
		do
			!!Result.make (0)
			if font_name_modified then
				function_string_to_string (Result, context_name, "set_font_name", font_name)
			end
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
			if is_window or else callback_generator.has (Current) then
				Result.append (callback_generator.eiffel_text (Current))
			end
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
				(not is_window) and then callback_generator.has (Current)
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
--			creation_procedure: STRING
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
			Result.append (bulletin_resize_text (""))

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

	retrieved_node: S_CONTEXT

	retrieve_oui_create (a_parent: COMPOSITE) is
			-- Create the widget and define the callbacks
			--| This oui_create does not create the
			--| tree element since it will be done
			--| after retrieving the attributes from
			--| the storer (an optimization)
		do
			initialize
			create_oui_widget (a_parent)
			if not is_window then
				!! resize_policy
				resize_policy.set_context (Current)
			end
			add_widget_callbacks
		end

	stored_node: S_CONTEXT is
		deferred
		end

	set_retrieved_node (a_node: S_CONTEXT) is
		do
			retrieved_node := a_node
		end

	retrieve_set_visual_name (s: STRING) is
		require
			valid_s: s /= Void
		do
			visual_name := clone (s)
		end

	retrieve_oui_widget is
		local
			parent_widget: COMPOSITE
			temp_w: TEMP_WIND_C
		do
			if parent /= Void then
				parent_widget ?= parent.widget
			end
			retrieve_oui_create (parent_widget)
			retrieved_node.set_context_attributes (Current)
			!! tree_element.make (Current)
			from
				child_start
			until
				child_offright
			loop
				child.retrieve_oui_widget
				child_forth
			end
			if is_window then
				realize
				temp_w ?= Current
				if temp_w /= Void then
					show
				end
			else
				widget.manage
			end
			retrieved_node := Void
		end

	import_oui_widget (group_table: INT_H_TABLE [INTEGER]) is
		local
			parent_widget: COMPOSITE
			temp_w: TEMP_WIND_C
		do
			generate_internal_name
			if parent /= Void then
				parent_widget ?= parent.widget
			end
			retrieve_oui_create (parent_widget)
			retrieved_node.set_context_attributes (Current)
			!!tree_element.make (Current)
			from
				child_start
			until
				child_offright
			loop
				child.import_oui_widget (group_table)
				child_forth
			end
			if is_window then
				temp_w ?= Current
				if temp_w /= Void then
					show
				end
			else
				widget.manage
			end
			retrieved_node := Void
		end

	realize is
		do
			widget.realize
		end

	full_type_name: STRING is
			-- Name of type of current context.
		deferred
		end
end
