indexing
	description: "Eiffel Vision fontable, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "font, name, property"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	font: EV_FONT is
			-- Typeface appearance for `Current'.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		ensure
			assigned: is_usable implies font.is_equal (a_font)
		end

feature {NONE} -- Implementation

	interface: EV_FONTABLE;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
			
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




end -- class EV_FONTABLE_I

