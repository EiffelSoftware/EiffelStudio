indexing
	description: "Objects that represent a client's widget which docking issues are managed"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONTENT
	
create
	make_with_widget_title_pixmap,
	make_with_widget
		
feature {NONE} -- Initialization
	
	make_with_widget_title_pixmap (a_widget: EV_WIDGET; a_title: STRING; a_pixmap: EV_PIXMAP) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
			a_title_not_void: a_title /= Void
			a_pixmap_not_void: a_pixmap /= Void
		local
			l_state: SD_AUTO_HIDE_STATE
		do
			create internal_shared
			internal_user_widget := a_widget
			internal_title := a_title
			internal_pixmap := a_pixmap
			
			-- By default, dock left.
			create l_state.make (Current, {SD_SHARED}.dock_left)
			l_state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
			internal_state := l_state
			internal_type := {SD_SHARED}.type_normal
		ensure
			a_widget_set: a_widget = internal_user_widget
			a_title_set: a_title = internal_title
			a_pixmap_set: a_pixmap = internal_pixmap
			state_not_void: internal_state /= Void
		end
		
	make_with_widget (a_widget: EV_WIDGET) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_icon: EV_PIXMAP
		do
			create internal_shared
			l_icon := internal_shared.icons.default_icon.twin
			l_icon.set_minimum_size (20, 20)
			make_with_widget_title_pixmap (a_widget, "Untitled", l_icon)
		end
	
feature -- Access
		
	user_widget: like internal_user_widget is
			-- Client programmer's widget.
		do
			Result := internal_user_widget
		ensure
			result_valid: Result = internal_user_widget
		end
		
	title: like internal_title is
			-- Client programmer's widget's title.
		do
			Result := internal_title
		ensure
			result_valid: Result = internal_title
		end
		
	set_title (a_title: like internal_title) is
			-- Set the widget's title
		require
			a_title_not_void: a_title /= Void
		do
			internal_title := a_title
			internal_state.change_title (a_title)
		ensure
			a_title_set: a_title = internal_title
		end
		
	pixmap: like internal_pixmap is
			-- Client programmer's widget's pixmap.
		do
			Result := internal_pixmap
		ensure
			result_valid: Result = internal_pixmap
		end
	
	set_pixmap (a_pixmap: like internal_pixmap) is
			-- Set the pixmap which shown on title bar.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
		ensure
			a_pixmap_set: a_pixmap = internal_pixmap
		end
		
	mini_toolbar: like internal_mini_toolbar is
			-- Mini toolbar.
		do
			Result := internal_mini_toolbar
		ensure
			result_valid: Result = internal_mini_toolbar
		end
	
	set_mini_toolbar (a_bar: like internal_mini_toolbar) is
			-- Set mini toolbar.
		require
			a_bar_not_void: a_bar /= Void
		do
			internal_mini_toolbar := a_bar
		ensure
			a_bar_set: a_bar = internal_mini_toolbar
		end
		
	type: INTEGER is
			-- 
		do
			Result := internal_type
		end
	
	set_type (a_type: INTEGER) is
			--
		require
			a_type_valid: a_type = {SD_SHARED}.type_normal or a_type = {SD_SHARED}.type_editor
		do
			internal_type := a_type
		end		

feature -- Set Position

	set_docking_position_relative (a_relative: SD_CONTENT; a_direction: INTEGER) is
			-- 
		do
   			
   		end
   	
	set_docking_position_top (a_direction: INTEGER) is
			-- 
		do
	   		
		end
   	
	set_auto_hide (a_direction: INTEGER) is
			-- 
		do
			
		end
   	
	set_floating (a_screen_x, a_screen_y: INTEGER) is
			-- 
		do
			
		end
   	
	set_tab_with (a_content: SD_CONTENT) is
			-- 
		do
			
		end
	
	
		
feature {SD_STATE, SD_HOT_ZONE, SD_CONFIG, SD_ZONE, SD_DOCKING_MANAGER} -- Access
	
	state: like internal_state is
			-- Current state
		do
			Result := internal_state
		end
		
feature {SD_DOCKING_MANAGER} -- Restore issues.
	
	save_config (a_file: IO_MEDIUM) is
			-- Remember current state which is used for restore.
		do
--			state.basic_store (a_file)
		end
	
	open_config (a_file: IO_MEDIUM) is
			-- Restore the states from the xml file.
		do
--			internal_state ?= state.retrieved (a_file)
--			check internal_state /= Void end
		end
		
feature {NONE} -- Restore issues implementation
	
	internal_state: SD_STATE
			-- The SD_STATE instacne, which will change itself base on different states. States pattern.

feature {SD_STATE, SD_DOCKING_MANAGER} -- Change the SD_STATE base on the states
	
	change_state (a_state: SD_STATE) is
			-- Called by SD_RESOTRE, change current state object.
		require
			a_state_not_void: a_state /= Void
		do
			internal_state := a_state
		end

feature {NONE}  -- Implemention
	
	internal_user_widget: EV_WIDGET
			-- Client programmer's widget.
	
	internal_title: STRING
			-- The internal_user_widget's internal_title.
	
	internal_pixmap: EV_PIXMAP
			-- The internal_pixmap at the head of internal_title.
	
	internal_mini_toolbar: EV_TOOL_BAR
			-- Mini toolbar at the titlt bar.

	internal_shared: SD_SHARED
			-- All singletons.
	
	internal_type: INTEGER
			-- The type of `Current'. One value from SD_SHARED.			
	
invariant
	the_user_widget_not_void: internal_user_widget /= Void
end
