indexing
	description: "Implementation interface for objects that represent paragraph formatting information."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PARAGRAPH_FORMAT_I
	
inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Status report

	alignment: INTEGER is
			-- Current alignment. See EV_PARAGRAPH_CONSTANTS
			-- for possible values.
		deferred
		end

	left_margin: INTEGER is
			-- Left margin between border and text in pixels.
		deferred
		end
		
	right_margin: INTEGER is
			-- Right margin between line end and border in pixels.
		deferred
		end
		
	top_spacing: INTEGER is
			-- Spacing between top of paragraph and previous line in pixels.
		deferred
		end
		
	bottom_spacing: INTEGER is
			-- Spacing between bottom of paragraph and next line in pixels.
		deferred
		end

feature -- Status setting

	set_alignment (an_alignment: INTEGER) is
			-- Assign `an_alignment' to `alignment.
		deferred
		ensure
			alignment_set: alignment = an_alignment
		end

	set_left_margin (a_margin: INTEGER) is
			-- Set `left_margin' to `a_margin'.
		require
			margin_non_negative: a_margin >= 0
		deferred
		ensure
			margin_set: left_margin = a_margin
		end

	set_right_margin (a_margin: INTEGER) is
			-- Set `right_margin' to `a_margin'.
		require
			margin_non_negative: a_margin >= 0
		deferred
		ensure
			margin_set: right_margin = a_margin
		end
		
	set_top_spacing (a_spacing: INTEGER) is
			-- Set `top_spacing' to `a_spacing'.
		require
			spacing_non_negative: a_spacing >= 0
		deferred
		ensure
			spacing_set: top_spacing = a_spacing
		end
		
	set_bottom_spacing (a_spacing: INTEGER) is
			-- Set `bottom_spacing' to `a_spacing'.
		require
			spacing_non_negative: a_spacing >= 0
		deferred
		ensure
			spacing_set: bottom_spacing = a_spacing
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PARAGRAPH_FORMAT

end -- class EV_PARAGRAPH_FORMAT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

