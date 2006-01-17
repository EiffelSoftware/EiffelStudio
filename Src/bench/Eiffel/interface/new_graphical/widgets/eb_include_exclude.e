indexing
	description:
		"Components consisting of two lists, one typically%N%
		%for inclusion and one for exclusion of items.%N%
		%Together, they contain all possible items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	appearance:
		" Exclude:               Include:      %N%
		%+-------------+ +----+ +-------------+%N%
		%| 'first'     | | -> | | 'first'     |%N%
		%|  ...        | +----+ |  ...        |%N%
		%|  ...        | +----+ |  ...        |%N%
		%| `last'      | | <- | | `last'      |%N%
		%+-------------+ +----+ +-------------+"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_INCLUDE_EXCLUDE

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
			include_button.select_actions.extend (agent on_include)
			vb.extend (include_button)
			vb.disable_item_expand (include_button)
			create exclude_button.make_with_text ("<-")
			exclude_button.select_actions.extend (agent on_exclude)
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
			-- List with items that should be initially included.

	exclude_list: EV_LIST
			-- List with items that should be initially excluded.

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_INCLUDE_EXCLUDE
