indexing
	description: "Provides useful transformations."
	external_name: "ISE.Reflection.Convert"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	CONVERT

feature -- Access

	assembly_info_from_name (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ARRAY [STRING] is 
		indexing
			description: "Assembly info [name, version, culture, public key] corresponding to `an_assembly_name'"
			external_name: "AssemblyInfoFromName"
		require
			non_void_assembly: an_assembly_name /= Void
			non_void_assembly_name: an_assembly_name.get_name /= Void
			non_void_assembly_version: an_assembly_name.get_version /= Void
		local
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			retried: BOOLEAN
		do
			create Result.make (4)
			if not retried then
				a_name := an_assembly_name.get_name
				a_version := an_assembly_name.get_version.to_string
				a_culture := an_assembly_name.get_culture_info.get_name
				if a_culture /= Void and then a_culture.get_length = 0 then
					a_culture := Neutral_culture
				end
				if an_assembly_name.get_public_key_token /= Void then
					a_public_key := decode_key (an_assembly_name.get_public_key_token)	
				else
					a_public_key := Void
				end
				Result.put (0, a_name)
				Result.put (1, a_version)
				Result.put (2, a_culture)
				Result.put (3, a_public_key)
			end
		ensure
			non_void_assembly_info: Result /= Void
			valid_assembly_info: Result.count = 4
		rescue
			retried := True
			retry
		end
	
	Empty_string: STRING is ""
		indexing
			description: "Empty string"
			external_name: "EmptyString"
		end

	Neutral_culture: STRING is "neutral"
		indexing
			description: "Neutral culture as a string"
			external_name: "NeutralCulture"
		end
		
feature {NONE} -- Implementation

	decode_key (a_key: ARRAY [INTEGER_8]): STRING is
		indexing
			description: "Printable representation of `a_key'"
			external_name: "DecodeKey"
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			hex_rep: STRING
		do
			Result := Empty_string
			from
				i := 0
			until
				i >= a_key.count
			loop
				hex_rep := a_key.item (i).to_string_string2 ("X").to_lower
				if hex_rep.get_length < 2 then
					hex_rep := hex_rep.concat_string_string ("0", hex_rep)
				end
				Result := Result.concat_string_string (Result, hex_rep)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class CONVERT
