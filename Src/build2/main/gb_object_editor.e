indexing
	description: "Objects that allow you to edit the properties of a widget."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR

inherit

	EV_VERTICAL_BOX
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	INTERNAL
		undefine
			is_equal, copy, default_create
		end
		
	GB_CONSTANTS

	GB_DEFAULT_STATE
	
	GB_SHARED_OBJECT_EDITORS
		
	GB_NAMING_UTILITIES
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_COMMAND_HANDLER
		
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_OBJECT_HANDLER
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_HISTORY
		undefine
			default_create, copy, is_equal
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy, is_equal
		end

feature -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			tool_bar: EV_TOOL_BAR
			separator: EV_HORIZONTAL_SEPARATOR
			vertical_box1: EV_VERTICAL_BOX			
		do
			Precursor {EV_VERTICAL_BOX}
			create vertical_box1
			create tool_bar
			vertical_box1.extend (tool_bar)
			vertical_box1.disable_item_expand (tool_bar)
			tool_bar.extend (command_handler.object_editor_command.new_toolbar_item (True, False))
			create separator
			vertical_box1.extend (separator)
			vertical_box1.disable_item_expand (separator)
			create attribute_editor_box
			create scrollable_holder
			create viewport
			viewport.set_minimum_width (Minimum_width_of_object_editor)
			create scrollable_holder
			vertical_box1.extend (scrollable_holder)
			create control_holder
			create scroll_bar
			control_holder.set_minimum_width (Minimum_width_of_object_editor)
			vertical_box1.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
			scrollable_holder.extend (viewport)
			viewport.extend (control_holder)
			control_holder.extend (attribute_editor_box)
			control_holder.disable_item_expand (attribute_editor_box)

			control_holder.resize_actions.force_extend (agent update_scroll_bar)
			viewport.resize_actions.force_extend (agent update_scroll_bar)
			scroll_bar.change_actions.extend (agent scroll_bar_changed)
			scroll_bar.hide
			scrollable_holder.extend (scroll_bar)
			scrollable_holder.disable_item_expand (scroll_bar)
			extend (vertical_box1)
			vertical_box1.set_minimum_height (100)
			
			create item_parent
			control_holder.extend (item_parent)
			control_holder.disable_item_expand (item_parent)
			is_initialized := True
		end
		
	do_not_allow_object_type (transported_object: GB_OBJECT): BOOLEAN is
		do
				-- If the object is not void, it means that
				-- we are not currently picking a type.
			if transported_object.object /= Void then
				Result := True
			end
		end

feature -- Access

	object: GB_OBJECT
		-- Object currently referenced by `Current'.
		-- All object modifications are applied to this
		-- object.
		
	has_object: BOOLEAN is
			-- Is an object being edited in `Current'?
		do
			Result := object /= Void
		end

