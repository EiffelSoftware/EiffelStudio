indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMPOSITION_STRING_CONSTANTS

feature -- Constants

	Gcs_compreadstr : INTEGER is 1
	
	Gcs_compreadattr : INTEGER is 2
	
	Gcs_compreadclause : INTEGER is 4
	
	Gcs_compstr : INTEGER is 8

	Gcs_compattr: INTEGER is 16
	
	Gcs_compclause : INTEGER is 32
	
	Gcs_cursorpos : INTEGER is 64 
	
	Gcs_deltastart : INTEGER is 128
	
	Gcs_resultreadstr  : INTEGER is 256 
	
	Gcs_resultreadclause : INTEGER is 512

	Gcs_resultstr : INTEGER is 1024
	
	Gcs_resultclause : INTEGER is 2048
	
	Scs_setstr: INTEGER is 
		once
			Result := Gcs_compreadstr.bit_or (Gcs_compstr)
		end
	
	Scs_changeattr: INTEGER is
		once
				Result := Gcs_compreadattr.bit_or (Gcs_compattr)
		end
		
	Scs_changeclause: INTEGER is
		once
				Result := Gcs_compreadclause.bit_or (Gcs_compclause)
		end
		
	Scs_setreconvertstring: INTEGER is 65536
	
	Scs_queryreconvertstring: INTEGER is 131072


end -- class WEL_COMPOSITION_STRING_CONSTANTS
