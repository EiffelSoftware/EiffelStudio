note
	description:
		"Eiffel Vision colorizable. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "colorizible"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLORIZABLE_IMP

inherit

	EV_COLORIZABLE_I
		redefine
			interface,
			set_default_colors
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Access

	background_color: EV_COLOR
			-- Color of face.
		do
			if background_color_imp /= Void then
				Result := background_color_imp.interface
			else
				create Result
			end
		end

	foreground_color: EV_COLOR
			-- Color of foreground features like text.
		local
			color: POINTER
		do
			if foreground_color_imp /= Void then
				Result := foreground_color_imp.interface
			else
				color := foreground_color_pointer
				create Result
			end
		end

feature -- Status setting


	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		do
			background_color_imp ?= a_color.implementation
		end

	real_set_background_color (a_c_object: POINTER; a_color: EV_COLOR)
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
		do

		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			foreground_color_imp ?= a_color.implementation
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: EV_COLOR)
			-- Implementation of `set_foreground_color'
		do
		end


	set_default_colors
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
		end

feature {NONE} -- Implementation

	background_color_imp: EV_COLOR_IMP
		-- Color used for the background of `Current'

	foreground_color_imp: EV_COLOR_IMP
		-- Color used for the foreground of `Current'

	background_color_pointer: POINTER
			-- Pointer to bg color for `a_widget'.
		do
		end

	foreground_color_pointer: POINTER
			-- Pointer to fg color for `a_widget'.
		do
			create Result.default_create
		end

	Prelight_scale: REAL = 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL = 0.90912397
		-- Highlight color is this much darker than `background_color'.

feature {EV_ANY_I} -- Implementation

	interface: EV_COLORIZABLE;

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




end -- EV_COLORIZABLE_IMP

