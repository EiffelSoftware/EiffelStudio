indexing
	description: "Object that represents all features with clients in an export clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EXPORT_FEATURE_SET

create
	make

feature{NONE} -- Implementation

	make (export_clause: EIFFEL_LIST [EXPORT_ITEM_AS]; a_list: LEAF_AS_LIST) is
			-- Initialize.
		require
			export_clause_not_void: export_clause /= Void
			export_clause_not_empty: not export_clause.is_empty
			a_list_not_void: a_list /= Void
		local
			l_index: INTEGER
			l_index2: INTEGER
			l_all: ALL_AS
			l_feature_list: FEATURE_LIST_AS
		do
			l_index := export_clause.index
			create features.make
			from
				export_clause.start
			until
				export_clause.after
			loop
				if export_clause.item.features /= Void then
					l_all ?= export_clause.item.features
					if l_all /= Void then
						features.extend (create{ERT_EXPORT_FEATURE}.make (l_all.all_keyword.text (a_list), client_set (export_clause.item)))
					else
						l_feature_list ?= export_clause.item.features
						check l_feature_list /= Void end
						l_index2 := l_feature_list.features.index
						from
							l_feature_list.features.start
						until
							l_feature_list.features.after
						loop
							features.extend (create{ERT_EXPORT_FEATURE}.make (l_feature_list.features.item.internal_name,
											 client_set (export_clause.item)))
							l_feature_list.features.forth
						end
						l_feature_list.features.go_i_th (l_index2)
					end
				end
				export_clause.forth
			end
		end

feature

	merge (other: like Current) is
			-- Merge `other' into current.
		require
			other_not_void: other /= Void
		local
			l_found: BOOLEAN
			l_temp_list: LINKED_LIST [ERT_EXPORT_FEATURE]
		do
			create l_temp_list.make
			from
				other.features.start
			until
				other.features.after
			loop
				l_found := False
				from
					features.start
				until
					features.after
				loop
					if other.features.item.feature_name.is_case_insensitive_equal (features.item.feature_name) then
						l_found := True
						if not features.item.clients.is_equal (other.features.item.clients) then
							features.item.clients.merge_other (other.features.item.clients)
						end
					end
					features.forth
				end
				if not l_found then
					l_temp_list.extend (other.features.item)
				end
				other.features.forth
			end
			features.finish
			features.merge_right (l_temp_list)
		end

	export_items: LIST [ERT_EXPORT_ITEM_LIST] is
			-- A list of feature name list which are exported to the same client set
			-- Every item in list represents a client set and all features exported to that set.
		local
			l_features: like features
			l_item: ERT_EXPORT_ITEM_LIST
			l_is_all: BOOLEAN
		do
			l_features := features.twin
			create {LINKED_LIST [ERT_EXPORT_ITEM_LIST]}Result.make
			from

			until
				l_features.is_empty
			loop
				l_features.start
				create l_item.make (l_features.first.clients)
				l_item.feature_name_list.extend (l_features.first.feature_name)
				l_is_all := l_features.first.is_all
				l_features.remove
				if not l_features.is_empty then
					from
						l_features.start
					until
						l_features.after
					loop
						if l_item.clients.is_equal (l_features.item.clients) then
							if l_is_all or else l_features.item.is_all then
								l_is_all := True
								l_item.feature_name_list.wipe_out
								l_item.feature_name_list.extend ("all")
							else
								l_item.feature_name_list.extend (l_features.item.feature_name)
							end
							l_features.remove
						else
							l_features.forth
						end
					end
				end
				Result.extend (l_item)
			end
		end

feature -- Access

	features: LINKED_LIST [ERT_EXPORT_FEATURE]
			-- features in an export inherit clause		

feature -- Implementation

	client_set (a_export_item: EXPORT_ITEM_AS): ERT_CLIENT_SET is
			-- Client set of `a_export_item' AST node
		require
			a_export_itme_not_void: a_export_item /= Void
		local
			l_index: INTEGER
			l_none_id: NONE_ID_AS
		do
			l_index := a_export_item.clients.clients.index
			create Result.make
			from
				a_export_item.clients.clients.start
			until
				a_export_item.clients.clients.after
			loop
				l_none_id ?= a_export_item.clients.clients.item
				if l_none_id /= Void then
					Result.put (once "NONE")
				else
					Result.put (a_export_item.clients.clients.item)
				end
				a_export_item.clients.clients.forth
			end
			a_export_item.clients.clients.go_i_th (l_index)
		ensure
			Result_not_void: Result /= Void
		end

invariant
	features_not_void: features /= Void

end
