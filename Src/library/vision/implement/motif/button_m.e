indexing

	description: 
		"EiffelVision implementation of a Motif button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_M 

inherit

	PRIMITIVE_M
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
		do
			Result := label_as_string
			keysym := mnemonic;
			if keysym /= '%U' then
				check
					string_has_mnemonic: Result.has (keysym)
				end;
				pos := Result.index_of (keysym, 1);
				Result.insert ("&", pos)
			end
		end; 

feature -- Status setting

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require
			not_text_void: a_text /= Void
		local
			menu_m: MENU_M;
			button_text: STRING
		do
			set_mnemonic_from_text (a_text, True)
		ensure
			text_set: text.is_equal (a_text)
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

	is_able_have_accerlators: BOOLEAN is
			-- Can the button able to have accelerators?
			-- True if it is not a label and not in an
			-- option pull
		local
			menu_m: MENU_M;
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
		local
			count, pos: INTEGER;
			finished: BOOLEAN;
			button_text: STRING;
			keysym: CHARACTER
		do
			if is_able_have_accerlators then
				count := a_text.count;
				if count > 0 then
					from
						pos := 1
					until
						finished
					loop
						pos := a_text.index_of ('&', pos);
						if pos = 0 then
							finished := True
						elseif pos = count then
							pos := 0;
							finished := True
						elseif a_text.item (pos + 1) /= '&' then	
							finished := True
						else
							pos := pos + 1
						end	
					end
				end
				if pos = 0 then
					if set_text_explicity then
						set_label_as_string (a_text)
						if mnemonic /= '%U' then
							set_mnemonic ('%U');
						end
					end
				else
					keysym := a_text.item (pos + 1);
					set_mnemonic (keysym);
					button_text := clone (a_text);
					button_text.remove (pos) -- Remove the `&'
					set_label_as_string (button_text)
				end
			elseif set_text_explicity then
				set_label_as_string (a_text)
			end;
		end

end -- class BUTTON_M

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
