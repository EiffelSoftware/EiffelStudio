indexing
	description: "[
		Searches an object for help provider help contexts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_HELP_CONTEXT_SCAVENGER [G -> !ANY]

inherit
	USABLE_I

feature -- Access

	scavenged_contexts: !DS_BILINEAR [!HELP_CONTEXT_I]
			-- List of contexts scavenged when probing the last object using `probe'
		require
			is_interface_usable: is_interface_usable
			has_probed: has_probed
		do
			if {l_results: !DS_BILINEAR [!HELP_CONTEXT_I]} internal_scavenged_contexts then
				Result := l_results
			else
				create internal_scavenged_contexts.make_default
				Result ?= internal_scavenged_contexts
			end
		ensure
			result_consistent: Result = scavenged_contexts
			result_contains_usable_items: Result.for_all (agent {!HELP_CONTEXT_I}.is_interface_usable)
		end

feature -- Status report

	has_probed: BOOLEAN
			-- Indicates if a probe has taken place

feature -- Basic operations

	frozen probe (a_object: G)
		require
			is_interface_usable: is_interface_usable
		local
			retried: BOOLEAN
		do
			if not retried then
				reset
				internal_scavenged_contexts.append_last (probe_object (a_object))
			end
			has_probed := True
		ensure
			has_probed: has_probed
		end

feature {NONE} -- Basic operations

	reset
			-- Sets Current to clear any previously probed cached data.
		do
			has_probed := False
			create internal_scavenged_contexts.make_default
		ensure
			not_has_probed: not has_probed
			internal_scavenged_contexts_attached: internal_scavenged_contexts /= Void
			internal_scavenged_contexts_is_empty: internal_scavenged_contexts.is_empty
		end

	probe_object (a_object: G): !DS_ARRAYED_LIST [!HELP_CONTEXT_I]
			-- Probes an object to locate and scavenge any help context information to be used with a help provider.
			--
			-- `a_object': Object to probe to scavenge help contexts
			-- `Result': The list of scavanged help contexts.
		require
			is_interface_usable: is_interface_usable
			not_has_probed: not has_probed
		deferred
		ensure
			not_has_probed: not has_probed
			result_contains_usable_items: Result.for_all (agent {!HELP_CONTEXT_I}.is_interface_usable)
		end

feature {NONE} -- Internal implementation cache

	frozen internal_scavenged_contexts: ?DS_ARRAYED_LIST [!HELP_CONTEXT_I]
			-- Cached version of `scavenged_contexts'

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
