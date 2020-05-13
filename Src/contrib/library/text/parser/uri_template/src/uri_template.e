note
	description: "[
			Implementation of URI Template  RFC6570.

			See http://tools.ietf.org/html/rfc6570
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=URI Template RFC6570", "protocol=URI", "src=http://tools.ietf.org/html/rfc6570"

class
	URI_TEMPLATE

inherit
	HASHABLE

	DEBUG_OUTPUT

create
	make

create {URI_TEMPLATE}
	make_from_uri_template

convert
	make ({READABLE_STRING_8, STRING_8})

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		do
			template := s
		end

	make_from_uri_template (a_tpl: like Current)
		do
			template := a_tpl.template.string
		end

feature -- Access

	template: READABLE_STRING_8
			-- URI string representation

	duplicate: like Current
			-- Duplicate object from Current
		do
			create Result.make_from_uri_template (Current)
		end

feature -- Element change

	set_template (t: like template)
			-- Set `template' to `t'
		do
			template := t
			reset
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (template)
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := template.hash_code
		end

feature -- Structures

	variable_names: LIST [STRING]
			-- All variable names
		do
			analyze
			if attached expressions as l_expressions then
				create {ARRAYED_LIST [STRING]} Result.make (l_expressions.count)
				from
					l_expressions.start
				until
					l_expressions.after
				loop
					Result.append (l_expressions.item.variable_names)
					l_expressions.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
			end
		end

	path_variable_names: LIST [STRING]
			-- All variable names part of the path
		do
			analyze
			if attached expressions as l_expressions then
				create {ARRAYED_LIST [STRING]} Result.make (l_expressions.count)
				from
					l_expressions.start
				until
					l_expressions.after
				loop
					if not l_expressions.item.is_query then
						Result.append (l_expressions.item.variable_names)
					end
					l_expressions.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
			end
		end

	query_variable_names: LIST [STRING]
			-- All variable names part of the query (i.e after '?')	
		do
			analyze
			if attached expressions as l_expressions then
				create {ARRAYED_LIST [STRING]} Result.make (l_expressions.count)
				from
					l_expressions.start
				until
					l_expressions.after
				loop
					if l_expressions.item.is_query then
						Result.append (l_expressions.item.variable_names)
					end
					l_expressions.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
			end
		end

feature -- Builder

	expanded_string (a_ht: HASH_TABLE [detachable ANY, STRING]): STRING
			-- Expanded template using variable from `a_ht'
		local
			tpl: like template
			exp: URI_TEMPLATE_EXPRESSION
			p,q: INTEGER
		do
			analyze
			tpl := template
			if attached expressions as l_expressions then
				create Result.make (tpl.count)
				from
					l_expressions.start
					p := 1
				until
					l_expressions.after
				loop
					q := l_expressions.item.position
						--| Added inter variable text
					Result.append (tpl.substring (p, q - 1))
						--| Expand variables ...
					exp := l_expressions.item
					exp.append_expanded_to_string (a_ht, Result)

					p := q + l_expressions.item.expression.count + 2

					l_expressions.forth
				end
				Result.append (tpl.substring (p, tpl.count))
			else
				create Result.make_from_string (tpl)
			end
		end

	expanded_string_with_base_url (a_base_url: READABLE_STRING_8; a_ht: HASH_TABLE [detachable ANY, STRING]): STRING
			-- Expanded template using variable from `a_ht'
			-- with based url
		do
			create Result.make_from_string (a_base_url)
			Result.append (expanded_string (a_ht))
		end

feature -- Match

	match (a_uri: READABLE_STRING_8): detachable URI_TEMPLATE_MATCH_RESULT
		require
			is_valid: is_valid
		local
			b: BOOLEAN
			tpl: like template
			l_offset: INTEGER
			p,q,nb: INTEGER
			exp: URI_TEMPLATE_EXPRESSION
			vv, vn, t, s: READABLE_STRING_8
			path_vv: STRING
			l_vars, l_path_vars, l_query_vars: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			l_uri_count: INTEGER
			tpl_count: INTEGER
			l_next_literal_separator: detachable READABLE_STRING_8
		do
				--| Extract expansion parts  "\\{([^\\}]*)\\}"
			analyze
			if attached expressions as l_expressions then
				create l_path_vars.make (l_expressions.count)
				create l_query_vars.make (l_expressions.count)
				l_vars := l_path_vars
				b := True
				l_uri_count := a_uri.count
				tpl := template
				tpl_count := tpl.count
				if l_expressions.is_empty then
