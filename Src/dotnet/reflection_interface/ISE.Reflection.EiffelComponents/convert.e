indexing
	description: "Provides useful transformations."
	external_name: "ISE.Reflection.Convert"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	CONVERT

feature -- Access

	assembly_info_from_name (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ARRAY [STRING] is 
			-- Assembly info [name, version, culture, public key] corresponding to `an_assembly_name'
		indexing
			external_name: "AssemblyInfoFromName"
		require
			non_void_assembly_name: an_assembly_name /= Void
		local
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			retried: BOOLEAN
		do
			create Result.make (4)
			if not retried then
				a_name := an_assembly_name.name
				a_version := an_assembly_name.version.tostring
				a_culture := an_assembly_name.cultureinfo.name
				if a_culture /= Void and then a_culture.length = 0 then
					a_culture := Neutral_culture
				end
				a_public_key := decode_key (an_assembly_name.getpublickeytoken)	
				
				Result.put (0, a_name)
				Result.put (1, a_version)
				Result.put (2, a_culture)
				Result.put (3, a_public_key)
			end
		ensure
			non_void_assembly_descriptor: Result /= Void
		rescue
			retried := True
			retry
		end

	Neutral_culture: STRING is "neutral"
			-- Neutral culture as a string
		indexing
			external_name: "NeutralCulture"
		end
		
feature {NONE} -- Implementation

	decode_key (a_key: ARRAY [INTEGER_8]): STRING is
			-- Printable representation of `a_key'.
		indexing
			external_name: "DecodeKey"
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			hex_rep: STRING
		do
			Result := ""
			from
				i := 0
			until
				i >= a_key.count
			loop
				hex_rep := a_key.item (i).tostring_string2 ("X").tolower
				if hex_rep.length < 2 then
					hex_rep := hex_rep.concat_string_string ("0", hex_rep)
				end
				Result := Result.concat_string_string (Result, hex_rep)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class CONVERT
