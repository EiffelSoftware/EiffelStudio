indexing
    description: "This is a copy of STRING_EX from ISE.  Token-handling version of STRING. NOTE: cannot have empty fields."
	legal: "See notice at end of class."
	status: "See notice at end of class."
    keywords:	""
    revision:	"%%A%%"
    source:	        "%%P%%"
    requirements: ""

class STRING_TOKEN

   inherit
	STRING
		rename
			make as string_make
		end

   create
	make

   feature -- Initialisation
	make( n:INTEGER ) is
		do
			string_make(n)
			delimiter := ','
		end

	set_delimiter( a_delimiter: CHARACTER ) is
		do
			delimiter := a_delimiter
		end		

   feature -- Iteration
	token_start is
	    require
		Not_empty: count > 0
	    do
	    	from idx1 := 1 until item(idx1) /= ' ' loop idx1 := idx1+1 end
		idx2 :=  index_of(delimiter,idx1) - 1
		if idx2 < 0 then
			idx2 := count
		end
	end

	token_forth is
		require
			Not_off: not token_off
		do 
			idx1 := idx2+ 2
			from  until token_off or else item(idx1) /= ' ' loop idx1 := idx1+1 end
			if not token_off then
				idx2 :=  index_of(delimiter,idx1) - 1
     				if idx2 < 0  then 
					idx2 := count
				end
			end
		end

	token_off : BOOLEAN is
		do 
			Result := 	idx1 > count
		end

	token_item : STRING is
		require
			Not_off: not token_off
		do
			if idx2 >= idx1 then
				create Result .make(0)
				Result.make_from_string(substring(idx1,idx2))
			else
				Result := clone( "" )
			end
		end

	token_count : INTEGER is
	        -- return the number of tokens found
		do 
			Result := occurrences(delimiter) + 1
		end

   feature -- Status setting
	use_whitespace_parsing is
	        -- set up string so that any whitespace (TABs, SPCs) will be treated
	        -- as a single delimiter between tokens not containing whitespace chars
	    require
	        Not_empty: count > 0
	    local
	        change_pos :INTEGER
	        one_tab, two_tabs, one_space: like Current
	    do
	        create one_tab.make(0) one_tab.make_from_string("%T")
	        create two_tabs.make(0) two_tabs.append(one_tab) two_tabs.append(one_tab)
	        create one_space.make(0) one_space.make_from_string(" ")

	        -- remove leading and trailing white space
  	        left_adjust 
  	        right_adjust 

	        -- convert SPACEs to TABs
	        replace_substring_all(one_space, one_tab)

	        -- convert all occurrences of multiple TAB to one TAB only
		from
		    change_pos := substring_index (two_tabs, 1)
		until
		    change_pos = 0
		loop
		    replace_substring (one_tab, change_pos, change_pos + 1)
		    if change_pos < count then
			change_pos := substring_index (two_tabs, change_pos)
		    else
			change_pos := 0
		    end
		end

	        delimiter := '%T'
	    end

   feature {NONE} -- 
	delimiter: CHARACTER
	idx1, idx2 : INTEGER;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

