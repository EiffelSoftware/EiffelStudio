indexing
	description:
		"EiffelVision Tree. Implementation interface"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_TREE_NODE_LIST_I
		redefine
			interface
		end
		
	EV_ITEM_PIXMAP_SCALER_I
		redefine
			interface
		end

	EV_TREE_ACTION_SEQUENCES_I

feature {EV_ANY} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
				-- Set default width & height for the pixmaps
			initialize_pixmaps
		end

feature -- Access

	selected_item: EV_TREE_NODE is
			-- Currently selected tree item.
		deferred
		end

feature -- Status report

	ensure_item_visible (an_item: EV_TREE_NODE) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		deferred
		end

	selected: BOOLEAN is
			-- Is at least one tree item selected?
		deferred
		end
		
feature {EV_ANY_I}

	interface: EV_TREE;

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




end -- class EV_TREE_I

