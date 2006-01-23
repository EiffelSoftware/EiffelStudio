indexing 
	description: "EiffelVision Combo-box. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMBO_BOX_I

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end
		
	EV_COMBO_BOX_ACTION_SEQUENCES_I
	
feature -- Status report

	is_list_shown: BOOLEAN is
			-- Is drop down list currently shown?
		deferred
		end

feature {EV_COMBO_BOX_I} -- Implementation

	interface: EV_COMBO_BOX;

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




end -- class EV_COMBO_BOX_I

