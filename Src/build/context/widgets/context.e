

deferred class CONTEXT  

inherit

	EB_TREE [WIDGET]
		rename
			item as widget,
			make as tree_create
		redefine
			parent
		end;
	TEXT_GENERATION;
	WINDOWS;
	CONSTANTS;
	COMMAND_ARGS
		rename
			First as first_arg,
			Second as second_arg
		end;
	CONTEXT_STONE
		rename
			source as widget
		end;
	EB_HASHABLE;
	CALLBACK_GENE;
	HOLE
		rename
			target as widget
		redefine
			stone, compatible
		end;
	REMOVABLE;
	NAMABLE;
	DEFERRED_CREATOR;
	EDITABLE
	
feature -- Editable

	create_editor is
		local
			ed, other_editor: CONTEXT_EDITOR;
			editor_form: INTEGER
		do
			editor_form := option_list @ 1;
			other_editor := context_catalog.editor 
					(Current, editor_form);
				--! Check to see if there is already an 
				--! editor for editor_form.
			if other_editor = Void then
				ed := window_mgr.context_editor;
				window_mgr.display (ed);
				ed.set_edited_context (Current);	
			else
				other_editor.raise
			end;
		end;

feature {NONE}

	update_tree_element is
		do
			tree_element.set_text (label);
			tree.display (original_stone);
			context_catalog.update_name_in_editors (Current);
		end;
	
feature -- Namable

	visual_name: STRING;
	
	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
			else
				visual_name := clone (s);
			end;
			update_tree_element;
		end;

	reset_name is
		do
			namer.reset
			integer_generator.reset;
		end;

feature -- Removable

	remove_yourself is
		local
			command: CONTEXT_CUT_CMD;
			a_parent: CONTEXT;
		do
			a_parent := parent;
				-- After cut, the parent field is Void
			!! command;
				-- Applied on original stone because of
				-- the bulletin_c that can be transformed
				-- in group_c
			command.execute (original_stone);
			tree.display (a_parent);
		end;

	