--					b := a_uri.substring (1, tpl_count).same_string (tpl)
					b := a_uri.same_string (tpl)
				else
					from
						l_expressions.start
						p := 0
						l_offset := 0
					until
						l_expressions.after or not b
					loop
						exp := l_expressions.item
						vn := exp.expression
						q := exp.position
							--| Check text between vars
						if p = q then
							--| There should be at least one literal between two expression
							--|  {var}{foobar}  is ambigous for matching ...
							--| unless with {/var} or {?var} ... since we can search for '/' or '?'
							exp.analyze
							b := exp.operator = '/' or exp.operator = '?'
							p := exp.end_position
						elseif q > p then
							if p = 0 then
								p := 1
							end
							t := tpl.substring (p, q - 1)
							s := a_uri.substring (p + l_offset, q + l_offset - 1)
							b := s.same_string (t)
							p := exp.end_position
						end
						l_expressions.forth --| we forth `l_expressions' so be careful

							--| Check related variable
						if b and then not vn.is_empty then
							if exp.is_query then
								l_vars := l_query_vars
							else
								l_vars := l_path_vars
							end
							if q + l_offset <= l_uri_count then
								inspect vn[1]
								when '?' then
									import_form_style_parameters_into (a_uri.substring (q + l_offset + 1, l_uri_count), l_vars)
									p := tpl_count + 1
									l_offset := l_offset + (l_uri_count - (q + l_offset + 1))
								when ';' then
									import_path_style_parameters_into (a_uri.substring (q + l_offset, l_uri_count), l_vars)
									p := tpl_count + 1
								else
									if not l_expressions.after then
										exp := l_expressions.item --| We change `exp' here
										exp.analyze
										if exp.operator = '/' or exp.operator = '?' then
											l_next_literal_separator := Void
										else
											l_next_literal_separator := tpl.substring (p, exp.position -1)
										end
									elseif p < tpl_count then
										l_next_literal_separator := tpl.substring (p, tpl_count)
									else
										l_next_literal_separator := Void
									end
									if vn[1] = '/' then
										vn := vn.substring (2, vn.count)
										from
											create path_vv.make_empty
											vv := "/"
											nb := 0
										until
											vv.is_empty or q + l_offset + 1 > a_uri.count
										loop
											vv := next_path_variable_value (a_uri, q + l_offset + 1, l_next_literal_separator)
											l_offset := l_offset + vv.count + 1
											nb := nb + 1
											if not vv.is_empty then
												path_vv.extend ('/')
												path_vv.append (vv)
												l_vars.force (vv, vn + "[" + nb.out + "]")
											end
										end
										l_vars.force (path_vv, vn)
										l_offset := l_offset - (1 + vn.count + 2)
									else
										vv := next_path_variable_value (a_uri, q + l_offset, l_next_literal_separator)
										l_vars.force (vv, vn)
										l_offset := l_offset + vv.count - (vn.count + 2)
									end
								end
							else
								b := exp.is_query --| query are optional
							end
						end
						if b and l_expressions.after then
							if
								(p < tpl_count) or
								(p + l_offset < l_uri_count)
							then
									--| Remaining literal part
								t := tpl.substring (p, tpl_count)
								s := a_uri.substring (p + l_offset, l_uri_count)
								b := s.same_string (t)
							end
						end
					end
				end
				if b then
					create Result.make (l_path_vars, l_query_vars)
				end
			end
		end

feature -- Basic operation

	parse
			-- Parse template
		do
			reset
			analyze
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is Current URI template valid?
		do
			analyze
			Result := not has_syntax_error
		end

