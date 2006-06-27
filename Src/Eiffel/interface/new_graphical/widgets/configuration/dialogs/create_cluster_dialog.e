indexing
	description: "Create a new cluster."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CLUSTER_DIALOG

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
			set_title (dialog_create_cluster_title)
			show_actions.extend (agent name.set_focus)
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

			create l_lbl.make_with_text (dialog_create_cluster_name)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb.extend (name)
			vb.disable_item_expand (name)

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_cluster_location)
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

			set_minimum_width (300)
		end

feature -- Status

	is_ok: BOOLEAN
			-- Was the dialog closed with ok?

feature -- Access

	parent_cluster: CONF_CLUSTER
			-- Parent cluster (if any).

feature -- Update

	set_parent_cluster (a_parent: like parent_cluster) is
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

	browse is
			-- Browse for a location.
		local
			l_brows_dial: EV_DIRECTORY_DIALOG
			l_loc: CONF_DIRECTORY_LOCATION
			l_dir: DIRECTORY
		do
			create l_brows_dial
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make (l_loc.evaluated_directory)
			else
				create l_dir.make (target.system.directory)
			end
			if l_dir.exists then
				l_brows_dial.set_start_directory (l_dir.name)
			end

			l_brows_dial.ok_actions.extend (agent set_location (l_brows_dial))
			l_brows_dial.show_modal_to_window (Current)
		end

	set_location (a_dial: EV_DIRECTORY_DIALOG) is
			-- Set location from `a_dial'.
		require
			a_dial_not_void: a_dial /= Void
		do
			location.set_text (a_dial.directory)
		end

	on_cancel is
			-- Close the dialog.
		do
			destroy
		end

	on_ok is
			-- Add group and close the dialog.
		local
			wd: EV_WARNING_DIALOG
			l_loc: CONF_DIRECTORY_LOCATION
			l_cluster: CONF_CLUSTER
		do
			if not name.text.is_empty and not location.text.is_empty then
				if target.groups.has (name.text) then
					create wd.make_with_text (group_already_exists (name.text))
				end

				if wd /= Void then
					wd.show_modal_to_window (Current)
				else
					l_loc := factory.new_location_from_path (location.text, target)
					l_cluster := factory.new_cluster (name.text, l_loc, target)
					if parent_cluster /= Void then
						l_cluster.set_parent (parent_cluster)
						parent_cluster.add_child (l_cluster)
					end
					target.add_cluster (l_cluster)
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
