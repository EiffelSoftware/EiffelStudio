JSON serialization library

## WARNING
	- the default reflection serializer is requiring to have recursively expanded object (i.e no cycle in references).
	- the default reflection deserializer does not support array and table, unless a specific deserializer is provided.

## Simple out of the box serialization:

```eiffel
	local
		json: JSON_SERIALIZATION
		obj: like new_object
		txt: STRING
	do
		obj := new_object
			-- We want indented pretty JSON string as output
		json.set_pretty_printing 
		txt := json.to_json_string (obj)
		print (txt)
	end
```

## Advanced solution using specific serializer:

```eiffel
	local
		json: JSON_SERIALIZATION
		obj: like new_object
		txt: STRING
	do
		obj := new_object
			-- We want indented pretty JSON string as output
		json.set_pretty_printing 
		json.register (create {TEAM_JSON_SERIALIZATION}, {TEAM})
		txt := json.to_json_string (obj)
		print (txt)
	end
```

with code:

```eiffel
class
	TEAM_JSON_SERIALIZATION

inherit
	JSON_SERIALIZER
	JSON_DESERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
		do
			if attached {TEAM} obj as grp then
				create j_object.make_with_capacity (2)
				j_object.put_string (grp.name, "name")
				if attached grp.persons as lst then
					create j_array.make (lst.count)
					across
						lst as ic
					loop
						if ctx /= Void and then attached ctx.serializer (ic.item) as conv then
							j_value := conv.to_json (ic.item, ctx)
							j_array.extend (j_value)
						else
							check type_serializable: False end
							j_array.extend (create {JSON_NULL})
						end
					end
					j_object.put (j_array, "persons")
				end
				Result := j_object
			else
				create {JSON_NULL} Result
			end
		end

	from_json (a_json: detachable JSON_VALUE; ctx: detachable JSON_DESERIALIZER_CONTEXT): detachable TEAM
		do
			if attached {JSON_OBJECT} a_json as j_team then
				if attached {JSON_STRING} j_team.item ("name") as j_name then
					create Result.make (j_name.unescaped_string_32)
					if attached {JSON_ARRAY} j_team.item ("persons") as j_items then
						if ctx /= Void and then attached ctx.deserializer ({PERSON}) as conv then
							across
								j_persons as ic
							loop
								if attached {PERSON} conv.from_json (ic.item, ctx) as l_person then
									Result.persons.put (l_person)
								end
							end
						end
					end
				end
			end
		end		

end

class TEAM
create 
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
			create persons.make (0)
		end

feature -- Access 

	name: IMMUTABLE_STRING_32

	persons: ARRAYED_LIST [PERSON]

end
```

Thus for any instance of `{TEAM}`, the serialization and deserialization will use the {TEAM_JSON_SERIALIZATION} implementation.



