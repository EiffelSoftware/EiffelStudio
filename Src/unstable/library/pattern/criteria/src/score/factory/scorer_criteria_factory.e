note
	description: "Summary description for {SCORER_CRITERIA_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCORER_CRITERIA_FACTORY [G]

create
	make

feature {NONE} -- Initialization

	make
		do
			create builders.make (10)
		end

feature -- Factory

	criteria_from_string (s: READABLE_STRING_GENERAL): like criteria
		require
			s_attached: s /= Void
		do
			Result := criteria_from_token_list (criteria_tokens (s))
		end

	criteria (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [G]
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
				create {SCORER_CRITERIA_MANIFEST_VALUE [G]} Result.make_name_value (k, a_value)
			end
			if l_is_not then
				Result := not Result
			end
		end

	default_criteria (a_value: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [G]
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

	has_default: BOOLEAN
			-- Has a default criteria?
		do
			Result := attached default_builder_name as n and then has_criteria (n)
		end

feature {NONE} -- Parse

	criteria_from_token_list (exps: like criteria_tokens): like criteria
		local
			opf: detachable SCORER_CRITERIA_BINARY_OPERATION [G]
			notf: detachable SCORER_CRITERIA_NOT [G]
			f: like criteria
			fake: SCORER_CRITERIA_MANIFEST_VALUE [G]
			tok: SCORE_TOKEN
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
							create {SCORER_CRITERIA_AND [G]} opf.make (Result, f)
							opf.set_operator_string (tok.name)
							Result := opf
						elseif tok.is_operator_or and Result /= Void then
							check opf = Void end
							create {SCORER_CRITERIA_OR [G]} opf.make (Result, f)
							opf.set_operator_string (tok.name)
							Result := opf
						elseif tok.is_operator_not and Result /= Void then
							create notf.make (create {SCORER_CRITERIA_MANIFEST_VALUE [G]}.make_false)
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
								create {SCORER_CRITERIA_AND [G]} Result.make (Result, f)
							else
								Result := f
							end
						end
					end
				end
			end
		end

	criteria_from_token (tok: SCORE_TOKEN): like criteria
		local
			l_op: detachable SCORE_TOKEN
			f_and: SCORER_CRITERIA_AND [G]
			f_or: SCORER_CRITERIA_OR [G]
			f_not: SCORER_CRITERIA_NOT [G]
			f_right: detachable SCORER_CRITERIA [G]
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

	criteria_tokens (s: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [SCORE_TOKEN]
		require
			s_attached: s /= Void
		local
			c: CHARACTER_32
			p,i,n: INTEGER
			l_value, l_name: detachable READABLE_STRING_GENERAL
			in_dble_quote: BOOLEAN
			in_paren: INTEGER
			in_exp: BOOLEAN
			l_parts: ARRAYED_LIST [READABLE_STRING_GENERAL]
			prev_is_op: BOOLEAN
			tok: SCORE_TOKEN
			prev_tok, group_tok, next_tok: detachable SCORE_TOKEN
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
						if l_name.starts_with ("+") then
							create tok.make_silent_or_operator
							l_name := l_name.substring (2, l_name.count)

							if prev_tok = Void and then tok.is_binary_operator then
							else
								Result.force (tok)
								prev_tok := tok
							end
						end
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
						if l_name.starts_with ("+") then
							create tok.make_silent_or_operator
							l_name := l_name.substring (2, l_name.count)

							if prev_tok = Void and then tok.is_binary_operator then
							else
								Result.force (tok)
								prev_tok := tok
							end
						end
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
						not Result.after and prev_tok /= Void and then
						attached Result.item as op_next_tok
					then
						if
							tok.is_silent_operator_and and
							op_next_tok.is_operator_or
						then
							Result.back
							Result.remove
							tok := op_next_tok
						elseif
							op_next_tok.is_silent_operator_or
						then
							Result.remove
						elseif op_next_tok.is_binary_operator then
							check and_token_has_non_binary_operator_token: False end
						else
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
									check not_token_has_non_binary_operator_token: False end
								end
							end
							create group_tok.make_group (prev_tok, tok, next_tok)
							Result.remove -- remove right
							Result.back
							Result.remove -- remove op
							Result.back
							Result.replace (group_tok) -- replace left
							tok := group_tok
						end
					else
						check and_token_has_tokens_on_left_and_right: False end
					end
				elseif tok.is_operator_or then
					Result.forth
					if
						not Result.after and
						attached Result.item as l_next_tok and then
						l_next_tok.is_silent_operator_or
					then
						Result.remove
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
						check not_token_has_non_binary_operator_token: False end
					end
				end
				prev_tok := tok
				Result.forth
			end
		end

feature -- Access

	short_description: STRING_32
		local
			k: READABLE_STRING_GENERAL
			s: STRING_32
			len: INTEGER
		do
			create s.make_empty
			s.append ("Criteria:%N")
			across
				builders as c
			loop
				len := len.max (c.key.count)
			end

			across
				builders as c
			loop
				k := c.key
				s.append_character (' ')
				s.append_character (' ')
				s.append_character ('[')
				s.append_string_general (k)
				s.append_character (']')
				if k.count < len then
					s.append (create {STRING_32}.make_filled (' ', len - k.count))
				end
				if attached c.item.description as d then
					s.append_character (' ')
					s.append_string_general (d)
				end
				s.append_character ('%N')
			end
			Result := s
		end

	description: STRING_32
		local
			sh: READABLE_STRING_32
			s: STRING_32
		do
			sh := short_description
			create s.make (sh.count + 30)
			s.append ("Usage: %"criterion:value%"")
			if attached default_builder_name as dft then
				s.append (" (note: %"value%" is aliased with  %"" + dft + ":value%")")
			end
			s.append_character ('%N')
			s.append_character ('%N')
			s.append (sh)
			s.append_character ('%N')
			s.append ("Criteria can be combined with %"and%" (the default), %"or%" (aliased with prefix %"+%"), %"not%" (aliased with prefix %"-%").%N")
			Result := s
		end

feature -- Change		

	register_builder (a_name: READABLE_STRING_GENERAL; bld: attached like builder)
		local
			t: like builders.item
		do
			t := [bld, Void]
			builders.force (t, a_name)
		end

	register_builder_with_description (a_name: READABLE_STRING_GENERAL; bld: attached like builder; a_desc: READABLE_STRING_GENERAL)
		local
			t: like builders.item
		do
			t := [bld, a_desc]
			builders.force (t, a_name)
		end

	register_default_builder (a_name: detachable READABLE_STRING_GENERAL)
		require
			a_name /= Void implies has_criteria (a_name)
		do
			default_builder_name := a_name
		end

	set_builder_description (a_name: READABLE_STRING_GENERAL; a_desc: detachable READABLE_STRING_GENERAL)
		require
			has_criteria (a_name)
		do
			if attached builders.item (a_name) as b then
				builders.force ([b.builder, a_desc], a_name)
			end
		end

feature {NONE} -- Implementation		

	builder (a_name: READABLE_STRING_GENERAL): detachable FUNCTION [TUPLE [name: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL], like criteria]
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
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
