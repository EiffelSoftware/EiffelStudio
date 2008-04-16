indexing
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

create
	make,
	make_with_location

feature {NONE} -- Initialization

	make (a_class: like class_i) is
			-- Initialize with `a_class'.
			-- The extractor returns all EIS enties in the given class.
		do
			class_i := a_class
			create eis_entries.make (2)
			extract
		end

	make_with_location (a_location: like location; a_class: like class_i) is
			-- Initialize with `a_class' and `a_location'.
			-- `a_location' indicates the extractor only return EIS entries containing
			-- `a_location'.
		do
			location_specialized := True
			location := a_location
			make (a_class)
		ensure
			location_set: location = a_location
			location_specialized: location_specialized
		end

feature -- Access

	eis_full_entries: !SEARCH_TABLE [!EIS_ENTRY]
			-- <precursor>
		local
			l_conf_extractor: ES_EIS_CONF_EXTRACTOR
		do
			if not {lt_full_entries: like eis_full_entries}internal_eis_full_entries then
				if {lt_cluster: CONF_CLUSTER}class_i.config_class.group then
					create l_conf_extractor.make (lt_cluster)
					Result := l_conf_extractor.eis_full_entries.twin
					Result.merge (eis_entries.twin)
				else
					Result := eis_entries
				end
				internal_eis_full_entries := Result
			else
				Result := internal_eis_full_entries
			end
		end

feature -- Querry

	location_specialized: BOOLEAN
			-- Does current extractor take cursor location into account?

feature {NONE} -- Implementation

	extract is
			-- Perform extracting
			-- If the information is up-to-date, read cached info from storage.
		local
			l_entries: !HASH_TABLE [!SEARCH_TABLE [!HASHABLE], !STRING]
		do
				-- Compute EIS class id.
			eis_class_id := id_solution.id_of_class (class_i.config_class)

			if {lt_id: STRING}eis_class_id then
				if not location_specialized then
					l_entries := storage.entry_server.entries
					l_entries.search (lt_id)
					if not l_entries.found then
							-- No found in the storage, perform a fresh real extracting from text.
						real_extract (lt_id)
					else
						if {lt_entries: like eis_entries}l_entries.found_item then
							if class_i.config_class.has_modification_date_changed then
									-- Found in the storage, but has been changed.
									-- Perform a fresh real extracting from text.
								real_extract (lt_id)
							else
								eis_entries := lt_entries
							end
						else
							check
								type_conformace: False
							end
						end
					end
				else
						-- Always extract entries when `location_specialized'
					real_extract (lt_id)
				end
			end
		end

feature {NONE} -- Access

	class_i: !CLASS_I
			-- A help context class

	location: INTEGER
			-- Location in the text where including EIS entries are calculated

	eis_class_id: ?STRING
			-- Class ID for EIS entry.

	eis_feature_id: like eis_class_id
			-- Current feature ID for EIS entry.

	internal_eis_full_entries: like eis_full_entries
			-- Cached full entries

feature {NONE} -- Basic operations

	real_extract (a_computed_id: !STRING) is
			-- Perform real extract from the class text.
			-- Register result into storage.
		local
			l_class_modifier: ES_EIS_CLASS_MODIFIER
		do
			create l_class_modifier.make (class_i)
			l_class_modifier.prepare
				-- Compute EIS entries.
			if l_class_modifier.is_ast_available and then {l_class_as: CLASS_AS}l_class_modifier.ast then
				probe_ast (l_class_as)
					-- Register extracted entries to EIS storage.
					-- We register empty entries to show that there is really not
					-- entries found in the class.
					-- If `location_specialized', imcomplete entries were possible extracted.
					-- In this case, we don't register it into the storage.
				if not location_specialized then
					storage.register_entries_of_component_id (eis_entries, a_computed_id)
				end
			end
		end

	probe_ast (a_ast: !CLASS_AS) is
			-- Probes an AST root node to locate and scavenge any help context information.
		local
			l_indexing_clauses: !DS_ARRAYED_LIST [INDEXING_CLAUSE_AS]
			l_feature_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_features: EIFFEL_LIST [FEATURE_AS]
			l_feature: FEATURE_AS
			l_feature_name: ?STRING_8
			l_class: CONF_CLASS
		do
			create l_indexing_clauses.make_default
			l_class := class_i.config_class

				-- Add top and bottom class indexing clauses.
			if {lt_clause3: INDEXING_CLAUSE_AS}a_ast.bottom_indexes then
				extract_enties_from_index_clause (lt_clause3, False)
			end
			if {lt_clause4: INDEXING_CLAUSE_AS}a_ast.top_indexes then
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
									if {lt_clause1: INDEXING_CLAUSE_AS}l_feature.indexes then
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
								if {lt_clause2: INDEXING_CLAUSE_AS}l_feature.indexes then
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

	extract_enties_from_index_clause (a_clause: !INDEXING_CLAUSE_AS; a_for_feature: BOOLEAN) is
			-- Extract entries from indexing clause into `eis_entries'.
		local
			l_id: like eis_class_id
		do
			from
				a_clause.start
			until
				a_clause.after
			loop
				if {lt_index: INDEX_AS}a_clause.item then
					if a_for_feature then
						l_id := eis_feature_id
					else
						l_id := eis_class_id
					end
					if {lt_eis_entry: EIS_ENTRY}eis_entry_from_index (lt_index, l_id) then
						eis_entries.force (lt_eis_entry)
					end
				end
				a_clause.forth
			end
		end

;indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end
