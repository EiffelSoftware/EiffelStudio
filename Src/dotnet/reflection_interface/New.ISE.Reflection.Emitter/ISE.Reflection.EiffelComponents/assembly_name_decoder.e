indexing
	description: "Provides useful transformations."
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	ASSEMBLY_NAME_DECODER

feature -- Access

	assembly_info_from_name (an_assembly_name: ASSEMBLY_NAME): ARRAY [STRING] is 
		indexing
			description: "Assembly info [name, version, culture, public key] corresponding to `an_assembly_name'"
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
			create Result.make (0, 3)
			if not retried then
				create a_name.make_from_cil(an_assembly_name.get_name)
				create a_version.make_from_cil(an_assembly_name.get_version.to_string)
				create a_culture.make_from_cil(an_assembly_name.get_culture_info.get_name)
				if a_culture /= Void and then a_culture.count = 0 then
					a_culture := Neutral_culture
				end
				if an_assembly_name.get_public_key_token /= Void then
					a_public_key := decode_key (an_assembly_name.get_public_key_token)	
				else
					a_public_key := Void
				end
				Result.put (a_name, 0)
				Result.put (a_version, 1)
				Result.put (a_culture, 2)
				Result.put (a_public_key, 3)
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
		end

	Neutral_culture: STRING is "neutral"
		indexing
			description: "Neutral culture as a string"
		end
		
feature {NONE} -- Implementation

	decode_key (a_key: NATIVE_ARRAY [INTEGER_8]): STRING is
		indexing
			description: "Printable representation of `a_key'"
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			hex_rep: STRING
			x_string: STRING
		do
			x_string := "X";
			Result := Empty_string
			from
				i := 0
			until
				i >= a_key.count
			loop
				create hex_rep.make_from_cil(a_key.item (i).to_string_string2 (x_string.to_cil).to_lower)
				if hex_rep.count < 2 then
					hex_rep.prepend ("0")
					--hex_rep.append (hex_rep)
				end
				Result.append(hex_rep)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class ASSEMBLY_NAME_DECODER
