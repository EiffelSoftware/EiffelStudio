indexing

	description: "Abstract description of a parent. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PARENT_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like type; rn: like renaming; e: like exports;
		u: like undefining; rd: like redefining; s: like selecting; ek: like end_keyword) is
			-- Create a new PARENT AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			internal_renaming := rn
			internal_exports := e
			internal_undefining := u
			internal_redefining := rd
			internal_selecting := s
			end_keyword := ek
		ensure
			type_set: type = t
			internal_renaming_set: internal_renaming = rn
			internal_exports_set: internal_exports = e
			internal_undefining_set: internal_undefining = u
			internal_redefining_set: internal_redefining = rd
			internal_selecting_set: internal_selecting = s
			end_keyword_set: end_keyword = ek
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parent_as (Current)
		end

feature -- Attributes

	type: CLASS_TYPE_AS
			-- Parent type

	renaming: EIFFEL_LIST [RENAME_AS] is
			-- Rename clause
		do
			if internal_renaming = Void or else internal_renaming.is_empty then
				Result := Void
			else
				Result := internal_renaming
			end
		end

	exports: EIFFEL_LIST [EXPORT_ITEM_AS] is
			-- Exports for parent
		do
			if internal_exports = Void or else internal_exports.is_empty then
				Result := Void
			else
				Result := internal_exports
			end
		end

	redefining: EIFFEL_LIST [FEATURE_NAME] is
			-- Redefining clause
		do
			if internal_redefining = Void or else internal_redefining.is_empty then
				Result := Void
			else
				Result := internal_redefining
			end
		end

	undefining: EIFFEL_LIST [FEATURE_NAME] is
			-- Undefine clause
		do
			if internal_undefining = Void or else internal_undefining.is_empty then
				Result := Void
			else
				Result := internal_undefining
			end
		end

	selecting: EIFFEL_LIST [FEATURE_NAME] is
			-- Select clause
		do
			if internal_selecting = Void or else internal_selecting.is_empty then
				Result := Void
			else
				Result := internal_selecting
			end
		end

	end_keyword: KEYWORD_AS
			-- End of clause if any of the `rename', `export', `redefine', `undefine'
			-- and `select' is present

