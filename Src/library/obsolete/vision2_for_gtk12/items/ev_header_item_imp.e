note
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

	needs_event_box: BOOLEAN = False

	make (an_interface: like interface)
			-- Create the header item.
		do
			base_make (an_interface)
		end

	initialize
			-- Initialize `Current'.
		do
			textable_imp_initialize
			pixmapable_imp_initialize
			align_text_left
			set_width (80)
			set_minimum_width (0)
			set_maximum_width (32000)
			set_is_initialized (True)
		end

feature -- Access

	width: INTEGER
			-- `Result' is width of `Current' used
			-- while parented.

feature -- Status setting

	set_text (a_text: STRING_32)
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			if parent_imp /= Void then
				parent_imp.update_items
			end
		end

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		do
			if parent_imp /= Void then
				{EV_GTK_EXTERNALS}.gtk_clist_set_column_width (parent_imp.visual_widget, parent_imp.index_of (interface, 1) - 1, a_width)
			else
				internal_set_width (a_width)
			end
		end

	internal_set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		do
			width := a_width
		end


	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
			--| FIXME Implement correctly
			width := 80
		end

feature -- PND

	enable_transport
			-- Enable PND transport
		do
			is_transport_enabled := True
		end

	disable_transport
			-- Disable PND transport
		do
			is_transport_enabled := False
		end

	draw_rubber_band
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band
		do
			check
				do_not_call: False
			end
		end

	enable_capture
		do
			check
				do_not_call: False
			end
		end

	disable_capture
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER)
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_POINTER_STYLE)
			-- Set 'pointer_style' to 'curs' (not needed)
		do
			check
				do_not_call: False
			end
		end

feature -- Access

	minimum_width: INTEGER
		-- Lower bound on `width' in pixels.

	maximum_width: INTEGER
		-- Upper bound on `width' in pixels.

	user_can_resize: BOOLEAN
		-- Can a user resize `Current'?

feature -- Status setting

	disable_user_resize
			-- Prevent `Current' from being resized by users.
		do
			user_can_resize := False
		end

	enable_user_resize
			-- Permit `Current' to be resized by users.
		do
			user_can_resize := True
		end

	set_maximum_width (a_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			maximum_width := a_width
		end

	set_minimum_width (a_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			minimum_width := a_width
		end

	set_parent_imp (par_imp: like parent_imp)
			-- Set `parent_imp' to `par_imp'.
		do
			parent_imp := par_imp
		end

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'.

	create_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Create a drop action sequence.
		do
		end

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	destroy
			-- Destroy `Current'.
		do
			set_is_destroyed (True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HEADER_ITEM;
		-- Interface object for `Current'.

note
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
