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
			search_in_manager, search_by_class_manager,
			all_search_results
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

	last_group: detachable CONF_PRECOMPILE
			-- <Precursor>

	search_in_manager: ES_LIBRARY_PROVIDER_SERVICE
		once
			create Result.make (2)
			Result.register (create {ES_PRECOMPILE_LIBRARY_LOCAL_PROVIDER})
			Result.register (create {ES_PRECOMPILE_LIBRARY_IRON_PROVIDER})
		end

	search_by_class_manager: ES_LIBRARY_PROVIDER_SERVICE
		once
			create Result.make (0)
		end

feature {NONE} -- Basic operation

	all_search_results (a_filter: detachable READABLE_STRING_32; a_provider_ids: detachable LIST [READABLE_STRING_GENERAL]): LIST [ES_LIBRARY_PROVIDER_ITEM]
		local
			libs: like all_search_results
			l_precompilation: detachable STRING_32
		do
				-- We store the ISE_PRECOMP environment variable because when editing an ECF, it can
				-- be either .NET or classic so we need to compute the right path.
			l_precompilation := eiffel_layout.get_environment_32 ({EIFFEL_CONSTANTS}.ise_precomp_env)
			eiffel_layout.set_precompile (target.setting_msil_generation)

				-- Lookup all the ECFs that matches.
			libs := Precursor (a_filter, a_provider_ids)
			create {ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]} Result.make (libs.count)
			across
				libs as ic
			loop
				if attached {CONF_SYSTEM_VIEW} ic.value as cfg and then cfg.system_name.starts_with ("precomp_") then
					Result.force (ic)
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

	on_library_selected (a_library: detachable CONF_SYSTEM_VIEW)
			-- <Precursor>
		do
			library_widget.set_library (a_library)
			library_widget.set_name (if a_library /= Void and then attached a_library.library_target_name as n then n else {STRING_32} "Unknown" end + "_precompile")
		end

	on_ok (w: ADD_LIBRARY_WIDGET)
			-- <Precursor>
		local
			l_name, l_location: READABLE_STRING_32
		do
				-- library choosen?
			l_name := w.name
			l_location := w.location
			if not l_location.is_empty and not l_name.is_empty then
				if not is_valid_group_name (l_name) then
					prompts.show_error_prompt (conf_interface_names.invalid_precompile_name, Current, Void)
				elseif group_exists (l_name, target) then
					prompts.show_error_prompt (conf_interface_names.group_already_exists (l_name), Current, Void)
				else
					last_group := factory.new_precompile (l_name, l_location, target)
					target.set_precompile (last_group)
					destroy
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
