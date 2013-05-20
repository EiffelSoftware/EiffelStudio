note
	description: "Summary description for {URI_TEMPLATE_EXPRESSION_VARIABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	URI_TEMPLATE_EXPRESSION_VARIABLE

inherit
	ANY

	URI_TEMPLATE_CONSTANTS
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (exp: like expression; n: like name; d: like default_value; em: detachable STRING)
			-- Create based on expression `exp', variable name `n', default value `d' if any
			-- and explode or modifier string `em'
		do
			expression := exp
			operator := exp.operator
			name := n
			default_value := d
			if em /= Void and then em.count > 0 then
				inspect em[1]
				when Explode_star, Explode_plus then
					explode := em[1]
				when Modifier_substring, Modifier_remainder then
					modifier := em
				else
				end
			end

			op_prefix := '%U'
			op_separator := ','

			inspect operator
			when Reserved_operator then --| '+'
				reserved := True
			when Form_style_query_operator then --| '?'
				op_prefix := '?'
				op_separator := '&'
			when form_style_query_continuation then --| '&'
				op_prefix := '&'
				op_separator := '&'
			when Path_style_parameters_operator then --| ';'
				op_prefix := ';'
				op_separator := ';'
			when Path_segment_operator then --| '/'
				op_prefix := '/'
				op_separator := '/'
			when fragment_expansion then --| '#'
				reserved := True
				op_prefix := '#'
				op_separator := ','
			when Label_operator then --| '.'
				op_prefix := '.'
				op_separator := '.'
			else
			end
		end

feature -- Access

	expression: URI_TEMPLATE_EXPRESSION
			-- Parent expression

	operator: CHARACTER
			-- First character of related `expression'

	name: STRING
			-- variable name

	default_value: detachable STRING
			-- default value if any

	reserved: BOOLEAN
			-- Is reserved?
			-- i.e: do not url-encode the reserved character			

	op_prefix: CHARACTER
			-- When expanding list of table, first character to use
			--| ex: '?'  for  {?var}	

	op_separator: CHARACTER
			-- When expanding list of table, delimiter character to use
			--| ex: ','  for  {?var}	

	explode: CHARACTER
			-- Explode character , '*' or '+'

	modifier: detachable STRING
			-- Modifier expression, starting by ':' or '^'
			--| ":3" , "-3", "^4", ...

	modified_string (s: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		local
			t: STRING
			i,n: INTEGER
		do
			Result := s
			if attached modifier as m and then m.count > 1 then
				n := s.count
				t := m.substring (2, m.count)
				if t.is_integer then
					i := t.to_integer
					inspect m[1]
					when Modifier_substring then
						if i > 0 then
							if i < n then
								Result := s.substring (1, i)
							end
						elseif i < 0 then
							Result := s.substring (n - i, n)
						end
					when Modifier_remainder then
						if i > 0 then
							if i < n then
								Result := s.substring (i + 1, n)
							end
						elseif i < 0 then
							Result := s.substring (1, n + i) --| n + i = n - (-i)
						end
					else
						check Known_modified: False end
						-- Unchanged
					end
				end
			end
		end

	has_explode: BOOLEAN
		do
			Result := explode = Explode_plus or explode = Explode_star
		end

	has_explode_plus: BOOLEAN
		do
			Result := explode = Explode_plus
		end

	has_explode_star: BOOLEAN
		do
			Result := explode = Explode_star
		end

feature -- Report

	expanded_string (d: detachable ANY): detachable STRING
		local
			l_delimiter: CHARACTER
			v_enc: detachable STRING
			k_enc: STRING
			l_obj: detachable ANY
			i,n: INTEGER
			explode_is_plus: BOOLEAN
			explode_is_star: BOOLEAN
			l_has_explode: BOOLEAN
			dft: detachable ANY
			has_list_op: BOOLEAN
			op: like operator
		do
			l_has_explode := has_explode
			if l_has_explode then
				explode_is_plus := has_explode_plus
				explode_is_star := has_explode_star
			end
			op := operator
			has_list_op := op /= '%U' and op /= Reserved_operator
			dft := default_value
			create Result.make (20)
			if attached {READABLE_STRING_GENERAL} d as l_string then
				v_enc := url_encoded_string (modified_string (l_string), not reserved)
				if op = Form_style_query_operator or op = form_style_query_continuation then
	                Result.append (name)
	                Result.append_character ('=')
				elseif op = Path_style_parameters_operator then
	                Result.append (name)
	                if not v_enc.is_empty then
		                Result.append_character ('=')
	                end
				end
				Result.append (v_enc)
			elseif attached {ARRAY [detachable ANY]} d as l_array then
				if l_array.is_empty then
					if dft /= Void then
						inspect op
						when Path_style_parameters_operator,Form_style_query_operator, form_style_query_continuation then
							if not l_has_explode then
								Result.append (name)
								Result.append_character ('=')
								Result.append (dft.out)
							else
								if explode_is_plus then
									Result.append (name)
									Result.append_character ('.')
								end
								Result.append (dft.out)
							end
						when Path_segment_operator then
							if explode_is_plus then
								Result.append (name)
								Result.append_character ('.')
							end
							Result.append (dft.out)
						when Label_operator then
						else
							if l_has_explode then
								if explode_is_plus then
									Result.append (name)
									Result.append_character ('.')
								end
								Result.append (dft.out)
							end
						end
					else
						-- nothing ...
					end
				else
					if l_has_explode then
						l_delimiter := op_separator
					else
						l_delimiter := ','
						inspect op
						when Form_style_query_operator, form_style_query_continuation, path_style_parameters_operator then
							Result.append (name)
							Result.append_character ('=')
						else
						end
					end

					from
						i := l_array.lower
						n := l_array.upper
					until
						i > n
					loop
						l_obj := l_array[i]
						if l_obj /= Void then
							v_enc := url_encoded_string (l_obj.out, not reserved)
						else
							v_enc := ""
						end
						if explode_is_plus then
							if
								(op = Form_style_query_operator and explode_is_plus) or
								(op = form_style_query_continuation and explode_is_plus) or
								(op = Path_style_parameters_operator and l_has_explode)
							then
								Result.append (name)
								Result.append_character ('=')
							else
								Result.append (name)
								Result.append_character ('.')
							end
						elseif explode_is_star and (op = Form_style_query_operator or op = form_style_query_continuation or op = path_style_parameters_operator) then
							Result.append (name)
							Result.append_character ('=')
						end
						Result.append (v_enc)
						if i < n then
							Result.append_character (l_delimiter)
						end

						i := i + 1
					end
				end
				if Result.is_empty then
					Result := Void
				end
			elseif attached {HASH_TABLE [detachable ANY, STRING]} d as l_table then
				if l_table.is_empty then
					if dft /= Void then
						inspect op
						when Path_style_parameters_operator, Form_style_query_operator, form_style_query_continuation then
							if not l_has_explode then
								Result.append (name)
								Result.append_character ('=')
								Result.append (dft.out)
							else
								if explode_is_plus then
									Result.append (name)
									Result.append_character ('.')
								end
								Result.append (dft.out)
							end
						when Path_segment_operator then
							if explode_is_plus then
								Result.append (name)
								Result.append_character ('.')
							end
							Result.append (dft.out)
						when Label_operator then
						else
							if l_has_explode then
								if explode_is_plus then
									Result.append (name)
									Result.append_character ('.')
								end
								Result.append (dft.out)
							end
						end
					else
						-- nothing ...
					end
				else
					if l_has_explode then
						l_delimiter := op_separator
					else
						l_delimiter := ','
						inspect op
						when Form_style_query_operator, form_style_query_continuation, path_style_parameters_operator then
							Result.append (name)
							Result.append_character ('=')
						else
						end
					end

					from
						l_table.start
					until
						l_table.after
					loop
						k_enc := url_encoded_string (l_table.key_for_iteration, not reserved)
						l_obj := l_table.item_for_iteration
						if l_obj /= Void then
							v_enc := url_encoded_string (l_obj.out, not reserved)
						else
							v_enc := ""
						end

						if explode_is_plus then
							Result.append (name)
							Result.append_character ('.')
						end
						if
							l_has_explode
						then
							Result.append (k_enc)
							Result.append_character ('=')
						else
							Result.append (k_enc)
							Result.append_character (l_delimiter)
						end
						Result.append (v_enc)

						l_table.forth
						if not l_table.after then
							Result.append_character (l_delimiter)
						end
					end
				end
				if Result.is_empty then
					Result := Void
				end
			else
				if d /= Void then
					v_enc := url_encoded_string (d.out, not reserved)
				elseif dft /= Void then
					v_enc := url_encoded_string (dft.out, not reserved)
				else
					v_enc := default_value
				end
				if op = Form_style_query_operator or op = form_style_query_continuation then
	                Result.append (name)
	                if v_enc /= Void then
		                Result.append_character ('=')
	                end
	            elseif op = Path_style_parameters_operator then
	                Result.append (name)
	                if v_enc /= Void and then not v_enc.is_empty then
		                Result.append_character ('=')
	                end
				end
				if v_enc /= Void then
					Result.append (v_enc)
				end
			end
		end

feature {NONE} -- Implementation

	url_encoded_string (s: READABLE_STRING_GENERAL; a_encoded: BOOLEAN): STRING
		do
			if a_encoded then
				Result := url_encoder.encoded_string (s.as_string_32)
			else
				Result := url_encoder.partial_encoded_string (s.as_string_32, <<
									':', ',',
									Reserved_operator,
									Label_operator,
									Path_segment_operator,
									Path_style_parameters_operator,
									Form_style_query_operator,
									'|', '!', '@'
									>>)
			end
		end

	url_encoder: URL_ENCODER
		once
			create Result
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
