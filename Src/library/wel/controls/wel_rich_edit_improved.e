deferred class
	WEL_RICH_EDIT_IMPROVED

inherit
	WEL_RICH_EDIT
		redefine
			on_en_msgfilter,
			make,
			on_char,
			on_key_down,
			on_key_up,
			default_style

		end

	WEL_VK_CONSTANTS
	
	WEL_WINDOWS_ROUTINES
	
--creation
--	make,
--	make_by_id
feature -- Initialisation
	make (a_parent: WEL_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
		do
			{WEL_RICH_EDIT} Precursor (a_parent, a_name, a_x, a_y, a_width, 
												a_height, an_id)
			set_event_mask (enm_keyevents)
		end

		
feature -- Notifications


	on_char (character_code, key_data: INTEGER) is
		do
			if
				character_code /= Vk_back and
					-- only events that really insert a character
					-- `Vk_back' is handled somewhere else
				not (character_code = Vk_tab and has_selection) and
					-- do nothing, is handled elsewhere
				not ctrl_down
			then
				if
					has_selection
				then
					on_delete_selection
				end
				on_insert_character (character_code.ascii_char)
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Wm_keydown message
		do
			if
				virtual_key = Vk_delete
			then
				if
					has_selection
				then
					on_delete_selection
				else
					on_delete_right_character
				end
			elseif
				virtual_key = Vk_insert
			then
				if
					not has_selection
				then
					if
						shift_down
					then
						on_paste_clipboard
					end
				end
			elseif
				virtual_key.ascii_char = 'V'
			then
				if
					ctrl_down
				then
					on_paste_clipboard
				end
			elseif
				virtual_key.ascii_char = 'X'
			then
				if
					ctrl_down
				then
					on_cut_selection
				end
			elseif
				virtual_key.ascii_char = 'Y'
			then
				if
					ctrl_down
				then
					on_redo
				end
			elseif
				virtual_key.ascii_char = 'Z'
			then
				if
					ctrl_down
				then
					on_undo
				end
			elseif
				virtual_key = Vk_back
			then
				if
					has_selection
				then
					on_delete_selection
				else
					on_delete_left_character
				end
			end
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Wm_keydown message
		do
--			trace_msg ("key up", virtual_key)
		end


	on_en_msgfilter (a_msg_filter: WEL_MSG_FILTER) is
		do
--			if
--				a_msg_filter.msg = Wm_char
--			then
				--chr := a_msg_filter.wparam.ascii_char
				--on_insert_character (chr)
--			end
--			elseif
--				a_msg_filter.msg = Wm_syschar
--			then
--				trace_msg ("wm_sys_char", a_msg_filter.wparam)
--			elseif
--				a_msg_filter.msg = Wm_deadchar
--			then
--				trace_msg ("wm_dead_char", a_msg_filter.wparam)
--			elseif
--				a_msg_filter.msg = Wm_sysdeadchar
--			then
--				trace_msg ("wm_sys_dead_char", a_msg_filter.wparam)
			if
				a_msg_filter.msg = Wm_keydown
			then
				-- trace_msg ("wm_kew_down", a_msg_filter.wparam)
				if
					(a_msg_filter.wparam.ascii_char = 'Z' or
					 a_msg_filter.wparam.ascii_char = 'Y') and
					ctrl_down
				then
					ignore_filtered_message
				end
			end
			
			if
				((a_msg_filter.msg = Wm_char) or (a_msg_filter.msg = Wm_keydown) or
				(a_msg_filter.msg = Wm_keyup))
				and (a_msg_filter.wparam = Vk_tab) and (has_selection)
			then
				ignore_filtered_message
			end
		end

	trace_msg (msg: STRING; i: INTEGER) is
		require
			msg /= Void
		do
				print (msg)
				print ("[")
				print (i.out)
				print (",")
				print (i.ascii_char.out)
				print ("]%N")
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
   			-- Default style used to create the control
  		once
--  			Result := 	ws_visible + ws_child + ws_border + ws_hscroll + 
--  							ws_vscroll + es_savesel + es_disablenoscroll + es_multiline +
--  							+ Es_nohidesel + Es_autohscroll

  			Result := 	ws_visible + ws_child + ws_hscroll + ws_vscroll + es_disablenoscroll +
  							es_multiline + Es_autohscroll
  		end;

feature {NONE} -- Key pressed tests

	ctrl_down: BOOLEAN is
			-- Was the CONTROL key down, when the last windows message was dispatched?
		do
			Result := key_down (Vk_control)
		end

	shift_down: BOOLEAN is
			-- Was the SHIFT key down, when the last windows message was dispatched?
		do
			Result := key_down (Vk_shift)
		end
	
feature {NONE} -- test

	on_insert_character (chr: CHARACTER)	is
			-- Inserts `chr' at current position by moving all 
			-- characters starting from the current position
			-- to the right.
		deferred
		end
	
	on_delete_left_character is
		deferred
		end

	on_delete_right_character is
		deferred
		end

	on_delete_selection is
		deferred
		end
		
	on_cut_selection is
		deferred
		end

	on_paste_clipboard is
		deferred
		end

	on_undo is
		deferred
		end

	on_redo is
		deferred
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
