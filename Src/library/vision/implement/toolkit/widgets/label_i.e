indexing

	description: "General label implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	LABEL_I 

inherit

	PRIMITIVE_I;

	FONTABLE_I
	
feature -- Access

	text: STRING is
			-- Text of current label
		deferred
		end

feature -- Status setting

	allow_recompute_size is
			-- Allow current label to recompute its  size according to
			-- some changes on its value.
		deferred
		end;

	forbid_recompute_size is
			-- Forbid current label to recompute its size according to
			-- some changes on its value.
		deferred
		end;

	set_right_alignment is
		-- Set text alignment of current label to right.
		deferred
		end;

	set_center_alignment is
			-- Set text alignment of current label to center.
		deferred
		end;

	set_left_alignment is
			-- Set text alignment of current label to left.
		deferred
		end;

feature -- Element change

	set_text (a_text: STRING) is
			-- Set text of current label to `a_text'.
		require
			not_a_text_void: a_text /= Void
		deferred
		ensure
			set: text.is_equal (a_text)
		end;

end --class LABEL_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

