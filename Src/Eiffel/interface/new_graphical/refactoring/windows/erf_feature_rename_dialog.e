indexing
	description: "Dialog that let the user edit the name of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_FEATURE_RENAME_DIALOG

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
			fvb, vb_top, vb, vb_label, vb_text_field: EV_VERTICAL_BOX
			hb, hb_name, hb_old: EV_HORIZONTAL_BOX
			f_bottom, f_top: EV_FRAME
			l: EV_LABEL
			sep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor
			set_title ("Refactoring: Feature rename (compiled classes)")
			set_icon_pixmap (pixmaps.icon_dialog_window)

			create vb
			vb.set_padding (Layout_constants.small_padding_size)
			vb.set_border_width (Layout_constants.default_border_size)
			create f_top
			create vb_top
			vb_top.set_padding (Layout_constants.small_padding_size)
			create current_name
			create hb_old
			hb_old.extend (current_name)
			hb_old.disable_item_expand (current_name)
			vb_top.extend (create {EV_CELL})
			vb_top.extend (hb_old)
			create sep
			vb_top.extend (sep)
			vb_top.disable_item_expand (sep)
			create vb_label
			vb_label.set_padding (Layout_constants.small_padding_size)
			vb_label.set_border_width (Layout_constants.default_border_size)
			create hb_name
			create l.make_with_text ("New name:")
			vb_label.extend (l)
			vb_label.disable_item_expand (l)
			vb_label.extend (create {EV_CELL})
			hb_name.extend (vb_label)
			hb_name.disable_item_expand (vb_label)
			create vb_text_field
			vb_text_field.set_padding (Layout_constants.small_padding_size)
			vb_text_field.set_border_width (Layout_constants.default_border_size)
			create name_field
			name_field.set_minimum_height (22)
			vb_text_field.extend (name_field)
			vb_text_field.disable_item_expand (name_field)
			hb_name.extend (vb_text_field)
			vb_top.extend (hb_name)
			vb_top.disable_item_expand (hb_name)
			f_top.extend (vb_top)
			vb.extend (f_top)

			create f_bottom
			create fvb
			fvb.set_padding (Layout_constants.small_padding_size)
			fvb.set_border_width (Layout_constants.default_border_size)
			f_bottom.extend (fvb)

			create comments_button.make_with_text ("Replace name in comments")
			fvb.extend (comments_button)
			create strings_button.make_with_text ("Replace name in strings")
			fvb.extend (strings_button)
			vb.extend (f_bottom)

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

	comments: BOOLEAN is
			-- Replace name in comments?
		do
			Result := comments_button.is_selected
		end

	strings: BOOLEAN is
			-- Replace name in strings?
		do
			Result := strings_button.is_selected
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button with label "OK".

	cancel_button: EV_BUTTON
			-- Button with label "Cancel".

	name: STRING is
			-- Class name typed by user.
		do
			Result := name_field.text
		end

feature -- Element change

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			current_name.set_text ("   Feature name:           " + a_name.as_lower)
			if a_name.is_empty then
				name_field.remove_text
			else
				name_field.set_text (a_name.as_lower)
			end
		end

	enable_update_comments is
			-- Enable replace comments.
		do
			comments_button.enable_select
		end

	enable_update_strings is
			-- Enable replace strings.
		do
			strings_button.enable_select
		end

feature {NONE} -- Implementation

	comments_button, strings_button: EV_CHECK_BUTTON
	name_field: EV_TEXT_FIELD
	current_name: EV_LABEL

	on_ok_pressed is
			-- The user pressed OK.
		do
			ok_pressed := True
			destroy
		end

	on_cancel_pressed is
			-- The user pressed Cancel.
		do
			ok_pressed := False
			destroy
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
