indexing
	description:
		"Components consisting of two lists, one typically%N%
		%for inclusion and one for exclusion of items.%N%
		%Together, they contain all possible items."
	appearance:
		" Exclude:               Include:      %N%
		%+-------------+ +----+ +-------------+%N%
		%| 'first'     | | -> | | 'first'     |%N%
		%|  ...        | +----+ |  ...        |%N%
		%|  ...        | +----+ |  ...        |%N%
		%| `last'      | | <- | | `last'      |%N%
		%+-------------+ +----+ +-------------+"
	status: "See notice at end of class"
	keywords: "include, exclude, lists, multiple selection"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INCLUDE_EXCLUDE

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize,
			is_in_default_state
		end

feature {NONE} -- Initialization

	initialize is
			-- Set defaults.
		local
			vb: EV_VERTICAL_BOX
		do
			Precursor {EV_HORIZONTAL_BOX}

			create vb
			create exclude_label.make_with_text ("Exclude:")
			exclude_label.align_text_left
			vb.extend (exclude_label)
			vb.disable_item_expand (exclude_label)
			create exclude_list
			exclude_list.enable_multiple_selection
			vb.extend (exclude_list)
			extend (vb)

			create vb
			vb.extend (create {EV_CELL})
			create include_button.make_with_text ("->")
			include_button.select_actions.extend (~on_include)
			vb.extend (include_button)
			vb.disable_item_expand (include_button)
			create exclude_button.make_with_text ("<-")
			exclude_button.select_actions.extend (~on_exclude)
			vb.extend (exclude_button)
			vb.disable_item_expand (exclude_button)
			vb.extend (create {EV_CELL})
			vb.set_padding (5)
			vb.set_minimum_width (40)
			extend (vb)
			disable_item_expand (vb)

			create vb
			create include_label.make_with_text ("Include:")
			include_label.align_text_left
			vb.extend (include_label)
			vb.disable_item_expand (include_label)
			create include_list
			include_list.enable_multiple_selection
			vb.extend (include_list)
			extend (vb)
			set_padding (5)
		end

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default sate.
		do
			Result := Precursor or padding = 5
		end

feature -- Access

	include_list: EV_LIST
			-- Selected items.

	exclude_list: EV_LIST
			-- All unselected items.

	include_label: EV_LABEL
			-- Text displayed over `include_list'. Default: "Include:".

	exclude_label: EV_LABEL
			-- Text displayed over `exclude_list'. Default: "Exclude:".

feature {NONE} -- Implementation

	include_button: EV_BUTTON
			-- When clicked, all selected items in `exclude_list' are moved to `include_list'.

	exclude_button: EV_BUTTON
			-- When clicked, all selected items in `include_list' are moved to `exclude_list'.

	on_include is
			-- "->" button has been pressed.
		local
			si: DYNAMIC_LIST [EV_LIST_ITEM]
			i: EV_LIST_ITEM
		do
			si := exclude_list.selected_items
			from si.start until si.after loop
				i := si.item
				exclude_list.prune (i)
				include_list.extend (i)
				si.forth
			end
		end

	on_exclude is
			-- "<-" button has been pressed.
		local
			si: DYNAMIC_LIST [EV_LIST_ITEM]
			i: EV_LIST_ITEM
		do
			si := include_list.selected_items
			from si.start until si.after loop
				i := si.item
				include_list.prune (i)
				exclude_list.extend (i)
				si.forth
			end
		end

end -- class EV_INCLUDE_EXCLUDE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2001/06/07 23:07:58  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.1  2001/01/27 01:32:15  brendel
--| Initial version of component with 2 lists, which is basically a multiple
--| selection component. It comes from Src/Bench/Eiffel/interface/
--| new_graphical/widgets. Previous name was EB_INCLUDE_EXCLUDE.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
