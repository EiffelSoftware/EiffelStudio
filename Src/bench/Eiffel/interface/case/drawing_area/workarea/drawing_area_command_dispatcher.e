indexing
	description: "Manager of the commands associated to graphical manipulations."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_COMMAND_DISPATCHER

inherit
	WORKAREA_COM
		rename
			execute as dispatch
		redefine
			make
		end

creation
	make

feature -- Creation

	make(worka: WORKAREA) is
			-- Creation
		do
			precursor(worka)
			create selection.make(worka,Current)
			create show_focus.make(worka)
			create multi_selection.make(worka)
			create eiffeltip.make(worka)
			create popup_menu_timer.make(worka)
		end

feature -- Dispatcher

	dispatch (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Dispatcher
		require else
			args_exists: args /= Void
			data_exists: data /= Void
		local
			arg1: EV_ARGUMENT1[INTEGER]
			button_number: INTEGER
			button_data: EV_BUTTON_EVENT_DATA
			motion_data: EV_MOTION_EVENT_DATA
		do
			arg1 ?= args
			check
				arg1_exists: arg1 /= Void
			end
			button_number := arg1.first
			if button_number=0 then
				-- No mouse button clicked.
				motion_data ?= data
				check
					correct_event: motion_data /= Void
				end
				eiffeltip.execute(Void, motion_data)
				popup_menu_timer.update(motion_data)
			elseif button_number <4 then
				-- Mouse button clicked
				button_data ?= data
				check
					correct_event: button_data /= Void
				end
				if button_number=1 then
					-- Left button clicked.
					if button_data.shift_key_pressed then
						create_entity(button_data)
					elseif button_data.control_key_pressed then
						show_focus.execute(Void, button_data)
						multi_selection.execute(void, button_data)
					else
						show_focus.execute(Void, button_data)
						selection.execute(Void, button_data)
					end
				elseif button_number=3 then
					-- Right button clicked.
					if button_data.control_key_pressed then
						bring_editor(button_data)
					elseif not button_data.shift_key_pressed then
						popup_menu_timer.initialize(button_data)
					end
				end
			end				
		end


feature -- Implementation
	
	selection: WORKAREA_SELECT_COM	
		-- Selection

	multi_selection: WORKAREA_MULTISELECT_COM
		-- Multi selection

	show_focus: WORKAREA_SHOW_FOCUS_COM
		-- Show Focus

	eiffeltip: CHART_WIN_COM
		-- EiffelTip 

	popup_menu_timer: POPUP_MENU_TIMER

feature -- Command Executions

	create_entity(bt_data: EV_BUTTON_EVENT_DATA) is
			-- create an entity, either a cluster or a class.
		require
			event_exists: bt_data /= Void
		local
			active_entity: GRAPH_FORM
			create_win: CREATE_EDITOR_WINDOW_COM
			selected: BOOLEAN
		do
			workarea.create_entity_command.execute (Void, bt_data)
		end

	bring_editor(bt_data: EV_BUTTON_EVENT_DATA) is
			-- Popups an editor.
		require
			event_Exists: bt_data /= Void
		local
			active_entity: GRAPH_FORM
			create_win: CREATE_EDITOR_WINDOW_COM
			selected: BOOLEAN
		do
			active_entity := workarea.active_entity
			if active_entity /= Void then
				selected := active_entity.selected
				if not selected then
					active_entity.select_it
					active_entity.partial_draw
				end
				!! create_win.make (workarea.analysis_window)
				create_win.execute (active_entity.data)
				if not selected then
					active_entity.unselect
					workarea.refresh
				end
			end
		end

feature -- Set/Unset commands depending on the context.

	initialize_motion(com: MOVE_COM) is
		require
			command_exists: com /= Void
		local
			rout: EV_ROUTINE_COMMAND
		do
			workarea.drawing_area.remove_motion_notify_commands
			workarea.drawing_area.remove_button_release_commands(1)
			current_motion_command := com
			!! rout.make(com~execute_button_motion)
			workarea.drawing_area.add_motion_notify_command (rout,Void)
			!! rout.make( com~execute_button_release )
			workarea.drawing_area.add_button_release_command (1, rout, void)
		ensure
			motion_command_set: current_motion_command = com
		end

	current_motion_command: MOVE_COM
		-- Current used command which is called whenever there is a a motion with the mouse.

end -- class DRAWING_AREA_COMMAND_DISPATCHER
