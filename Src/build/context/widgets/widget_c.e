indexing
	description: "Widget context"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIDGET_C

inherit
	CONTEXT
		redefine
			gui_object,
			create_context,
			reset_modified_flags,
			set_modified_flags,
			is_able_to_be_grouped
		end

	UNDO_REDO_ACCELERATOR

feature -- Context creation

	create_context (a_parent: CONTAINER_C): like Current is
			-- Create a context of the same type
		do
			Result ?= {CONTEXT} Precursor (a_parent)
			a_parent.append (Result)
		end

feature {NONE} 

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'.
		do
			if size_modified then
				other_context.set_size (width, height)
			end
-- 			if font_name_modified then
-- 				other_context.set_font_named (font_name)
-- 			end
-- 			if bg_color_modified then
-- 				other_context.set_bg_color_name (bg_color_name)
-- 			end
-- 			if bg_pixmap_modified then
-- 				other_context.set_bg_pixmap_name (bg_pixmap_name)
-- 			end
-- 			if fg_color_modified then
-- 				other_context.set_fg_color_name (fg_color_name)
-- 			end
		end

	reset_modified_flags is
			-- reset all the flags to false
			-- in a recursive way
			-- Useful for the code generation (groups)
		do
			position_modified := False
			size_modified := False
--			fg_color_modified := False
--			bg_color_modified := False
--			bg_pixmap_modified := False
--			font_name_modified := False
			{CONTEXT} Precursor
		end

	set_modified_flags is
			-- set all the flags to true
			-- in a recursive way
			-- Useful for the code generation (groups) after ungrouping
		do
			position_modified := True
			size_modified := True
-- 			if fg_color_name /= Void and then not fg_color_name.empty then
-- 				fg_color_modified := True
-- 			end
-- 			if bg_color_name /= Void and then not bg_color_name.empty then
-- 				bg_color_modified := True
-- 			end
-- 			if bg_pixmap_name /= Void and then not bg_pixmap_name.empty then
-- 				bg_pixmap_modified := True
-- 			end
-- 			if font_name /= Void and then not font_name.empty then
-- 				font_name_modified := True
-- 			end
			{CONTEXT} Precursor
		end

feature {NONE} -- Callbacks

	add_gui_callbacks is
			-- Define the general behavior of the GUI object.
		do
-- 			if (parent = Void) or else not parent.is_group_composite then
-- 					-- In a group, move is applied to the group,
-- 					-- even if the cursor is on the children
-- 				
-- 				gui_object.add_enter_notify_command (Eb_selection_mgr, Current)
-- 			else
-- 				gui_object.add_enter_notify_command (Eb_selection_mgr, parent)
-- 			end
			add_common_callbacks (gui_object)
			initialize_transport
		end

	add_common_callbacks (an_object: like gui_object) is
			-- General callbacks for all types of contexts
		do
--XX	Use Vision drag and drop...
--				-- Undo/redo callback
--			add_undo_redo_accelerator (an_object)
-- 				-- Cursor motion
-- 			an_object.add_pointer_motion_action (Eb_selection_mgr, first_arg)
-- 				-- Move and resize action
-- 			an_object.set_action ("<Btn1Up>", Eb_selection_mgr, second_arg)
-- 			    -- Select action
-- 			an_object.add_button_press_action (1, Eb_selection_mgr, third)
-- 				-- Shift actions
-- 			an_object.set_action ("Shift<Btn1Down>", Eb_selection_mgr, fourth)
-- 			an_object.set_action ("Shift<Btn1Up>", Eb_selection_mgr, second_arg)
-- 				-- Ctrl actions (group)
-- 			an_object.set_action ("Ctrl<Btn1Down>", Eb_selection_mgr, fifth)
-- 			an_object.set_action ("Ctrl<Btn1Up>", Eb_selection_mgr, second_arg)
-- 				-- Callbacks for arrow keys
-- 			an_object.set_action ("<Key>LEFT", Eb_selection_mgr, sixth)
-- 			an_object.set_action ("<Key>RIGHT", Eb_selection_mgr, seventh)
-- 			an_object.set_action ("<Key>UP", Eb_selection_mgr, eighth)
-- 			an_object.set_action ("<Key>DOWN", Eb_selection_mgr, nineth)
		end

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current context may be dragged and
			-- dropped.
		local
			routine_cmd: EV_ROUTINE_COMMAND
		do
			gui_object.activate_pick_and_drop (3, Current, Pnd_types.context_type)
--			create routine_cmd.make (~process_attribute)
--			gui_object.add_pnd_command (Pnd_types.attribute_type, routine_cmd, Void)
--			create routine_cmd.make (~process_instance)
--			gui_object.add_pnd_command (Pnd_types.command_type, routine_cmd, Void)
		end

	remove_gui_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		do
--			gui_object.remove_pointer_motion_action (Eb_selection_mgr, 
--					first_arg)
--			gui_object.remove_enter_action (Eb_selection_mgr, Current)
		end

