indexing
	description: "Literal fields as seen in Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_LITERAL_FIELD

inherit
	CONSUMED_FIELD
		rename
			make as field_make
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; rt: CONSUMED_REFERENCED_TYPE; static, pub: BOOLEAN; val: SYSTEM_OBJECT) is
			-- Initialize field.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_return_type: return_type /= Void
			non_void_value: val /= Void
		local
			d: DOUBLE
			r: REAL
			a: NATIVE_ARRAY [INTEGER_8]
		do
			if val.get_type.equals (Double_type) then
				d ?= val
				check
					is_double: d /= Void
				end
				value := bytes_to_string (feature {BIT_CONVERTER}.get_bytes_double (d))
			elseif val.get_type.equals (Real_type) then
				r ?= val
				check
					is_real: r /= Void
				end
				value := bytes_to_string (feature {BIT_CONVERTER}.get_bytes_single (r))
			else
				create value.make_from_cil (val.to_string)
			end
			field_make (en, dn, rt, static, pub)
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			return_type_set: return_type = rt
			is_static_set: is_static = static
			is_public_set: is_public = pub
		end

feature -- Access

	value: STRING
			-- Literal value

feature {NONE} -- Implementation

	bytes_to_string (a: NATIVE_ARRAY [INTEGER_8]): STRING is
			-- Convert `a' into a string.
		require
			non_void_array: a /= Void
		local
			i: INTEGER
		do
			create Result.make (a.get_length * 3)
			from
			until
				i >= a.get_length
			loop
				Result.append (a.item (i).out)
				i := i + 1
			end
		ensure
			converted: Result /= Void and then not Result.is_empty
		end
		
	Double_type: TYPE is
			-- typeof (double)
		once
			Result := feature {TYPE}.get_type_string (("System.Double").to_cil)
		end
		
	Real_type: TYPE is
			-- typeof (float)
		once
			Result := feature {TYPE}.get_type_string (("System.Float").to_cil)
		end
		
end -- class CONSUMED_LITERAL_FIELD
