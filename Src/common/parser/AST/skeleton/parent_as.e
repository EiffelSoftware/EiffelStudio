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