feature -- Status report

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := gui_object.x
		end

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := gui_object.y
		end

	position_modified: BOOLEAN

	width: INTEGER is
			-- Width of `gui_object'
		do
			Result := gui_object.width
		end

	height: INTEGER is
			-- Height of `gui_object'
		do
			Result := gui_object.height
		end

	size_modified: BOOLEAN

-- 	real_x: INTEGER is
-- 			-- Vertical position relative to root window
-- 		do
-- 			Result := gui_object.real_x
-- 		end

-- 	real_y: INTEGER is
-- 			-- horizontal position relative to root window
-- 		do
-- 			Result := gui_object.real_y
-- 		end

	shown: BOOLEAN is
		do
			Result := gui_object.shown
		end

	is_able_to_be_grouped: BOOLEAN is
		do
			Result := not is_in_a_group and then parent.is_invisible_container
			if Result then
				from
					group.start
				until
					group.after
				loop
					Result := (group.item.parent = parent)
				end
			end
		end

feature -- Status setting

-- 	set_real_x_y (x_pos, y_pos: INTEGER) is
-- 			-- Set the x and y coord from
-- 			-- selection manager.
-- 		require
-- 			valid_parent: parent /= Void
-- 			parent_is_bulletin: parent.is_bulletin
-- 		local
-- 			new_x, new_y: INTEGER
-- 		do
-- 			new_x := x_pos
-- 			new_y := y_pos
-- 			if new_x < 0 then
-- 				new_x := 0
-- 			elseif new_x + width > parent.width then
-- 				new_x := parent.width - width
-- 			end
-- 			if new_y < 0 then
-- 				new_y := 0
-- 			elseif new_y + height > parent.height then
-- 				new_y := parent.height - height
-- 			end
-- 			set_x_y (new_x, new_y)
-- 		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of `gui_object'.
		require
			valid_parent: parent /= Void
		local
-- 			eb_bulletin: SCALABLE
-- 			was_managed: BOOLEAN
		do
			gui_object.set_x_y (new_x, new_y)
-- 			position_modified := True
-- 			if parent.is_bulletin then
-- 				if gui_object.managed then
-- 					was_managed := True
-- 					gui_object.unmanage
-- 				end
-- 				gui_object.set_x_y (new_x, new_y)
-- 				if was_managed then
-- 					gui_object.manage
-- 				end
-- 				eb_bulletin ?= parent.gui_object
-- 				eb_bulletin.update_ratios (gui_object)
-- 			else
-- 				gui_object.set_x_y (new_x, new_y)
-- 			end
		end

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of `gui_object'.
		require
			valid_parent: parent /= Void
		local
-- 			eb_bulletin: SCALABLE
-- 			not_managed: BOOLEAN
-- 			group_composite: GROUP_COMPOSITE_C
		do
			gui_object.set_size (new_w, new_h)
-- 			size_modified := True
-- 			if parent.is_bulletin then
-- 				if gui_object.managed then
-- 					not_managed := True
-- 					gui_object.unmanage
-- 				end
-- 				gui_object.set_size (new_w, new_h)
-- 				eb_bulletin ?= parent.gui_object
-- 				eb_bulletin.update_ratios (gui_object)
-- 				if not_managed then
-- 					gui_object.manage
-- 				end
-- 			else
-- 				gui_object.set_size (new_w, new_h)
-- 			end
		end

	hide is
		do
			if shown then
				gui_object.hide
			end
		end

	show is
		do
			if not shown then
				gui_object.show
			end
		end
 
