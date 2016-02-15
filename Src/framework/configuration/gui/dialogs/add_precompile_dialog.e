note
	description: "Dialog to add a precompile library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_PRECOMPILE_DIALOG

inherit
	ADD_LIBRARY_DIALOG
		redefine
			make,
			last_group,
			on_library_selected,
			on_ok,
			libraries_manager,
			all_libraries
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: like factory)
			-- <Precursor>
		do
			Precursor {ADD_LIBRARY_DIALOG} (a_target, a_factory)
			set_title (conf_interface_names.dialog_create_precompile_title)
			set_icon_pixmap (conf_pixmaps.new_precompiled_library_icon)
		end

feature -- Access

	last_group: CONF_PRECOMPILE
			-- <Precursor>

	libraries_manager: ES_LIBRARY_MANAGER
		once
			create Result.make (2)
			Result.register (create {ES_PRECOMPILE_LIBRARY_DELIVERY_PROVIDER})
			Result.register (create {ES_PRECOMPILE_LIBRARY_IRON_PROVIDER})
		end

feature {NONE} -- Basic operation

	all_libraries (a_filter: detachable READABLE_STRING_GENERAL): STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			libs: like all_libraries
			l_precompilation: detachable STRING_32
		do
				-- We store the ISE_PRECOMP environment variable because when editing an ECF, it can
				-- be either .NET or classic so we need to compute the right path.
			l_precompilation := eiffel_layout.get_environment_32 ({EIFFEL_CONSTANTS}.ise_precomp_env)
			eiffel_layout.set_precompile (target.setting_msil_generation)

				-- Lookup all the ECFs that matches.
			libs := Precursor (a_filter)
			create Result.make_caseless (libs.count)
			across
				libs as ic
			loop
				if ic.item.system_name.starts_with ("precomp_") then
					Result.force (ic.item, ic.key)
				end
			end

				-- Restore ISE_PRECOMP to its previous value.
			if l_precompilation /= Void then
				eiffel_layout.set_environment (l_precompilation, {EIFFEL_CONSTANTS}.ise_precomp_env)
			else
				eiffel_layout.set_environment ("", {EIFFEL_CONSTANTS}.ise_precomp_env)
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: CONF_SYSTEM_VIEW; a_location: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			name.set_text (a_library.library_target_name + "_precompile")
			location.set_text (a_location)
		end

	on_ok
			-- <Precursor>
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					prompts.show_error_prompt (conf_interface_names.invalid_precompile_name, Current, Void)
				elseif group_exists (name.text, target) then
					prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					last_group := factory.new_precompile (name.text, location.text, target)
					target.set_precompile (last_group)
					is_ok := True
					destroy
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
