indexing
	description: "This class is an ancestor of EV_WIDGET_IMP, EV_ITEM_IMP%
		% and EV_MESSAGE_DIALOG_IMP"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_EVENT_HANDLER_IMP

inherit	
        EV_GTK_EXTERNALS
	EV_GTK_TYPES_EXTERNALS
	EV_GTK_WIDGETS_EXTERNALS
	EV_GTK_GENERAL_EXTERNALS
	EV_GTK_CONTAINERS_EXTERNALS
        EV_GTK_CONSTANTS

	EV_WIDGET_EVENTS_CONSTANTS_IMP

feature {NONE} -- Initialization

	initialize_list is
			-- Create the `event_command_array' and the `arguments_list' with a length
			-- of command_count.
		do
			!! event_command_array.make (1, command_count)
		
		ensure
			array_non_void: event_command_array /= void
		end
	
feature {NONE} -- Access

	event_command_array: ARRAY [EV_GTK_COMMAND_LIST]
			-- Array sorted by event_id. And for each event_id,
			-- list of the commands and its associated con_id
			-- For this event_ids, See the class EV_EVENT_CONSTANTS

feature {NONE} -- Status report

	has_command (event_id: INTEGER): BOOLEAN is
			-- Does the object has at least one command on the 
			-- event given by `event_id'.
		require
			array_non_void: event_command_array /= void
		do
			if event_command_array = Void then
				Result := False
			else
				Result := (event_command_array @ event_id) /= Void
			end
		end

	which_event_id (ev_str: STRING; mouse_but: INTEGER; double_clic: BOOLEAN): INTEGER is
			-- gives the event_id number corresponding to the `event' string
		require
			event_not_void: ev_str/=void
--			mouse_button_ok: (mouse_but>=0 and mouse_but<=3) 
--				and ((mouse_but=0) = not (ev_str.is_equal ("button_press_event") or ev_str.is_equal ("button_release_event")))
-- alex
-- also requires that event is one of the following events:
			
		do
			-- For every widgets:
			if ev_str.is_equal ("button_press_event") then
				inspect
					mouse_but
				when 1 then
					if double_clic then
						Result := button_one_double_click_event_id
					else
						Result := button_one_press_event_id
					end
				when 2 then
					if double_clic then
						Result := button_two_double_click_event_id
					else
						Result := button_two_press_event_id
					end
				when 3 then
					if double_clic then
						Result := button_three_double_click_event_id
					else
						Result := button_three_press_event_id
					end
				end
			elseif ev_str.is_equal ("button_release_event") then
				inspect
					mouse_but
				when 1 then
					Result := button_one_release_event_id
				when 2 then
					Result := button_two_release_event_id
				when 3 then
					Result := button_three_release_event_id
				end
			elseif ev_str.is_equal ("expose_event") then
				Result := expose_event_id
			elseif ev_str.is_equal ("key_press_event") then
				Result := key_press_event_id
			elseif ev_str.is_equal ("key_release_event") then
				Result := key_release_event_id
			elseif ev_str.is_equal ("motion_notify_event") then
				Result := motion_notify_event_id
			elseif ev_str.is_equal ("enter_notify_event") then
				Result := enter_notify_event_id
			elseif ev_str.is_equal ("leave_notify_event") then
				Result := leave_notify_event_id
			elseif ev_str.is_equal ("focus_in_event") then
				Result := focus_in_event_id
			elseif ev_str.is_equal ("focus_out_event") then
				Result := focus_out_event_id
			elseif ev_str.is_equal ("expose_event") then
				Result := expose_event_id
			elseif ev_str.is_equal ("destroy") then
				Result := destroy_id

			-- For windows:
			elseif ev_str.is_equal ("delete_event") then
				Result := close_event_id
			elseif ev_str.is_equal ("configure_event") then
				inspect
					mouse_but
				when 1 then
					Result := move_event_id
				when 2 then
					Result := resize_event_id
				end

			-- For items:
			elseif ev_str.is_equal ("select") then
				Result := select_id
			elseif ev_str.is_equal ("deselect") then
				Result := deselect_id
			elseif ev_str.is_equal ("collapse") then
				Result := collapse_id
			elseif ev_str.is_equal ("expand") then
				Result := expand_id
			-- for Menu_item, text_fields and combo_box
			elseif ev_str.is_equal ("activate") then
				Result := activate_id

			-- For buttons:
			elseif ev_str.is_equal ("clicked") then
				Result := clicked_id
			elseif ev_str.is_equal ("toggled") then
				Result := toggled_id
			
			-- For notebook:
			elseif ev_str.is_equal ("switch_page") then
				Result := switch_page_id

			-- For lists, trees and combo boxes:
			elseif ev_str.is_equal ("selection_changed") then
				Result := selection_changed_id

			-- For multi column lists:
			elseif ev_str.is_equal ("select_row") then
				Result := select_row_id
			elseif ev_str.is_equal ("unselect_row") then
				Result := unselect_row_id
			elseif ev_str.is_equal ("click_column") then
				Result := click_column_id

			-- For text components and combo boxes:
			elseif ev_str.is_equal ("changed") then
				Result := changed_id

			-- For text fields:
			elseif ev_str.is_equal ("activate") then
				Result := activate_id

			end
		ensure
			event_id_ok: (Result>=0 and Result<=23)
		end

