note
	description: "Context for JSON serialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZER_CONTEXT

inherit
	JSON_SERIALIZATION_CONTEXT_I
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create serializers.make (1)
			create serializer_location.make_empty
			is_type_name_included := True
		end

feature -- Settings / output

	is_pretty_printing: BOOLEAN
			-- Generate pretty JSON string (indented...)?

	is_compact_printing: BOOLEAN
		do
			Result := not is_pretty_printing
		end

feature -- Settings / behavior		

	is_type_name_included: BOOLEAN assign set_is_type_name_included
			-- Is JSON output includes type name when possible?
			-- Default: True

feature -- Status

	is_accepted_object (obj: detachable ANY): BOOLEAN
			-- Is `obj' accepted for serialization?
			-- ie: when cycle are forbidden, it should be recursively expanded.
		do
			Result := is_recursively_expanded (obj)
		end

	is_recursively_expanded (obj: detachable ANY): BOOLEAN
			-- Is `obj' recursively expanded?
			-- (i.e without any cycle).
		local
			lst: ARRAYED_LIST [ANY]
		do
			if obj = Void then
				Result := True
			else
				create lst.make (1)
				lst.compare_references
				lst.force (obj)
				Result := is_recursively_expanded_in_context (obj, lst)
			end
		end

	is_recursively_expanded_in_context (obj: ANY; ctx: LIST [ANY]): BOOLEAN
		local
			refl_obj: REFLECTED_REFERENCE_OBJECT
			i, l_field_count: INTEGER
			l_field_type: INTEGER
			l_field_ref: detachable ANY
		do
			Result := True
			create refl_obj.make (obj)
			l_field_count := refl_obj.field_count
			from
				i := 1
			until
				i > l_field_count or not Result
			loop
				l_field_type := refl_obj.field_type (i)
				if l_field_type = refl_obj.reference_type then
					l_field_ref := refl_obj.reference_field (i)
					if l_field_ref /= Void then
						if ctx.has (l_field_ref) then
							Result := False
						else
							ctx.force (l_field_ref)
						end
						if obj /= l_field_ref then
							Result := is_recursively_expanded_in_context (l_field_ref, ctx)
						end
					end
				elseif l_field_type = refl_obj.expanded_type then
					if l_field_ref /= Void then
						l_field_ref := refl_obj.expanded_field (i)
						if obj /= l_field_ref then
							Result := is_recursively_expanded_in_context (l_field_ref, ctx)
						end
					end
				end
				i := i + 1
			end
		end

feature -- Settings change

	set_is_type_name_included (b: BOOLEAN)
			-- Set `is_type_name_included' to `b'.
		do
			is_type_name_included := b
		end

	set_pretty_printing
			-- Set JSON generation to use pretty printing (indentation, ...).
		do
			is_pretty_printing := True
		end

	set_compact_printing
			-- Set JSON generation to use compact printing (thus no indentation, ...).
		do
			is_pretty_printing := False
		end

feature -- Cleaning

	reset
			-- Clean any temporary data, to release memory or reset computation.
		do
			serializer_location.wipe_out
			serializers_cache := Void

			across
				serializers as ic
			loop
				ic.item.reset
			end
		end

feature -- Live status		

	serializer_location: STRING_32
			-- String representing the current location in the serialization.
			--| empty string location represents the root location.
			--| using a.b.c  representation corresponding to `{ "a": { "b": { "c": ... } } }'

feature -- Callback events		

	on_field_start (a_field_name: READABLE_STRING_GENERAL)
			-- Event triggered just before processing a reference field `a_field_name' on Current object.
		local
			s: like serializer_location
		do
			s := serializer_location
			if s.count > 0 then
				s.append_character ('.')
			end
			s.append_string_general (a_field_name)
		end

	on_field_end (a_field_name: READABLE_STRING_GENERAL)
			-- Event triggered just after reference field `a_field_name' on Current object was processed.
		local
			s: like serializer_location
		do
			s := serializer_location
			check s.ends_with_general (a_field_name) end
			s.remove_tail (a_field_name.count + 1) -- Include the '.'
		end

	on_object_serialization_start (a_obj: ANY)
			-- Event triggered just before processing object `a_obj'.
		do
		end

	on_object_serialization_end (j_value: JSON_VALUE; a_obj: ANY)
			-- Event triggered just after having object `a_obj' processed with associated `j_value' json value..
			--| `j_value' is either JSON_STRING, JSON_OBJECT or JSON_ARRAY.
		do
		end

feature -- Helpers

	to_json (obj: ANY; a_caller_serializer: detachable JSON_SERIALIZER): detachable JSON_VALUE
			-- JSON value from `obj'.
			-- To avoid infinite recursion, be sure to not reuse the same serializer as `a_caller_serializer'.			
		do
			check is_accepted_object: is_accepted_object (obj) end
			if attached {READABLE_STRING_GENERAL} obj as str and then attached default_serializer as conv then
				Result := conv.to_json (obj, Current)
			elseif attached serializer (obj) as conv then
				if
					a_caller_serializer = conv and then attached {JSON_REFLECTOR_SERIALIZER} a_caller_serializer
				then
						-- Stop cycle!
				else
					Result := conv.to_json (obj, Current)
				end
			elseif attached {READABLE_STRING_GENERAL} obj as str then
				create {JSON_STRING} Result.make_from_string_general (str)
			end
		end

feature -- Access

	default_serializer: like serializer assign set_default_serializer
			-- If set, use this default serializer when no other are available for a specific type.

	serializer (obj: ANY): detachable JSON_SERIALIZER
			-- Serializer register for type of `obj'.
		local
			o_type, k_type: TYPE [detachable ANY]
			tb: like serializers_cache
			l_serializer: detachable JSON_SERIALIZER
			dft: like default_serializer
		do
				-- FIXME: for now, we search for exact mapping, but we should also look for conforming serializer.
			if obj /= Void then
				o_type := obj.generating_type

				tb := serializers_cache
				if tb /= Void then
					Result := tb.item (o_type)
				end

				across
					serializers as ic
				until
					Result /= Void
				loop
					Result := ic.item
					k_type := ic.key
					if o_type ~ k_type then
							-- Found
					elseif attached k_type.attempted (obj) then
						if attached o_type.generating_type.attempted (k_type) then
							-- Hack: use conformance of type, and reverse conformance of type of type.
							-- Found
						else
							if l_serializer = Void then
								l_serializer := Result
							elseif Result.conforms_to (l_serializer) then
									-- Keep previous `l_serializer'.
							end
							Result := Void
						end
					else
						Result := Void
					end
				end
				if Result = Void then
					Result := l_serializer
					dft := default_serializer
					if Result = Void and then dft /= Void then
						Result := dft
					end
				end
				if Result /= Void then
					if tb = Void then
						create tb.make (1)
						serializers_cache := tb
					end
					tb.force (Result, o_type)
				end
			end
		end

feature -- Element change

	register_serializer (a_conf: attached like serializer; a_type: TYPE [detachable ANY])
		do
			serializers.force (a_conf, a_type)
		end

	set_default_serializer (conv: like default_serializer)
		do
			default_serializer := conv
		end

feature {NONE} -- Implementation

	serializers: HASH_TABLE [JSON_SERIALIZER, TYPE [detachable ANY]]

	serializers_cache: detachable HASH_TABLE [JSON_SERIALIZER, TYPE [detachable ANY]]

;note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
