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

	initialize (t: like type; rn: like internal_renaming; e: like internal_exports;
		u: like internal_undefining; rd: like internal_redefining; s: like internal_selecting; ek: like end_keyword) is
			-- Create a new PARENT AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			set_internal_renaming (rn)
			set_internal_exports (e)
			set_internal_undefining (u)
			set_internal_redefining (rd)
			set_internal_selecting (s)
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

	renaming: EIFFEL_LIST [RENAME_AS]
			-- Rename clause

	exports: EIFFEL_LIST [EXPORT_ITEM_AS]
			-- Exports for parent

	redefining: EIFFEL_LIST [FEATURE_NAME]
			-- Redefining clause

	undefining: EIFFEL_LIST [FEATURE_NAME]
			-- Undefine clause

	selecting: EIFFEL_LIST [FEATURE_NAME]
			-- Select clause

	end_keyword: KEYWORD_AS
			-- End of clause if any of the `rename', `export', `redefine', `undefine'
			-- and `select' is present

feature -- Roundtrip

	internal_exports: EXPORT_CLAUSE_AS
			-- Internal exports for parent

	internal_renaming: RENAME_CLAUSE_AS
			-- Internal rename clause

	internal_redefining: REDEFINE_CLAUSE_AS
			-- Internal redefining clause

	internal_undefining: UNDEFINE_CLAUSE_AS
			-- Internal undefine clause

	internal_selecting: SELECT_CLAUSE_AS
			-- Internal select clause

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			Result := type.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if end_keyword /= Void then
				Result := end_keyword.last_token (a_list)
			else
				Result := type.last_token (a_list)
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

feature{NONE} -- Implementation

	set_internal_renaming (a_renaming: like internal_renaming) is
			-- Set `internal_renaming' with `a_renaming' and set `renaming' accordingly.
		do
			internal_renaming := a_renaming
			if internal_renaming /= Void then
				renaming := internal_renaming.meaningful_content
			else
				renaming := Void
			end
		ensure
			internal_renaming_set: internal_renaming = a_renaming
		end

	set_internal_exports (a_exports: like internal_exports) is
			-- Set `internal_exports' with `a_exports' and set `exports' accordingly.
		local
			l_internal_exporting: like internal_exports
			l_exports: like exports
		do
			internal_exports := a_exports
			if internal_exports /= Void then
				exports := internal_exports.meaningful_content
			else
				exports := Void
			end
		ensure
			internal_exports_set: internal_exports = a_exports

		end

	set_internal_undefining (a_undefining: like internal_undefining) is
			-- Set `internal_undefining' with `a_undefining' and set `undefining' accordingly.
		do
			internal_undefining := a_undefining
			if internal_undefining /= Void then
				undefining := internal_undefining.meaningful_content
			else
				undefining := Void
			end
		ensure
			internal_undefining_set: internal_undefining = a_undefining
		end

	set_internal_redefining (a_redefining: like internal_redefining) is
			-- Set `internal_redefining' with `a_redefining' and set `redefining' accordingly.
		do
			internal_redefining := a_redefining
			if internal_redefining /= Void then
				redefining := internal_redefining.meaningful_content
			else
				redefining := Void
			end
		ensure
			internal_redefining_set: internal_redefining = a_redefining
		end

	set_internal_selecting (a_selecting: like internal_selecting) is
			-- Set `internal_selecting' with `a_selecting' and set `selecting' accordingly.
		do
			internal_selecting := a_selecting
			if internal_selecting /= Void then
				selecting := internal_selecting.meaningful_content
			else
				selecting := Void
			end
		ensure
			internal_selecting_set: internal_selecting = a_selecting
		end

invariant
	renaming_correct: (internal_renaming /= Void implies renaming = internal_renaming.meaningful_content) and
					  (internal_renaming = Void implies renaming = Void)
	undefining_correct: (internal_undefining /= Void implies undefining = internal_undefining.meaningful_content) and
					  (internal_undefining = Void implies undefining = Void)
	redefining_correct: (internal_redefining /= Void implies redefining = internal_redefining.meaningful_content) and
					  (internal_redefining = Void implies redefining = Void)
	selecting_correct: (internal_selecting /= Void implies selecting = internal_selecting.meaningful_content) and
					  (internal_selecting = Void implies selecting = Void)

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
