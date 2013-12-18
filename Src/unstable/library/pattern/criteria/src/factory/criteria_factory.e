note
	description: "Summary description for {CRITERIA_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	CRITERIA_FACTORY [G]

create
	make

feature {NONE} -- Initialization

	make
		do
			create builders.make (10)
		end

feature -- Factory

	criteria_from_string (s: READABLE_STRING_GENERAL): like criteria
		do
			Result := criteria_from_token_list (criteria_tokens (s))
		end

	criteria (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL): detachable CRITERIA [G]
		local
			l_is_not: BOOLEAN
			k: READABLE_STRING_GENERAL
		do
			if a_name.count >= 2 and then a_name[1] = '-' then
				l_is_not := True
				k := a_name.substring (2, a_name.count)
			else
				k := a_name
			end
			if attached builder (k) as bld then
				Result := bld.item ([k, a_value])
			end
			if Result = Void then
				create {CRITERIA_MANIFEST_VALUE [G]} Result.make_name_value (k, a_value)
			end
			if l_is_not then
				Result := not Result
			end
		end

	default_criteria (a_value: READABLE_STRING_GENERAL): detachable CRITERIA [G]
		do
			if
				attached default_builder_name as n and then
				attached builder (n) as b
			then
				Result := b.item ([n, a_value])
			end
		end

	has_criteria (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has criteria for name `a_name'?
		do
			Result := builders.has (a_name)
		end

	has_default_criteria: BOOLEAN
			-- Has a default criteria?
		do
			Result := attached default_builder_name as n and then has_criteria (n)
		end

feature {NONE} -- Parse

	criteria_from_token_list (exps: like criteria_tokens): like criteria
		local
			opf: detachable CRITERIA_BINARY_OPERATION [G]
			notf: detachable CRITERIA_NOT [G]
			f: like criteria
			fake: CRITERIA_MANIFEST_VALUE [G]
			tok: CRITERIA_TOKEN
		do
			if exps /= Void and then not exps.is_empty then
				create fake.make_true
				across
					exps as c
				loop
					f := Void
					tok := c.item
					if tok.is_known_operator then
						f := fake
						if tok.is_operator_and and Result /= Void then
							check opf = Void end
							create {CRITERIA_AND [G]} opf.make (Result, f)
							opf.set_operator_string (tok.name)
							Result := opf
						elseif tok.is_operator_or and Result /= Void then
							check opf = Void end
							create {CRITERIA_OR [G]} opf.make (Result, f)
							opf.set_operator_string (tok.name)
							Result := opf
						elseif tok.is_operator_not and Result /= Void then
							create notf.make (create {CRITERIA_MANIFEST_VALUE [G]}.make_false)
							f := notf
						else
							check False end
						end
					end
					if f /= fake then
						if f = Void then
							f := criteria_from_token (tok)
						end
						if f /= Void then
							if opf /= Void then
								opf.set_other_criteria (f)
								Result := opf
								opf := Void
							elseif notf /= Void and f /= notf then
								notf.set_criteria (f)
							elseif Result /= Void then
								create {CRITERIA_AND [G]} Result.make (Result, f)
							else
								Result := f
							end
						end
					end
				end
			end
		end

	criteria_from_token (tok: CRITERIA_TOKEN): like criteria
		local
			l_op: detachable CRITERIA_TOKEN
			f_and: CRITERIA_AND [G]
			f_or: CRITERIA_OR [G]
			f_not: CRITERIA_NOT [G]
			f_right: detachable CRITERIA [G]
		do
			if tok.is_group and then attached tok.group as group_tok then
				f_right := criteria_from_token (group_tok.right)
				if f_right /= Void then
					l_op := group_tok.op
					if l_op.is_operator_not then
						create f_not.make (f_right)
						Result := f_not
					else
						if
							attached group_tok.left as l_left and then
							attached criteria_from_token (l_left) as f_left
						then
							if l_op.is_operator_and then
								create f_and.make (f_left, f_right)
								f_and.set_operator_string (l_op.name)
								Result := f_and
							elseif l_op.is_operator_or then
								create f_or.make (f_left, f_right)
								f_or.set_operator_string (l_op.name)
								Result := f_or
							else
								check False end
							end
						else
							check False end
						end
					end
				end
			elseif attached tok.value as v then
				if tok.is_embedded then
					Result := criteria_from_string (v)
				else
					Result := criteria (tok.name, v)
				end
			else
				check is_single: tok.is_single end
				Result := default_criteria (tok.name)
			end
		end

	criteria_tokens (s: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [CRITERIA_TOKEN]
		local
			c: CHARACTER_32
			p,i,n: INTEGER
			l_value, l_name: detachable READABLE_STRING_GENERAL
			in_dble_quote: BOOLEAN
			in_paren: INTEGER
			in_exp: BOOLEAN
			l_parts: ARRAYED_LIST [READABLE_STRING_GENERAL]
			prev_is_op: BOOLEAN
			tok: CRITERIA_TOKEN
			prev_tok, group_tok, next_tok: detachable CRITERIA_TOKEN
		do
			create l_parts.make (5)
			from
				i := 1
				n := s.count
			until
				i > n
			loop
				c := s[i]
				if in_dble_quote then
					if c = '%"' then
						in_dble_quote := False
						l_parts.extend (s.substring (p, i).as_string_32)
						in_exp := False
					end
				elseif in_paren > 0 then
					if c = '(' then
						in_paren := in_paren + 1
					elseif c = ')' then
						in_paren := in_paren - 1
						if in_paren = 0 then
							l_parts.extend (s.substring (p, i).as_string_32)
							in_exp := False
						end
					end
				elseif c.is_space then
					if in_exp then
						l_parts.extend (s.substring (p, i - 1).as_string_32)
						in_exp := False
					end
				else
					if not in_exp then
						in_exp := True
						p := i
						if c = '(' then
							in_paren := 1
						end
					elseif c = '%"' then
						in_dble_quote := True
					end
				end
				i := i + 1
			end
			if i = n + 1 and in_exp then
				l_parts.force (s.substring (p, n).as_string_32)
				in_exp := False
			end

			create Result.make (l_parts.count)
			prev_is_op := True
			across
				l_parts as cur
			loop
				prev_is_op := prev_tok = Void or else prev_tok.is_known_operator

				l_name := cur.item
				if l_name.count > 1 and then l_name[1] = '(' then
					if not prev_is_op then
						create tok.make_silent_and_operator
						Result.force (tok)
						prev_tok := tok
					end
					check l_name [l_name.count] = ')' end
					create tok.make_embedded (l_name.substring (2, l_name.count - 1))
					Result.force (tok)
					prev_tok := tok
				else
					p := l_name.index_of (':', 1)
					if p = 0 then
						p := l_name.index_of ('=', 1)
					end
					if p = 0 then
						create tok.make_operator (l_name)
						if prev_tok = Void and then tok.is_binary_operator then
						else
							Result.force (tok)
							prev_tok := tok
						end
					else
						if not prev_is_op then
							create tok.make_silent_and_operator
							Result.force (tok)
							prev_tok := tok
						end

						l_value := l_name.substring (p + 1, l_name.count)
						l_name := l_name.head (p - 1)
						if l_value.count > 1 and l_value[1] = '%"' then
							check l_value[l_value.count] = '%"' end
							l_value := l_value.substring (2, l_value.count - 1)
						end
						create tok.make_name_value (l_name, l_value)
						Result.force (tok)
						prev_tok := tok
					end
				end
			end
			from
				prev_tok := Void
				Result.start
			until
				Result.after
			loop
				tok := Result.item
				if tok.is_operator_and then
					Result.forth
					if
						not Result.after and prev_tok /= Void and
						attached Result.item as op_next_tok and then not op_next_tok.is_binary_operator
					then
						next_tok := op_next_tok
						if next_tok.is_operator_not then
							Result.forth
							if
								not Result.after and
								attached Result.item as not_next_tok and then not not_next_tok.is_binary_operator
							then
								create group_tok.make_group (Void, next_tok, not_next_tok)
								Result.remove -- remove right
								Result.back
								next_tok := group_tok
							else
								check False end
							end
						end
						create group_tok.make_group (prev_tok, tok, next_tok)
						Result.remove -- remove right
						Result.back
						Result.remove -- remove op
						Result.back
						Result.replace (group_tok) -- replace left
						tok := group_tok
					else
						check False end
					end
				elseif tok.is_operator_not then
					Result.forth
					if
						not Result.after and
						attached Result.item as not_next_tok and then not not_next_tok.is_binary_operator
					then
						create group_tok.make_group (Void, tok, not_next_tok)
						Result.remove -- remove right
						Result.back
						Result.replace (group_tok) -- replace not
						tok := group_tok
					else
						check False end
					end
				end
				prev_tok := tok
				Result.forth
			end
		end

feature -- Access

	description: STRING_32
		local
			s: STRING_32
		do
			create s.make_empty
			across
				builders as c
			loop
				s.append_character ('[')
				s.append_string_general (c.key)
				s.append_character (']')
				if attached c.item.description as d then
					s.append_character (' ')
					s.append_string_general (d)
				end
				s.append_character ('%N')
			end
			s.append ("%N")
			s.append ("Operators: or, and, not%N")
			s.append ("Usage:%N")
			s.append ("%Tfoo:bar means 'foo:bar'%N" )
			s.append ("%T-foo:bar means 'not foo:bar'%N")
			s.append ("%T+foo:bar means 'or foo:bar'%N")

			Result := s
		end

feature -- Change		

	register_builder (a_name: READABLE_STRING_GENERAL; bld: attached like builder)
		do
			builders.force ([bld, Void], a_name)
		end

	register_builder_with_description (a_name: READABLE_STRING_GENERAL; bld: attached like builder; a_desc: READABLE_STRING_GENERAL)
		do
			builders.force ([bld, a_desc], a_name)
		end

	register_default_builder (a_name: detachable READABLE_STRING_GENERAL)
		require
			a_name /= Void implies has_criteria (a_name)
		do
			default_builder_name := a_name
		end

feature {NONE} -- Implementation		

	builder (a_name: READABLE_STRING_GENERAL): detachable FUNCTION [ANY, TUPLE [name: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL], like criteria]
		do
			if attached builders.item (a_name) as b then
				Result := b.builder
			end
		end

	builders: STRING_TABLE [TUPLE [builder: detachable like builder; description: detachable READABLE_STRING_GENERAL]]

	default_builder_name: detachable READABLE_STRING_GENERAL
			-- Optional default builder, to handle single token filter.

invariant
	builders /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
