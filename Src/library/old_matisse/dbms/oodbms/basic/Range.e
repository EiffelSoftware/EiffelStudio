indexing
	description:"Models a range. Any range with two limits, and any %
		    %combination  of inclusion  of  the  limit values, as well %
		    %as the sense of the range (within or  without)  can  be %
		    %modelled.  Single-sided  ranges  are modelled by setting %
		    %one limit to the infinity value."
	version:    "%%I%%"
	date:       "%%D%%"
	source:     "%%P%%"
	keywords:   "range"
	copyright:   "See notice at end of class"

class RANGE[G->COMPARABLE]

creation
	make

feature -- Initialisation
	make(n,m:G) is
		require
			Limits_valid: n /= Void and m /= Void and then n <= m
		do
			lower := n
			upper := m
		end

feature -- Access    
	lower:G
		-- lower limit of the range.  Single-sided ranges are modelled
		-- by setting upper to +ve infinity value 

	upper:G
		-- upper limit of the range.  Single-sided ranges are modelled
		-- by setting lower limit to -ve infinity value 

feature -- Status
	lower_is_infinite:BOOLEAN
		-- is lower limit value -infinity?

	upper_is_infinite:BOOLEAN
		-- is upper limit value +infinity?

	include_lower: BOOLEAN
		-- Indicates whether the range limit values themselves
		-- are included.  Models the difference between "<" and "<=".  

	include_upper: BOOLEAN
		-- Indicates whether the range limit values themselves
		-- are included.  Models the difference between ">" and ">=".

	is_inside: BOOLEAN
		-- Indicates whether the range is inside or outside the limits

feature -- Comparison
	is_in_range(v:G):BOOLEAN is
			-- True if v is in the range as defined
		local
			lt_upper, eq_upper, gt_lower, eq_lower:BOOLEAN
		do
			gt_lower := lower_is_infinite or v > lower
			eq_lower := not lower_is_infinite and v = lower

			lt_upper := upper_is_infinite or v < upper
			eq_upper := not upper_is_infinite and v = upper

			Result := (gt_lower or include_lower and eq_lower) and
				  (lt_upper or include_upper and eq_upper)

		        if not is_inside then
		        	Result := not Result
			end
		end

feature -- Modification
	set_lower(n:G) is
		require
			Lower_valid: n /= Void and then n <= upper
		do
			lower := n
			lower_is_infinite := False
		end

	set_lower_infinite is
		do
			lower_is_infinite := True
			include_lower := False
		end

	set_upper(m:G) is
		require
			Upper_valid: m /= Void and then m >= lower
		do
			upper := m
			upper_is_infinite := False
		end

	set_upper_infinite is
		do
			upper_is_infinite := True
			include_upper := False
		end

feature -- Status Setting
	set_include_lower is
		do
			include_lower := True
		end

	set_exclude_lower is
		do
			include_lower := False
		end

	set_include_upper is
		do
			include_upper := True
		end

	set_exclude_upper is
		do
			include_upper := False
		end

	set_inside is
		do
			is_inside := True
		end

	set_outside is
		do
			is_inside := False
		end

invariant
	Limits_valid: lower <= upper

end



--         +-------------------------------------------------------+
--         |                                                       |
--         |                 Copyright (c) 1998                    |
--         |             Deep Thought Informatics P/L              |
--         |         Australian Company Number 076 645 291         |
--         |                                                       |
--         | Unauthorised duplication and distribution prohibited  |
--         | Authorised distribution must include this notice      |
--         | intact.                                               |
--         |                                                       |
--         |           email: info@deepthought.com.au              |
--         |                                                       |
--         +-------------------------------------------------------+
