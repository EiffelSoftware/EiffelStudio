indexing
	description: "Dialog that lets the user select a class of a given list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CLASS_SELECT

inherit
	EV_DIALOG
		redefine
			initialize
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Build interface.
		local
			vb_top, vb: EV_VERTICAL_BOX
			hb : EV_HORIZONTAL_BOX
			f_top: EV_FRAME
		do
			Precursor
			set_title ("Select class")
			set_icon_pixmap (pixmaps.icon_dialog_window)

			create vb
			vb.set_padding (Layout_constants.small_padding_size)
			vb.set_border_width (Layout_constants.default_border_size)
			create f_top
			create vb_top
			vb_top.set_padding (Layout_constants.small_padding_size)

			create class_list
			vb.extend (class_list)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)
			hb.set_padding (Layout_constants.small_padding_size)
			hb.extend (create {EV_CELL})

			create ok_button.make_with_text_and_action (Interface_names.b_ok, agent on_ok_pressed)
			create cancel_button.make_with_text_and_action (Interface_names.b_cancel, agent on_cancel_pressed)
			extend_button (hb, ok_button)
			extend_button (hb, cancel_button)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

feature -- Status report

	ok_pressed: BOOLEAN
			-- Did the user confirm the action?

	is_multiple_selections: BOOLEAN is
			-- Can multiple classes be choosen?
		do
			Result := class_list.multiple_selection_enabled
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button with label "OK".

	cancel_button: EV_BUTTON
			-- Button with label "Cancel".

	selected_class: CLASS_I is
			-- The class the user selected.
		local
			l_class_c: CLASS_C
			l_item: EV_LIST_ITEM
		do
			l_item := class_list.selected_item
			if l_item /= Void then
				l_class_c ?= l_item.data
				if l_class_c /= Void then
					Result := l_class_c.lace_class
				end
			end
		end

	selected_classes: ARRAYED_LIST [CLASS_I] is
			-- The classes the user selected with multiple selection.
		local
			l_class_c: CLASS_C
			l_selected: DYNAMIC_LIST [EV_LIST_ITEM]
		do
			l_selected := class_list.selected_items
			if l_selected /= Void then
				from
					create Result.make (l_selected.count)
					l_selected.start
				until
					l_selected.after
				loop
					l_class_c := Void
					l_class_c ?= l_selected.item.data
					if l_class_c /= Void then
						Result.extend (l_class_c.lace_class)
					end
					l_selected.forth
				end
			end
		ensure
			first_item_equal_selected: Result.first.is_equal (selected_class)
		end


feature -- Element change

	set_classes (a_classes: LIST [CLASS_C]) is
			-- Set the classe from which the user can choose.
		require
			a_classes_not_void: a_classes /= Void
		local
			l_item: EV_LIST_ITEM
			l_class: CLASS_C
		do
			class_list.wipe_out
			if a_classes /= Void and then not a_classes.is_empty then
				from
					a_classes.start
				until
					a_classes.after
				loop
					l_class := a_classes.item
					create l_item.make_with_text (l_class.name_in_upper)
					l_item.set_data (l_class)
					class_list.extend (l_item)
					a_classes.forth
				end
				class_list.first.enable_select
			end
		end

	enable_multiple_selections is
			-- Enable multiple selections.
		do
			class_list.enable_multiple_selection
		end

	disable_multiple_selections is
			-- Disable multiple selections.
		do
			class_list.disable_multiple_selection
		end

	select_all is
			-- Select all classes.
		do
			class_list.do_all (agent {EV_LIST_ITEM}.enable_select)
		end


feature {NONE} -- Implementation

	class_list: EV_LIST
			-- The graphical list of classes.

	on_ok_pressed is
			-- The user pressed OK.
		local
			wd: EV_WARNING_DIALOG
		do
			if selected_class /= Void then
				ok_pressed := True
				destroy
			else
				create wd.make_with_text ("No class selected.")
				wd.show_modal_to_window (Current)
			end
		end

	on_cancel_pressed is
			-- The user pressed Cancel.
		do
			ok_pressed := False
			destroy
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

end