feature {NONE}

	stone: TYPE_STONE;

	compatible (s: TYPE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
			-- Process stone in current hole.
			-- By default, process only the attrib_stones
		local
			attrib_stone: ATTRIB_STONE;
		do
			attrib_stone ?= stone;
			if not (attrib_stone = Void) then
				attrib_stone.copy_attribute (original_stone);
			end;
		end;

	-- ************************
	-- * Hash coding features *
	-- ************************

	
feature 

	group_name: STRING is
		local
			con_group: GROUP_C;
		do
			con_group ?= Current;
			Result := parent.group_name;
			if Result /= Void then
				Result.append (entity_name);
				Result.append ("_");
			elseif con_group /= Void then
				!!Result.make (0);
				Result.append (entity_name);
				Result.append ("_");
			end;
		end;

	hash_code: INTEGER is
		do
			Result := entity_name.hash_code
		end;

	same (other: like Current): BOOLEAN is
		do
			Result := (other = Current)
		end;

	-- *****************
	-- * Stone section *
	-- *****************

	entity_name: STRING;
			-- Eiffel entity name of context
			-- associated wit the current stone

	identifier: INTEGER;
			-- Unique identifier

	
feature {NONE}

	namer: NAMER is
			-- Name generator for each type of context
		deferred
		end;
	
feature 

	label: STRING is
			-- Text label representing current stone
		do
			if (visual_name = Void) then
				Result := entity_name
			else
				Result := visual_name
			end;
		end;

	original_stone: CONTEXT is
			-- Canonical representative of current stone
		do
			Result := Current
		end;

feature {NONE}

	integer_generator: INT_GENERATOR is
			-- Integer generator for each type of context
		once
			!!Result
		end;
	
feature 

	context_type: CONTEXT_TYPE is
		deferred
		end;

	parent: CONTEXT;
			-- Parent of current context

	link_to_parent is
		require 
			parent_not_void: parent /= Void;
		do
			parent.child_finish;
			parent.put_child_right (Current);
		end;

	root: CONTEXT is
			-- Root  of context tree (window to
			-- which the context belongs)
		require
			parent_not_void: parent /= Void;
		do
			Result := parent.root
		end;

	is_bulletin: BOOLEAN is
			-- is widget a descendant of BULLETIN
		do
		end;

	is_window: BOOLEAN is
			-- Is Current a window (perm or temp window)?
		do
		end;

feature {NONE}

	initialize is
			-- Define the name and the identifier
		do
			tree_create (Void);
			set_next_identifier;
		end;
	
feature 
	set_identifier (i: INTEGER) is
		do
			identifier := i;
			if integer_generator.value < i then
				integer_generator.set (i);
			end;
		end;

	set_next_identifier is
		do
			if identifier = 0 then
				integer_generator.next;
				identifier := integer_generator.value;
			end;
		end;

	set_internal_name (a_name: STRING) is
			-- Set `entity_name' to `a_name'
		do
			entity_name := a_name;
		end;

	generate_internal_name is
			-- Use the namer to generate a new `entity_name'
		do
			namer.next;
			entity_name := namer.value;
		end;

	oui_create (a_parent: COMPOSITE) is
			-- Create the widget and define the callbacks
		do
			initialize;
			create_oui_widget (a_parent);
			add_widget_callbacks;
			!!tree_element.make (Current);
		end;

	create_oui_widget (a_parent: COMPOSITE) is
			-- Deferred routine for the real creaton of the widget
		deferred
		end;

	raise is
		do
			widget.raise;
		end;

	set_widget (a_widget: WIDGET) is
		do
			widget := a_widget
		end;

	change_widget (table: HASH_TABLE [WIDGET, CONTEXT]) is
			-- Change the widget reference
		local
			a_widget: WIDGET
		do
			a_widget := widget;
			widget := table.item (Current);
			table.force (a_widget, Current);
		end;

	save_widget (new_context: CONTEXT; table: HASH_TABLE [WIDGET, CONTEXT]) is
		local
			found: BOOLEAN
		do
			table.put (new_context.widget, Current);
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
						found := True;
						child.save_widget (new_context.child, table);
					end;
					new_context.child_forth;
				end;
				found := False;
				child_forth
			end;
		end;

	set_position (x_pos, y_pos: INTEGER) is
			-- Set the position of the context to
			-- the absolute position (x_pos, y_pos)
		require
			valid_parent: parent /= Void;
			parent_is_bulletin: parent.is_bulletin
		local
			new_x, new_y: INTEGER;
		do
			new_x := x_pos - parent.real_x;
			new_y := y_pos - parent.real_y;
			if new_x > parent.width or else new_x <= 0 then
				new_x := 0
			end;
			if new_y > parent.height or else new_y <= 0 then
				new_y := 0
			end;
			set_x_y (new_x, new_y);
			!! resize_policy.make;
			resize_policy.set_context (Current)
		end;

	
feature {NONE}

	add_widget_callbacks is
			-- Define the general behavior of the widget
		do
			if (parent = Void) or else not parent.is_group_composite then
					-- In a group, move is applied to the group,
					-- even if the cursor is on the children
				widget.add_enter_action (Eb_selection_mgr, Current);
			end;
			add_common_callbacks (widget);
			initialize_transport;
		end;

	add_common_callbacks (a_widget: WIDGET) is
			-- General callbacks forall types of contexts
		do
				-- Move and resize actions
			a_widget.set_action ("~Shift ~Ctrl<Btn1Down>", Eb_selection_mgr, third);
			a_widget.set_action ("<Btn1Up>", Eb_selection_mgr, second_arg);
				-- Shift actions
			a_widget.set_action ("Shift<Btn1Down>", Eb_selection_mgr, fourth);
				-- Ctrl actions (group)
			a_widget.set_action ("Ctrl<Btn1Down>", Eb_selection_mgr, fifth);
				-- Callbacks for arrow keys
			a_widget.set_action ("<Key>osfLeft", Eb_selection_mgr, Sixth);
			a_widget.set_action ("<Key>osfRight", Eb_selection_mgr, Seventh);
			a_widget.set_action ("<Key>osfUp", Eb_selection_mgr, Eighth);
			a_widget.set_action ("<Key>osfDown", Eb_selection_mgr, Nineth);
				-- Cursor shape
			a_widget.add_pointer_motion_action (Eb_selection_mgr, first_arg);
		end;

	remove_widget_callbacks is
		do
			widget.remove_button_press_action (2, show_command, Current);
			widget.remove_button_release_action (2, show_command, Nothing);
			widget.remove_button_press_action (3, transport_command, Current);
		end;
	
feature 

	remove_callbacks is
		do
			remove_widget_callbacks;
			from
				child_start
			until
				child_offright
			loop
				child.remove_callbacks;
				child_forth
			end;
		end;

	
feature {NONE}

	reset_widget_callbacks is
		do
			add_widget_callbacks;
			initialize_transport
		end;

	
feature 

	reset_callbacks is
		do
			reset_widget_callbacks;
			from
				child_start
			until
				child_offright
			loop
				child.reset_callbacks;
				child_forth
			end;
		end;

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		local
			create_command: CONTEXT_CREATE_CMD;
		do
			Result := New;
			a_parent.append (Result);
			Result.generate_internal_name;
			Result.oui_create (a_parent.widget);
				-- Void widget if context created for context catalog
			if widget /= Void then
				-- Copy the attributes of the source
				tree.disable_drawing;
				copy_attributes (Result);
				tree.enable_drawing;
			end;
			!!create_command;
			create_command.execute (Result);
		end;

	tree_element: TREE_ELEMENT;
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
			!! Result.make (1, Context_const.number_of_formats);
			add_to_option_list (Result);
			if is_bulletin then
				Result.put (Context_const.alignment_form_nbr, 
					Context_const.align_format_nbr);
				Result.put (Context_const.grid_form_nbr, 
					Context_const.grid_format_nbr)
			end;
			if resize_policy /= Void then
				Result.put (Context_const.bulletin_resize_form_nbr, 
				Context_const.resize_format_nbr)
			end;
			Result.put (Context_const.color_form_nbr, 
				Context_const.color_format_nbr)
			if is_fontable then
				Result.put (Context_const.font_form_nbr, 
					Context_const.font_format_nbr)
			end;
			Result.put (Context_const.behavior_form_nbr, 
				Context_const.behaviour_format_nbr)
		ensure
			valid_result: Result /= Void;
			result_not_empty: not Result.empty;
			valid_result_count: Result.count = 9
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
			-- List of specific forms for Current
			-- Context
		require
			valid_opt_list: opt_list /= Void;
			option_list_has_correct_count: 
					opt_list.count = Context_const.number_of_formats
		deferred
		end;
	
feature {NONE}

	-- *********************
	-- * Widget attributes *
	-- *********************
	
feature 

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := widget.x
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := widget.y
		end;

	width: INTEGER is
			-- Width of widget
		do
			Result := widget.width
		end;

	height: INTEGER is
			-- Height of widget
		do
			Result := widget.height
		end;

	set_real_x_y (x_pos, y_pos: INTEGER) is
			-- Set the x and y coord from
			-- selection manager.
		require
			valid_parent: parent /= Void;
			parent_is_bulletin: parent.is_bulletin
		local
			new_x, new_y: INTEGER;
		do
			new_x := x_pos;
			new_y := y_pos;
			if new_x < 0 or else 
				new_x > parent.width 
			then
				new_x := 0
			end;
			if new_y < 0 or else 
				new_y > parent.height 
			then
				new_y := 0
			end;
			set_x_y (new_x, new_y);
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require
			valid_parent: parent /= Void;
			parent_is_bulletin: parent.is_bulletin
		local
			eb_bulletin: SCALABLE;
			not_managed: BOOLEAN
		do
			position_modified := True;
			if parent.is_bulletin then
				if widget.managed then
					not_managed := True
					widget.unmanage
				end;
				widget.set_x_y (new_x, new_y);
				if not_managed then
					widget.manage
				end;
				eb_bulletin ?= parent.widget;
				eb_bulletin.update_ratios (widget);
			else
				widget.set_x_y (new_x, new_y);
			end;
		end;

	position_modified: BOOLEAN;

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		require
			valid_parent: parent /= Void;
			parent_is_bulletin: parent.is_bulletin
		local
			eb_bulletin: SCALABLE;
			not_managed: BOOLEAN
		do
			size_modified := True;
			if widget.managed then
				not_managed := True
				widget.unmanage
			end;
			widget.set_size (new_w, new_h);
			if not_managed then
				widget.manage
			end;
			eb_bulletin ?= parent.widget;
			eb_bulletin.update_ratios (widget);
		end;

	size_modified: BOOLEAN;

	real_x: INTEGER is
			-- Vertical position relative to root window
		do
			Result := widget.real_x
		end;

	real_y: INTEGER is
			-- horizontal position relative to root window
		do
			Result := widget.real_y
		end;

	hide is
		do
			if widget.realized and then widget.shown then
				widget.hide
			end
		end;

	show is
		do
			if widget.realized then
				widget.show
			else
				widget.realize
			end
		end;

	-- ***********************
	-- EiffelVision attributes
	-- ***********************

	bg_pixmap_name: STRING;

	set_bg_pixmap_name (a_string: STRING) is
		local
			a_pixmap: PIXMAP;
		do
			bg_pixmap_name := a_string;
			bg_pixmap_modified := False;
			if (a_string = Void) then 
				widget.set_background_pixmap (default_bg_pixmap)
			else
				!!a_pixmap.make;
				a_pixmap.read_from_file (a_string);
				if a_pixmap.is_valid then
					widget.set_background_pixmap (a_pixmap);
					bg_pixmap_modified := True;
				end;
			end;
		end;

	bg_pixmap_modified: BOOLEAN;

	default_bg_pixmap: PIXMAP is
		require
			widget_is_window: is_window
		once
			Result := widget.background_pixmap
		ensure
			valid_result: Result /= Void and then
						Result.is_valid
		end;

	set_default_bg_pixmap is
			-- Perm window will call this first.
		require
			widget_is_window: is_window
		do
			if default_bg_pixmap = Void then end
		end;

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
					widget.unmanage;
					widget.set_background_pixmap (pix)
					widget.manage
				end
			end
		end;

	bg_color_name: STRING;
	
	set_bg_color_name (a_color_name: STRING) is
		require
			never_empty_name: a_color_name /= Void implies 
							not a_color_name.empty
		local
			a_color: COLOR;
		do
			bg_color_name := a_color_name;
			if 	a_color_name = Void then
				bg_color_modified := False
			else
				!!a_color.make;
				a_color.set_name (a_color_name);
				widget.set_background_color (a_color);
				bg_color_modified := True;
			end;
		end;

	bg_color_modified: BOOLEAN;

	fg_color_name: STRING;
	
	set_fg_color_name (a_color_name: STRING) is
		require
			never_empty_name: a_color_name /= Void implies 
							not a_color_name.empty
		deferred
		end;

	fg_color_modified: BOOLEAN;

	font_name: STRING;

	font: FONT is
		local
			fontable: FONTABLE;
		do
			if is_fontable then
				fontable ?= widget;
				Result := fontable.font;
			end;	
		end;

	set_font_named (s: STRING) is
		local
			fontable: FONTABLE;
		do
			font_name_modified := False;
			if is_fontable then
				font_name := s;
				if s = Void then
					font_name_modified := False
				else
					font_name_modified := True;
					fontable ?= widget;
					widget.unmanage;
					fontable.set_font_name (s);
					widget.manage;
				end
			end;			
		end;

	font_name_modified: BOOLEAN;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'
		do
			if size_modified then
				other_context.set_size (width, height);
			end;
			if font_name_modified then
				other_context.set_font_named (font_name)
			end;
			if bg_color_modified then
				other_context.set_bg_color_name (bg_color_name)
			end;
			if bg_pixmap_modified then
				other_context.set_bg_pixmap_name (bg_pixmap_name)
			end;
			if fg_color_modified then
				other_context.set_fg_color_name (fg_color_name)
			end;
		end;

	-- ********************
	-- * Form attachments *
	-- ********************

--	attachments: FORM_ATTACHMENTS;
--			-- Attachments of the context if its parent
--			-- is a form

--	set_attachments (new_attachments: FORM_ATTACHMENTS) is
--		do
--			attachments := new_attachments
--		end;

	
feature 

	resize_policy: RESIZE_POLICY;

	set_resize_policy (new_elmt: RESIZE_POLICY) is
		do
			resize_policy := new_elmt;
			resize_policy.update;
		end;

	set_parent (a_parent: CONTEXT) is
			--  Set `parent' to `a_parent' without updating the tree
		do
			parent := a_parent
		end;

	is_fontable: BOOLEAN is
			-- Is curent context fontable ?.
		do
			Result := False
		end;

	is_group_composite: BOOLEAN is
			-- Is current context a special composite for
			-- groups of widgets (i.e. radio_box, check_box, ...)
		do
		end;

	is_a_group: BOOLEAN is
		do
		end;

	is_in_a_group: BOOLEAN is
		do
			Result := parent.is_in_a_group
		end;

	-- ***********
	-- * Edition *
	-- ***********

	is_selectionnable: BOOLEAN is
			-- Is current context selectionnable
		do
			Result := True
		end;

feature {NONE}

	Eb_selection_mgr: SELECTION_MANAGER is
			-- Selection manager
		once
			!!Result.make
		end;

feature 

	grouped: BOOLEAN;
			-- Is current context in the group list

	set_grouped (flag: BOOLEAN) is
			-- Set `grouped' to `flag'
		local
			a_context: CONTEXT
		do
			if flag then
				tree_element.select_figure;
				from
					a_context := parent
				until
					(a_context = Void)
				loop
					a_context.tree_element.set_children_visibility (True);
					a_context := a_context.parent
				end;
			else
				tree_element.deselect;
			end;
			grouped := flag;
		end;

	deleted: BOOLEAN is
		do
			Result := (parent = Void) or else parent.deleted
		end;

	group: LINKED_LIST [CONTEXT] is
		do
			Result := Eb_selection_mgr.group
		end;

	cut is
			-- Delete the context
		require
			parent_not_void: parent /= Void;
		do
			if  not parent.is_a_group then
				parent.child_start;
				parent.search_same_child (Current);
				parent.remove_child;
			end;
			if grouped then
				set_grouped (False)
			end;
			tree.cut (tree_element);
			context_catalog.clear_editors (Current);
			widget.set_managed (False);
		ensure
			widget_is_hidden: not widget.managed
		end;

	cut_list: LINKED_LIST [CONTEXT] is
			-- Current Context and all its children 
			-- that will be destroyed
		local
			a_child, new_child: CONTEXT;
		do
			!!Result.make;
			Result.put_right (Current);
			from
				a_child := first_child;
			until
				(a_child = Void)
			loop
				new_child := a_child.right_sibling;
				Result.merge_right (a_child.cut_list);
				a_child := new_child;
			end;
		ensure
			valid_result: Result /= Void;
			has_current: Result.has (Current);
		end;

	undo_cut is
			-- Undelete the context
		require
			widget_unmanaged: not widget.managed
		do
				-- If the parent is a group_c, the only link is
				-- the value of parent, the tree is not updated
				-- (but the context is in the subtree list of the parent)
			if (parent = Void) or else not parent.is_a_group then
				link_to_parent;
			end;
			tree.append (tree_element);
			widget.set_managed (True);
		ensure
			widget_shown: widget.managed
		end;

	hide_tree_elements is
			-- Remove the tree_elements from the context tree
		do
			if tree_element.show_children then
				from
					child_start
				until
					child_offright
				loop
					tree.cut (child.tree_element);
					child.hide_tree_elements;
					child_forth;
				end;
			end;
		end;

	show_tree_elements is
			-- Add the tree_elements in the context tree
		do
			if tree_element.show_children then
				from
					child_start
				until
					child_offright
				loop
					tree.append (child.tree_element);
					child.show_tree_elements;
					child_forth;
				end;
			end;
		end;

	reset_modified_flags is
			-- reset all the flags to false
			-- in a recursive way
			-- Useful for the code generation (groups)
		do
			position_modified := False;
			size_modified := False;
			fg_color_modified := False;
			bg_color_modified := False;
			bg_pixmap_modified := False;
			font_name_modified := False;
			if not (resize_policy = Void) then
				resize_policy.reset_modified_flags
			end;
			from
				child_start
			until
				child_offright
			loop
				child.reset_modified_flags;
				child_forth
			end;
		end;


	set_modified_flags is
			-- set all the flags to true
			-- in a recursive way
			-- Useful for the code generation (groups) after ungrouping
		do
			position_modified := True;
			size_modified := True;
			if fg_color_name /= Void and then not fg_color_name.empty then
				fg_color_modified := True;
			end;
			if bg_color_name /= Void and then not bg_color_name.empty then
				bg_color_modified := True;
			end;
			if bg_pixmap_name /= Void and then not bg_pixmap_name.empty then
				bg_pixmap_modified := True;
			end;
			if font_name /= Void and then not font_name.empty then
				font_name_modified := True;
			end;
			from
				child_start
			until
				child_offright
			loop
				child.set_modified_flags;
				child_forth
			end;
		end;

	-- **********************
	-- * Generation section *
	-- **********************

	
feature {CONTEXT}

	children_declaration: STRING is
			-- Generated string for the declaration of the
			-- children of the context
		do
			from
				!!Result.make (0);
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_declaration);
				child_forth
			end;
		end;

	eiffel_declaration: STRING is
			-- Generated string for the declaration of the context
			-- and all its children
		do
			!!Result.make (0);
			Result.append ("%T");
			Result.append (entity_name);
			Result.append (": ");
			Result.append (eiffel_type);
			Result.append (";%N");
			Result.append (children_declaration);
		end;

	children_creation (parent_name: STRING): STRING is
			-- Generated string for the creation of all the
			-- children of current context
		do
			from
				!!Result.make (0);
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_creation (parent_name));
				child_forth
			end;
		end;

	eiffel_creation (parent_name: STRING): STRING is
			-- Generated string for the creation of current context
			-- and all its children
		do
			!!Result.make (0);
			Result.append ("%T%T%T!!");
			Result.append (entity_name);
			Result.append (".make (%"");
			Result.append (entity_name);
			Result.append ("%", ");
			Result.append (parent_name);
			Result.append (");");
			if not (visual_name = Void) then
				Result.append ("%T-- ");
				Result.append (visual_name);
			end;
			Result.append ("%N");
			Result.append (children_creation (entity_name))
		end;

	children_initialization: STRING is
			-- Generated string for the initialization of all the
			-- descendants of the context
		do
			!!Result.make (0);
			from
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_initialization);
				child_forth
			end;
		end;

	
feature 

	full_name: STRING is
			-- full name of the context i.e. with root, group, ...
		do
			Result := intermediate_name;	
			if not Result.empty then
				Result.append (".");
			end;
			Result.append (entity_name);
		end;

	
feature {CONTEXT}

	intermediate_name: STRING is
			-- Intermediate name redefined for the elements
			-- of a group
		local
			mc: MENU_PULL_C;
			opc: OPT_PULL_C;
			bul: BULLETIN_C;
		do
			mc ?= parent;
			opc ?= parent;
			bul ?= parent;
			if mc /= Void or else opc /= Void 
				 or else bul /= Void then
				Result := parent.intermediate_name;
			else
				Result := parent.full_name;
			end;
		end;

	
feature {NONE}

	comment_text: STRING is
		do
			!!Result.make (0);
			if not (visual_name = Void) then
				Result.append ("%T%T%T%T-- ");
				Result.append (visual_name);
				Result.append ("%N");
			end;
		end;

	
feature {CONTEXT}

	eiffel_initialization: STRING is
			-- Generated string for the initialization of the context
			-- and all its descendants
		local
			context_name: STRING;
			comment: STRING;
		do
			!!Result.make (0);
			if group_name = Void then
				context_name := clone (entity_name);
			else
				context_name := full_name;
			end;
			context_name.append (".");
			Result.append (context_initialization (context_name));
			Result.append (font_creation (context_name));
			Result.append (position_initialization (context_name));
			if not Result.empty then
				Result.prepend (comment_text);
			end;
			Result.append (children_initialization);
--			Result.append (form_attachments_text (context_name));
			Result.append (bulletin_resize_text (context_name));
		end;

--	form_attachments_text (context_name: STRING): STRING is
--			-- Text generated for the attachments of
--			-- the children if the context is a form
--		do
--			Result.Create (0);
--			if is_form then
--				from
--					child_start
--				until
--					child_offright
--				loop
--					Result.append (child.attachments.generated_text (context_name));
--					child_forth
--				end;
--			end;
--		end;

	
feature {NONE}

	bulletin_resize_text (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if is_bulletin then
				from
					child_start
				until
					child_offright
				loop
					Result.append (child.resize_policy.generated_text (context_name));
					child_forth
				end;
			end;
		end;

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0);
			if parent.is_bulletin and then
					position_modified then
				function_int_int_to_string (Result, context_name, 
					"set_x_y", x, y);
			end;
			if parent.is_bulletin and then size_modified then
				function_int_int_to_string (Result, context_name, 
						"set_size", width, height);
			end;
		end;

	
feature 

	children_color: STRING is
			-- Generated string for the creation of all the
			-- colors and pximaps of the children of current context
		local
			context_name: STRING;
		do
			!!Result.make (0);
			from
				child_start
			until
				child_offright
			loop
				context_name := clone (child.entity_name);
				context_name.append (".");
				Result.append (child.eiffel_color (context_name));
				child_forth
			end;
		end;

	
feature {CONTEXT}

	eiffel_color (context_name: STRING): STRING is
			-- Generated string for the creation of all the
			-- colors and pixmaps of the current context
			-- and all its children
		do
			!!Result.make (0);
			if bg_pixmap_modified then
				Result.append ("%T%T%T!!a_pixmap.make;%N%T%T%Ta_pixmap.read_from_file (%"");
				Result.append (bg_pixmap_name);
				Result.append ("%");%N%T%T%T");
				Result.append (context_name);
				Result.append ("set_background_pixmap (a_pixmap);%N");
			end;
			if bg_color_modified then
				Result.append ("%T%T%T!!a_color.make;%N%T%T%Ta_color.set_name (%"");
				Result.append (bg_color_name);
				Result.append ("%");%N%T%T%T");
				Result.append (context_name);
				Result.append ("set_background_color (a_color);%N");
			end;
			if fg_color_modified then
				Result.append ("%T%T%T!!a_color.make;%N%T%T%Ta_color.set_name (%"");
				Result.append (fg_color_name);
				Result.append ("%");%N%T%T%T");
				Result.append (context_name);
				Result.append ("set_foreground (a_color);%N");
			end;
			if not Result.empty then
				Result.prepend (comment_text);
			end;
			result.append (children_color);
		end;

	
feature {NONE}

	font_creation (context_name: STRING): STRING is
			-- Eiffel code for the specification of
			-- the font associated with current context
		do
			!!Result.make (0);
			if font_name_modified then
				function_string_to_string (Result, context_name, "set_font_name", font_name)
			end;
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
			-- Specific initialization string for each type of context,
			-- 'context_name' can be the name of the context followed by a dot
			-- or an empty string if the context is at the higher level
		do
			!!Result.make (0)
		end;

	eiffel_callbacks: STRING is
		do
			!!Result.make (0);
			if is_window or else callback_generator.has (Current) then
				Result.append (callback_generator.eiffel_text (Current))
			end;
			Result.append (children_callbacks)
		end;

	children_callbacks: STRING is
		do
			from
				!!Result.make (0);
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_callbacks);
				child_forth
			end;	
		end;

	
feature {CLBKS, CONTEXT}

	eiffel_callback_calls: STRING is
		local
			context_name: STRING;
		do
			!!Result.make (0);
			if 
				(not is_window) and then callback_generator.has (Current)
			then
				if group_name = Void then
					context_name := clone (entity_name);
					context_name.append ("_");
				else
					context_name := group_name;
				end;
				Result.append ("%T%T%Tset_");
				Result.append (context_name);
				Result.append ("callbacks;");	
				if visual_name /= Void then
					Result.append ("%N%T%T%T-- (Widget's visual name is ");
					Result.append (visual_name);
					Result.append (")");
				end;
				Result.append ("%N");
			end;
			from
				child_start
			until
				child_offright
			loop
				Result.append (child.eiffel_callback_calls);
				child_forth
			end		
		end;

	
feature {NONE}

	creation_procedure_text: STRING is
		local
			creation_procedure: STRING
		do
			creation_procedure := clone (eiffel_type);
			creation_procedure.to_lower;
			creation_procedure.append ("_make");

			!!Result.make (100);
			Result.append ("%N%Tmake (a_name: STRING; a_parent: COMPOSITE) is%N%T%Tdo%N%T%T%T");
			Result.append (creation_procedure);
			Result.append (" (a_name, a_parent);%N");
		end;

	
feature 

	eiffel_text: STRING is
			-- Text of the class generated for this context and
			-- all its descendants, including declaration, creation
			-- and initialization
		local
			class_name: STRING;
			creation_procedure: STRING;
			color_text: STRING;
		do
			!!Result.make (0);

				-- ************
				-- Class header
				-- ************
			Result.append ("class ");
			class_name := clone (entity_name);
			class_name.to_upper;
			Result.append (class_name);

				-- ***********
				-- Inheritance
				-- ***********
			Result.append ("%N%Ninherit%N%N%T");
			Result.append ("WINDOWS;%N%N%TSTATES;%N%N%T");
			Result.append (eiffel_type);
			Result.append ("%N%T%Trename%N%T%T%Tmake as ");
				creation_procedure := clone (eiffel_type);
				creation_procedure.to_lower;
				creation_procedure.append ("_make");
			Result.append (creation_procedure);
			Result.append (",%N%T%T%Trealize as old_realize");
			Result.append ("%N%T%Tundefine%N%T%T%Tinit_toolkit");
			Result.append ("%N%T%Tend;%N%T");
			Result.append (eiffel_type);
			Result.append ("%N%T%Trename%N%T%T%Tmake as ");
			Result.append (creation_procedure);
			Result.append ("%N%T%Tundefine%N%T%T%Tinit_toolkit");
			Result.append ("%N%T%Tredefine%N%T%T%Trealize");
			Result.append ("%N%T%Tselect%N%T%T%Trealize%N%T%Tend");

				-- ********
				-- Features
				-- ********
			Result.append ("%N%Ncreation%N%N%Tmake");
			Result.append ("%N%Nfeature%N%N");

				-- Declaration
				--============
			Result.append (children_declaration);

				-- Creation
				--=========
			Result.append (creation_procedure_text);
			Result.append (children_creation ("Current"));
			Result.append ("%T%T%Tset_values;%N");
			Result.append ("%T%Tend;%N");

				-- Initialization
				--===============
			Result.append ("%N%Tset_values is%N%T%Tdo%N");
			Result.append (context_initialization (""));
			Result.append (font_creation (""));
			Result.append (children_initialization);
			Result.append (bulletin_resize_text (""));
			Result.append (position_initialization (""));

				-- Colors

			color_text := eiffel_color ("");
			if not color_text.empty then
				Result.append ("%T%T%Tset_colors;%N");
				Result.append ("%T%Tend;%N");
				Result.append ("%N%Tset_colors is%N%T%Tlocal%N%T%T%Ta_color: COLOR;%N%T%T%Ta_pixmap: PIXMAP%N%T%Tdo%N");
				Result.append (color_text);
			end;
			Result.append ("%T%Tend;%N");

			Result.append ("%N%Trealize is%N%T%Tdo%N%T%T%Tset_callbacks;%N%T%T%Told_realize%N%T%Tend;%N");

				-- Callbacks
				--==========
			Result.append (eiffel_callbacks);
			Result.append ("%Nend%N");
		end;

-- ******************************
-- Storage and retrieval features
-- ******************************

	stored_node: S_CONTEXT is
		deferred
		end;

	set_retrieved_node (a_node: S_CONTEXT) is
		do
			retrieved_node := a_node;
		end;

	retrieved_node: S_CONTEXT;

	retrieve_oui_widget is
		local
			parent_widget: COMPOSITE
		do
			if parent /= Void then
				parent_widget ?= parent.widget;
			end;
			oui_create (parent_widget);
			retrieved_node.set_context_attributes (Current);
			from
				child_start
			until
				child_offright
			loop
				child.retrieve_oui_widget;
				child_forth
			end;
			if not is_window then
				widget.manage;
			end;
			retrieved_node := Void;
		end;

	import_oui_widget (group_table: INT_H_TABLE [INTEGER]) is
		local
			parent_widget: COMPOSITE
		do
			generate_internal_name;
			retrieved_node.set_name_change (full_name);
			if not (parent = Void) then
				parent_widget ?= parent.widget;
			end;
			oui_create (parent_widget);
			retrieved_node.set_context_attributes (Current);
			from
				child_start
			until
				child_offright
			loop
				child.import_oui_widget (group_table);
				child_forth
			end;
			if not is_window then
				widget.manage;
			end;
			retrieved_node := Void
		end;

	realize is
		do
			widget.realize
		end;

end
