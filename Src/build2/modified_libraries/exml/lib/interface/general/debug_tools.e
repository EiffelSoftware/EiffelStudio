expanded class
   DEBUG_TOOLS
feature
   escape (str: STRING): STRING is
	 -- Prints a string with some characters converted 
	 -- to escape sequences similar to their Eiffel string escapge sequences.
	 -- This feature makes it easy to find, count and distinguish 
	 -- all kind of white spaces.
	 -- TODO: Add complete conversion table
      local
	 i : INTEGER
      do
	 from
	    i := 1
	    !! Result.make (0)
	 until
	    i > str.count
	 loop
	    
	    inspect
	       str.item (i)
	    when ' ' then
	       Result.append_string ("%%s")
	    when '%N' then
	       Result.append_string ("%%N")
	    when '%T' then
	       Result.append_string ("%%T")
	    else
	       Result.append_character (str.item (i))
	    i := i + 1
	    end
	 end
      end
end

   
