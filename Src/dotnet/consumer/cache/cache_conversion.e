indexing
	description: "Provide conversions from EAC types to .NET types"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_CONVERSION

inherit
	CACHE_ERRORS

feature -- Conversion

	assembly (ca: CONSUMED_ASSEMBLY): ASSEMBLY is
			-- .NET assembly corresponding to `ca'.
		require
			non_void_consumed_assembly: ca /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := feature {ASSEMBLY}.load_string (ca.out.to_cil)
			end
		rescue
			retried := True
			set_error (Assembly_not_found_error, ca.out)
			retry
		end

end -- class CACHE_CONVERSION
