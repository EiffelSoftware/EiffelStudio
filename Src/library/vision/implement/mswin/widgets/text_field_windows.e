indexing
	description: "This class represents a MS_WINDOWS one-line text editor";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TEXT_FIELD_WINDOWS

inherit
	PRIMITIVE_WINDOWS
		redefine
			realize, 
			unrealize,
			on_key_down,
			on_key_up
		end

	TEXT_FIELD_I

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			move as wel_move,
			item as wel_item,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture, 
			release_capture as wel_release_capture,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			clear as wel_clear,
			set_selection as wel_set_selection,
			font as wel_font,
			set_font as wel_set_font
		undefine
			on_show,
			on_hide,
			on_size,
			on_move,
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_set_cursor,
			on_key_up,
			on_key_down,
			on_char
		end

	SIZEABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_text_field: TEXT_FIELD; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a text field.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			!! private_text.make (0)
			managed := man
			a_text_field.set_font_imp (Current)
		end

	realize is
			-- Realize current widget
		local
			wc: WEL_COMPOSITE_WINDOW
			fw: FONT_WINDOWS
		do
			if not realized then 
				if width = 0 then 
					set_width (150) 
				end
				resize_for_shell
				wc ?= parent
				wel_make (wc, text, x,y, width, height, id_default)
				if private_font /= Void then
					set_font (private_font)
				end
				if height = 0 then 
					fw ?= font.implementation
					set_height (fw.string_height (Current, "I") * 7 // 4)
				end
				set_text (private_text)
				if maximum_size > 0 then
					set_maximum_size (maximum_size)
				end
				if not managed then
					wel_hide
				elseif parent.shown then
					shown := true
				end
			end
		end

	unrealize is
			-- Unrealize current widget
		do
			private_text := text
			wel_destroy
		end

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
                        -- Add `a_command' to the list of action to be executed when
			-- an activate event occurs.
                        -- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			activate_actions.add (Current, a_command, argument)
		end
	
feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
                        -- Remove `a_command' from the list of action to execute when the
			-- an activate event occurs.
		do
			activate_actions.remove (Current, a_command, argument)
		end

feature -- Access

	maximum_size: INTEGER
			-- Maximum number of characters in current
			-- text field

	text: STRING is
			-- Value of current text field
		local
			ext_text: ANY
			size: INTEGER
		do
			if exists then
				Result := wel_text
			else
				Result := private_text
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of character in current text field
		do
			if exists  then
				Result := wel_text.count
			else
				Result := private_text.count
			end
		end

feature -- Status setting

	clear is
			-- Clear current text field.
		do
                        set_text ("")
		end

	set_maximum_size (a_max: INTEGER) is
                        -- Set maximum_size to `a_max'.
		do
			maximum_size := a_max
		end

	set_text (a_text: STRING) is
                        -- Set `text' to `a_text'.
		do
			private_text := clone (a_text)
			if exists then
				wel_set_text (a_text)
			end
		end

feature -- Element change

	append (s: STRING) is
                        -- Append `s' at the end of current text.
		local
			a_text: STRING
		do
			a_text := clone (text)
			a_text.append (s)
			set_text (a_text)
		end

	insert (s: STRING; a_position : INTEGER) is
                        -- Insert `s' in current text field at `a_position'.
                        -- Same as `replace (a_position, a_position, s)'.
		local
			a_text: STRING
		do
			a_text := clone (text)
			if a_position = a_text.count then
				a_text.append (s)
			else
				a_text.insert (s, a_position + 1)
			end
			set_text (a_text)
		end

	replace (from_position, to_position: INTEGER; s: STRING) is
                        -- Replace text from `from_position' to `to_position' by `s'.
		local
			a_text: STRING
		do
			a_text := clone (text)
			if from_position = to_position then
				a_text.insert (s, from_position + 1)
			else
				a_text.replace_substring (s, from_position + 1, to_position)
			end
			set_text (a_text)
		end

feature {NONE} -- Implementation

	private_text: STRING
			-- Value of current text field

	on_char (virtual_key, key_data: INTEGER) is
			-- Wm_char message
		do
			if virtual_key = vk_return or virtual_key = vk_tab then
				disable_default_processing
			end
		end

	on_key_up (code, flags: INTEGER) is
			-- Respond to a wm_key_up message.
		local
			cd: KEYREL_DATA
			k: KEYBOARD_WINDOWS
		do
			check
				code_large_enough: code >= virtual_keys.lower
				code_small_enough: code <= virtual_keys.upper
			end
			!! k.make_from_key_state
			!! cd.make (owner, code, virtual_keys @ code, k);
			key_release_actions.execute (Current, cd)
			if code = Vk_shift then
				shift_pressed := False
			end
		end

	on_key_down (code, flags: INTEGER) is
			-- Wm_keydown message
		local
			kw: KEYBOARD_WINDOWS
			kpd: KYPRESS_DATA
		do
			!! kw.make_from_key_state
			!! kpd.make (owner, code, virtual_keys @ code, kw) 
			key_press_actions.execute (Current, kpd)
			if code = Vk_return then
				activate_actions.execute (Current, kpd)
				disable_default_processing
			elseif code = Vk_tab then
				if shift_pressed then
					go_to_prev_text_field
				else
					go_to_next_text_field
				end
				disable_default_processing
			elseif code = Vk_shift then
				shift_pressed := True
			end
		end

	go_to_prev_text_field is
		local
			tf: TEXT_FIELD_WINDOWS
			found: BOOLEAN
			p : POINTER
			w: W_MANAGER
		do
			w := widget_manager
			from
				w.start
			until
				w.after or else w.item.implementation = Current
			loop
				w.forth
			end
			if not w.after then
				from
					w.forth
				until
					w.after or else found or else w.item.depth = 0
				loop
					tf ?= w.item.implementation
					found := tf /= Void
					w.forth
				end
				if not found then	
					from
						w.start
					until
						found or else w.item.implementation = Current
					loop
						tf ?= w.item.implementation
						found := tf /= Void
						w.forth
					end
				end		
			end
			if found then
				tf.wel_set_focus
			end
		end

	go_to_next_text_field is
		local
			tf: TEXT_FIELD_WINDOWS
			found: BOOLEAN
			p : POINTER
			w: W_MANAGER
		do
			w := widget_manager
			from
				w.start
			until
				w.after or else w.item.implementation = Current
			loop
				w.forth
			end
			if not w.off then
				from
					w.back
				until
					w.before or else found or else w.item.depth = 0
				loop
					tf ?= w.item.implementation
					found := tf /= Void
					w.back
				end
				if not found then	
					from
						w.finish
					until
						found or else w.item.implementation = Current
					loop
						tf ?= w.item.implementation
						found := tf /= Void
						w.back
					end
				end		
			end
			if found then
				tf.wel_set_focus
			end
		end

	shift_pressed: BOOLEAN
			-- Is the shift-key pressed?

end -- class TEXT_FIELD_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
