indexing
	description: "Dotnet debug value associated with Basic type"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_BASIC_VALUE [G]

inherit
	DEBUG_VALUE [G]
		rename
			make as dv_make
		redefine
			dump_value
		end
	
	EIFNET_ABSTRACT_DEBUG_VALUE
		redefine
			dump_value
		end
	
create {DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Redefinition of make

	make (a_referenced_value: like icd_referenced_value; a_frame: ICOR_DEBUG_FRAME; v: like value) is
		require
			a_referenced_value_not_void: a_referenced_value /= Void
		do
			icd_referenced_value := a_referenced_value
			icd_frame := a_frame
			dv_make (v)
		end
		
feature -- Access : Redefinition of dump_value
		
	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
			-- (from ABSTRACT_DEBUG_VALUE)
		do
			Result := Precursor {DEBUG_VALUE}
			if Result /= Void then
				Result.set_value_dotnet (icd_referenced_value)
				Result.set_value_frame_dotnet (icd_frame)				
			end
		end		
		
end
