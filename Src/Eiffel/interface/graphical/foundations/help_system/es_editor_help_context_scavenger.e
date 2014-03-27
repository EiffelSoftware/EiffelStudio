note
	description: "[
		A help context scavenger used to probe the Eiffel editor {EB_SMART_EDITOR} for help context information.
		For more information on help context scavengers see {ES_HELP_CONTEXT_SCAVENGER}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_EDITOR_HELP_CONTEXT_SCAVENGER

inherit
	ES_HELP_CONTEXT_SCAVENGER [attached EB_SMART_EDITOR]

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := True
		end

feature {NONE} -- Basic operations

	probe_object (a_object: attached EB_SMART_EDITOR): attached DS_ARRAYED_LIST [attached HELP_CONTEXT_I]
			-- Probes an object to locate and scavenge any help context information to be used with a help provider.
			--
			-- `a_object': Object to probe to scavenge help contexts
			-- `Result': The list of scavanged help contexts.
		local
			l_class_extractor: ES_EIS_CLASS_EXTRACTOR
			l_cluster_extractor: ES_EIS_CONF_EXTRACTOR
			l_entries: detachable SEARCH_TABLE [EIS_ENTRY]
			l_entry: detachable EIS_ENTRY
		do
			create Result.make_default
			if attached {CLASSI_STONE} a_object.stone as lt_class_stone then
				if a_object.text_is_fully_loaded then
					if attached lt_class_stone.class_i as lt_class then
						create l_class_extractor.make_with_location (a_object.position, lt_class, True)
						l_entries := l_class_extractor.eis_full_entries
					end
				end
			elseif attached {CLUSTER_STONE} a_object.stone as lt_cluster_stone then
				if attached {CONF_CLUSTER} lt_cluster_stone.group as lt_cluster then
					create l_cluster_extractor.make (lt_cluster, True)
					l_entries := l_class_extractor.eis_full_entries
				end
			end
			if l_entries /= Void then
				from
					l_entries.start
				until
					l_entries.after
				loop
					l_entry := l_entries.item_for_iteration
					check l_entry_not_void: l_entry /= Void end
					Result.force_last (create {ES_EIS_ENTRY_HELP_CONTEXT}.make (l_entry, False))
					l_entries.forth
				end
			end
		end

;note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
