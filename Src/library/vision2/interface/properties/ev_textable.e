indexing
	description:
		"Abstraction for objects that have a text label."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "text, label, font, name, property"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE

inherit
	EV_ANY
		redefine
			is_in_default_state,
			implementation
		end

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		ensure
			text_assigned: text.is_equal (a_text) and text /= a_text
		end
		
feature -- Access

	text: STRING is
			-- Text displayed in textable.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text
		ensure
			bridge_ok: equal (Result, implementation.text)
			not_void: Result /= Void
			cloned: Result /= implementation.text
			no_carriage_returns: not Result.has ('%R')
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			implementation.set_text (a_text)
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

	remove_text is
			-- Make `text' `is_empty'.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_empty: text.is_empty
		end
		
feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and text.is_empty
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TEXTABLE_I
			-- Responsible for interaction with native graphics toolkit.
			
invariant
	text_not_void: is_usable implies text /= Void

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




end -- class EV_TEXTABLE

