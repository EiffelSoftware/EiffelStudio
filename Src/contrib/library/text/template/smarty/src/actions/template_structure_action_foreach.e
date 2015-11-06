note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_FOREACH

inherit
	TEMPLATE_STRUCTURE_ACTION
		redefine
			process, get_output
		end

create {TEMPLATE_STRUCTURE_ACTION_FACTORY}
	make

feature -- Output

	process
		do
			Precursor
			process_foreach
		end

	get_output
		do
			Precursor
--			if output = Void then
--				if is_foreach_action then
--					output := "{!! Action[" + action_name + "] !!}"
--				end
--			end
		end

feature {NONE} -- Implementation

	Reflexion: INTERNAL
		once
			create Result
		end

	Integer_dynamic_type: INTEGER
		once
			Result := reflexion.dynamic_type (0)
		end

	process_foreach
		local
			sfrom,sitem, skey: detachable STRING
			vfrom: detachable ANY
			lst_any: detachable ITERABLE [detachable ANY]
			hsh_any_hashable: detachable TABLE_ITERABLE [detachable ANY, HASHABLE]
			tmp_output: detachable STRING
		do
--			template_context.backup
			if parameters.has (key_param_id) then
				skey := parameters.item (key_param_id)
			end
			if parameters.has (item_param_id) then
				sitem := parameters.item (item_param_id)
			end
			if parameters.has (from_param_id) then
				sfrom := parameters.item (from_param_id)
			elseif parameters.has (expression_param_id) then
				sfrom := parameters.item (expression_param_id)
			end
			if sfrom /= Void then
				vfrom := resolved_expression (sfrom)
				if vfrom /= Void then
					hsh_any_hashable := Void
					lst_any := Void
					if attached {detachable TABLE_ITERABLE [detachable ANY, HASHABLE]} vfrom as l_ti then
						hsh_any_hashable := l_ti
					elseif attached {ITERABLE [detachable ANY]} vfrom as lst then
						lst_any := lst
					else
					end
				end
			end
			if hsh_any_hashable /= Void and (skey /= Void or sitem /= Void)	then
				tmp_output := foreach_hash_any_hashable_output (hsh_any_hashable, skey, sitem)
			elseif lst_any /= Void and sitem /= Void then
				tmp_output := foreach_list_any_output (lst_any, skey, sitem)
			end
--			template_context.restore
			if tmp_output /= Void then
				set_forced_output (tmp_output)
			end
		end

	foreach_hash_any_hashable_output (obj: TABLE_ITERABLE [detachable ANY, HASHABLE]; skey, sitem: detachable STRING): STRING
		require
			valid_data: obj /= Void and (skey /= Void or sitem /= Void)
		local
			item_output: STRING
			vobj_item: detachable ANY
			vobj_key: detachable HASHABLE
		do
			Result := ""
			across
				obj as cursor
			loop
				if sitem /= Void then
					vobj_item := cursor.item
					template_context.add_runtime_value (vobj_item, sitem)
				end

				if skey /= Void then
					vobj_key := cursor.key
					template_context.add_runtime_value (vobj_key, skey)
				end

				item_output := foreach_iteration_string (inside_text, False)
				Result.append_string (item_output)
			end
			if sitem /= Void then
				template_context.remove_runtime_value (sitem)
			end
			if skey /= Void then
				template_context.remove_runtime_value (skey)
			end
		end

	foreach_list_any_output (obj: ITERABLE [detachable ANY]; skey, sitem: detachable STRING): STRING
		require
			data_valid: obj /= Void and sitem /= Void
		local
			item_output: STRING
			vobj_item: detachable ANY
			i: INTEGER
		do
			i := 0
			Result := ""
			across
				obj as cursor
			loop
				i := i + 1
				if sitem /= Void then
					vobj_item := cursor.item
					template_context.add_runtime_value (vobj_item, sitem)
				end
				if skey /= Void then
					template_context.add_runtime_value (i, skey)
				end

				item_output := foreach_iteration_string (inside_text, False)
				Result.append_string (item_output)
			end
			if sitem /= Void then
				template_context.remove_runtime_value (sitem)
			end
			if skey /= Void then
				template_context.remove_runtime_value (skey)
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
