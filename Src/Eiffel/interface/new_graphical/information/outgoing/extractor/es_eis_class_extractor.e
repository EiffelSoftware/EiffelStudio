note
	description: "EIS entries extractor from a class."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_CLASS_EXTRACTOR

inherit
	ES_EIS_EXTRACTOR

	ES_EIS_NOTE_PICKER

	ES_SHARED_LOCALE_FORMATTER

create
	make,
	make_with_location

feature {NONE} -- Initialization

	make (a_class: like class_i; a_force: BOOLEAN)
			-- Initialize with `a_class'.
			-- The extractor returns all EIS enties in the given class.
		do
			class_i := a_class
			create eis_entries.make (2)
			force_extracting := a_force
			extract
		ensure
			force_extracting_set: force_extracting = a_force
		end

	make_with_location (a_location: like location; a_class: like class_i; a_force: BOOLEAN)
			-- Initialize with `a_class' and `a_location'.
			-- `a_location' indicates the extractor only return EIS entries containing
			-- `a_location'.
		do
			location_specialized := True
			location := a_location
			make (a_class, a_force)
		ensure
			location_set: location = a_location
			location_specialized: location_specialized
		end

feature -- Access

	eis_full_entries: attached SEARCH_TABLE [EIS_ENTRY]
			-- <precursor>
		local
			l_conf_extractor: ES_EIS_CONF_EXTRACTOR
		do
			if attached internal_eis_full_entries as lt_full_entries then
				Result := lt_full_entries
			else
				if attached {CONF_CLUSTER} class_i.config_class.group as lt_cluster then
					create l_conf_extractor.make (lt_cluster, True)
					Result := l_conf_extractor.eis_full_entries.twin
					Result.merge (eis_entries.twin)
				else
					Result := eis_entries
				end
				internal_eis_full_entries := Result
			end
		end

feature -- Querry

	location_specialized: BOOLEAN
			-- Does current extractor take cursor location into account?

feature {NONE} -- Implementation

	extract
			-- Perform extracting
			-- If the information is up-to-date, read cached info from storage.
		local
			l_entries: HASH_TABLE [SEARCH_TABLE [EIS_ENTRY], STRING]
			l_search_entries: detachable SEARCH_TABLE [EIS_ENTRY]
			l_date: INTEGER
		do
				-- Compute EIS class id.
			eis_class_id := id_solution.id_of_class (class_i.config_class)

			if attached eis_class_id as lt_id then
				if not location_specialized and not force_extracting then
					l_entries := storage.entry_server.entries
					l_entries.search (lt_id)
					if not l_entries.found then
							-- No found in the storage, perform a fresh real extracting from text.
						real_extract (lt_id)
					else
						storage.date_server.search (lt_id)
						l_date := storage.date_server.found_item
						if l_date /= 0 implies class_i.date /= l_date then
								-- Found in the storage, but has been changed.
								-- Perform a fresh real extracting from text.
							real_extract (lt_id)
						else
							l_search_entries := l_entries.found_item
							check l_search_entries /= Void end -- Implied from `found'.
							eis_entries := l_search_entries
						end
					end
				else
						-- Always extract entries when `location_specialized'
					real_extract (lt_id)
				end
				if not has_override then
					extend_auto_entry
				end
			end
		end

feature {NONE} -- Access

	class_i: attached CLASS_I
			-- A help context class

	location: INTEGER
			-- Location in the text where including EIS entries are calculated

	eis_class_id: detachable STRING
			-- Class ID for EIS entry.

	eis_feature_id: like eis_class_id
			-- Current feature ID for EIS entry.

	internal_eis_full_entries: detachable like eis_full_entries
			-- Cached full entries

