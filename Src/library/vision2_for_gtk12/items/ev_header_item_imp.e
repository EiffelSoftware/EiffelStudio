indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM_IMP

inherit
	EV_HEADER_ITEM_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
	
	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create the header item.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			textable_imp_initialize
			set_width (80)
			set_is_initialized (True)
		end

feature -- Access

	width: INTEGER
			-- `Result' is width of `Current' used
			-- while parented.

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			if parent_imp /= Void then
				parent_imp.update_items
			end
		end

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		do
			if parent_imp /= Void then
				{EV_GTK_EXTERNALS}.gtk_clist_set_column_width (parent_imp.visual_widget, parent_imp.index_of (interface, 1) - 1, a_width)
			else
				internal_set_width (a_width)
			end
		end

	internal_set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		do
			width := a_width
		end
		
		
	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
			--| FIXME Implement correctly
			width := 80
		end

feature -- PND

	enable_transport is
			-- Enable PND transport
		do
			is_transport_enabled := True
		end

	disable_transport is
			-- Disable PND transport
		do
			is_transport_enabled := False
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is 
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
			-- Set 'pointer_style' to 'curs' (not needed)
		do
			check
				do_not_call: False
			end
		end

feature

	set_parent_imp (par_imp: like parent_imp) is
			-- Set `parent_imp' to `par_imp'.
		do
			parent_imp := par_imp
		end

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'.
	
	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
		end

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			set_is_destroyed (True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HEADER_ITEM;
		-- Interface object for `Current'.

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




end
