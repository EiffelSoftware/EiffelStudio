indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TRANSLATION_COMMAND 

inherit
	EVENT_HDL

	WEL_SIZE_CONSTANTS

	COMMAND
		redefine
			context_data_useful,
			execute
		end

creation

	make

feature -- Initialization

	make (s: STRING; c: COMMAND; a: ANY) is
		require
			s_exists: s /= Void
			s_meaningful: not s.empty
		do
			translation := s
			parse (s)
			command := c
			argument := a
		end

feature 

	argument: ANY
			-- Argument for set_action

	context_data_useful: BOOLEAN is
			-- Should the context data be available
			-- when Current command is invoked as a
			-- callback
		do
			Result := true
		end

	execute (arg: ANY) is
			-- Execute Current command.
			-- `argument' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		local
			command_clone: COMMAND
		do
			if conditions_met then
				debug ("ACTION")
					io.error.putstring ("conditions met%N")
				end
				if executing_exact.item then
					debug ("ACTION")
						io.error.putstring ("executing exact%N")
					end
					if exact_to_execute then
						debug ("ACTION")
							io.error.putstring ("exact to execute%N")
						end
						if command.is_template then
							command_clone := clone (command)
						else
							command_clone := command
						end
						command_clone.set_context_data (context_data)
						command_clone.execute (arg)
					else
						-- while it looks good its not exact enough
					end
				else -- we can execute all translations that match
					debug ("ACTION")
						io.error.putstring ("not executing exact%N")
					end
					if command.is_template then
						command_clone := clone (command)
					else
						command_clone := command
					end
					command_clone.set_context_data (context_data)
					command_clone.execute (arg)
				end
			end
		end;

feature {WIDGET_IMP, ACCELERABLE_WINDOWS} -- Implementation

	parse (s: STRING) is
		local
			m : CHARACTER
			modifier, action: STRING
			place: INTEGER
			t : INTEGER
		do
			from
				t := 1
			variant
				special_translations.count + 1 - t
			until
				t > special_translations.count or special_translation_number /= 0
			loop
				if special_translations.item (t).is_equal (s) then
					other_action := true
					place := s.count + 1
					special_translation_number := t
				end
				t := t + 1
			end
			if special_translation_number = 0 then
				m := s.item (1)

-- FIXME: On windows, we should put exact to true all the time, because otherwise if we have
-- Ctrl<Btn1Down> and <Btn1Down> it will execute the two actions corresponding to the
-- two events when you press Ctrl+Btn1 instead of doing only the first one.
				exact := true

				if m = '!' then
--					exact := true
					place := 2
				elseif m = ':' then
					case_sensitive := true
					place := 2
				elseif m = '~' then
					io.error.putstring ("Translation table processing unavailable for ~%N")
					place := s.count + 1
				else
					place := 1
				end
			end
			from 
				!!modifier.make (0)
			variant
				s.count + 1 - place
			until
				place > s.count or else s.item (place) = '<'
			loop            
				modifier.extend (s.item(place))
				place := place + 1
			end
			modifier.to_lower
			no_modifier := true
			if not modifier.empty then
				if modifier.index_of ('s',1) > 0 then
					shift_required := true
					no_modifier := false
				end
				if modifier.index_of ('a',1) > 0 then
					alt_required := true
					no_modifier := false
				end
				if modifier.index_of ('c',1) > 0 then
					ctrl_required := true
					no_modifier := false
				end
			end
			place := place + 1
			from
				!!action.make (0)
			variant
				s.count + 2 - place
			until
				place > s.count or else s.item(place) = '>'
			loop
				action.extend (s.item (place))
				place := place + 1
			end
			action.to_lower
			if not action.empty then
				if action.substring_index ("up",1) > 0 then
					direction_up := true
				end
				t := action.substring_index ("btn", 1)
				if action.substring_index ("key",1) > 0 then
					key_action := true
				end 
			end
			if t > 0 and then t+3 <= action.count then
				mouse_action := true
				if ("123").has(action.item (t+3)) then
					mouse_button := action.item (t+3).code - ('0').code
				end 
			end 
			if place < s.count  then
				place := place + 1
				key_string := s.substring (place, s.count)
				key_string.to_upper
			end
			debug ("ACTION")
				io.putstring ("Translation: ")
				io.putstring (s)
				io.new_line
				io.putstring ("No modifier: ")
				io.putbool (no_modifier)
				io.new_line
				io.putstring ("Exact: ")
				io.putbool (exact)
				io.new_line
				io.putstring ("Required%N")
				io.putstring ("ALT ")
				io.putbool (alt_required)
				io.putstring (" SHIFT ")
				io.putbool (shift_required)
				io.putstring (" CTRL ")
				io.putbool (ctrl_required)
				io.new_line
				io.putstring ("Mouse button: ")
				io.putint (mouse_button)
				io.new_line                        
				io.putstring ("Up?: ")
				io.putbool (direction_up)
				io.new_line
				io.putstring ("Case sensitive: ")
				io.putbool (case_sensitive)
				io.new_line
				io.putstring ("Key action?: ")
				io.putbool (key_action)
				io.new_line
				io.putstring (" Mouse action?: ")
				io.putbool (mouse_action)
				io.new_line
				io.putstring ("Other action?: ")
				io.putbool (other_action)
				io.new_line
				io.putstring ("Special translation number: ")
				io.putint (special_translation_number)
				io.new_line
			end
		end

feature {WIDGET_ACTIONS, WIDGET_IMP, ACCELERABLE_WINDOWS}

	equiv (other: TRANSLATION_COMMAND) : BOOLEAN is
		do
			Result :=
				alt_required = other.alt_required and then
				ctrl_required = other.ctrl_required and then
				shift_required = other.shift_required and then
				direction_up = other.direction_up and then
				equal (key_string, other.key_string) and then
					((mouse_button = other.mouse_button) or else
					 (other.mouse_button = 0))
		end

	conditions_met: BOOLEAN is
		local
			bd: BUTTON_DATA
			kd: KEY_DATA
		do
			bd ?= context_data
			if bd /= Void then      
					-- A response to a button event of some sort                    
				if (mouse_button = 0) or else (bd.button = mouse_button) then
					if no_modifier then
						if exact then
							Result := not bd.keyboard.shift_pressed and
								not bd.keyboard.modifiers.item (1) and
								not bd.keyboard.control_pressed
						else
							Result := true
						end
					else    -- We have a modifier check for each and that its met before we
						-- agree the conditions are met
						Result := true
						if shift_required then
							Result := bd.keyboard.shift_pressed
						elseif exact then
							Result := not bd.keyboard.shift_pressed
						end
						if Result then
							if alt_required then
								Result := bd.keyboard.modifiers.item (1)        
							elseif exact then
								Result := not bd.keyboard.modifiers.item (1)
							end
						end
						debug ("ACTION")
							io.putstring ("Result before ctrl required ")
							io.putbool (Result)
							io.new_line
						end
						if Result then
							if ctrl_required then
								Result := bd.keyboard.control_pressed
							elseif exact then
								Result := not bd.keyboard.control_pressed
							end
						end
						debug ("ACTION")
							io.putstring ("Result after ctrl required ")
							io.putbool (Result)
							io.new_line
						end
					end
				else -- Wrong button
				end
			else
				kd ?= context_data
					-- A response to a key event of some sort
				if kd /= Void then
					Result := kd.string.is_equal (key_string)
					if no_modifier then
						-- We have the result
					else    -- We have a modifier check for each and that its met before we
						-- agree the conditions are met
						if Result and shift_required then
							Result := kd.keyboard.shift_pressed
						end
						if Result and then alt_required then
							Result := kd.keyboard.modifiers.item (1)
						end
						if Result and then ctrl_required then
							Result := kd.keyboard.control_pressed
						end
					end
				else
					-- Another event type
					-- Configure event on WM_MOVE
					-- Configure, Map or Unmap on WM_SIZE
					Result := True
				end
			end
		end

feature {WIDGET_ACTIONS}

	set_exact_to_execute is
		do
			executing_exact.set_item (true)
			exact_to_execute := true
		end

	executing_exact: BOOLEAN_REF is
		once
			!! Result
		end

	set_no_execute_now is
		do
			executing_exact.set_item (false)
			exact_to_execute := false
		end

	exact_to_execute: BOOLEAN 
			-- This is the exact to execute

	exact: BOOLEAN
			-- There must be an exact match of this translation

feature {WIDGET_IMP, TRANSLATION_COMMAND, WIDGET_ACTIONS, ACCELERABLE_WINDOWS}

	command: COMMAND

	no_modifier: BOOLEAN 
		-- No Alt, Ctrl, Shift is required for this translation

	alt_required: BOOLEAN
			-- The alt key is required

	ctrl_required: BOOLEAN
			-- The control key is required

	shift_required: BOOLEAN
			-- The shift key is required

	mouse_button: INTEGER
			-- Which mouse button for this translation

	direction_up: BOOLEAN
			-- Whether the action is a press/down or release/up

	case_sensitive: BOOLEAN
			-- Must we also match on case?

	key_string: STRING
			-- Key to be pressed
			-- Represented as a virtual key string

	key_action: BOOLEAN
			-- Is this action dependent on a key
			
	mouse_action: BOOLEAN
			-- Is this action dependent on a mouse action?
			
	other_action: BOOLEAN
			-- Is this action independent of the mouse and keyboard

	configure_action: BOOLEAN is
			-- Is this action a `Configure' action?
		do
			Result := special_translation_number = 4
		end

	visible_action: BOOLEAN is
			-- Is this action a `Configure' action?
		do
			Result := special_translation_number = 3
		end

	map_action: BOOLEAN is
			-- Is this action a `map' action?
		do
			Result := special_translation_number = 2
		end

	unmap_action: BOOLEAN is
			-- Is this action an `unmap' action?
		do
			Result := special_translation_number = 1
		end

	translation: STRING
			-- Text of translation

	special_translation_number : INTEGER
			-- Number of matched special translation

	special_translations : ARRAY [STRING] is
			-- Translations we will specifically allow and deal with
		once
			Result := << 
				"<Unmap>,<Prop>",       -- WM_SIZE & SIZE_MINIMIZED message.
				"<Prop>,<Map>",         -- WM_SIZE & SIZE_MAXMIZE or SIZE_RESTORED message.
				"<Visible>",            -- WM_SHOWWINDOW message.
				"<Configure>">>		-- WM_MOVE and WM_SIZE message.
		end

end -- class TRANSLATION_COMMAND

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

