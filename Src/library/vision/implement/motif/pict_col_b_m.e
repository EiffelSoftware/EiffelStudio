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
		do
			widget_index := widget_manager.last_inserted_position;
			mel_pb_make (a_push_b.identifier,
					mel_parent (a_push_b, widget_index),
					man);
			a_push_b.set_font_imp (Current)
			set_type_string (False);
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
				--ext_name := MlabelPixmap.to_c;
				--pixmap_x.set_default_pixmap (c_get_pixmap (screen_object, $ext_name));
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
				pixmap_implementation.remove_object (Current)
			end;
			private_pixmap := a_pixmap;
			pixmap_implementation ?= private_pixmap.implementation;
			pixmap_implementation.put_object (Current);
			--ext_name := MlabelPixmap.to_c;
			--c_set_pixmap (screen_object, 
					--pixmap_implementation.resource_pixmap (screen), 
					--$ext_name)
		end;

feature {NONE} -- Implementation

	private_pixmap: PIXMAP;
		-- Pixmap data

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X
		do
			--ext_name := MlabelPixmap.to_c;
			pixmap_implementation ?= pixmap.implementation;
			--c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
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