feature -- Status setting

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
			-- Set up `Current' to modify `object'.
		require
			an_object_not_void: an_object /= Void
		local
			command_name_change: GB_COMMAND_NAME_CHANGE
		do
			-- | FIXME - revisit as soon as time allows.
			-- This really is a hack, but I do not have time to fix it correctly now.
			-- When in the process of editing a name, if you click on the the layout constructor
			-- then for some reason the select_actions of that tree seemed to be called before
			-- the focus out actions of the text field. This was giving bad behaviour,
			-- so this section of code was added as a temporary fix.
			if object /= Void then
				if object.name /= object.edited_name then
					if object_handler.named_object_exists (object.edited_name, object) then
						object.cancel_edited_name
						update_editors_for_name_change (object.object, Current)
					else
						create command_name_change.make (object, object.edited_name, object.name)
						object.accept_edited_name
						history.cut_off_at_current_position
						command_name_change.execute
					end
				end
			end
			
			make_empty
			
			object := an_object
			
				-- Set title of parent window to
				-- reflect the name.
			set_title_from_name

			construct_editor
			
			update_scroll_bar
		ensure
			an_object_set: object = an_object
		end
		
	make_empty is
			-- Remove all editor objects from `Current'.
			-- Assign `Void' to `object'.
		local
			current_parent_window: EV_WINDOW
			locked_in_here: BOOLEAN
		do
			current_parent_window := parent_window (Current)
			if name_field /= Void then
				name_field.focus_in_actions.block
				name_field.focus_out_actions.block			
			end
			object := Void
			if current_parent_window /= Void and ((create {EV_ENVIRONMENT}).application.locked_window = Void) then
				locked_in_here := True
				current_parent_window.lock_update
			end
			item_parent.wipe_out
			attribute_editor_box.wipe_out
			if current_parent_window /= Void and locked_in_here then
				current_parent_window.unlock_update
			end
			if name_field /= Void then
				name_field.focus_in_actions.resume
				name_field.focus_out_actions.resume	
			end
		ensure
			now_empty: attribute_editor_box.count = 0
			object_is_void: object = Void
		end
		
	update_current_object is
			-- Update fields for `object'.
			-- For now, we just rebuild the whole
			-- tool. This can be optimized later.
		do
			set_object (object)
		end
		
	replace_object_editor_item (a_type: STRING) is
			-- Replace object editor item of type `a_type' with a newly built one.
			-- This forces an update due to the current state of `object'.
		local
			found: BOOLEAN
			editor_item: GB_OBJECT_EDITOR_ITEM
		do
			from
				item_parent.start
			until
				item_parent.off or found
			loop
				editor_item ?= item_parent.item
				check
					editor_item_not_void: editor_item /= Void
				end
				if editor_item.type_represented.is_equal (a_type) then
					found := True
					editor_item.creating_class.update_attribute_editor
				end
				item_parent.forth
			end
		end

feature {GB_SHARED_OBJECT_EDITORS} -- Implementation
		
	end_name_change_on_object is
			-- Update the object to reflect the edited name.
			-- If the edited name is not valid, then we restore the name of `object'
			-- to the previous name before the editing began.
		local
			command_name_change: GB_COMMAND_NAME_CHANGE
		do
			name_field.change_actions.block
				-- If the name exists, we must restore the name of `object' to
				-- the name before the name change began.
			if object_handler.named_object_exists (name_field.text, object) then
				object.cancel_edited_name
				check
					object_names_now_equal: object.edited_name.is_equal (object.name)
				end
				if object.name.is_empty then
					object.layout_item.set_text (object.type.substring (4, object.type.count))
				else
					object.layout_item.set_text (object.name + ": " + object.type.substring (4, object.type.count))			
				end
				set_title_from_name
				update_editors_for_name_change (object.object, Current)
				name_field.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				name_field.set_text (object.name)
			else
					-- Now check that the name has actually changed. If it has not changed,
					-- then do nothing.
				if not object.edited_name.is_equal (object.name) then
						-- Use the text in `name_field' as the new name of the object.
						-- We have guaranteed that the name is unique at this point.
					create command_name_change.make (object, object.edited_name, object.name)
					object.accept_edited_name
					history.cut_off_at_current_position
					command_name_change.execute
				end
			end
			name_field.change_actions.resume
		end

