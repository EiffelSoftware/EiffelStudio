indexing
	description: "Add an override cluster."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_OVERRIDE_DIALOG

inherit
	CREATE_CLUSTER_DIALOG
		redefine
			make,
			on_ok
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
	do
		Precursor {CREATE_CLUSTER_DIALOG} (a_target, a_factory)
		set_title (dialog_create_override_title)
	end

feature {NONE} -- Actions

	on_ok is
			-- Add group and close the dialog.
		local
			wd: EV_WARNING_DIALOG
			l_loc: CONF_DIRECTORY_LOCATION
		do
			if not name.text.is_empty and not location.text.is_empty then
				if target.groups.has (name.text) then
					create wd.make_with_text (group_already_exists (name.text))
				end

				if wd /= Void then
					wd.show_modal_to_window (Current)
				else
					l_loc := factory.new_location_from_path (location.text, target)
					target.add_override (factory.new_override (name.text, l_loc, target))
					is_ok := True
					destroy
				end
			end
		end

end
