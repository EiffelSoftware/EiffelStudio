note
	description: "Feature name with alias."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_NAME_ALIAS_AS

inherit
	FEATURE_NAME
		rename
			initialize as initialize_id
		redefine
			is_binary,
			has_bracket_alias,
			is_equivalent,
			has_parentheses_alias,
			is_unary,
			process,
			first_token,
			last_token
		end

create
	initialize_with_list

feature {NONE} -- Creation

	initialize_with_list (feature_id: like feature_name; alias_names: LIST [FEATURE_ALIAS_NAME]; a_convert_keyword: detachable KEYWORD_AS)
		require
			feature_id_not_void: feature_id /= Void
			alias_list_not_empty: not alias_names.is_empty
			has_alias_name: ∀ a: alias_names ¦ not a.alias_name.value.is_empty
			no_alias_duplicates: ∀ x: alias_names ¦ ∀ y: alias_names ¦
						x.alias_name.value.same_string (y.alias_name.value) implies @ x.target_index = @ y.target_index
		do
			initialize_id (feature_id)
			if attached a_convert_keyword then
				convert_keyword_index := a_convert_keyword.index
				has_convert_mark := True
			end
			if attached {like aliases} alias_names as l then
				aliases := l
			else
				create aliases.make_from_iterable (alias_names)
			end
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_feature_name_alias_as (Current)
		end

feature -- Access: aliases

	aliases: ARRAYED_LIST [FEATURE_ALIAS_NAME]

feature -- Roundtrip

	keyword_at (a_list: LEAF_AS_LIST; i: INTEGER): detachable KEYWORD_AS
		require
			a_list_not_void: a_list /= Void
		do
			if a_list.valid_index (i) and then attached {KEYWORD_AS} a_list.i_th (i) as k then
				Result := k
			end
		end

	convert_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
		require
			has_convert_mark
		do
			if convert_keyword_index > 0 then
				Result := keyword_at (a_list, convert_keyword_index)
			end
		end

feature -- Access

	has_convert_mark: BOOLEAN assign set_has_convert_mark
			-- Is operator marked with "convert"?

	convert_keyword_index: INTEGER
			-- Index of convert keyword, if any.

feature -- Status report

	has_bracket_alias: BOOLEAN
			-- Is feature alias (if any) bracket?
		do
			Result := ∃ a: aliases ¦ a.is_bracket
		end

	has_parentheses_alias: BOOLEAN
			-- <Precursor>
		do
			Result := ∃ a: aliases ¦ a.is_parentheses
		end

	bracket_alias_as: detachable STRING_AS
		require
			has_bracket_alias
		do
			across
				aliases as ic
			until
				Result /= Void
			loop
				if ic.item.is_bracket then
					Result := ic.item.alias_name
				end
			end
		end

	parenthesis_alias_as: detachable STRING_AS
		require
			has_parentheses_alias
		do
			across
				aliases as ic
			until
				Result /= Void
			loop
				if ic.item.is_parentheses then
					Result := ic.item.alias_name
				end
			end
		end

	is_binary: BOOLEAN
			-- Is feature alias (if any) a binary operator unless it is a circumfix operator?

	is_unary: BOOLEAN
			-- Is feature alias (if any) an unary operator unless it is a circumfix operator?

	is_valid_binary: BOOLEAN
			-- Are all non-circumfix aliases valid as binary operators?
		do
			Result := ∀ a: aliases ¦ (¬ a.is_circumfix ⇒ a.is_valid_binary)
		end

	is_valid_unary: BOOLEAN
			-- Are all non-circumfix aliases valid as unary operators?
		do
			Result := ∀ a: aliases ¦ (¬ a.is_circumfix ⇒ a.is_valid_unary)
		end

feature -- Status setting

	set_has_convert_mark (b: BOOLEAN)
		do
			has_convert_mark := b
		end

	set_is_binary
			-- Mark operator as binary.
		require
			is_valid_binary
			not is_unary
		local
			a: like aliases.item
		do
			is_binary := True
			if attached aliases as l_aliases then
				across
					l_aliases as ic
				loop
					a := ic.item
					if not a.is_circumfix then
						a.set_is_binary
					end
				end
			end
		ensure
			is_binary
			∀ o: aliases ¦ (¬ o.is_circumfix ⇒ o.is_binary)
		end

	set_is_unary
			-- Mark operator as unary.
		require
			is_valid_unary
			not is_binary
		local
			a: like aliases.item
		do
			is_unary := True
			if attached aliases as l_aliases then
				across
					l_aliases as ic
				loop
					a := ic.item
					if not a.is_circumfix then
						a.set_is_unary
					end
				end
			end
		ensure
			is_unary
			∀ o: aliases ¦ (¬ o.is_circumfix ⇒ o.is_unary)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := frozen_keyword
			if Result = Void or else Result.is_null then
				Result := feature_name.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		local
			c: CURSOR
			l_aliases: like aliases
		do
			if a_list /= Void and then convert_keyword_index > 0 then
				Result := keyword_at (a_list, convert_keyword_index)
			else
				l_aliases := aliases
				c := l_aliases.cursor
				from
					l_aliases.finish
				until
					l_aliases.off or Result /= Void
				loop
					if attached l_aliases.item as l_item then
						if a_list = Void then
							if attached l_item.alias_name as l_as then
								Result := l_as.last_token (a_list)
							end
						else
							if attached l_item.alias_name as l_as then
								Result := l_as.last_token (a_list)
							elseif a_list /= Void and then l_item.alias_keyword_index /= 0 then
								Result := keyword_at (a_list, l_item.alias_keyword_index)
							end
						end
					end
					l_aliases.back
				end
				l_aliases.go_to (c)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		local
			c1, c2: CURSOR
			l_aliases, l_other_aliases: like aliases
		do
				-- There is no need to check whether both alias names are Bracket,
				-- because there is a check that they have the same alias name
			if
				Precursor (other) and then
				is_binary = other.is_binary and then
				has_convert_mark = other.has_convert_mark and then
				convert_keyword_index = other.convert_keyword_index
			then
				l_aliases := aliases
				l_other_aliases := other.aliases
				if l_aliases = l_other_aliases then
						-- Same alias list object.
				elseif l_aliases /= Void and l_other_aliases /= Void then
					if l_aliases.count = l_other_aliases.count then
						Result := True
						c1 := l_aliases.cursor
						c2 := l_other_aliases.cursor
						from
							l_aliases.start
							l_other_aliases.start
						until
							not Result or l_aliases.after or l_other_aliases.after
						loop
							if not equivalent (l_aliases.item.alias_name, l_other_aliases.item.alias_name) then
								Result := False
							end
							l_aliases.forth
							l_other_aliases.forth
						end
						l_aliases.go_to (c1)
						l_other_aliases.go_to (c2)
					end
				elseif aliases = Void then
					Result := other.aliases = Void
				else
					Result := False
				end
			end
		end

invariant

	has_alias: not aliases.is_empty
	has_alias_name: ∀ a: aliases ¦ not a.alias_name.value.is_empty
	no_alias_duplicates: ∀ x: aliases ¦ ∀ y: aliases ¦
		x.alias_name.value.same_string (y.alias_name.value) ⇒ @ x.target_index = @ y.target_index

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
