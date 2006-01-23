indexing

	description: "Widgets which define a font"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONTABLE_I 

feature -- Access

	font: FONT is
			-- Font name of label
		deferred
		end

feature -- Element change

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
		require
			a_font_exists: a_font /= Void
			a_font_specified: a_font.is_specified
		deferred
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




end -- class FONTABLE_I

