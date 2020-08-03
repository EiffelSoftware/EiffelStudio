note
	description: "Summary description for {STRIPE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_OBJECT

feature {NONE} -- Initialization

	make_empty
		do
			make_with_json (create {JSON_OBJECT}.make_empty)
		end

	make_with_json (j: like json)
		do
			set_id ("")
			json := j
			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				in_livemode := boolean_item (j, "livemode", False)
			end
		end

feature -- Access

	id: IMMUTABLE_STRING_8

	in_livemode: BOOLEAN
			-- Has the value true if the object exists in live mode
			-- or the value false if the object exists in test mode.

feature -- Status

	has_id: BOOLEAN
		do
			Result := not id.is_whitespace
		end

feature -- Element change

	set_id (a_id: READABLE_STRING_8)
		do
			create id.make_from_string (a_id)
		end

feature {NONE} -- Implementation

	boolean_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL; dft: BOOLEAN): BOOLEAN
		do
			if attached {JSON_BOOLEAN} (j @ k) as jb then
				Result := jb.item
			else
				Result := dft
			end
		end

	integer_32_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): INTEGER_32
		do
			Result := integer_64_item (j, k).to_integer_32
		end

	integer_64_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): INTEGER_64
		do
			if attached {JSON_NUMBER} (j @ k) as jnum then
				Result := jnum.integer_64_item
			elseif
				attached {JSON_STRING} (j @ k) as js and then
				js.item.is_integer_64
			then
				Result := js.item.to_integer_64
			end
		end

	natural_32_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): NATURAL_32
		do
			Result := natural_64_item (j, k).to_natural_32
		end

	natural_64_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): NATURAL_64
		do
			if attached {JSON_NUMBER} (j @ k) as jnum then
				Result := jnum.natural_64_item
			elseif
				attached {JSON_STRING} (j @ k) as js and then
				js.item.is_natural_64
			then
				Result := js.item.to_natural_64
			end
		end

	string_8_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): detachable STRING_8
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_8
			end
		end

	string_32_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): detachable STRING_32
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_32
			end
		end

	safe_string_8_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL; dft: READABLE_STRING_8): READABLE_STRING_8
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_8
			else
				Result := dft
			end
		end

	safe_string_32_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL; dft: READABLE_STRING_32): READABLE_STRING_32
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_32
			else
				Result := dft
			end
		end

	table_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): detachable STRING_TABLE [detachable ANY]
		local
			v: detachable ANY
		do
			if attached {JSON_OBJECT} (j @ k) as jo then
				create Result.make_caseless (jo.count)
				across
					jo as ic
				loop
					v := Void
					if attached {JSON_STRING} ic.item as js then
						v := js.unescaped_string_32
					elseif attached {JSON_NUMBER} ic.item as jnum then
						if jnum.is_natural then
							v := jnum.natural_64_item
						elseif jnum.is_integer then
							v := jnum.integer_64_item
						end
					elseif attached {JSON_BOOLEAN} ic.item as jb then
						v := jb.item
					end
					Result [ic.key.unescaped_string_32] := v
				end
			end
		end

	list_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [detachable ANY]
		local
			v: detachable ANY
		do
			if attached {JSON_ARRAY} (j @ k) as jarr then
				create Result.make (jarr.count)
				across
					jarr as ic
				loop
					v := Void
					if attached {JSON_STRING} ic.item as js then
						v := js.unescaped_string_32
					elseif attached {JSON_NUMBER} ic.item as jnum then
						if jnum.is_natural then
							v := jnum.natural_64_item
						elseif jnum.is_integer then
							v := jnum.integer_64_item
						end
					elseif attached {JSON_BOOLEAN} ic.item as jb then
						v := jb.item
					end
					Result.force (v)
				end
			end
		end

	json: JSON_OBJECT

	put_string (v: READABLE_STRING_GENERAL; k: READABLE_STRING_GENERAL)
		do
			json.put_string (v, k)
		end

feature -- Conversion

	to_string: STRING
		local
			jp: JSON_PRETTY_STRING_VISITOR
		do
			create Result.make (1_000)
			create jp.make (Result)
			jp.visit_json_object (json)
		end

end
