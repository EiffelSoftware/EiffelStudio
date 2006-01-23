indexing
	description: "Text we can display on the wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SMART_TEXT

inherit
	EV_VERTICAL_BOX
		
create
	make

feature -- Initialization

	make(par: EV_BOX) is
			-- Initialize with box parent 'par'.
		do
			default_create
			par.extend(Current)
			par.disable_item_expand(Current)
		end

feature -- basic Operations 

	add_line(s: STRING) is
			-- Add a line to the text.
		require
			possible: s /= Void
		do
			extend(Create {EV_LABEL}.make_with_text(s))
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




end -- class WIZARD_SMART_TEXT