feature {NONE} -- Implementation


	set_title_from_name is
			-- Update title of top level window to reflect the
			-- name of the object in `Current'.
		do	
			if not (current = docked_object_editor) then
				if object.output_name.is_empty then
					parent_window (Current).set_title (object.short_type)
				else
					parent_window (Current).set_title (object.output_name)
				end
			end
		end

	construct_editor is
			-- Build `Current'. Build all attribute editors and populate,
			-- to represent `object'.
		require
			object_not_void: object /= Void
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			display_object: GB_DISPLAY_OBJECT
			separator: EV_HORIZONTAL_SEPARATOR
			label: EV_LABEL
			current_window_parent: EV_WINDOW
		do
			current_window_parent := parent_window (Current)
			if current_window_parent /= Void then
				current_window_parent.lock_update	
			end
			attribute_editor_box.wipe_out
			create label.make_with_text ("Type:")
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			create label.make_with_text (object.type.substring (4, object.type.count))
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			
			create label.make_with_text ("Name:")
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			create name_field.make_with_text (object.name)
			
			--| FIXME - revisit
			--| I dont think this shoud be called here. Julian.
			object.set_edited_name (object.name)
			
			
			name_field.focus_in_actions.extend (agent start_name_change_on_object)
			name_field.focus_out_actions.extend (agent end_name_change_on_object)
			name_field.change_actions.extend (agent update_visual_representations_on_name_change)
			name_field.return_actions.extend (agent update_name_when_return_pressed)
			attribute_editor_box.extend (name_field)
			attribute_editor_box.disable_item_expand (name_field)
			
			create separator
			attribute_editor_box.extend (separator)
			attribute_editor_box.disable_item_expand (separator)
			
			
			
			create handler
			supported_types := clone (handler.supported_types)
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				if is_instance_of (object.object, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
					gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
					gb_ev_any.set_parent_editor (Current)
					gb_ev_any.default_create
					check
						gb_ev_any_exists: gb_ev_any /= Void
					end
					gb_ev_any.add_object (object.object)
					
						-- We need to check that the display_object is not of type `GB_DISPLAY_OBJECT'.
						-- If it is, we must add its child, as this is the object that must be modified.
					display_object ?= object.display_object
					if display_object /= Void then
						gb_ev_any.add_object (display_object.child)	
					else
						gb_ev_any.add_object (object.display_object)
					end
					
					item_parent.extend (gb_ev_any.attribute_editor)
				end
				supported_types.forth
			end
			if current_window_parent /= Void then
				current_window_parent.unlock_update	
			end
		end
		
	update_visual_representations_on_name_change is
			-- Update visual representations of `object' to reflect new name
			-- in `name_field'.
		local
			current_caret_position: INTEGER
		do
			if valid_class_name (name_field.text) or name_field.text.is_empty then
				object.set_edited_name (name_field.text)
				if object_handler.named_object_exists (name_field.text, object) then
					name_field.set_foreground_color ((create {EV_STOCK_COLORS}).red)
				else
					name_field.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				end
				if name_field.text.is_empty then
					object.layout_item.set_text (object.type.substring (4, object.type.count))
				else
					object.layout_item.set_text (name_field.text + ": " + object.type.substring (4, object.type.count))			
				end
					-- Update title of window.
				set_title_from_name
					-- Must be performed after we have actually changed the name of the object.
				update_editors_for_name_change (object.object, Current)
					-- We now inform the system that the user has modified something
				system_status.enable_project_modified
				command_handler.update	
			else
				current_caret_position := name_field.caret_position
				name_field.change_actions.block
					-- We must handle three different cases in order to restore the text if an
					-- invalid character was received.
				if current_caret_position = name_field.text.count + 1 then
					name_field.set_text (name_field.text.substring (1, name_field.text.count - 1))
					name_field.set_caret_position (current_caret_position - 1)
				elseif current_caret_position = 2 then
					name_field.set_text (name_field.text.substring (2, name_field.text.count))	
					name_field.set_caret_position (1)
				else
						--| FIXME, this still allows us to enter invalid names.
					name_field.set_text (name_field.text.substring (1, current_caret_position - 2) + name_field.text.substring (current_caret_position, name_field.text.count))
					name_field.set_caret_position (current_caret_position)
				end
				name_field.change_actions.resume
			end
		end
		
	start_name_change_on_object is
			-- Inform object that a name change has begun.
		require
			object_not_void: object /= Void
		do
				-- Ensure edited_namd and name for the object are
				-- identical. We should be in a state where name is valid
				-- and unique at this point.
			object.set_edited_name (object.name)
		end
		
	update_name_when_return_pressed is
			-- Return has been pressed in `name_field'. We must now either accept the new
			-- name for `object' if it is valid and unique. If it is not, then we notify the user
			-- with a warning dialog, telling them that the name already exists, and giving the option
			-- to continue changing the name, or to cancel the name change.
		local
			my_dialog: GB_DUPLICATE_OBJECT_NAME_DIALOG
			previous_caret_position: INTEGER
			command_name_change: GB_COMMAND_NAME_CHANGE
		do
			name_field.focus_out_actions.block
			if not name_field.text.is_empty and then object_handler.named_object_exists (name_field.text, object) then
				previous_caret_position := name_field.caret_position
				create my_dialog.make_with_text (Duplicate_name_warning_part1 + name_field.text + Duplicate_name_warning_part2)
				my_dialog.show_modal_to_window (parent_window (Current))
				my_dialog.destroy
				if my_dialog.selected_button.is_equal ("Modify") then
					restore_name_field (name_field.text, previous_caret_position)	
				else
						-- Restore name as edit was "cancelled".
					restore_name_field (object.name, object.name.count + 1)
						-- Reflect changes in all editors.
					update_editors_for_name_change (object.object, Current)
				end
			elseif not object.edited_name.is_equal (object.name) then
				
					-- This is a command so it is added to the history. Pressing Return
					-- does accept the name, even though we still have the focus in the text field
					-- and are editing it.
				create command_name_change.make (object, object.edited_name, object.name)
				object.accept_edited_name
				history.cut_off_at_current_position
				command_name_change.execute
			end
			name_field.focus_out_actions.resume
		end
		
	restore_name_field (a_text: STRING; caret_position: INTEGER) is
			-- Assign `a_text' to text of `name_field', set the caret position
			-- to `caret_position' and give `name_field' the focus.
		require
			a_text_not_void: a_text /= Void
			valid_caret_position : caret_position >= 1 and caret_position <= a_text.count + 1
		do
			name_field.set_text (a_text)
			name_field.set_caret_position (caret_position)
			name_field.set_focus
		ensure
			text_set: name_field.text.is_equal (a_text)
			caret_position_set: name_field.caret_position = caret_position
			focus_set: name_field.has_focus
		end
		
	update_scroll_bar is
			-- Show/hide the scroll bar as appropriate. Modify the
			-- range of the scroll bar as needed.
		local
			interval: INTEGER_INTERVAL
			timeout: EV_TIMEOUT
		do
			if viewport.height < control_holder.minimum_height then
				if not scroll_bar.is_show_requested then
					parent_window (Current).lock_update
					viewport.resize_actions.pause
					control_holder.resize_actions.pause
						-- There is no way ti resize a box in a viewport to
						-- be smaller, so we must rebuild a new box,
						-- and expand it by putting the items in.
					control_holder.wipe_out
					viewport.prune_all (control_holder)
					create control_holder
					viewport.extend (control_holder)
					control_holder.extend (attribute_editor_box)
					control_holder.disable_item_expand (attribute_editor_box)
					control_holder.extend (item_parent)
					control_holder.disable_item_expand (item_parent)
				
						-- Set up the minimum width on the new box.
					control_holder.set_minimum_width (Minimum_width_of_object_editor)
					viewport.set_minimum_width (Minimum_width_of_object_editor)
					control_holder.resize_actions.force_extend (agent update_scroll_bar)
						-- Create a timeout and set up the action to fix a Windows
						-- Vision2 bug. See comment in `show_scroll_bar_again'.
					create timeout.make_with_interval (5)
					timeout.actions.extend (agent show_scroll_bar_again (timeout))
					scroll_bar.show	
					
					viewport.resize_actions.resume
					control_holder.resize_actions.resume
					parent_window (Current).unlock_update
				end
			else
				scroll_bar.hide
				scroll_bar_changed (0)
				control_holder.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
				viewport.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
			end
				-- If the scroll bar is visible then we must update the values
				-- to match the size of the 
			if scroll_bar.is_show_requested then
				create interval.make (0, control_holder.minimum_height - viewport.height)
				if viewport.height > 0 then
					scroll_bar.set_leap (viewport.height)
				end
				scroll_bar.value_range.adapt (interval)
				scroll_bar_changed (scroll_bar.value)
			end
		end
		
	show_scroll_bar_again (a_timeout: EV_TIMEOUT)is
			-- Call show on `scroll_bar' and destroy `a_timeout'.
			-- This is needed, as there is a Vision2 resizing bug on Windows
			-- which stops teh scroll bar being displayed when it is first shown, as you
			-- resize the main window smaller. Therefore,
			-- we call show on it after the resizing has occured to combat this problem.
			-- There should be no ill effects on either platform.
		do
			scroll_bar.show
			a_timeout.destroy			
		end
		
		
	scroll_bar_changed (value: INTEGER) is
			-- Set the offset of the controls to `Value'
			-- within the viewport.
		do
			viewport.set_y_offset (value)
		end
		

	item_parent: EV_VERTICAL_BOX
		-- An EV_VERTICAL_BOX to hold all GB_OBJECT_EDITOR_ITEM.
		
	name_field: EV_TEXT_FIELD
		-- Entry for the object name.
		
	attribute_editor_box: EV_VERTICAL_BOX
		-- All attribute editors are placed in here.

	scrollable_holder: EV_HORIZONTAL_BOX
		-- Holds the viewport and a scrollbar.
		
	scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- Scroll bar to control the positioning of the object editor.
		
	viewport: EV_VIEWPORT
		-- Viewport containg the attribute editors.
	
	control_holder: EV_VERTICAL_BOX
		-- Holds the controls, and is placed in the scrollable area.
	
feature {GB_SHARED_OBJECT_EDITORS} -- Implementation

	update_name_field is
			-- Update `name_field' to reflect `object.name'.
			-- Used when a name changes from another
			-- object editor. All must be updated.
		do
			set_title_from_name
			name_field.change_actions.block
			name_field.set_text (object.edited_name)
			name_field.change_actions.resume
		end

end -- class GB_OBJECT_EDITOR
