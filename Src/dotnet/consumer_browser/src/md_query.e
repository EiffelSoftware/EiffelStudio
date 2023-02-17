note
	description: "Summary description for {MD_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_QUERY

feature -- Mode

	is_full_mode: BOOLEAN

feature -- Filter

	assembly: detachable READABLE_STRING_GENERAL assign set_assembly

	type: detachable READABLE_STRING_GENERAL assign set_type

	entity: detachable READABLE_STRING_GENERAL assign set_entity


feature -- Status report

	has_assembly_filter: BOOLEAN
		do
			Result := assembly /= Void
		end

	has_type_filter: BOOLEAN
		do
			Result := type /= Void
		end

	has_entity_filter: BOOLEAN
		do
			Result := entity /= Void
		end

feature -- Query

	matching (a_pattern, a_text: READABLE_STRING_GENERAL): BOOLEAN
		local
			kmp: KMP_WILD
		do
			if a_pattern.has ('*') then
				create kmp.make (a_pattern, a_text)
				Result := kmp.pattern_matches
			else
				Result := a_text.same_string (a_pattern)
			end
		end

	assembly_name_included (n: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached assembly as f then
				Result := matching (f, n)
			else
				Result := True
			end
		end

	assembly_included (ass: CONSUMED_ASSEMBLY): BOOLEAN
		do
			Result := assembly_name_included (ass.name)
		end

	type_name_included (n: READABLE_STRING_GENERAL): BOOLEAN
		local
			kmp: KMP_WILD
		do
			if attached type as f then
				Result := matching (f, n)
			else
				Result := True
			end
		end

	type_included (t: CONSUMED_TYPE): BOOLEAN
		do
			Result := type_name_included (t.dotnet_name)
		end

	entity_name_included (n: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached entity as f then
				Result := matching (f, n)
			else
				Result := True
			end
		end

	entity_included (e: CONSUMED_ENTITY): BOOLEAN
		do
			Result := entity_name_included (e.dotnet_name)
		end

feature -- Change

	enable_full_mode
		do
			is_full_mode := True
		end

	set_assembly (a: like assembly)
		do
			assembly := a
		end

	set_type (t: like type)
		do
			type := t
		end

	set_entity (e: like entity)
		do
			entity := e
		end

end
