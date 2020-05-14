note
	description: "Summary description for {WIKI_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TEMPLATE

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		require
			starts_with_double_curly_bracket: s.starts_with ("{{")
			ends_with_double_curly_bracket: s.ends_with ("}}")
		local
			p: INTEGER
			l_name: STRING_8
		do
			p := s.index_of ('|', 3)
			if p > 0 then
				l_name := s.substring (3, p - 1).to_string_8
				if p < s.count - 2 then
					parameters_text := s.substring (p + 1, s.count - 2)
				end
			else
				l_name := s.substring (3, s.count - 2).to_string_8 -- Remove "{{" and "}}"
			end
			l_name.adjust
			name := l_name
		end

feature -- Access

	name: READABLE_STRING_8

	parameters_text: detachable READABLE_STRING_8

	parameter (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
		do
			if attached parameters as l_params then
				Result := l_params.item (a_name)
			end
		end

	parameters: detachable STRING_TABLE [READABLE_STRING_8]
		local
			p: INTEGER
			i,j,n: INTEGER
			c: CHARACTER
			l_stack: ARRAYED_STACK [READABLE_STRING_8]
			l_split_positions: ARRAYED_LIST [INTEGER]
		do
			if attached parameters_text as l_params then
				create Result.make (0)
				p := l_params.index_of ('|', 1)
				if p = 0 then
					record_parameter_text_into (l_params, Result)
--					Result.force (l_params, "1")
				else
					create l_split_positions.make (1)
					create l_stack.make (1)
						-- Search for structure that may use '|'
					from
						i := 1
						n := l_params.count
					until
						i > n
					loop
						c := l_params[i]
						inspect
							c
						when '[' then
							if i < n and then l_params [i + 1] = '[' then
								l_stack.extend ("[[")
								i := i + 1
							end
						when ']' then
							if i < n and then l_params [i + 1] = ']' then
								if not l_stack.is_empty and then l_stack.item.same_string ("[[") then
									-- Closing link
									l_stack.remove
								else
									-- End without start!
								end
								i := i + 1
							end
						when '{' then
							if i < n and then l_params [i + 1] = '|' then
									-- Table
								l_stack.extend ("{|")
								i := i + 1
							end
						when '|' then
							if l_stack.is_empty then
								l_split_positions.force (i)
							else
								if i < n and then l_params [i + 1] = '}' then
									if not l_stack.is_empty and then l_stack.item.same_string ("{|") then
											-- Closing table
										l_stack.remove
									else
										-- End without start!
									end
									i := i + 1
								end
							end
						else
						end
						i := i + 1
					end
					if l_split_positions.is_empty then
						record_parameter_text_into (l_params, Result)
					else
						from
							i := 1
							l_split_positions.force (n + 1) -- so that last parameter is included.
							l_split_positions.start
						until
							i > n or l_split_positions.after
						loop
							j := l_split_positions.item
							record_parameter_text_into (l_params.substring (i, j - 1), Result)
							l_split_positions.forth
							i := j + 1
						end
					end
				end
			end
		end

	expression: detachable WIKI_STRING

	text (tpl: READABLE_STRING_8): WIKI_STRING
		local
			s: STRING
			vis: WIKI_STRING_ANALYZER
			l_parameters: like parameters
			i,j,k,n: INTEGER
			l_id: STRING_8
		do
			l_parameters := parameters
			if l_parameters /= Void and then l_parameters.count > 0 then
				create s.make (tpl.count)
				from
					i := 1
					n := tpl.count
				until
					i > n
				loop
					j := tpl.substring_index ("{{{", i)
					if j > 0 then
						s.append (tpl.substring (i, j - 1))

						k := tpl.substring_index ("}}}", j + 3)
						if k = 0 then
							s.append ("{{{")
							i := i + 3
						else
							l_id := tpl.substring (j + 3, k - 1).to_string_8
							l_id.left_adjust
							l_id.right_adjust
							if attached l_parameters.item (l_id) as l_part then
								s.append (l_part)
							else
								s.append ("{{{")
								s.append (l_id)
								s.append ("}}}")
							end
							i := k + 3
						end
					else
						s.append (tpl.substring (i, n))
						i := n + 1 -- Exit loop
					end
				end
				create Result.make (s)
			else
				create Result.make (tpl.string)
			end
			create vis.make
			Result.process (vis)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
				-- TODO: check that.
			Result := False
		end

feature -- Element change

	set_expression (a_exp: like expression)
		do
			expression := a_exp
		end

feature {NONE} -- Implementation

	record_parameter_text_into (a_param_text: READABLE_STRING_8; a_table: STRING_TABLE [READABLE_STRING_8])
		local
			k,v: STRING
			pos: INTEGER
		do
			pos := a_param_text.index_of ('=', 1)
			if pos > 0 then
				k := a_param_text.substring (1, pos - 1).to_string_8
				k.left_adjust
				k.right_adjust
				v := a_param_text.substring (pos + 1, a_param_text.count).to_string_8
				v.left_adjust
				v.right_adjust
				a_table.force (v, k)
			else
				a_table.force (a_param_text, (a_table.count + 1).out)
			end
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_template (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{{" + name + "}}"
		end

note
	copyright: "2011-2018, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
