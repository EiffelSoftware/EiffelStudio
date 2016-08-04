note
	description: "Summary description for {TEAM_JSON_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEAM_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object, j_dico: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			i: INTEGER
		do
			if attached {TEAM} obj as grp then
				create j_object.make_with_capacity (2)
					-- "name"
				j_object.put_string (grp.name, "name")

					-- "owner"
				if attached grp.owner as p then
					ctx.on_field_start ("owner")
					j_value := ctx.to_json (p, Current)
					if j_value /= Void then
						j_object.put (j_value, "owner")
					else
						check type_serializable: False end
					end
					ctx.on_field_end ("owner")
				end

					-- "persons"
				if attached grp.persons as lst then
					ctx.on_field_start ("persons")
					create j_array.make (lst.count)
					across
						lst as ic
					loop
						j_value := ctx.to_json (ic.item, Current)
						if j_value = Void then
							check type_serializable: False end
							create {JSON_NULL} j_value
						end
						j_array.extend (j_value)
					end
					j_object.put (j_array, "persons")
					ctx.on_field_end ("persons")
				end

					-- "vectors"
				create j_array.make (grp.vectors.count)
				ctx.on_field_start ("vectors")
				i := 1
				across
					grp.vectors as ic
				loop
					ctx.on_field_start (i.out)
					j_value := ctx.to_json (ic.item, Current)
					if j_value = Void then
						check type_serializable: False end
						create {JSON_NULL} j_value
					end
					j_array.extend (j_value)
					ctx.on_field_end (i.out)
					i := i + 1
				end
				ctx.on_field_end ("vectors")
				j_object.put (j_array, "vectors")

					-- "dico"
				create j_dico.make_with_capacity (grp.dico.count)
				ctx.on_field_start ("dico")
				i := 1
				across
					grp.dico as ic
				loop
					ctx.on_field_start (ic.key)
					j_value := ctx.to_json (ic.item, Current)
					if j_value = Void then
						check type_serializable: False end
						create {JSON_NULL} j_value
					end
					j_dico.put (j_value, ic.key)
					ctx.on_field_end (ic.key)
					i := i + 1
				end
				ctx.on_field_end ("dico")
				j_object.put (j_dico, "dico")

				Result := j_object
			else
				create {JSON_NULL} Result
			end
		end

end
