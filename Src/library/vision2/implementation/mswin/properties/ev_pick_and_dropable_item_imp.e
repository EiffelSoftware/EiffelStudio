indexing
	description: "Implementation of a pick and drop source for items."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_IMP

inherit
	
	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press
		end
feature -- Access

	parent_imp : EV_ITEM_LIST_IMP [EV_ITEM] is
		deferred
	end
	
pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			check
				parent_not_void: parent_imp /= Void
			end
			if press_action = Ev_pnd_start_transport then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x,
					a_screen_y)
				parent_imp.set_parent_source_true
				parent_imp.set_item_source (Current)
				parent_imp.set_item_source_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				parent_imp.set_parent_source_false
				parent_imp.set_item_source (Void)
				parent_imp.set_item_source_false
			else
				parent_imp.set_parent_source_false
				parent_imp.set_item_source (Void)
				parent_imp.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		do
			if parent_imp /= Void then
				parent_imp.set_pointer_style (c)
			end
		end

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

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class EV_PICK_AND_DROPABLE_ITEM_IMP
