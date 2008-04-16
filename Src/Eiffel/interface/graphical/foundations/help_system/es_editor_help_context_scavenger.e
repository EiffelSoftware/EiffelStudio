indexing
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
	ES_HELP_CONTEXT_SCAVENGER [!EB_SMART_EDITOR]

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := True
		end

feature {NONE} -- Basic operations

	probe_object (a_object: !EB_SMART_EDITOR): !DS_ARRAYED_LIST [!HELP_CONTEXT_I] is
			-- Probes an object to locate and scavenge any help context information to be used with a help provider.
			--
			-- `a_object': Object to probe to scavenge help contexts
			-- `Result': The list of scavanged help contexts.
		local
			l_class_extractor: ES_EIS_CLASS_EXTRACTOR
			l_cluster_extractor: ES_EIS_CONF_EXTRACTOR
			l_entries: ?SEARCH_TABLE [!EIS_ENTRY]
		do
			create Result.make_default
			if {lt_class_stone: CLASSI_STONE}a_object.stone then
				if a_object.text_is_fully_loaded then
					if {lt_class: CLASS_I}lt_class_stone.class_i then
						create l_class_extractor.make_with_location (a_object.position, lt_class)
						l_entries := l_class_extractor.eis_full_entries
					end
				end
			elseif {lt_cluster_stone: CLUSTER_STONE}a_object.stone then
				if {lt_cluster: CONF_CLUSTER}lt_cluster_stone.group then
					create l_cluster_extractor.make (lt_cluster)
					l_entries := l_class_extractor.eis_full_entries
				end
			end
			if l_entries /= Void then
				from
					l_entries.start
				until
					l_entries.after
				loop
					Result.force_last (create {ES_EIS_ENTRY_HELP_CONTEXT}.make (l_entries.item_for_iteration))
					l_entries.forth
				end
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
