indexing
	description:"Abstraction for formatted input."
	version:    "%%I%%"
	date:       "%%D%%"
	source:     "%%P%%"
	keywords:   "range"
	copyright:   "See notice at end of class"

class TIME_INPUT

inherit
	INPUT[TIME]

feature -- Initialisation
	set_from_canonical(s:STRING) is
			   -- initialise from a canonical string of form "00:00:00[.000]"
		do
		end

feature -- Validation
 	is_canonical(s:STRING):BOOLEAN is
		require
			 Args_valid: s /= Void and then not s.empty
		local
			 t:STRING
			 hr,min,sec:INTEGER
			 pos1, pos2, pos3:INTEGER
		do
	        end

feature -- Access
        Canonical_time_delim:CHARACTER is ':'
		        -- form is "hh:mm:ss[.sss]"

end
