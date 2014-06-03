note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_GENERIC

inherit
	TEMPLATE_STRUCTURE_ACTION
		redefine
			process,
			set_action_name
		end

create {TEMPLATE_STRUCTURE_ACTION_FACTORY}
	make

feature {TEMPLATE_TEXT} -- Type

	is_if_action,
	is_unless_action,
	is_include_action,
	is_invalid_action: BOOLEAN

	reset_type
		do
			is_if_action := False
			is_unless_action := False
			is_include_action := False
			is_invalid_action := False
		end

	update_type
		require
			action_name /= Void
		do
			reset_type
			if attached action_name as n then
				if n.is_case_insensitive_equal_general (if_op_id) then
					is_if_action := True
				elseif n.is_case_insensitive_equal_general (if_unless_id) then
					is_unless_action := True
				elseif n.is_case_insensitive_equal_general (include_op_id) then
					is_include_action := True
				else
					is_invalid_action := True
				end
			else
				is_invalid_action := True
			end
		end

feature -- Output

	process
		local
		do
			Precursor
			if is_if_action then
				process_if_unless (True)
			elseif is_unless_action then
				process_if_unless (False)
			elseif is_include_action then
				process_include
			elseif is_invalid_action then
			end
		end

feature -- Change

	set_action_name (v: like action_name)
		do
			Precursor (v)
			update_type
		end

feature {NONE} -- Implementation

	process_include
		require
			is_include_action
		local
			vn: detachable STRING
			f: PLAIN_TEXT_FILE
			t: detachable STRING
			fc: INTEGER
			is_literal: BOOLEAN
			templ_text: TEMPLATE_TEXT
			p: detachable PATH
			done: BOOLEAN
		do
			if parameters.has (file_param_id) then
				vn := parameters.item (file_param_id)
			end
			if
				parameters.has (literal_param_id) and then
				attached parameters.item (literal_param_id) as l_id
			then
				is_literal := l_id.is_case_insensitive_equal ("true")
			else
				is_literal := False
			end

			if vn /= Void then
				create p.make_from_string (vn)
				if p.is_absolute then
	 			elseif attached template_context.template_folder as tf then
	 				p := tf.extended_path (p)
				end
			end

			-- FIXME: one should optimize this part to reuse previous analyzes

			if p /= Void then
				create f.make_with_path (p)
				if f.exists then
					fc := f.count
					create t.make (fc)
					f.open_read
					from
		--				done := False
					until
						done
					loop
						f.read_stream (1_024)
						t.append (f.last_string)
						done := f.last_string.count < 1_024 or f.exhausted
					end
					f.close
				else
					set_error_output ("{!! Missing include file " + p.utf_8_name + " !!}")
				end
			else
				set_error_output ("{!! Invalid use of action include !!}")
			end

			if t /= Void then
				if t.ends_with ("%N") then
					-- Removed final %N from the included file, if one really wants a final %N, be sure to add an empty line at the end
					t.remove_tail (1)
				end
				if is_literal then
					set_forced_output (t)
				else
					if not items.is_empty then
						t.prepend_string (inside_text)
					end
					create templ_text.make_from_text (t)
					templ_text.set_values (template_context.values.twin)

					template_context.backup
					template_context.set_current_template_text (templ_text)
					templ_text.get_structure

					templ_text.get_output
					t := templ_text.output
					template_context.restore
					set_forced_output (t)
				end
			end
		end

	process_if_unless (is_if: BOOLEAN)
		require
			is_if_action or is_unless_action
		local
			vn: detachable STRING
			cond_isset: BOOLEAN
			cond_isempty: BOOLEAN
			vv,vv1,vv2: like resolved_expression
			cond: BOOLEAN
			item_output: STRING
			l_sp_exp: LIST[STRING]
		do
			if parameters.has (condition_param_id) then
				vn := parameters.item (condition_param_id)
			end
			if parameters.has (isset_param_id) then
				vn := parameters.item (isset_param_id)
				cond_isset := True
			end
			if parameters.has (isempty_param_id) then
				vn := parameters.item (isempty_param_id)
				cond_isempty := True
			end
			if vn /= Void and then not vn.is_empty then
				if vn.has ('=') then
					l_sp_exp := vn.split ('=')
					vv1 := resolved_expression (l_sp_exp.at (1))
					vv2 := resolved_expression (l_sp_exp.at (2))
					vv := vv1 = vv2
				elseif vn.has ('~') then
					l_sp_exp := vn.split ('~')
					vv1 := resolved_expression (l_sp_exp.at (1))
					vv2 := resolved_expression (l_sp_exp.at (2))
					if
						attached {READABLE_STRING_GENERAL} vv1 as l_vv1 and then
					    attached {READABLE_STRING_GENERAL} vv2 as l_vv2
					then
					   	vv := l_vv1.same_string (l_vv2)
					else
						vv := vv1 ~ vv2
					end
				else
					vv := resolved_expression (vn)
				end
				if vv = Void then
					if cond_isempty then
						cond := True
					else
						cond := False
					end
				else
					if cond_isset then
						cond := True
					else
						if cond_isempty then
							if attached {READABLE_STRING_GENERAL} vv as vstring then
								cond := vstring.is_empty
							else
								if attached {ITERABLE [detachable ANY]} vv as vcontainer then
									cond := vcontainer.new_cursor.after -- i.e is_empty
								else
									cond := False
								end
							end
						else
							if attached {BOOLEAN} vv as vbool then
								cond := vbool.item
							else
								check not_ref: not attached {BOOLEAN_REF} vv end
								if vv.out.is_case_insensitive_equal_general ("true") then
									cond := True
								end
							end
						end
					end
				end
			end
			if (is_if and cond) or (not is_if and not cond) then
				item_output := foreach_iteration_string (inside_text, False)
				set_forced_output (item_output)
			else
				set_forced_output ("")
			end
		end


note
	copyright: "2011-2014, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
