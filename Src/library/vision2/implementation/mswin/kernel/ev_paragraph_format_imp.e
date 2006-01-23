indexing
	description: "Mswin implementation for objects that represent paragraph formatting information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT_IMP
	
inherit
	EV_PARAGRAPH_FORMAT_I
		undefine
			copy, is_equal
		end
	
	WEL_PARAGRAPH_FORMAT2
		rename
			make as wel_make,
			destroy_item as destroy,
			alignment as wel_alignment,
			set_alignment as wel_set_alignment,
			initialize as wel_initialize
		end
		
	WEL_UNIT_CONVERSION
		export
			{NONE} all
		undefine
			copy, is_equal
		end
		
create
	make
		
feature -- Access

	make (an_interface: like interface) is
			-- Make `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
		end
		
	initialize is
			-- Initialize `Current'.
		do
			wel_set_alignment (pfa_left)
			set_is_initialized (True)
		end
		
feature -- Status report

	alignment: INTEGER is
			-- Current alignment. See EV_PARAGRAPH_CONSTANTS
			-- for possible values.
		local
			l_alignment: like wel_alignment
		do
			l_alignment := wel_alignment
			inspect l_alignment
			when pfa_left then
				Result := {EV_PARAGRAPH_CONSTANTS}.alignment_left
			when pfa_center then
				Result := {EV_PARAGRAPH_CONSTANTS}.alignment_center
			when pfa_right then
				Result := {EV_PARAGRAPH_CONSTANTS}.alignment_right
			when pfa_justify then
				Result := {EV_PARAGRAPH_CONSTANTS}.alignment_justified
			else
				Result := {EV_PARAGRAPH_CONSTANTS}.alignment_left
			end
		end

	left_margin: INTEGER is
			-- Left margin between border and text in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get

			Result := point_to_pixel (screen_dc, start_indent, 20)
			
			screen_dc.release
		end
		
	right_margin: INTEGER is
			-- Right margin between line end and border in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			
			Result := point_to_pixel (screen_dc, right_indent, 20)
			
			screen_dc.release
		end
		
	top_spacing: INTEGER is
			-- Spacing between top of paragraph and previous line in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			
			Result := point_to_pixel (screen_dc, space_before, 20)
			
			screen_dc.release	
		end
		
	bottom_spacing: INTEGER is
			-- Spacing between bottom of paragraph and next line in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			
			Result := point_to_pixel (screen_dc, space_after, 20)
			
			screen_dc.release
		end

feature -- Status setting

	set_alignment (an_alignment: INTEGER) is
			-- Assign `an_alignment' to `alignment.
		do
			if an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_left then
				wel_set_alignment (pfa_left)
			elseif an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_center then
				wel_set_alignment (pfa_center)
			elseif an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_right then
				wel_set_alignment (pfa_right)
			elseif an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_justified then
				wel_set_alignment (pfa_justify)
			else
				check
					alignment_not_handled: False
				end
			end
		end

	set_left_margin (a_margin: INTEGER) is
			-- Set `left_margin' to `a_margin'.
		local
			screen_dc: WEL_SCREEN_DC
		do			
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			
			set_start_indent (pixel_to_point (screen_dc, a_margin * 20))
			
			screen_dc.release
		end

	set_right_margin (a_margin: INTEGER) is
			-- Set `right_margin' to `a_margin'.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			
			set_right_indent (pixel_to_point (screen_dc, a_margin * 20))
			
			screen_dc.release
		end
		
	set_top_spacing (a_spacing: INTEGER) is
			-- Set `top_spacing' to `a_spacing'.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			
			set_space_before (pixel_to_point (screen_dc, a_spacing * 20))
			
			screen_dc.release
		end
		
	set_bottom_spacing (a_spacing: INTEGER) is
			-- Set `bottom_spacing' to `a_spacing'.
		local
			screen_dc: WEL_SCREEN_DC
		do
				-- Create a screen DC for access to metrics
			create screen_dc
			screen_dc.get
			set_space_after (pixel_to_point (screen_dc, a_spacing * 20))
			
			screen_dc.release
		end

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




end -- class EV_PARAGRAPH_FORMAT_IMP

