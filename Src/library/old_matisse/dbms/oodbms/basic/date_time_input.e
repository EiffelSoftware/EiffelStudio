indexing
	description:"Abstraction for formatted input."
	version:    "%%I%%"
	date:       "%%D%%"
	source:     "%%P%%"
	keywords:   "range"
	copyright:   "See notice at end of class"

class DATE_TIME_INPUT

inherit
	INPUT[DATE_TIME]

feature -- Initialisation
	set_from_canonical(s:STRING) is
			   -- initialise from a canonical string of form
			   -- "dd/mm/yyyy hh:mm:ss.sss". Note there may be any
			   -- number of decimal places at the end (including none).
			   -- Time part is 24 hour time. The day and month part may
			   -- have single digit entries (e.g. "1/1/1997").
		do
		end

	set_from_sybase(s:STRING) is
			   -- initialise from a standard SYBASE datetime string;
			   -- SYBASE format is: "Jun 24 1997 12:00AM". Does nothing
			   -- if string unparseable
		require
			   Args_valid: s /= Void and then not s.empty
		local
			   str:STRING	
		do
			   str := sybase_to_canonical(s)
			   if str /= Void then
				   set_from_canonical(str)
			   end
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
	
			 t := s.substring(pos3+1,s.count)
			 pos1 := t.index_of(Std_time_delim,1) 
			 pos2 := t.index_of(Std_time_delim,pos1+1) 
			 pos3 := t.count+1

			 if not tt.valid_time(t.substring(1,pos1-1).to_integer, 
							t.substring(pos1+1,pos2-1).to_integer, 
							t.substring(pos2+1,pos3-1).to_real) 
			 then
			      Result := False
			 end
	       end

feature -- Access
        Canonical_date_delim:CHARACTER is '/'
		        -- form is "dd/mm/yyyy"

        Canonical_time_delim:CHARACTER is ':'
		        -- form is "hh:mm:ss.sss"

        Canonical_date_time_delim:CHARACTER is ' '
		        -- appears between "dd/mm/yyyy" and "hh:mm:ss.sss"

        Sybase_tokens:INTEGER is 4

        Sybase_date_time_delim:CHARACTER is ' '

feature -- Conversion
	sybase_to_canonical(s:STRING):STRING is
			-- convert a standard SYBASE datetime string to the
			-- "standard" form of this library. SYBASE format is:
			-- "Jun 24 1997 12:00AM". Return Void if error in parsing.
		local
			tmp_str:STRING
			pos:INTEGER
			tokens:STRING_EX
			dt, mon, yr, hr, min :INTEGER
			sec :REAL
		do
			!!tokens.make(0)
			tokens.make_from_string(s)
			tokens.set_delimiter(Sybase_date_time_delim)

			if tokens.token_count = Sybase_tokens then

				-- 3-char month field
				tokens.token_start
				mon := tt.short_month_number(tokens.token_item)

				-- 2-digit date field
				tokens.token_forth
				dt := tokens.token_item.to_integer

				-- 4-digit year field
				tokens.token_forth
				yr := tokens.token_item.to_integer

				-- time field
				tokens.token_forth
				tmp_str := tokens.token_item
				pos := tmp_str.index_of(':', 1)
				hr := tmp_str.substring(1, pos-1).to_integer
				min := tmp_str.substring(pos+1, pos+2).to_integer
				sec := 0.0
				if tmp_str.substring(pos+3, pos+4).is_equal("PM") then
				    hr := hr + tt.hours_in_half_day
				end

				if tt.valid_date(yr, mon, dt) and tt.valid_time(hr, min, sec) then
					!!Result.make(0)
					Result.append_integer(dt)
					Result.append_character(Std_date_delim)
					Result.append_integer(mon)
					Result.append_character(Std_date_delim)
					Result.append_integer(yr)

					Result.append_character(Std_date_time_delim)

					Result.append_integer(hr)
					Result.append_character(Std_time_delim)
					Result.append_integer(min)
					Result.append_character(Std_time_delim)
					Result.append_real(sec)
				end
		    end
	  end
end
