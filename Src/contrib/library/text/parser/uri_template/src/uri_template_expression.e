note
	description: "Summary description for {URI_TEMPLATE_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	URI_TEMPLATE_EXPRESSION

inherit
	ANY

	DEBUG_OUTPUT
		export {NONE} all end

	URI_TEMPLATE_CONSTANTS
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_position: INTEGER; a_expression: STRING; a_is_query: BOOLEAN)
		do
			position := a_position
			expression := a_expression
			is_query := a_is_query
			operator := '%U'
		end

feature -- Processing

	analyze
		local
			exp: like expression
			s: detachable STRING
			lst: LIST [STRING]
			p: INTEGER
			vars: like variables
			vn: STRING
			vmodifier: detachable STRING
			i,n: INTEGER
		do
			if not is_analyzed then
				exp := expression
				if not exp.is_empty then
					op_prefix := '%U'
					op_delimiter := ','
					inspect exp[1]
					when Reserved_operator then
						--| '+'
						reserved := True
						operator := '+'
					when Label_operator then
						--| '.'
						operator := '.'
						op_prefix := '.'
						op_delimiter := '.'
					when Path_segment_operator then
						--| '/'
						operator := '/'
						op_prefix := '/'
						op_delimiter := '/'
					when Path_style_parameters_operator then
						--| ';'
						operator := ';'
						op_prefix := ';'
						op_delimiter := ';'
					when Form_style_query_operator then
						--| '?'
						operator := '?'
						op_prefix := '?'
						op_delimiter := '&'
					when form_style_query_continuation then
						--| '&'
						operator := '&'
						op_prefix := '&'
						op_delimiter := '&'
					when fragment_expansion then
						--| '#'
						reserved := True
						operator := '#'
						op_prefix := '#'
						op_delimiter := ','
					when '|', '!', '@' then
						operator := exp[1]
					else
						operator := '%U'
					end
					if operator /= '%U' then
						s := exp.substring (2, exp.count)
					else
						s := exp
					end

					lst := s.split (',')
					from
						create {ARRAYED_LIST [like variables.item]} vars.make (lst.count)
						lst.start
					until
						lst.after
					loop
						s := lst.item
						vmodifier := Void
						p := s.index_of (Default_delimiter, 1)
						if p > 0 then
							vn := s.substring (1, p - 1)
							s := s.substring (p + 1, s.count)
						else
							vn := s
							s := Void
						end
						from
							vmodifier := Void
							i := 1
							n := vn.count
						until
							i > n
						loop
							inspect vn[i]
							when Explode_plus, Explode_star, Modifier_substring, Modifier_remainder then
								vmodifier := vn.substring (i, n)
								vn := vn.substring (1, i - 1)
								i := n + 1 --| exit
							else
								i := i + 1
							end
						end
						vars.force (create {URI_TEMPLATE_EXPRESSION_VARIABLE}.make (Current, vn, s, vmodifier))
						lst.forth
					end
					variables := vars
				end
				is_analyzed := True
			end
		end

feature -- Access

	position: INTEGER
			-- Character position on Current in the template

	end_position: INTEGER
		do
			Result := position + expression.count + 2 --|  '{' + `expression' + '}'
		end

	expression: STRING
			-- Operator? + VariableName + modifier

	is_query: BOOLEAN
			-- Is in the query part (i.e: after '?' ?)

feature -- Status

	operator: CHARACTER
			-- First character of `expression' if among

	reserved: BOOLEAN
			-- Is reserved
			-- i.e: do not url-encode the reserved character

	op_prefix: CHARACTER
			-- When expanding list of table, first character to use
			--| ex: '?'  for  {?var}

	op_delimiter: CHARACTER
			-- When expanding list of table, delimiter character to use
			--| ex: ','  for  {?var}

	variables: detachable LIST [URI_TEMPLATE_EXPRESSION_VARIABLE]
			-- List of variables declared in `expression'
			--| ex: "foo", "bar"  for {?foo,bar}

	variable_names: LIST [STRING]
		do
			analyze
			if attached variables as vars then
				create {ARRAYED_LIST [STRING]} Result.make (vars.count)
				from
					vars.start
				until
					vars.after
				loop
					Result.force (vars.item.name)
					vars.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
			end
		end

feature -- Status report

	is_analyzed: BOOLEAN

feature -- Report

	append_expanded_to_string (a_ht: HASH_TABLE [detachable ANY, STRING]; a_buffer: STRING)
		do
			analyze
			if attached variables as vars then
				append_custom_variables_to_string (a_ht, vars, op_prefix, op_delimiter, True, a_buffer)
			end
		end

feature {NONE} -- Implementation

	append_custom_variables_to_string (a_ht: HASH_TABLE [detachable ANY, STRING]; vars: like variables; prefix_char, delimiter_char: CHARACTER; a_include_name: BOOLEAN; a_buffer: STRING)
			-- If `first_char' is '%U' do not print any first character
		local
			vi: like variables.item
			l_is_first: BOOLEAN
			vdata: detachable ANY
			vstr: detachable STRING
			l_use_default: BOOLEAN
		do
			if vars /= Void then
				from
					vars.start
					l_is_first := True
				until
					vars.after
				loop
					vi := vars.item
					vdata := a_ht.item (vi.name)
					vstr := Void
					if vdata /= Void then
						vstr := vi.expanded_string (vdata)
						if vstr = Void and vi.has_explode then
							--| Missing or list empty
							vstr := vi.default_value
							l_use_default := True
						else
							l_use_default := False
						end
					else
						--| Missing
						vstr := vi.default_value
						l_use_default := True
					end
					if vstr /= Void then
						if l_is_first then
							if prefix_char /= '%U' then
								a_buffer.append_character (prefix_char)
							end
							l_is_first := False
						else
							a_buffer.append_character (delimiter_char)
						end
						if l_use_default and (operator = Form_style_query_operator or operator = form_style_query_continuation or operator = path_style_parameters_operator) and not vi.has_explode_star then
							a_buffer.append (vi.name)
							if vi.has_explode_plus then
								a_buffer.append_character ('.')
							else
								a_buffer.append_character ('=')
							end
						end
						a_buffer.append (vstr)
					end
					vars.forth
				end
			end
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := expression
		end

;note
	copyright: "2011-2012, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