-- feature -- Background color
-- 
-- 	bg_color_name: STRING
-- 	
-- 	default_background_color: COLOR
-- 
-- 	bg_color_modified: BOOLEAN
-- 
-- 	set_bg_color_name (a_color_name: STRING) is
-- 		local
-- 			a_color: COLOR
-- 		do
-- 			if a_color_name = Void or else a_color_name.empty then
-- 				bg_color_name := Void
-- 				bg_color_modified := False
-- 				-- reset to default
-- 				a_color := default_background_color
-- 				bg_color_modified := False
-- 			else
-- 				if bg_color_name = Void then
-- 					save_default_background_color
-- 				end
-- 				bg_color_name := a_color_name
-- 				!!a_color.make
-- 				a_color.set_name (a_color_name)
-- 				bg_color_modified := True
-- 			end
-- 			if a_color /= Void then
-- 				if previous_bg_color = Void then
-- 					widget.set_background_color (a_color)
-- 				else
-- 					previous_bg_color := a_color
-- 				end
-- 			end
-- 		end
-- 
-- 	save_default_background_color is
-- 		require
-- 			bg_color_is_void: bg_color_name = Void
-- 		do
-- 			if default_background_color = Void then
-- 				default_background_color := widget.background_color
-- 			end
-- 			if fg_color_name = Void then
-- 					--| This is done since setting background color
-- 					--| could change the foreground color.
-- 				save_default_foreground_color
-- 			end
-- 		end	
-- 
-- feature -- Foreground color
-- 
-- 	fg_color_name: STRING
-- 	
-- 	default_foreground_color: COLOR
-- 
-- 	fg_color_modified: BOOLEAN
-- 
-- 	set_fg_color_name (a_name: STRING) is
-- 		local
-- 			a_color: COLOR
-- 		do
-- 			if a_name = Void or else a_name.empty then
-- 				fg_color_modified := False
-- 				fg_color_name := Void
-- 				a_color := default_foreground_color
-- 				if a_color /= Void then
-- 					widget.set_foreground_color (a_color)
-- 				end
-- 			else
-- 				if fg_color_name = Void then
-- 					save_default_foreground_color
-- 				end
-- 				fg_color_name := a_name
-- 				fg_color_modified := True
-- 				!!a_color.make
-- 				a_color.set_name (a_name)
-- 				widget.set_foreground_color (a_color)
-- 			end
-- 		end
-- 
-- 	save_default_foreground_color is
-- 		require
-- 			fg_color_is_void: fg_color_name = Void
-- 		do
-- 			if default_foreground_color = Void then
-- 		   		default_foreground_color := widget.foreground_color
-- 			end
-- 		end
-- 
-- 	reset_default_foreground_color is
-- 		require
-- 			valid_default_foreground_color: default_foreground_color /= Void
-- 		do
-- 			widget.set_foreground_color (default_foreground_color)
-- 		end
-- 
-- feature -- EiffelVision attributes
-- 
-- 	bg_pixmap_name: STRING
-- 
-- 	set_bg_pixmap_name (a_string: STRING) is
-- 		local
-- 			a_pixmap: PIXMAP
-- 		do
-- 			bg_pixmap_name := a_string
-- 			bg_pixmap_modified := False
-- 			if (a_string = Void or else a_string.empty) then 
-- 				widget.set_background_pixmap (default_bg_pixmap)
-- 			else
-- 				!!a_pixmap.make
-- 				a_pixmap.read_from_file (a_string)
-- 				if a_pixmap.is_valid then
-- 					widget.set_background_pixmap (a_pixmap)
-- 					bg_pixmap_modified := True
-- 				end
-- 			end
-- 		end
-- 
-- 	bg_pixmap_modified: BOOLEAN
-- 
-- 	default_bg_pixmap: PIXMAP is
-- 		once
-- 			Result := widget.background_pixmap
-- 		ensure
-- --			valid_result: Result /= Void and then Result.is_valid
-- 			valid_result: Result /= Void implies Result.is_valid
-- 		end
-- 
-- 	set_default_bg_pixmap is
-- 			-- Perm window will call this first.
-- 		require
-- 			widget_is_window: is_window
-- 		do
-- 			if default_bg_pixmap = Void then end
-- 		end
-- 
-- 	set_grid (pix: PIXMAP) is
-- 			--XX Only for container
-- 		require
-- 			is_bulletin: is_bulletin
-- 		do
-- 			if pix = Void then
-- 				if bg_pixmap_name /= Void then
-- 					set_bg_pixmap_name (bg_pixmap_name)
-- 				else
-- 					widget.set_background_pixmap (default_bg_pixmap)
-- 				end
-- 			else
-- 				if pix.is_valid then
-- 					widget.set_background_pixmap (pix)
-- 				end
-- 			end
-- 		end

-- feature -- Font
--XX Create a class FONTABLE_C ? 
--
-- 	font_name: STRING
-- 
-- 	default_font: FONT
-- 
-- 	save_default_font is
-- 		require
-- 			void_font_name: font_name = Void
-- 			is_fontable: is_fontable
-- 		local
-- 			fontable: FONTABLE
-- 		do
-- 			if default_font = Void then
-- 				fontable ?= widget
-- 				default_font := fontable.font
-- 			end
-- 		end	
-- 
-- 	font: FONT is
-- 		local
-- 			fontable: FONTABLE
-- 		do
-- 			if is_fontable then
-- 				fontable ?= widget
-- 				Result := fontable.font
-- 			end	
-- 		end
-- 
-- 	set_font_named (s: STRING) is
-- 		local
-- 			fontable: FONTABLE
-- 			old_w, old_h: INTEGER
-- 			was_managed: BOOLEAN
-- 		do
-- 			font_name_modified := False
-- 			if is_fontable then
-- 				fontable ?= widget
-- 				if s = Void or else s.empty then
-- 					if default_font /= Void then
-- 						was_managed := widget.managed
-- 						if was_managed then
-- 							old_w := width
-- 							old_h := height
-- 							widget.unmanage
-- 						end
-- 						fontable.set_font (default_font)		
-- 						if was_managed then
-- 							widget.set_size (old_w, old_h)
-- 							widget.manage
-- 						end
-- 					end
-- 					font_name_modified := False
-- 					font_name := s
-- 				else
-- 					if font_name = Void then
-- 						save_default_font
-- 					end
-- 					font_name := s
-- 					font_name_modified := True
-- 					was_managed := widget.managed
-- 					if was_managed then
-- 						old_w := width
-- 						old_h := height
-- 						widget.unmanage
-- 					end
-- 					fontable.set_font_name (s)
-- 					if was_managed then
-- 						widget.set_size (old_w, old_h)
-- 						widget.manage
-- 					end
-- 				end
-- 			end			
-- 		end
-- 
-- 	font_name_modified: BOOLEAN
 
feature -- Implementation

	gui_object: EV_WIDGET

end -- class WIDGET_C