feature {NONE} -- Basic operations

	extend_auto_entry
			-- Add auto entry if needed.
		require
			not_has_override: not has_override
			eis_class_id_not_void: eis_class_id /= Void
		local
			l_entry: EIS_AUTO_ENTRY
			l_auto_entry: like auto_entry
		do
			l_auto_entry := auto_entry (class_i.target)
			if l_auto_entry /= Void and then l_auto_entry.enabled then
				create l_entry.make (class_i.name, Void, l_auto_entry.src, Void, eis_class_id, Void)
				eis_entries.force (l_entry)
			end
		end

	real_extract (a_computed_id: attached STRING)
			-- Perform real extract from the class text.
			-- Register result into storage.
		local
			l_class_modifier: ES_EIS_CLASS_MODIFIER
		do
			create l_class_modifier.make (class_i)
			l_class_modifier.prepare
				-- Compute EIS entries.
			if l_class_modifier.is_ast_available and then attached l_class_modifier.ast as l_class_as then
				probe_ast (l_class_as)
					-- Register extracted entries to EIS storage.
					-- We register empty entries to show that there is really not
					-- entries found in the class.
					-- If `location_specialized', imcomplete entries were possible extracted.
					-- In this case, we don't register it into the storage.
				if not location_specialized then
					storage.register_entries_of_component_id (eis_entries, a_computed_id, class_i.file_date)
				end
			end
		end

	probe_ast (a_ast: attached CLASS_AS)
			-- Probes an AST root node to locate and scavenge any help context information.
		local
			l_indexing_clauses: attached DS_ARRAYED_LIST [INDEXING_CLAUSE_AS]
			l_feature_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_features: EIFFEL_LIST [FEATURE_AS]
			l_feature: FEATURE_AS
			l_feature_name: detachable STRING_8
			l_class: CONF_CLASS
		do
			create l_indexing_clauses.make_default
			l_class := class_i.config_class

				-- Add top and bottom class indexing clauses.
			if attached a_ast.bottom_indexes as lt_clause3 then
				extract_enties_from_index_clause (lt_clause3, False)
			end
			if attached a_ast.top_indexes as lt_clause4 then
				extract_enties_from_index_clause (lt_clause4, False)
			end

				-- Iterate through all feature clauses and all features.
			l_feature_clauses := a_ast.features
			if l_feature_clauses /= Void and then not l_feature_clauses.is_empty then
				if location_specialized then
						-- Take location into account. Only the feature including the location is recorded.
					from
						l_feature_clauses.start
					until
						l_feature_clauses.after or l_feature_name /= Void
					loop
						l_features := l_feature_clauses.item.features
						if l_features /= Void and then not l_features.is_empty then
							from
								l_features.start
							until
								l_features.after or l_feature_name /= Void
							loop
								l_feature := l_features.item
								eis_feature_id := id_solution.id_of_feature_ast (l_class, l_feature)
								if location >= l_feature.start_location.position  and then location <= l_feature.end_location.position then
										-- Set feature name, for URI replacement
									l_feature_name := l_feature.feature_name.name
									if attached l_feature.indexes as lt_clause1 then
										extract_enties_from_index_clause (lt_clause1, True)
									end
								end
								l_features.forth
							end
						end
						l_feature_clauses.forth
					end
				else
						-- Record all features.
					from
						l_feature_clauses.start
					until
						l_feature_clauses.after
					loop
						l_features := l_feature_clauses.item.features
						if l_features /= Void and then not l_features.is_empty then
							from
								l_features.start
							until
								l_features.after
							loop
								l_feature := l_features.item
								eis_feature_id := id_solution.id_of_feature_ast (l_class, l_feature)
								if attached l_feature.indexes as lt_clause2 then
									extract_enties_from_index_clause (lt_clause2, True)
								end
								l_features.forth
							end
						end
						l_feature_clauses.forth
					end
				end
			end
		end

feature {NONE} -- Formatting

	extract_enties_from_index_clause (a_clause: attached INDEXING_CLAUSE_AS; a_for_feature: BOOLEAN)
			-- Extract entries from indexing clause into `eis_entries'.
		local
			l_id: like eis_class_id
		do
			from
				a_clause.start
			until
				a_clause.after
			loop
				if attached a_clause.item as lt_index then
					if a_for_feature then
						l_id := eis_feature_id
					else
						l_id := eis_class_id
					end
					if attached eis_entry_from_index (lt_index, l_id) as lt_eis_entry then
						eis_entries.force (lt_eis_entry)
					end
				end
				a_clause.forth
			end
		end

feature {NONE} -- Implementation

	has_override: BOOLEAN
			-- Extracted entries has overriding entry?
		local
			l_entries: like eis_entries
		do
			l_entries := eis_entries
			if l_entries /= Void then
				from
					l_entries.start
				until
					l_entries.after or Result
				loop
					Result := l_entries.item_for_iteration.override
					l_entries.forth
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
