indexing
	description:
		"EV_COLORIZABLE implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "color, colored, colorable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_COLORIZABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		deferred
		end

	background_color: EV_COLOR is
			-- Color displayed behind foregournd features.
		deferred
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			foreground_color_assigned: is_initialized implies interface.implementation.foreground_color.is_equal (a_color)
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			background_color_assigned: is_initialized implies interface.implementation.background_color.is_equal (a_color)
		end

feature -- Status setting

	set_default_colors is
			-- Set foreground and background color to their default values.
		deferred
		end	

feature {EV_ANY_I} -- Implementation
	
	interface: EV_COLORIZABLE;

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




end -- class EV_COLORIZABLE_I

