note
	description: "Create a new cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CLUSTER_DIALOG

inherit
	ADD_GROUP_DIALOG
		redefine
			create_interface_objects,
			initialize,
			last_group
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create location
			create name
		end

	initialize
			-- Initialize.
		local
			l_btn: EV_BUTTON
			vb, vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
		do
			Precursor
			set_icon_pixmap (conf_pixmaps.new_cluster_icon)

			create vb
			extend (vb)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_border_width (layout_constants.default_border_size)
			vb2.set_padding (layout_constants.default_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_cluster_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

--			create name
			vb2.extend (name)
			vb2.disable_item_expand (name)

				-- location
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_border_width (layout_constants.default_border_size)
			vb2.set_padding (layout_constants.default_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_cluster_location)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb2.extend (hb2)
			vb2.disable_item_expand (hb2)
			hb2.set_padding (layout_constants.default_padding_size)

--			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (conf_interface_names.browse, agent browse)
			l_btn.set_pixmap (conf_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

				-- ok/cancel
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create l_btn.make_with_text (names.b_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			layout_constants.set_default_width_for_button (l_btn)

			create l_btn.make_with_text (names.b_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)

			set_title (conf_interface_names.dialog_create_cluster_title)
			show_actions.extend (agent name.set_focus)

			set_minimum_width (300)
		end

feature -- Access

	parent_cluster: detachable CONF_CLUSTER
			-- Parent cluster (if any).

	last_group: detachable CONF_CLUSTER
			-- Last created cluster.

feature -- Update

	set_parent_cluster (a_parent: like parent_cluster)
			-- Set `parent_cluster' to `a_parent'.
		do
			parent_cluster := a_parent
		ensure
			parent_cluster_set: parent_cluster = a_parent
		end

feature {NONE} -- GUI elements

	name: EV_TEXT_FIELD
			-- Name of the group.

	location: EV_TEXT_FIELD
			-- Location of the cluster.

feature {NONE} -- Actions

	browser_dialog: EV_DIRECTORY_DIALOG
			-- Dialog to browse to a directory.
		local
			l_dir: DIRECTORY
		once
			create Result
			create l_dir.make_with_path (target.system.directory)
			if l_dir.exists then
				Result.set_start_directory (target.system.directory.name)
			end
		ensure
			result_not_void: Result /= Void
		end

	browse
			-- Browse for a location.
		local
			l_loc: CONF_DIRECTORY_LOCATION
			l_dir: DIRECTORY
		do
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make_with_path (l_loc.evaluated_directory)
				if l_dir.exists then
					browser_dialog.set_start_path (l_dir.path)
				end
			end

			browser_dialog.ok_actions.extend (agent fill_fields)
			browser_dialog.show_modal_to_window (Current)
		end

	fill_fields
			-- Set location from `browser_dialog'.
		local
			l_dir: PATH
		do
			l_dir := browser_dialog.path
			location.set_text (l_dir.name)
			if name.text.is_empty and attached l_dir.entry as l_entry then
				name.set_text (l_entry.name)
			end
		end

	on_cancel
			-- Close the dialog.
		do
			destroy
		end

	on_ok
			-- Add group and close the dialog.
		local
			l_loc: CONF_DIRECTORY_LOCATION
			g: like last_group
		do
			if not name.text.is_empty and not location.text.is_empty then
				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_cluster_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					l_loc := factory.new_location_from_path (location.text, target)
					g := factory.new_cluster (name.text, l_loc, target)
					last_group := g
					if attached parent_cluster as l_parent_cluster then
						g.set_parent (l_parent_cluster)
						g.set_classes (create {STRING_TABLE [CONF_CLASS]}.make (0))
						l_parent_cluster.add_child (g)
					end
					g.set_recursive (True)
					target.add_cluster (g)
					destroy
				end
			end
		ensure
			is_ok_last_group: is_ok implies last_group /= Void
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
