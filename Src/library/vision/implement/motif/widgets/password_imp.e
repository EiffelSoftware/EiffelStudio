indexing

	description:
		"EiffelVision implementation of Motif password widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PASSWORD_IMP

inherit

	PASSWORD_I;

	TEXT_FIELD_IMP
		rename
			make as text_field_make
		redefine
			text, value
		end

	MEL_COMMAND

creation

	make

feature {NONE} -- Creation

	make (a_password: PASSWORD; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif text_field but do not echo input
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_text_make (a_password.identifier, mc, man);
			a_password.set_font_imp (Current)
			-- add modify action
			set_modify_verify_callback (Current, void);
		end;

feature  -- Access
	text, value :string is
		do
			Result := clone (password)
		end

feature {NONE} -- implementation

	execute (arg:ANY) is
		local
			vs: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			vs ?= callback_struct
			check 
				vs /= void
			end

			if vs.start_pos < vs.end_pos then
				password.replace_substring(vs.text_string, vs.start_pos+1, vs.end_pos)
			elseif vs.start_pos < password.count then
				password.insert(vs.text_string, vs.start_pos+1)
			else
				password.append(vs.text_string)
			end
			vs.set_all_to ('*')
		end

	password: STRING is
		once
			!!Result.make(0)
		end

end -- class PASSWORD_IMP

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

