indexing
	description: "This is the window used to hold SD_TITLE_BAR and client programmer's EV_WIDET."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WINDOW
	
inherit
	EV_CELL

create
	make

feature {NONE} -- Initlization

	make (a_type: INTEGER; a_zone: SD_ZONE) is
			-- Creation method.
		do
			default_create
			create internal_shared
			create vbox

			internal_title_bar := internal_shared.widget_factory.title_bar (a_type, a_zone)
			internal_title_bar.set_minimum_height (16)
			internal_title_bar.close_actions.extend (agent close_window)
			internal_title_bar.stick_select_actions.extend (agent stick_window)
			internal_title_bar.min_max_actions.extend (agent min_max_window)
			internal_title_bar.drag_actions.extend (agent drag_window)
			internal_title_bar.pointer_button_release_actions.extend (agent pointer_release)
			internal_title_bar.pointer_double_press_actions.extend (agent handle_pointer_double_press)
			pointer_button_release_actions.extend (agent pointer_release)
			pointer_motion_actions.extend (agent pointer_motion)
			
			vbox.extend (internal_title_bar)
			vbox.disable_item_expand (internal_title_bar)
						
			extend (vbox)
		
			set_minimum_size (20 * 3, 16)
		end
		
feature   -- Access

	set_stick (a_bool: BOOLEAN) is
			-- Set whether current is sticked.
		do
			internal_title_bar.set_stick (a_bool)
		end
		
	title_bar: like internal_title_bar is
			-- Get the title bar which above client programmer's widget.
		do
			Result := internal_title_bar
		end
	
	user_widget: like internal_user_widget assign set_user_widget is
			-- Get/set the client programmer's widget.
		do
			Result := internal_user_widget 
		end
	
	set_user_widget (a_widget: like internal_user_widget) is
			-- Set the client programmer's widget.
		require
			a_widget_not_void: a_widget /= Void
		do
			
			internal_user_widget := a_widget
			if vbox.count = 2 then
				vbox.prune (vbox [2])
			end
			if a_widget.parent /= Void then
				a_widget.parent.prune (a_widget)
			end
			vbox.extend (a_widget)

		ensure
			contain_right_number_widget: vbox.count = 2
			contain_user_wiget: vbox.has (a_widget)
		end
		
feature {NONE} -- Two widgets
	
	internal_title_bar: SD_TITLE_BAR
			-- The title bar which above client programmer's widget.
			
	internal_user_widget: EV_WIDGET
			-- The client programmer's widget.

feature -- Actions

	close_actions: like internal_close_actions is
			-- `internal_close_actions'
		do
			if internal_close_actions = Void then
				create internal_close_actions
			end
			Result := internal_close_actions
		ensure
			not_void: Result /= Void
		end
		
	stick_actions: like internal_stick_actions is
			-- `internal_stick_actions'
		do
			if internal_stick_actions = Void then
				create internal_stick_actions
			end
			Result := internal_stick_actions
		ensure
			not_void: Result /= Void
		end
		
	drag_actions: like internal_drag_actions is
			-- `internal_drag_actions'
		do
			if internal_drag_actions = Void then
				create internal_drag_actions
			end
			Result := internal_drag_actions
		ensure
			not_void: Result /= Void
		end
		
	min_max_action: like internal_min_max_action is
			-- `internal_min_max_action'
		do
			if internal_min_max_action = Void then
				create internal_min_max_action
			end
			Result := internal_min_max_action
		ensure
			not_void: Result /= Void
		end
		
	pointer_double_press_title_bar_actions: like internal_pointer_double_press_title_bar_actions is
			-- `internal_pointer_double_press_title_bar_actions'
		do
			if internal_pointer_double_press_title_bar_actions = Void then
				create internal_pointer_double_press_title_bar_actions
			end
			Result := internal_pointer_double_press_title_bar_actions
		ensure
			not_void: Result /= Void
		end
		
feature {NONE} -- Implemention

	close_window is
			-- 
		do
			close_actions.call ([])
		end
		
	min_max_window is
			-- 
		do
			min_max_action.call ([])
		end
		
	stick_window is
			-- 
		do
			stick_actions.call ([])
		end
		
	drag_window (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- 
		do
			drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
		end
	
	pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- 
		do
		end
		
	pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- 
		do
		end
	
	handle_pointer_double_press is
			-- 
		do
			if internal_pointer_double_press_title_bar_actions /= Void then
				internal_pointer_double_press_title_bar_actions.call ([])
			end
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.
			
	internal_close_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when close the window.
			
	internal_stick_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when stick the window.
			
	internal_drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions performed when drag the window.
			
	internal_min_max_action: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions perfromed when min/max window.
			
	internal_pointer_double_press_title_bar_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions perfromed when pointer double pressed `internal_title_bar'.

	vbox: EV_VERTICAL_BOX
			-- The vertical box to hold SD_TITLE_BAR and user_widget.
	
invariant

	internal_title_bar_not_void: internal_title_bar /= Void
	vbox_not_void: vbox /= Void

end
