indexing

	description: "Figure able to be clipped by its window's children";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CHILD_CLIP

feature -- Modification & Insertion 

	set_clipped_by_children is
			-- Specifies that drawing into the area of a drawing obscured by
			-- its visible children produces no effect.
		do
			subwindow_mode := ClipByChildren;
		end;

	set_including_inferiors is
			-- Specifies that drawing appears through visible children even
			-- when they have opaque backgrounds.
		do
			subwindow_mode := IncludeInferiors;
		end;

feature -- Status report 

	is_clipped_by_children: BOOLEAN is
			-- Is drawing into the area of a drawing obscured by its visible
			-- produces no effect ?
		do
			Result := subwindow_mode = ClipByChildren
		end;

	is_including_inferiors: BOOLEAN is
			-- Do drawing appears into the area of a window obscured by its
			-- visible children even when they have opaque backgrounds ?
		do
			Result := subwindow_mode = IncludeInferiors
		end;


feature {NONE} -- Access

	subwindow_mode: INTEGER;
			-- Whether subwindows obscure their parent for purposes of drawing
			-- on the parent

	ClipByChildren: INTEGER is 0;
			-- X code to define clip by children mode

	IncludeInferiors: INTEGER is 1;
			-- X code to define include inferiors mode


end -- class CHILD_CLIP


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