feature {NONE} -- Status setting

	add_command_with_event_data (wid: POINTER; event: STRING; cmd: EV_COMMAND; 
		     arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA;
		     mouse_button: INTEGER; double_click: BOOLEAN) is
			-- Add `cmd' at the end of the list of
			-- actions to be executed when the 'event'
			-- happens `arg' will be passed to
			-- `cmd' whenever it is invoked as a
			-- callback. 'arg' can be Void, which
			-- means that no arguments are passed to the
			-- cmd. 'ev_data' is an empty object 
			-- which will be filled by gtk (in C library) 
			-- when the event happens.
		
		require		
			valid_event: event /= Void
			valid_command: cmd /= Void
		local
			ev_str: ANY
			ev_d_imp: EV_EVENT_DATA_IMP
			con_id: INTEGER

			list_com: EV_GTK_COMMAND_LIST
			event_id: INTEGER
                do				
			ev_d_imp ?= ev_data.implementation
			check
				valid_event_data_implementation: ev_d_imp /= Void
			end
			ev_str := event.to_c
			con_id := c_gtk_signal_connect (
				wid,
				$ev_str,
				cmd.execute_address,
				$cmd,
				$arg,
				$ev_data,
				$ev_d_imp,
				ev_d_imp.initialize_address,
				mouse_button,
				double_click
			)
			check
				successfull_connect: con_id > 0
			end
-- alex
			-- Updating the `event_command_array' by including the new command :

			-- select the right `event_id' corresponding to the `event'
			event_id:= which_event_id (event, mouse_button, double_click)

			-- first, we create the list if it doesn't exist.
			if event_command_array = Void then
				initialize_list
			end

			-- Then, we create the list linked to the given
			-- `event_id' if it doesn't exist already
			if (event_command_array @ event_id) = Void then
				create list_com.make
				event_command_array.force (list_com, event_id)
			end

			-- Finally, we add the command and its con_id to the lists
			(event_command_array @ event_id).extend (cmd, con_id)
		end
        
	add_command (wid: POINTER; event: STRING; cmd: EV_COMMAND; 
		     arg: EV_ARGUMENT) is
			-- Add `cmd' at the end of the list of
			-- actions to be executed when the 'event'
			-- happens `arg' will be passed to
			-- `cmd' whenever it is invoked as a
			-- callback. 'arg' can be Void, which
			-- means that no arguments are passed to the
			-- command. 
			
		require		
			valid_event: event /= Void
			valid_command: cmd /= Void
		local
			ev_str: ANY
			con_id: INTEGER
-- alex
			list_com: EV_GTK_COMMAND_LIST
			event_id: INTEGER
		do
			ev_str:= event.to_c
			con_id := c_gtk_signal_connect (
				wid,
				$ev_str,
				cmd.execute_address,
				$cmd,
				$arg,
				Default_pointer,
				Default_pointer,
				Default_pointer,
				0,
				False
			)
			check
				successfull_connect: con_id > 0		
			end

-- alex
			-- Updating the `event_command_array' by including the new command :

			-- select the right event_id corresponding to the `event'
			event_id:= which_event_id (event, 0, False)

			-- first, we create the list if it doesn't exist.
			if event_command_array = Void then
				initialize_list
			end

			-- Then, we create the list linked to the given
			-- `con_id' if it doesn't exist already
			if (event_command_array @ event_id) = Void then
				create list_com.make
				event_command_array.force (list_com, event_id)
			end

			-- Finally, we add the command and its con_id to the lists
			(event_command_array @ event_id).extend (cmd, con_id)

		end

	remove_commands (wid: POINTER; event_id: INTEGER) is
			-- Remove the commands associated with
			-- 'event_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'event_id', nothing
			-- happens.
		require
			valid_id: event_id >= 1 and event_id <= command_count
		local
			list_com: EV_GTK_COMMAND_LIST
			con_id: INTEGER
		do
			if event_command_array /= Void then
				if (event_command_array @ event_id) /= Void then
					list_com:= event_command_array @ event_id
					from
						list_com.start
					until
						list_com.exhausted
					loop
						con_id := list_com.connexion_id
						gtk_signal_disconnect (wid, con_id)
						-- remove the command in GTK
						list_com.forth
					end
					event_command_array.force (Void, event_id)
						-- update of the event_command_array
				end
				if event_command_array.all_cleared then
					event_command_array := Void
				end
			end
		end

	remove_single_command (wid: POINTER; event_id: INTEGER; cmd: EV_COMMAND) is
			-- Remove `cmd' from the list of commmands associated
			-- with the event `event_id'.
		require
			valid_command: cmd /= Void
			valid_id: event_id >= 1 and event_id <= command_count
		local
			list_com: EV_GTK_COMMAND_LIST

		do
			if event_command_array /= Void and then 
					(event_command_array @ event_id) /= Void then
				list_com := event_command_array @ event_id
				from
					list_com.start
					list_com.search (cmd)
				until
					list_com.exhausted
				loop
					gtk_signal_disconnect (wid, list_com.connexion_id)
						-- remove the command in GTK
					list_com.remove
						-- update of the event_command_array
					list_com.search (cmd)
				end
			end

		end



feature {NONE} -- Deferred features

	widget: POINTER is
		deferred
		end

end -- class EV_EVENT_HANDLER_IMP
