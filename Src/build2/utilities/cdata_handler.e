indexing
	description: "Objects that handle CDATA tags in XML."
	date: "$Date$"
	revision: "$Revision$"

class
	CDATA_HANDLER
	
inherit
	STRING_HANDLER

feature -- Access

	has_cdata (a_string: STRING): BOOLEAN is
			-- Does `a_string' contain enclosing CDATA tags?
		require
			string_not_void: a_string /= Void
		do
			if a_string.substring_index (cdata_opening, 1) = 1 then
				Result := True
			end	
		end
		
feature -- Conversion

	strip_cdata_strict (a_string: STRING): STRING is
			-- `Result' is a copy of `a_string' with CDATA tags removed.
		require
			string_not_void: a_string /= Void
			has_cdata: has_cdata (a_string)
		do
			Result := a_string.substring (cdata_opening.count + 1, a_string.count - cdata_closing.count)
		ensure
			not has_cdata (Result)
			new_count_correct: Result.count = old a_string.count - cdata_opening.count - cdata_closing.count
		end
		
	strip_cdata (a_string: STRING): STRING is
			-- If CDATA is present in `a_string' then `Result' is
			-- a copy of `a_string' with CDATA tags removed.
			-- Otherwise, `Result' is a cpoy of the original STRING.
		require
			string_not_void: a_string /= Void
		do
			if has_cdata (a_string) then
				Result := strip_cdata_strict (a_string)
			else
				create Result.make (1)
				Result := Result.clone (a_string)
			end
		ensure
			not has_cdata (Result)
		end
		
	enclose_in_cdata (a_string: STRING): STRING is
			-- `Result' is copy of `a_string' with CDATA tags enclosing.
		require
			string_not_void: a_string /= Void
			not_has_cdata: not has_cdata (a_string)
		do
			Result := cdata_opening + a_string + cdata_closing
		ensure
			has_cdata (Result)
		end

feature {NONE} -- Implementation

	cdata_opening: STRING is "<![CDATA["
	
	cdata_closing: STRING is "]]>"
	
invariant
	operations_consistent: strip_cdata (enclose_in_cdata ("<A!@#B$^&C*()D>E")).is_equal ("<A!@#B$^&C*()D>E") 

end -- class CDATA_HANDLER
