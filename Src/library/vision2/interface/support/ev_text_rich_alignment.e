indexing
	description:
		"Enumeration class for text rich alignment       %
		% (left, center, right) for horizontal alignment %
		% (top, middle, bottom) for vertical alignment   "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "text, aligment, vertical, horizontal"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_RICH_ALIGNMENT

inherit
	EV_TEXT_ALIGNMENT

create
	default_create,
	make_with_left_alignment,
	make_with_center_alignment,
	make_with_right_alignment

feature -- Status setting

	set_top_alignment is
			-- Set the vertical alignment to "top"
		do
			vertical_alignment_code := top_alignment
		ensure
			is_top_aligned: is_top_aligned
		end

	set_middle_alignment is
			-- Set the vertical alignment to "top"
		do
			vertical_alignment_code := middle_alignment
		ensure
			is_middle_aligned: is_middle_aligned
		end

	set_bottom_alignment is
			-- Set the vertical alignment to "top"
		do
			vertical_alignment_code := bottom_alignment
		ensure
			is_bottom_aligned: is_bottom_aligned
		end

feature -- Status report

	is_top_aligned: BOOLEAN is
			-- Is the vertical alignment set to "top"?
		do
			Result := vertical_alignment_code = top_alignment
		end

	is_middle_aligned: BOOLEAN is
			-- Is the vertical alignment set to "middle"?
		do
			Result := vertical_alignment_code = middle_alignment
		end

	is_bottom_aligned: BOOLEAN is
			-- Is the vertical alignment set to "bottom"?
		do
			Result := vertical_alignment_code = bottom_alignment
		end

feature {EV_ANY_I} -- Implementation

	vertical_alignment_code: INTEGER
		-- Used internally to represent one of the three 
		-- vertical alignment states.

	top_alignment: INTEGER is 0
		-- Constant representing top alignment.
	middle_alignment: INTEGER is 1
		-- Constant representing middle alignment.
	bottom_alignment: INTEGER is 2
		-- Constant representing bottom alignment

invariant
	vertical_alignment_code_within_range:  
		alignment_code >= top_alignment and 
		alignment_code <= bottom_alignment

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT_RICH_ALIGNMENT

