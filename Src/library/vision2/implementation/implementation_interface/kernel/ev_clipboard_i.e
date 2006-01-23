indexing
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CLIPBOARD_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	has_text: BOOLEAN is
			-- Does the clipboard currently contain text?
		deferred
		end

	text: STRING is
		deferred
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		require
			text_not_void: a_text /= Void
		deferred
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CLIPBOARD
		-- Provides a common user interface to possibly dependent
		-- functionality implemented by `Current'.

invariant
	has_text_implies_text_not_empty: has_text implies not text.is_empty
	not_has_text_implies_text_empty: not has_text implies text.is_empty

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




end -- class EV_CLIPBOARD_I

