--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- CHILD_CLIP: Figure able to be clipped by its window's children.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CHILD_CLIP 

feature {NONE}

	ClipByChildren: INTEGER is 0;
			-- X code to define clip by children mode

	IncludeInferiors: INTEGER is 1;
			-- X code to define include inferiors mode

feature 

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

	set_clipped_by_children is
			-- Specifies that drawing into the area of a drawing obscured by
			-- its visible children produces no effect.
		do
			subwindow_mode := ClipByChildren
		end;

	set_including_inferiors is
			-- Specifies that drawing appears through visible children even
			-- when they have opaque backgrounds.
		do
			subwindow_mode := IncludeInferiors
		end;

feature {NONE}

	subwindow_mode: INTEGER
			-- Whether subwindows obscure their parent for purposes of drawing
			-- on the parent

end
