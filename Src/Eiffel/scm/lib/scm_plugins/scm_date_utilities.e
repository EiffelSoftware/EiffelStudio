note
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_DATE_UTILITIES

feature -- Access

	date_values (s: STRING_32): detachable TUPLE [year,month,day: INTEGER; hour,min,sec: INTEGER; fsec: REAL_64]
			-- "2010-11-30T23:33:40.105460Z" -> UTC
		local
			y, m,d: INTEGER
			h,mn,sec: INTEGER
			fsec: REAL_64
			p: INTEGER
		do
			if s.count >= 10 then
				y := s.substring (1, 4).to_integer
				m := s.substring (6, 7).to_integer
				d := s.substring (9, 10).to_integer
				if s.count >= 19 then
					h   := s.substring (12, 13).to_integer
					mn  := s.substring (15, 16).to_integer
					sec := s.substring (18, 19).to_integer
					if s.count >= 21 and then s.item (20) = '.' then
						p := s.index_of ('Z', 21)
						if p > 21 then
							fsec := s.substring (20, p-1).to_double
						end
					end
				end
				Result := [y,m,d, h,mn,sec, fsec]
			end
		end

note
	copyright: "Copyright (c) 2003-2020, Jocelyn Fiat, Alexander Kogtenkov"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
