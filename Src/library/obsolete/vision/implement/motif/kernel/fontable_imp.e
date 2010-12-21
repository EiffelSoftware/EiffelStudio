note

	description: 
		"EiffelVision implementation of motif fontable widget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	FONTABLE_IMP

feature -- Access

	font: FONT
			-- Current font
		local
			font_x: FONT_IMP
		do
			if private_font = Void then
				create private_font.make;
				font_x ?= private_font.implementation;
				font_x.set_default_font (font_list)
			end;
			Result := private_font
		end;

	font_list: MEL_FONT_LIST
			-- Motif font list for fontable widget
		deferred
		end;

	screen: SCREEN_I
			-- Associated screen
		deferred
		end

feature -- Status setting

	set_font_list (a_font_list: MEL_FONT_LIST)
			-- Set `font_list' to `a_font_list'.
		require
			valid_font_list: a_font_list /= Void and then a_font_list.is_valid
		deferred
		end;

	set_font (a_font: FONT)
			-- Set font label to `a_font'.
		require
			a_font_exists: a_font /= Void;
			a_font_specified: a_font.is_specified
		local
			font_implementation: FONT_IMP;
		do
			if private_font /= Void then
				font_implementation ?= private_font.implementation;
				font_implementation.decrement_users
			end;
			private_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.increment_users;
			set_font_from_imp (font_implementation)
		ensure
			set: font = a_font
		end; 

	font_width_of_string (a_text: STRING): INTEGER
			-- Width of string for `font'
		do
			Result := font.width_of_string (a_text);
		end;

feature {FONT_IMP} -- Implementation

	private_font: FONT
			-- Private font

	update_font
			-- Update the X font after a change inside the Eiffel font.
		local
			font_implementation: FONT_IMP
		do
			font_implementation ?= private_font.implementation;
			set_font_from_imp (font_implementation)
		end

feature {NONE} -- Implementation

	set_font_from_imp (font_implementation: FONT_IMP)
			-- Set the font from `a_font_imp'.
		require
			valid_font_imp: font_implementation /= Void
		local
			a_font_list: MEL_FONT_LIST
		do
			font_implementation.allocate_font;
			if font_implementation.is_valid then
				a_font_list := font_implementation.font_list;
				if a_font_list.is_valid then
					set_font_list (a_font_list);
					a_font_list.destroy
				else
					io.error.putstring ("Warning cannot allocate font%N");
				end;
			else
				io.error.putstring ("Warning cannot allocate font%N");
			end
		end;

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




end -- class FONTABLE_IMP

