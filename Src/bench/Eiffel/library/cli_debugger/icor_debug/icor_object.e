indexing
	description: "Represents abstraction of ICorDebug.. classes"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_OBJECT

inherit
	COM_OBJECT
		export 
			{NONE} all;
			{ICOR_EXPORTER} item, last_call_success, add_ref, default_pointer
		redefine
			make_by_pointer,
			out
		end
		
	ICOR_EXPORTER
		export
			{NONE} all
		redefine
			out
		end
	
feature {ICOR_EXPORTER} -- Initialisation

	make_by_pointer (an_item: POINTER) is
			-- Make Current by pointer.
		do
			Precursor (an_item)
			debug ("debugger_icor_data")
				init_icor
			end
		end
		
	init_icor is
			-- Initialize special field
			-- to be redefined
		do
		end

feature -- Equality

	is_equal_as_icor_object (other: like Current): BOOLEAN is
			-- Comparison of pointer
		require
			other_not_void: other /= void			
		do
			Result := item.is_equal (other.item)
		ensure
			symmetric: Result implies other.is_equal_as_icor_object (Current)
			consistent: is_equal_as_icor_object (other) implies Result		
		end

feature {ICOR_EXPORTER} -- Access

	check_last_call_succeed: BOOLEAN is
			-- Check last call
		do
			Result := last_call_success = 0
			debug
				if not Result then
					io.put_string ("[!] LastCallSuccess ERROR [" +last_error_code_id+ "]%N")
				end
			end
		end	
		
	out: STRING is
			-- 
		do
			Result := generating_type + "[0x"+item.out+"]"
		end

feature -- Access status		

	last_call_succeed: BOOLEAN is
			-- Is last call a success ?
		do
			Result := last_call_success = 0 
				or last_call_success = 1 -- S_OK or S_FALSE
				--| HRESULT .. < 0 if error ...
		end

	last_error_code_id: STRING is
			-- Convert `last_call_success' to hex and keep the last word
		do
			Result := last_call_success.to_hex_string
			Result.keep_tail (4)
		end

feature {NONE} -- Implementation

	sizeof_WCHAR: INTEGER is
			-- Number of bytes in a value of type `WCHAR'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(WCHAR)"
		end
		
	sizeof_CORDB_ADDRESS: INTEGER is
			-- Number of bytes in a value of type `CORDB_ADDRESS'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(CORDB_ADDRESS)"
		end

end -- class ICOR_OBJECT
	
