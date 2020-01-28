note
	description: "Summary description for {ADD_REMOTE_TARGET_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_REMOTE_TARGET_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	EIFFEL_SYNTAX_CHECKER
		undefine
			default_create,
			copy
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			copy
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

	make (a_target: CONF_TARGET; a_factory: like factory)
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			target := a_target
			factory := a_factory
			create location
			create name
			default_create
		ensure
			target_set: target = a_target
			factory_set: factory = a_factory
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		local
			l_btn: EV_BUTTON
			vb, vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
		do
			Precursor
			set_icon_pixmap (conf_pixmaps.new_remote_target_icon)

			create vb
			extend (vb)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

				-- location
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_border_width (layout_constants.default_border_size)
			vb2.set_padding (layout_constants.default_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_remote_target_location)
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

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_border_width (layout_constants.default_border_size)
			vb2.set_padding (layout_constants.default_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_remote_target_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

--			create name
			vb2.extend (name)
			vb2.disable_item_expand (name)


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

			set_title (conf_interface_names.dialog_create_remote_target_title)
			show_actions.extend (agent location.set_focus)

			set_minimum_width (400)
		end

feature {NONE} -- Implementation

	target: CONF_TARGET
			-- Current target.

	factory: CONF_PARSE_FACTORY
			-- Factory to create a group.

feature {NONE} -- GUI elements

	name: EV_TEXT_FIELD
			-- Name of the group.

	location: EV_TEXT_FIELD
			-- Location of the target system.

feature -- Status

	is_ok: BOOLEAN
			-- Was the dialog closed with ok?
		do
			Result := attached last_target
		ensure
			last_target_attached: Result implies attached last_target
		end

	last_target: detachable CONF_TARGET

feature {NONE} -- Actions

	browser_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a ECF file.
		local
			p: PATH
			l_dir: DIRECTORY
		once
			create Result
			Result.filters.extend (["*.ecf", "Eiffel Configuration File"])
			p := target.system.directory
			create l_dir.make_with_path (p)
			if l_dir.exists then
				Result.set_start_path (p)
			end
		ensure
			result_not_void: Result /= Void
		end

	browse
			-- Browse for a location.
		local
			l_loc: CONF_FILE_LOCATION
			l_file: RAW_FILE
		do
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_file.make_with_path (l_loc.evaluated_path)
				if l_file.exists then
					browser_dialog.set_start_path (l_file.path)
				end
			end
			browser_dialog.open_actions.extend (agent fill_fields)
			browser_dialog.show_modal_to_window (Current)
		end

	fill_fields
			-- Set location from `browser_dialog'.
		local
			p: PATH
			tgt: detachable CONF_TARGET
		do
			p := browser_dialog.full_file_path
			location.set_text (p.name)
			if attached conf_system_from_path (p.name) as cfg then
				if not name.text.is_whitespace then
					tgt := cfg.targets.item (name.text)
				else
					tgt := cfg.library_target
--					if tgt = Void then
--						tgt := cfg.target_order.first
--					end
				end
				if tgt = Void then
					name.remove_text
				else
					name.set_text (tgt.name)
				end
			else
				name.remove_text
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
			t: CONF_TARGET
		do
			if location.text.is_whitespace then
					-- Bad location value !!!
			else
				if attached conf_system_from_path (location.text) as cfg then
					if not name.text.is_empty then
						if not is_valid_target_name (name.text) then
							(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_target_name, Current, Void)
		--				elseif group_exists (name.text, target) then
		--					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
						else
							t := cfg.targets.item (name.text)
							last_target := t
						end
					end
					if t = Void then
						t := cfg.library_target
					end
				end
				if is_ok then
					destroy
				end
			end
		ensure
			is_ok_last_target: is_ok implies last_target /= Void
		end

	conf_system_from_path (a_path: READABLE_STRING_GENERAL): detachable CONF_SYSTEM
		local
			l_loc: CONF_FILE_LOCATION
			l_load: CONF_LOAD
		do
			l_loc := factory.new_file_location_from_path (a_path.as_string_32, target)
			create l_load.make (factory)
			l_load.retrieve_configuration (l_loc.evaluated_path.name)
			Result := l_load.last_system
		end

invariant
	target_not_void: target /= Void
	factory_not_void: factory /= Void

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
