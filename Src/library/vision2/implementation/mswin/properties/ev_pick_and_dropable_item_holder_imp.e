indexing
	description: "Ancestor of all PND widgets which contain items."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP

inherit

	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press
		end

feature -- Basic operations

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
					start_transport (a_x, a_y, a_button, 0, 0, 0.5,
						a_screen_x, a_screen_y)
					set_parent_source_true
			when
				Ev_pnd_end_transport
			then
				end_transport (a_x, a_y, a_button)
				set_parent_source_false
			else
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	parent_is_pnd_source : BOOLEAN
			-- PND started in the widget.

	pnd_item_source: EV_ITEM_IMP
			-- PND source if PND started in an item.

	item_is_pnd_source: BOOLEAN
		-- PND started in an item. 

	set_item_source (source: EV_ITEM_IMP) is
			-- Assign `source' to `pnd_item_source'
		do
			pnd_item_source := source
		end

	set_parent_source_true is
			-- Assign `True' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := True
		end

	set_parent_source_false is
			-- Assign `False' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := False
		end

	set_item_source_true is
			-- Assign `True' to `item_is_pnd_source'.
		do
			item_is_pnd_source := True
		end

	set_item_source_false is
			-- Assign `False' to `item_is_pnd_source'.
		do
			item_is_pnd_source := False
		end

	set_pointer_style (c: EV_CURSOR) is
		deferred
		end

feature -- Initialization

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
