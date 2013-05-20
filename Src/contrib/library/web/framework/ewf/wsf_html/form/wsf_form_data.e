note
	description : "Objects that represent a form filled with data from request."
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_FORM_DATA

inherit
	TABLE_ITERABLE [detachable WSF_VALUE, READABLE_STRING_8]

create {WSF_FORM}
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_form: WSF_FORM)
			-- Initialize `Current'.
		do
			form := a_form
			create items.make (a_form.count)
			get_items (req)
		end

feature -- Access		

	form: WSF_FORM

feature -- Status

	is_valid: BOOLEAN
		do
			Result := errors = Void
		end

	is_applied_to_associated_form: BOOLEAN
			-- Data already applied to `form'?

feature -- Access

	item_same_string (a_name: READABLE_STRING_GENERAL; s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is there any item named `a_name' with a value `v'?
		do
			if attached item (a_name) as l_value then
				Result := l_value.same_string (s)
			end
		end

	item (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
		do
			Result := items.item (a_name.as_string_8)
		end

	string_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached {WSF_STRING} item (a_name) as s then
				Result := s.value
			end
		end

	table_item (a_name: READABLE_STRING_GENERAL): detachable WSF_TABLE
		local
			s,k: READABLE_STRING_GENERAL
			p,q: INTEGER
		do
			if attached {WSF_TABLE} item (a_name) as tb then
				Result := tb
			else
				s := a_name + "["
				create Result.make (a_name.to_string_8) -- FIXME
				across
					items as c
				loop
					if attached c.item as v then
						k := c.key
						if k.starts_with (s) then
							if attached {WSF_TABLE} v as tb then
								across
									tb as t
								loop
									Result.add_value (t.item, t.item.name)
								end
							else
								p := k.index_of_code (91, 1) -- 91 '['
								if p > 0 then
									q := k.index_of_code (93, p + 1) -- 93 ']'
									if q > p then
										if q = p + 1 then
											-- []
											Result.add_value (v, (Result.count+1).out)
										else
											Result.add_value (v, k.substring (p + 1, q - 1))
										end
									end
								end
							end
						else
							-- skip
						end
					end
				end
			end
		end

	integer_item (a_name: READABLE_STRING_GENERAL): INTEGER
		do
			if attached {WSF_STRING} item (a_name) as s and then s.is_integer then
				Result := s.integer_value
			end
		end

	new_cursor: TABLE_ITERATION_CURSOR [detachable WSF_VALUE, READABLE_STRING_8]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Basic operation

	submit
		require
			is_valid: is_valid
		do
			form.submit_actions.call ([Current])
		end

	validate
		do
			across
				form as f
			loop
				validate_item (f.item)
			end
			form.validation_actions.call ([Current])
		end

	validate_item (w: WSF_WIDGET)
		do
			if attached {WSF_FORM_FIELD} w as l_field then
				l_field.validate (Current)
			elseif attached {ITERABLE [WSF_WIDGET]} w as lst then
				across
					lst as c
				loop
					validate_item (c.item)
				end
			end
		end

	set_fields_invalid (b: BOOLEAN; a_name: READABLE_STRING_GENERAL)
		do
			if attached form.fields_by_name (a_name) as lst then
				across
					lst as i
				loop
					i.item.set_is_invalid (b)
				end
			end
		end

	apply_to_associated_form
		do
			if not is_applied_to_associated_form then
				if attached errors as errs then
					across
						errs as e
					loop
						if attached e.item as err then
							if attached err.field as e_field then
								set_fields_invalid (True, e_field.name)
							end
						end
					end
				end
				across
					items as c
				loop
					across
						form as i
					loop
						apply_to_associated_form_item (c.key, c.item, i.item)
					end
				end
				is_applied_to_associated_form := True
			end
		end

feature {NONE} -- Implementation: apply

	apply_to_associated_form_item (a_name: READABLE_STRING_8; a_value: detachable WSF_VALUE; i: WSF_WIDGET)
		local
		do
			if attached {WSF_FORM_FIELD} i as l_field then
				if not attached {WSF_FORM_SUBMIT_INPUT} l_field then
					if l_field.name.same_string (a_name) then
						l_field.set_value (a_value)
					end
				end
			elseif attached {ITERABLE [WSF_WIDGET]} i as l_set then
				across
					l_set as c
				loop
					apply_to_associated_form_item (a_name, a_value, c.item)
				end
			end
		end

feature -- Change

	report_error (a_msg: READABLE_STRING_8)
		do
			add_error (Void, a_msg)
		ensure
			is_invalid: not is_valid
		end

	report_invalid_field (a_field_name: READABLE_STRING_8; a_msg: READABLE_STRING_8)
		require
			has_field: form.has_field (a_field_name)
		do
			if attached form.fields_by_name (a_field_name) as lst then
				across
					lst as c
				loop
					add_error (c.item, a_msg)
				end
			end
		ensure
			is_invalid: not is_valid
		end

feature {NONE} -- Implementation

	get_items (req: WSF_REQUEST)
		do
			get_form_items (req, form)
		end

	get_form_items (req: WSF_REQUEST; lst: ITERABLE [WSF_WIDGET])
		do
			across
				lst as c
			loop
				if attached {WSF_FORM_FIELD} c.item as l_field then
					get_form_field_item (req, l_field, l_field.name)
				elseif attached {ITERABLE [WSF_WIDGET]} c.item as l_set then
					get_form_items (req, l_set)
				end
			end
		end

	get_form_field_item (req: WSF_REQUEST; i: WSF_FORM_FIELD; n: READABLE_STRING_8)
		local
			v: detachable WSF_VALUE
		do
			if form.is_post_method then
				v := req.table_item (n, agent req.form_parameter)
			else
				v := req.table_item (n, agent req.query_parameter)
			end
			if v = Void then
				if n.ends_with_general ("[]") then
					if form.is_post_method then
						v := req.form_parameter (n.substring (1, n.count - 2))
					else
						v := req.query_parameter (n.substring (1, n.count - 2))
					end
				end
			end
			if i.is_required and (v = Void or else v.is_empty) then
				add_error (i, "Field %"<em>" + n + "</em>%" is required")
			else
				items.force (v, n)
			end
		end

	add_error (a_field: detachable WSF_FORM_FIELD; a_msg: detachable READABLE_STRING_8)
		local
			err: like errors
		do
			err := errors
			if err = Void then
				create err.make (1)
				errors := err
			end
			err.force ([a_field, a_msg])
		end

	items: HASH_TABLE [detachable WSF_VALUE, READABLE_STRING_8]

feature -- Cached values

	cached_value (k: READABLE_STRING_8): detachable ANY
		do
			if attached cached_values as tb then
				Result := tb.item (k)
			end
		end

	add_cached_value (k: READABLE_STRING_8; v: detachable ANY)
		local
			tb: like cached_values
		do
			tb := cached_values
			if tb = Void then
				create tb.make (1)
				cached_values := tb
			end
			tb.force (v, k)
		end

	remove_cached_value (k: READABLE_STRING_8; v: detachable ANY)
		do
			if attached cached_values as tb then
				tb.remove (k)
			end
		end

feature {NONE} -- Implementation: cached values

	cached_values: detachable HASH_TABLE [detachable ANY, READABLE_STRING_8]

feature -- Reports	

	has_error: BOOLEAN
		do
			Result := attached errors as err and then not err.is_empty
		end

	errors: detachable ARRAYED_LIST [TUPLE [field: detachable WSF_FORM_FIELD; message: detachable READABLE_STRING_8]]

invariant

end
