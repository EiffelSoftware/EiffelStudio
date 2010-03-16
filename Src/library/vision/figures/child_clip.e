note

	description: "Figure able to be clipped by its window's children"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	CHILD_CLIP

feature -- Status report 

	is_clipped_by_children: BOOLEAN
			-- Is drawing into the area of a drawing obscured by its visible
			-- produces no effect ?
		do
			Result := subwindow_mode = ClipByChildren
		end;

	is_including_inferiors: BOOLEAN
			-- Do drawing appears into the area of a window obscured by its
			-- visible children even when they have opaque backgrounds ?
		do
			Result := subwindow_mode = IncludeInferiors
		end;

feature -- Status setting

	set_clipped_by_children
			-- Specifies that drawing into the area of a drawing obscured by
			-- its visible children produces no effect.
		do
			subwindow_mode := ClipByChildren;
		end;

	set_including_inferiors
			-- Specifies that drawing appears through visible children even
			-- when they have opaque backgrounds.
		do
			subwindow_mode := IncludeInferiors;
		end;

feature {NONE} -- Access

	subwindow_mode: INTEGER;
			-- Whether subwindows obscure their parent for purposes of drawing
			-- on the parent

	ClipByChildren: INTEGER = 0;
			-- X code to define clip by children mode

	IncludeInferiors: INTEGER = 1;;
			-- X code to define include inferiors mode

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




end -- class CHILD_CLIP

