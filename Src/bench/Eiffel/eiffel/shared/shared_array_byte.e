-- Shared instances of byte code array

class SHARED_ARRAY_BYTE
	
feature {NONE}

	Byte_array: BYTE_ARRAY is
			-- Byte code array
		once
			create Result.make;
		end;

end
