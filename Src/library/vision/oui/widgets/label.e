--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Simple label.

indexing

	date: "$Date$";
	revision: "$Revision$"

class LABEL 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

creation

	make
	
feature -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.label (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Resizing policies

	allow_recompute_size is
			-- Allow current label to recompute its size according to
			-- changes on its value.
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size is
			-- Forbid current label to recompute its size according to
			-- changes on its value.
		do
			implementation.forbid_recompute_size
		end;

feature -- Text 
	
	set_center_alignment is
			-- Set text alignment of current label to center
		do
			implementation.set_center_alignment
		end;
	
	set_left_alignment is
			-- Set text alignment of current label to left.
		do
			implementation.set_left_alignment
		end;

	set_text (a_text: STRING) is
			-- Set text of current label to `a_text'.
		require
			not_a_text_void: not (a_text = Void)
		do
			implementation.set_text (a_text)
		ensure
			text.is_equal (a_text)
		end;

	text: STRING is
			-- Text of current label
		do
			Result:= implementation.text
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: LABEL_I;
			-- Implementation of current label

feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE ?
	
feature {NONE}

	set_default is
			-- Set default values to current label.
		do
		end;

end
