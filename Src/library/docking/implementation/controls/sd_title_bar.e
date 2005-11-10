indexing
	description: "The title bar on the top of user's widget."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TITLE_BAR
	
inherit
	EV_HORIZONTAL_BOX
		rename
			pointer_double_press_actions as pointer_double_press_actions_horizontal_box
		end
		
create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method.
		local
			l_cell: EV_CELL
		do
			create internal_shared
			default_create
			create internal_title.make_with_text ("untitled")
			internal_title.align_text_left
			create stick
			stick.set_pixmap (internal_shared.icons.unstick)
			
			is_stick := False
			create min_max
			min_max.set_pixmap (internal_shared.icons.maximize)
			create close
			close.set_pixmap (internal_shared.icons.close)
			
			stick.pointer_button_press_actions.force_extend (agent handle_stick_select)
			min_max.pointer_button_press_actions.force_extend (agent handle_min_max)
			close.pointer_button_press_actions.force_extend (agent handle_close)
			
			internal_title.pointer_button_press_actions.force_extend (agent handle_pointer_press)
			internal_title.pointer_button_release_actions.force_extend (agent handle_pointer_release)
			internal_title.pointer_leave_actions.force_extend (agent handle_pointer_leave)
			internal_title.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_title.pointer_double_press_actions.force_extend (agent handle_pointer_double_press)
			
			
			internal_title.set_minimum_width (0)
			extend (internal_title)
			enable_item_expand (internal_title)
			create internal_tool_bar
			internal_tool_bar.extend (stick)
			internal_tool_bar.extend (min_max)
			internal_tool_bar.extend (close)
			
			-- If we don't put the tool bar into the cell, the bottom border of the toolbar will disappear.
			create l_cell
			l_cell.extend (internal_tool_bar)
			
			extend (l_cell)
			disable_item_expand (l_cell)
			
			-- default setting
			set_border_width (1)
		 	disable_focus_color
		 	
		end

feature -- Access
	
	set_title (a_title: STRING) is
			-- Set the title on the title bar.
		do
			internal_title.set_text (a_title)
		end
		
	set_stick (a_bool: BOOLEAN) is
			-- Set if current is sticked.
		do
			if a_bool then
				stick.set_pixmap (internal_shared.icons.stick)
			else
				stick.set_pixmap (internal_shared.icons.unstick)
			end
		end
	
	enable_focus_color is
			-- 
		local
			focus_background_color: EV_GRID
			l_text_color: EV_COLOR
		do
			create focus_background_color
			set_background_color (focus_background_color.focused_selection_color )
			internal_title.set_background_color (focus_background_color.focused_selection_color)
			if focus_background_color.focused_selection_color.lightness > 0.5 then
				create l_text_color.make_with_rgb (0, 0, 0)
			else
				create l_text_color.make_with_rgb (1, 1, 1)
			end
			internal_title.set_foreground_color (l_text_color)
--			stick.set_background_color (focus_background_color.focused_selection_color)
--			min_max.set_background_color (focus_background_color.focused_selection_color)
--			close.set_background_color (focus_background_color.background_color)
		end
		
	disable_focus_color is
			-- 
		local
			unfocus_background_color: EV_GRID
			l_text_color: EV_COLOR
		do
			create unfocus_background_color
			
			internal_title.set_background_color (unfocus_background_color.non_focused_selection_color)
			if unfocus_background_color.non_focused_selection_color.lightness > 0.5 then
				create l_text_color.make_with_rgb (0, 0, 0)
			else
				create l_text_color.make_with_rgb (1, 1, 1)
			end			
			internal_title.set_foreground_color (l_text_color)
			set_background_color (l_text_color)
		end
		
feature -- Actions
	
	stick_select_actions: like internal_stick_select_actions is
			-- 
		do
			if internal_stick_select_actions = Void then
				create internal_stick_select_actions
			end
			Result := internal_stick_select_actions
		ensure
			not_void: Result /= Void
		end
		
	close_actions: like internal_close_actions is
			-- 
		do
			if internal_close_actions = Void then
				create internal_close_actions
			end
			Result := internal_close_actions
		ensure
			not_void: Result /= Void			
		end
		
	min_max_actions: like internal_min_max_actions is
			--
		do
			if internal_min_max_actions = Void then
				create internal_min_max_actions
			end
			Result := internal_min_max_actions
		ensure
			not_void: Result /= Void
		end
		
	drag_actions: like internal_drag_actions is
			-- 
		do
			if internal_drag_actions = Void then
				create internal_drag_actions
			end
			Result := internal_drag_actions
		ensure
			not_void: Result /= Void
		end
		
	pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 
		do
			if internal_pointer_double_press_actions = Void then
				create internal_pointer_double_press_actions
			end
			Result := internal_pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end
		
	
feature {NONE} -- Implementation for agents

	handle_stick_select is
			-- Notify clients when user click stick button.
		do
			if  is_stick then
				stick.set_pixmap (internal_shared.icons.unstick)
			else
				stick.set_pixmap (internal_shared.icons.stick)
			end

			is_stick := not is_stick
			stick_select_actions.call ([])
		end
	
	handle_min_max is
			-- 
		do
			min_max_actions.call ([])
		end
		
	handle_close is
			-- Handle the event when close button pressed.
		do
			close_actions.call ([])
		end
	
	pressed: BOOLEAN 
			-- Is pointer button pressed?
	
	handle_pointer_press is
			-- 
		do
			pressed := True
		end
		
	handle_pointer_release is
			-- 
		do
			pressed := False
		end
		
	handle_pointer_leave is
			-- 
		do
			pressed := False
		end
		
	on_pointer_motion (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- 
		do
			if pressed then
				drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
			end
		end
	
	handle_pointer_double_press is
			-- 
		do
			if pointer_double_press_actions /= Void then
				pointer_double_press_actions.call ([])
			end
		end
		
feature {NONE} -- Implementation
	is_stick: BOOLEAN
			-- If the stick button selected ?
			
	internal_title: EV_LABEL 
			-- Internal_title

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar which hold `stick', `min_max', `close' buttons.
	stick: EV_TOOL_BAR_BUTTON
			-- Sitck button
	min_max: EV_TOOL_BAR_BUTTON
			-- Minimize and maxmize button
	close: EV_TOOL_BAR_BUTTON
			-- Close button
	
	internal_shared: SD_SHARED
			-- All singletons
			
	internal_pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE
	
	internal_stick_select_actions, internal_close_actions, internal_min_max_actions: EV_NOTIFY_ACTION_SEQUENCE
	
	internal_drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE

end
