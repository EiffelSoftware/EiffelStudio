note

	description: 
		"EiffelVision implementation of a Motif gadget button."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_G_M 

inherit

	WIDGET_IMP
		redefine
			remove_action, set_action,
			set_background_color, set_background_pixmap
		end;

	FONTABLE_IMP;

	MEL_LABEL_GADGET
		rename
			make as mel_label_make,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		end

feature -- Access

	is_stackable: BOOLEAN
			-- Is the Current widget stackable?
		do
			Result := True
		end;

	is_label: BOOLEAN
			-- Is current button a label?
			-- (False by default)
		do
		end;

feature -- Status report

	text: STRING
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

	set_text (a_text: STRING)
			-- Set button text to `a_text'.
		require
			not_text_void: a_text /= Void
		do
			if a_text.empty then
				set_label_as_string (a_text)
			else
				set_mnemonic_from_text (a_text, True)
			end
		ensure
			text_set: text.is_equal (a_text)
		end;

	set_left_alignment
			-- Set text alignment to left.
		do
			set_beginning_alignment
		end;

	set_right_alignment
			-- Set text alignment to left.
		do
			set_end_alignment
		end;

feature -- Removal

	remove_action (a_translation: STRING)
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
		end;

feature {NONE} -- Implementation

	is_able_have_accerlators: BOOLEAN
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

	set_mnemonic_from_text (a_text: STRING; set_text_explicity: BOOLEAN)
			-- Extract the mnemonic from `a_text' and set it and then
			-- set the button text to `a_text' if `set_text_explicity' is True.
		local
			count, pos: INTEGER;
			finished: BOOLEAN;
			button_text: STRING;
			keysym: CHARACTER
		do
			if is_able_have_accerlators then
				count := a_text.count
				if count > 0 then
					from
						pos := 1;
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
		end;

	foreground_color: COLOR
			-- Foreground color of gadget (Is Void)
		do
		end

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY)
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		do
		end; 

	set_background_color (new_color: COLOR)
			-- Set background color to `new_color'.
		do
		end; 

	set_foreground_color (new_color: COLOR)
			-- Set foreground_color color to `new_color'.
		do
		end;

	update_foreground_color
			-- Do nothing.
		do
		end;

	set_background_pixmap (new_pixmap: PIXMAP)
			-- Set background_pixmap to `new_color'.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class BUTTON_G_M

