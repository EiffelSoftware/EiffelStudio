indexing
	description: 
		"EiffelVision textable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "text, label, font, name, property"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	text: STRING is
			-- Text displayed in label.
		deferred
		ensure
			not_void: Result /= Void
			cloned: Result /= text
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		deferred
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

feature {NONE} -- Implementation

	interface: EV_TEXTABLE;
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




end -- class EV_TEXTABLE_I

