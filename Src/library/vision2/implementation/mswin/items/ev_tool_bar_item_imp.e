indexing
	description: "Eiffel Vision tool bar item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_ITEM_IMP

inherit
	EV_ITEM_IMP
		redefine
			interface
		end
	
	EV_ID_IMP

feature -- Access

	text: STRING is
			-- Text displayed in textable.
		deferred
		end
		
	has_pixmap: BOOLEAN is
			-- Has Current a pixmap?
		deferred
		end
		
	image_index: INTEGER
			-- Index of the pixmaps in the imagelists.

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive?
		deferred
		end
		
	disable_sensitive is
			-- Enable `Current'.
		deferred
		end
		
	enable_sensitive is
			-- Disable `Current'.
		deferred
		end
		
	internal_non_sensitive: BOOLEAN is
			-- Is `Current' not sensitive to input as seen
			-- from `interface'?
		deferred
		end
		
	restore_private_pixmaps is
			-- When `Current' is parented, `private_pixmap' and
			-- `private_gray_pixmap' are assigned Void. This is to stop
			-- us keeping to many references to GDI objects. When
			-- `Current' is removed from its parent, we must then
			-- restore them. 
		deferred
		end

feature -- Status setting

	set_pixmap_in_parent is
			-- Add the pixmap to the parent by updating the 
			-- parent's image list.
		deferred
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		deferred
		end
		
feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_ITEM;
		
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




end -- class EV_TOOL_BAR_ITEM_IMP

