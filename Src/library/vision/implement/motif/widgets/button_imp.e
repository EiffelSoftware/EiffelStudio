indexing

	description: 
		"EiffelVision implementation of a Motif button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_IMP

inherit

	PRIMITIVE_IMP
		rename
			is_shown as shown
		end;

	MEL_LABEL
		rename
			make as mel_label_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		end

feature -- Access

	is_label: BOOLEAN is
			-- Is current button a label?
			-- (False by default)
		do
		end;

feature -- Status report

	text: STRING is
			-- Text of button
		local
			keysym: CHARACTER;
			pos: INTEGER;
			pull: MEL_PULLDOWN_MENU;
			acc_text: MEL_STRING
		do
			Result := label_as_string
			keysym := mnemonic;
			if Result.has (keysym) then
				pos := Result.index_of (keysym, 1);
				Result.insert ("&", pos)
			end;
			pull ?= parent;
			if pull /= Void then
				-- Parent is menu pull.
				-- Check to see for accelerators.
				acc_text := accelerator_text;
				if acc_text /= Void then
					Result.extend ('%T');
					Result.append (acc_text.to_eiffel_string);
					acc_text.destroy
				end
			end
		end; 

feature -- Status setting

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require
			not_text_void: a_text /= Void
		local
			menu_m: MENU_IMP;
			button_text: STRING
		do
			if a_text.is_empty then
				set_label_as_string (a_text)
			else
				set_mnemonic_from_text (a_text, True)
			end
		ensure 
			text_set: equal (without_ampersands (text), without_ampersands (a_text))
		end;

	set_left_alignment is
			-- Set text alignment to left.
		do
			set_beginning_alignment
		end;

	set_right_alignment is
			-- Set text alignment to left.
		do
			set_end_alignment
		end;

feature {NONE} -- Implementation

	without_ampersands (a_text: STRING): STRING is
			-- Returns a string which is a_text without ampersands
		do
			Result := clone(a_text)
			Result.prune_all('&')
		end
	
			
	is_able_have_accerlators: BOOLEAN is
			-- Can the button able to have accelerators?
			-- True if it is not a label and not in an
			-- option pull
		local
			menu_m: MENU_IMP;
			a_text: STRING
		do
			if not is_label then
				menu_m ?= parent;
				Result := menu_m /= Void and then
					menu_m.children_has_accelerators
			end
		end

	set_mnemonic_from_text (a_text: STRING; set_text_explicity: BOOLEAN) is
			-- Extract the mnemonic from `a_text' and set it and then
			-- set the button text to `a_text' if `set_text_explicity' is True.
		require
			valid_text: a_text /= Void 
		local
			count, pos: INTEGER;
			finished: BOOLEAN;
			button_text: STRING;
			keysym: CHARACTER;
			pull: MEL_PULLDOWN_MENU;
			acc_text: MEL_STRING;
			acc_set: BOOLEAN
		do
			if not a_text.is_empty then
				if is_able_have_accerlators then
					count := a_text.count;
					pull ?= parent;
					button_text := a_text;
					if pull /= Void then
							-- Find the %T tag and anything after this
							-- is the accelerator text
						pos := button_text.index_of ('%T', 1);
						if pos > 1 and then pos /= count then
							!! acc_text.make_localized (button_text.substring (pos + 1, count));
							set_accelerator_text (acc_text);
							button_text := button_text.substring (1, pos - 1);
							acc_set := True;
						elseif set_text_explicity then
							set_accelerator_text (Void);
						end
					end;
					from
						pos := 1
					until
						finished
					loop
						pos := button_text.index_of ('&', pos);
						if pos = 0 then
							finished := True
						elseif pos = count then
							pos := 0;
							finished := True
						elseif button_text.item (pos + 1) /= '&' then	
							finished := True
						else
							pos := pos + 1
						end	
					end
					if pos = 0 then
						if set_text_explicity or else acc_set then
							set_label_as_string (button_text)
							if mnemonic /= '%U' then
								set_mnemonic ('%U');
							end
						end
					else
						keysym := button_text.item (pos + 1);
						set_mnemonic (keysym);
						button_text := clone (button_text);
						button_text.remove (pos) -- Remove the `&'
						set_label_as_string (button_text)
					end
				elseif set_text_explicity then
					set_label_as_string (a_text)
				end;
			end
		end
	
end -- class BUTTON_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

