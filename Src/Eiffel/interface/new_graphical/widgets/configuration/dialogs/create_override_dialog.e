indexing
	description: "Add an override cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_OVERRIDE_DIALOG

inherit
	CREATE_CLUSTER_DIALOG
		redefine
			last_group,
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

feature -- Access

	last_group: CONF_OVERRIDE
			-- Last added override cluster.

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
					last_group := factory.new_override (name.text, l_loc, target)
					if parent_cluster /= Void then
						last_group.set_parent (parent_cluster)
						parent_cluster.add_child (last_group)
					end
					target.add_override (last_group)
					is_ok := True
					destroy
				end
			end
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