feature -- Roundtrip

	internal_exports: EIFFEL_LIST [EXPORT_ITEM_AS]
			-- Internal exports for parent

	internal_renaming: EIFFEL_LIST [RENAME_AS]
			-- Internal rename clause

	internal_redefining: EIFFEL_LIST [FEATURE_NAME]
			-- Internal redefining clause

	internal_undefining: EIFFEL_LIST [FEATURE_NAME]
			-- Internal undefine clause

	internal_selecting: EIFFEL_LIST [FEATURE_NAME]
			-- Internal select clause

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := type.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if end_keyword /= Void then
				Result := end_keyword.complete_end_location (a_list)
			else
				Result := type.complete_end_location (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (exports, other.exports) and
				equivalent (redefining, other.redefining) and
				equivalent (renaming, other.renaming) and
				equivalent (selecting, other.selecting) and
				equivalent (type, other.type) and
				equivalent (undefining, other.undefining)
		end

feature -- Status report

	is_effecting: BOOLEAN is
			-- Is this parent clause redefining or undefining
			-- one or more features?
		do
			Result := undefining /= Void and then not undefining.is_empty
				and then redefining /= Void and then not redefining.is_empty
		end

feature -- Roundtrip/Item removal

	can_remove_items (rename_items, export_items, undefine_items, redefine_items, select_items: LIST [INTEGER]; a_list: LEAF_AS_LIST): BOOLEAN is
			-- Can items indicated by `rename_items', `export_items', `undefine_items', `redefine_items' and `select_items'
			-- be removed from current AST node?
		require
			a_list_not_void: a_list /= Void
		local
			l_all_removed: BOOLEAN
			l_all_removed_list: ARRAYED_LIST [BOOLEAN]
			l_clause_list: ARRAYED_LIST [EIFFEL_LIST[AST_EIFFEL]]
			l_remove_list: ARRAYED_LIST [LIST [INTEGER]]
		do
			l_clause_list := inherit_clauses
			l_remove_list := to_be_removed_items (rename_items, export_items, undefine_items, redefine_items, select_items)
			l_all_removed_list := inherit_clauses_status
			from
				l_remove_list.start
				l_clause_list.start
				l_all_removed_list.start
				l_all_removed := True
				Result := True
			until
				l_remove_list.after or not Result
			loop
				Result := (l_remove_list.item /= Void implies l_clause_list.item /= Void) and then l_clause_list.item.valid_remove_items (l_remove_list.item)
				if l_remove_list.item /= Void and Result then
					l_all_removed_list.put (l_clause_list.item.count = l_remove_list.item.count)
					l_all_removed := l_all_removed and l_all_removed_list.item
					if l_all_removed_list.item then
						Result := l_clause_list.item.can_remove_all_text (a_list)
					else
						Result := l_clause_list.item.can_remove_items (l_remove_list.item, a_list)
					end
				end
				l_remove_list.forth
				l_clause_list.forth
				l_all_removed_list.forth
			end
			if Result then
				Result := (l_all_removed and end_keyword /= Void) implies end_keyword.can_remove_all_text (a_list)
			end
		end

	remove_items (rename_items, export_items, undefine_items, redefine_items, select_items: LIST [INTEGER]; a_list: LEAF_AS_LIST) is
			-- Remove items indicated by `rename_items', `export_items', `undefine_items', `redefine_items' and `select_items'
			-- from current AST node?
		require
			a_list_not_void: a_list /= Void
			items_valid: can_remove_items (rename_items, export_items, undefine_items, redefine_items, select_items, a_list)
		local
			l_all_removed: BOOLEAN
			l_all_removed_list: ARRAYED_LIST [BOOLEAN]
			l_clause_list: ARRAYED_LIST [EIFFEL_LIST[AST_EIFFEL]]
			l_remove_list: ARRAYED_LIST [LIST [INTEGER]]
		do
			l_clause_list := inherit_clauses
			l_remove_list := to_be_removed_items (rename_items, export_items, undefine_items, redefine_items, select_items)
			l_all_removed_list := inherit_clauses_status
			from
				l_remove_list.start
				l_clause_list.start
				l_all_removed_list.start
				l_all_removed := True
			until
				l_remove_list.after
			loop
				if l_remove_list.item /= Void and l_clause_list.item /= Void then
					l_all_removed_list.put (l_clause_list.item.count = l_remove_list.item.count)
					l_all_removed := l_all_removed and l_all_removed_list.item
					if l_all_removed_list.item then
						l_clause_list.item.remove_all_text (a_list)
					else
						l_clause_list.item.remove_items (l_remove_list.item, a_list)
					end
				end
				l_remove_list.forth
				l_clause_list.forth
				l_all_removed_list.forth
			end
			if l_all_removed and end_keyword /= Void then
				end_keyword.remove_all_text (a_list)
			end
		end

feature{NONE} -- Roundtrip/Implementation

	inherit_clauses: ARRAYED_LIST [EIFFEL_LIST[AST_EIFFEL]] is
			-- List of all inherit clauses
		do
			create Result.make (5)
			Result.extend (internal_renaming)
			Result.extend (internal_exports)
			Result.extend (internal_undefining)
			Result.extend (internal_redefining)
			Result.extend (internal_selecting)
		end

	inherit_clauses_status: ARRAYED_LIST [BOOLEAN] is
			-- List to indicate whether certain inherit clause is Void
		do
			create Result.make (5)
			Result.extend (internal_renaming = Void)
			Result.extend (internal_exports = Void)
			Result.extend (internal_undefining = Void)
			Result.extend (internal_redefining = Void)
			Result.extend (internal_selecting = Void)
		end

	to_be_removed_items (rename_items, export_items, undefine_items, redefine_items, select_items: LIST [INTEGER]): ARRAYED_LIST [LIST[INTEGER]] is
			-- List of index of items which are to be removed
		do
			create Result.make (5)
			Result.extend (rename_items)
			Result.extend (export_items)
			Result.extend (undefine_items)
			Result.extend (redefine_items)
			Result.extend (select_items)
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class PARENT_AS
