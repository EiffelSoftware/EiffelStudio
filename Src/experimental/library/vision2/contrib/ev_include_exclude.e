note
	description:
		"Components consisting of two lists, one typically%N%
		%for inclusion and one for exclusion of items.%N%
		%Together, they contain all possible items."
	legal: "See notice at end of class."
	appearance:
		" Exclude:               Include:      %N%
		%+-------------+ +----+ +-------------+%N%
		%| 'first'     | | -> | | 'first'     |%N%
		%|  ...        | +----+ |  ...        |%N%
		%|  ...        | +----+ |  ...        |%N%
		%| `last'      | | <- | | `last'      |%N%
		%+-------------+ +----+ +-------------+"
	status: "See notice at end of class."
	keywords: "include, exclude, lists, multiple selection"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INCLUDE_EXCLUDE

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize,
			is_in_default_state,
			create_interface_objects
		end

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create include_list
			create include_button.make_with_text ("->")
			create include_label.make_with_text ("Include:")
			create exclude_label.make_with_text ("Exclude:")
			create exclude_button.make_with_text ("<-")
			create exclude_list
		end

	initialize
			-- Set defaults.
		local
			vb: EV_VERTICAL_BOX
		do
			Precursor {EV_HORIZONTAL_BOX}

			create vb

			exclude_label.align_text_left
			vb.extend (exclude_label)
			vb.disable_item_expand (exclude_label)
			exclude_list.enable_multiple_selection
			vb.extend (exclude_list)
			extend (vb)

			create vb
			vb.extend (create {EV_CELL})

			include_button.select_actions.extend (agent on_include)
			vb.extend (include_button)
			vb.disable_item_expand (include_button)

			exclude_button.select_actions.extend (agent on_exclude)
			vb.extend (exclude_button)
			vb.disable_item_expand (exclude_button)
			vb.extend (create {EV_CELL})
			vb.set_padding (5)
			vb.set_minimum_width (40)
			extend (vb)
			disable_item_expand (vb)

			create vb

			include_label.align_text_left
			vb.extend (include_label)
			vb.disable_item_expand (include_label)
			include_list.enable_multiple_selection
			vb.extend (include_list)
			extend (vb)
			set_padding (5)
		end

	is_in_default_state: BOOLEAN
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

	on_include
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

	on_exclude
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




end -- class EV_INCLUDE_EXCLUDE




