indexing
	description:"Abstraction for formatted input."
	version:    "%%I%%"
	date:       "%%D%%"
	source:     "%%P%%"
	keywords:   "range"
	copyright:   "See notice at end of class"

class DATE_INPUT

inherit
	INPUT[DATE]

feature -- Initialisation
	set_from_canonical(s:STRING) is
			   -- initialise from a canonical string of form
			   -- "dd/mm/yyyy". Note there may be any
			   -- number of decimal places at the end (including none).
			   -- Time part is 24 hour time. The day and month part may
			   -- have single digit entries (e.g. "1/1/1997").
		do
		end

feature -- Validation
 	is_canonical(s:STRING):BOOLEAN is
		require
			 Args_valid: s /= Void and then not s.empty
		local
			 t:STRING
			 dt,mon,yr,hr,min:INTEGER
			 sec:REAL
			 pos1, pos2, pos3:INTEGER
		do
			 Result := True

			 pos1 := s.index_of(Std_date_delim,1) 
			 pos2 := s.index_of(Std_date_delim,pos1+1) 
			 pos3 := s.index_of(Std_date_time_delim,1)

			 if not tt.valid_date(s.substring(pos2+1,pos3-1).to_integer,
							s.substring(pos1+1,pos2-1).to_integer, 
							s.substring(1,pos1-1).to_integer) 
			 then
			      Result := False
			 end
	        end

feature -- Access
        Canonical_date_delim:CHARACTER is '/'
		        -- form is "dd/mm/yyyy"

end
