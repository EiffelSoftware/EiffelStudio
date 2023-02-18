note
	description: "A visitor that nomalizes loop bodies using specified cursor."

class
	PRETTY_PRINTER_LOOP_TESTER

inherit
	AST_ITERATOR
		redefine
			process_access_feat_as,
			process_binary_as,
			process_eiffel_list,
			process_nested_expr_as,
			process_unary_as
		end

create
	make

feature {NONE} -- Creation

	make (cursor_name: ID_AS; leaves: LEAF_AS_LIST)
		do
			name_id := cursor_name.name_id
			match_list := leaves
		end

feature -- Processing

	process (a: AST_EIFFEL)
			-- Process `a` and set `can_be_symbolic` accordingly.
		do
			can_be_symbolic := True
			a.process (Current)
		end

feature {NONE} -- Access

	name_id: like {NAMES_HEAP}.id_of
			-- Name ID of the loop cursor.

	match_list: LEAF_AS_LIST
			-- A list of leaves to be pretty-printed.

feature -- Status report

	can_be_symbolic: BOOLEAN
			-- Can given loop body be translated to a symbolic form?
			-- `True` if and only if all these conditions are met:
			-- - cursor is used as a target of a call;
			-- - the called feature is "item".

feature {NONE} -- Status report

	is_message: BOOLEAN
			-- Is a message of a call being processed?

	is_target: BOOLEAN
			-- Is a target of a call being processed?

feature {NONE} -- Visitor

	process_access_feat_as (a: ACCESS_FEAT_AS)
			-- <Precursor>
		do
			if can_be_symbolic then
				can_be_symbolic :=
					not is_target or else
					not attached a.feature_name as n or else
					n.name_id /= name_id
				Precursor (a)
			end
		end

	process_binary_as (a: BINARY_AS)
			-- <Precursor>
		do
			if
				attached {EXPR_CALL_AS} a.left as e and then
				attached {ACCESS_FEAT_AS} e.call as f and then
				f.feature_name.name_id = name_id
			then
				can_be_symbolic := False
			else
				is_target := True
				safe_process (a.left)
				is_target := False
				is_message := False
				safe_process (a.right)
			end
		end

	process_eiffel_list (a: EIFFEL_LIST [AST_EIFFEL])
			-- <Precursor>
		local
			old_is_message: like is_message
			old_is_target: like is_target
		do
			old_is_message := is_message
			old_is_target := is_target
			if attached a then
				across a as c loop
					is_message := False
					is_target := False
					safe_process (c)
				end
			end
			is_target := old_is_target
			is_message := old_is_message
		end

	process_nested_expr_as (a: NESTED_EXPR_AS)
			-- <Precursor>
		do
			if can_be_symbolic and then not is_message then
				if
					attached {EXPR_CALL_AS} a.target as c and then
					attached {ACCESS_FEAT_AS} c.call as f and then
					attached f.feature_name as n and then
					n.name_id = name_id
				then
						-- The target of a call is the cursor name.
						-- The only allowed feature call is "item".
					can_be_symbolic := is_item_call (a.message)
				else
					is_target := True
					safe_process (a.target)
					is_target := False
					is_message := True
					safe_process (a.message)
					is_message := False
				end
			end
		end

	process_unary_as (a: UNARY_AS)
			-- <Precursor>
		do
			is_target := True
			safe_process (a.expr)
			is_target := False
		end

feature {NONE} -- Feature name test

	is_item_call (a: CALL_AS): BOOLEAN
			-- Does `a` represent  a call to a feature of name "item"?
		do
			Result :=
					-- Take care about involved structure of qualified calls and consider only feature calls.
				attached {ACCESS_FEAT_AS}
						if attached {NESTED_EXPR_AS} a as m then
							if attached {EXPR_CALL_AS} m.target as c then c.call else m.target end
						else
							a
						end
					as f and then
					-- Pick up the feature name.
				attached f.feature_name as n and then
					-- Test if this is the name of a feature "item".
				n.name_id = {NAMES_HEAP}.item_name_id
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
