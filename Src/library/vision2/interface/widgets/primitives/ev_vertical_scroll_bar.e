indexing
	description:
		"[
			Interactive vertical scrolling widget.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+-+
			|^|
			|-|
			| |
			|_|
			|#|
			|-|
			|_|
			|V|
			+-+
		]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR

inherit
	EV_SCROLL_BAR
		redefine
			implementation
		end

create
	default_create,
	make_with_value_range

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_SCROLL_BAR_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_SCROLL_BAR_IMP} implementation.make (Current)
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




end -- class EV_VERTICAL_SCROLL_BAR

