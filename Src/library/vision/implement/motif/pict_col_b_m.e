indexing

	description: 
		"EiffelVision implementation of a push button with a pixmap.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PICT_COL_B_M 

inherit

	PICT_COL_B_I;

	PUSH_B_M
		rename
			make as push_b_m_make,
			pixmap as mel_pixmap,
			set_pixmap as mel_set_pixmap
		end

creation

	make

feature {NONE} -- Initialization

	make (a_push_b: PICT_COLOR_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif push button.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_pb_make (a_push_b.identifier, mc, man);
			a_push_b.set_font_imp (Current)
			set_type_pixmap
		end;

feature -- Status report

	pixmap: PIXMAP is
			-- Pixmap for Current
		local
			ext_name: ANY;
			pixmap_x: PIXMAP_X
		do
			if private_pixmap = Void then
				!! private_pixmap.make;
				pixmap_x ?= private_pixmap.implementation;
				pixmap_x.increment_users;
				pixmap_x.set_default_pixmap (mel_pixmap);
			end;
			Result := private_pixmap
		end;

feature -- Status setting

	set_pixmap (a_pixmap: PIXMAP) is
			-- Set pixmap to `a_pixmap'.
		local
			pixmap_implementation: PIXMAP_X;
			ext_name: ANY
		do
			if private_pixmap /= Void then
				pixmap_implementation ?= private_pixmap.implementation;
				pixmap_implementation.decrement_users
			end;
			private_pixmap := a_pixmap;
			pixmap_implementation ?= a_pixmap.implementation;
			pixmap_implementation.increment_users;
			mel_set_pixmap (pixmap_implementation);
			set_insensitive_pixmap (pixmap_implementation)
		end;

feature {PIXMAP_X} -- Implementation

	private_pixmap: PIXMAP;
			-- Pixmap data

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			pixmap_implementation: PIXMAP_X
		do
			pixmap_implementation ?= private_pixmap.implementation;
			mel_set_pixmap (pixmap_implementation);
			set_insensitive_pixmap (pixmap_implementation)
		end

end -- PICT_COL_B_M

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