feature {NONE} -- Internal Access

	reset
		do
			expressions := Void
			has_syntax_error := False
		end

	has_syntax_error: BOOLEAN
			-- Has syntax error
			--| Make sense only if `analyze' was processed before

	expressions: detachable LIST [URI_TEMPLATE_EXPRESSION]
			-- Expansion parts

feature {NONE} -- Implementation

	analyze
		local
			l_expressions: like expressions
			c: CHARACTER
			i,p,n: INTEGER
			tpl: like template
			in_x: BOOLEAN
			in_query: BOOLEAN
			x: STRING
			exp: URI_TEMPLATE_EXPRESSION
			l_has_query_expression: BOOLEAN
		do
			l_expressions := expressions
			if l_expressions = Void then
				tpl := template

					--| Extract expansion parts  "\\{([^\\}]*)\\}"
				create {ARRAYED_LIST [URI_TEMPLATE_EXPRESSION]} l_expressions.make (tpl.occurrences ('{'))
				from
					i := 1
					n := tpl.count
					l_has_query_expression := False
					create x.make_empty
				until
					i > n
				loop
					c := tpl[i]
					if in_x then
						if c = '}' then
							create exp.make (p, x.twin, in_query)
							l_expressions.force (exp)
							x.wipe_out
							in_x := False
							if l_has_query_expression and then i < n then
								--| Remaining text after {?exp}
								has_syntax_error := True
							end
						else
							x.extend (c)
						end
					else
						inspect c
						when '{' then
							check x_is_empty: x.is_empty end
							p := i
							in_x := True
							if not l_has_query_expression then
								l_has_query_expression := tpl.valid_index (i+1) and then tpl[i+1] = '?'
							end
							if not in_query then
								in_query := l_has_query_expression
							end
						when '?' then
							in_query := True
						else
						end
					end
					i := i + 1
				end
				expressions := l_expressions
			end
		end

	import_path_style_parameters_into (a_content: READABLE_STRING_8; res: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8])
		require
			a_content_attached: a_content /= Void
			res_attached: res /= Void
		do
			import_custom_style_parameters_into (a_content, ';', res)
		end

	import_form_style_parameters_into (a_content: READABLE_STRING_8; res: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8])
		require
			a_content_attached: a_content /= Void
			res_attached: res /= Void
		do
			import_custom_style_parameters_into (a_content, '&', res)
		end

	import_custom_style_parameters_into (a_content: READABLE_STRING_8; a_separator: CHARACTER; res: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8])
		require
			a_content_attached: a_content /= Void
			res_attached: res /= Void
		local
			n, p, i, j: INTEGER
			s: READABLE_STRING_8
			l_name, l_value: READABLE_STRING_8
		do
			n := a_content.count
			if n > 0 then
				from
					p := 1
				until
					p = 0
				loop
					i := a_content.index_of (a_separator, p)
					if i = 0 then
						s := a_content.substring (p, n)
						p := 0
					else
						s := a_content.substring (p, i - 1)
						p := i + 1
					end
					if not s.is_empty then
						j := s.index_of ('=', 1)
						if j > 0 then
							l_name := s.substring (1, j - 1)
							l_value := s.substring (j + 1, s.count)
						else
								-- variable without value
							l_name := s
							create {IMMUTABLE_STRING_8} l_value.make_empty
						end
						res.force (l_value, l_name)
					end
				end
			end
		end

	next_path_variable_value (a_uri: READABLE_STRING_8; a_index: INTEGER; a_end_token: detachable READABLE_STRING_8): STRING
		require
			valid_index: a_index <= a_uri.count
		local
			c: CHARACTER
			i,n,p: INTEGER
			l_end_token_first_char: CHARACTER
			l_end_token_count: INTEGER
		do
			from
				if a_end_token /= Void and then not a_end_token.is_empty then
					l_end_token_first_char := a_end_token.item (1)
					l_end_token_count := a_end_token.count
				end
				i := a_index
				n := a_uri.count
			until
				i > n
			loop
				c := a_uri[i]
				inspect c
				when '/', '?' then
					i := n
				else
					if
						a_end_token /= Void and then
						c = l_end_token_first_char and then
						a_uri.substring (i, i + l_end_token_count - 1).same_string (a_end_token)
					then
						i := n
					else
						p := i
					end
				end
				i := i + 1
			end
			Result := a_uri.substring (a_index, p).to_string_8
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
