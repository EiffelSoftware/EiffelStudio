indexing
	description: "Dialog to add or remove dependencies."
	date: "$Date$"
	revision: "$Revision$"

class
	DEPENDENCY_DIALOG

inherit
	LIST_DIALOG
		redefine
			initialize,
			on_add
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			Precursor {LIST_DIALOG}
			modify_button.hide
			up_button.hide
			down_button.hide
		end

feature -- Access

	conf_target: CONF_TARGET
			-- Configuration target.

feature -- Update

	set_conf_target (a_target: like conf_target) is
			-- Set `conf_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			conf_target := a_target
		ensure
			conf_target_set: conf_target /= Void
		end

feature {NONE} -- Agents

	on_add is
			-- Called if an item should be added.
		local
			wd: EV_WARNING_DIALOG
		do
			check
				conf_target_set: conf_target /= Void
			end
			if not conf_target.groups.has (new_item_name.text.to_string_8) then
				create wd.make_with_text (cluster_dependency_group_not_exist)
				wd.show_modal_to_window (Current)
			else
				Precursor {LIST_DIALOG}
			end
		end

end
