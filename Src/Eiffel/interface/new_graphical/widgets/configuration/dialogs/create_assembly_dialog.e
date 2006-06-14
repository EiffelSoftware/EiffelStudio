indexing
	description: "Dialog to create a new assembly."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_ASSEMBLY_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	EB_LAYOUT_CONSTANTS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: CONF_FACTORY) is
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			target := a_target
			factory := a_factory
			default_create
			set_title (dialog_create_assembly_title)
		ensure
			target_set: target = a_target
			factory_set: factory = a_factory
		end

	initialize is
			-- Initialize.
		local
			l_btn: EV_BUTTON
			hb_out: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
		do
			Precursor {EV_DIALOG}

			create hb_out
			extend (hb_out)
			append_margin (hb_out)
			create vb
			hb_out.extend (vb)
			vb.set_padding (default_padding_size)

			append_margin (vb)

			create l_lbl.make_with_text (dialog_create_assembly_name)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb.extend (name)
			vb.disable_item_expand (name)

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_assembly_location)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb.extend (hb2)
			vb.disable_item_expand (hb2)

			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (ellipsis_text, agent browse)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			append_margin (vb)
			vb.extend (create {EV_CELL})

			create l_lbl.make_with_text (dialog_create_assembly_a_name)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create assembly_name
			vb.extend (assembly_name)
			vb.disable_item_expand (assembly_name)

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_assembly_a_version)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create assembly_version
			vb.extend (assembly_version)
			vb.disable_item_expand (assembly_version)

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_assembly_a_culture)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create assembly_culture
			vb.extend (assembly_culture)
			vb.disable_item_expand (assembly_culture)

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_assembly_a_key)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create assembly_key
			vb.extend (assembly_key)
			vb.disable_item_expand (assembly_key)

			append_small_margin (vb)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (default_padding_size)

			create l_btn.make_with_text (ev_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			l_btn.set_minimum_width (default_button_width)

			create l_btn.make_with_text (ev_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			l_btn.set_minimum_width (default_button_width)

			append_margin (vb)

			append_margin (hb_out)

			set_minimum_size (400, 325)

			show_actions.extend (agent name.set_focus)
		end

feature -- Status

	is_ok: BOOLEAN
			-- Was the dialog closed with ok?

feature {NONE} -- GUI elements

	name: EV_TEXT_FIELD
			-- Name of the group.

	location: EV_TEXT_FIELD
			-- Location of the assembly (for local assemblies).

	assembly_name: EV_TEXT_FIELD
	assembly_version: EV_TEXT_FIELD
	assembly_culture: EV_TEXT_FIELD
	assembly_key: EV_TEXT_FIELD
			-- Information if a gac assembly should be added.

feature {NONE} -- Actions

	browse is
			-- Browse for a location.
		local
			l_brows_dial: EV_FILE_OPEN_DIALOG
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
		do
			create l_brows_dial
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make (l_loc.evaluated_directory)
				if l_dir.exists then
					l_brows_dial.set_start_directory (l_dir.name)
				end
			end

			l_brows_dial.open_actions.extend (agent set_location (l_brows_dial))
			l_brows_dial.show_modal_to_window (Current)
		end

	set_location (a_dial: EV_FILE_DIALOG) is
			-- Set location from `a_dial'.
		require
			a_dial_not_void: a_dial /= Void
		do
			location.set_text (a_dial.file_name)
		end

	on_cancel is
			-- Close the dialog.
		do
			destroy
		end

	on_ok is
			-- Add group and close the dialog.
		local
			l_local, l_a_n, l_a_v, l_a_c, l_a_k: STRING
			wd: EV_WARNING_DIALOG
		do
			if not name.text.is_empty then
				l_local := location.text
				l_a_n := assembly_name.text
				l_a_v := assembly_version.text
				l_a_c := assembly_culture.text
				l_a_k := assembly_key.text

				if target.groups.has (name.text) then
					create wd.make_with_text (group_already_exists (name.text))
				elseif not l_local.is_empty then
					if l_a_n.is_empty and l_a_v.is_empty and l_a_c.is_empty and l_a_k.is_empty then
						target.add_assembly (factory.new_assembly (name.text, location.text, target))
					else
						create wd.make_with_text (assembly_location_or_gac)
					end
				else
					if l_a_n.is_empty or l_a_v.is_empty or l_a_c.is_empty or l_a_k.is_empty then
						create wd.make_with_text (assembly_no_location)
					else
						target.add_assembly (factory.new_assembly_from_gac (name.text, l_a_n, l_a_v, l_a_c, l_a_k, target))
					end
				end

				if wd /= Void then
					wd.show_modal_to_window (Current)
				else
					is_ok := True
					destroy
				end
			end
		end

feature {NONE} -- Implementation

	target: CONF_TARGET
			-- Target where we add the group.

	factory: CONF_FACTORY
			-- Factory to create a group.

invariant
	target_not_void: target /= Void
	factory_not_void: factory /= Void

end
