indexing
    description: "Version of SORTED_TWO_WAY_LIST[G] with faster searching,%
        %based on the idea that the next search request will usually be for%
        %an item just after the last."

class FAST_SORTED_TWO_WAY_LIST[G -> COMPARABLE ]

    inherit
	SORTED_TWO_WAY_LIST[G]
	    redefine
	    	search_after, search_before
	    end

    creation
	make

feature -- Access
	search_after (v: like item) is
			-- Go to first position with item greater than or 
			-- equal to `v', using the binary split method.
		local
			i,j,k:INTEGER
			found:BOOLEAN
		do
			from
				start
				i := 1
				j := count + 1
			until
				i + 1 > j or found
			loop
				k := (i + j)//2
				go_i_th(k)
				if v < item then
					j := k
				elseif v > item then
					i := k + 1
					go_i_th(i)
				else
					found := True
				end
			end
		end

	search_before (v: like item) is
			-- Go to first position with item less than or 
			-- equal to `v', using the binary split method.
		local
			i,j,k:INTEGER
			found:BOOLEAN
		do
			from
				start
				i := 0
				j := count
			until
				i + 1 > j or found
			loop
				k := (i + j)//2
				go_i_th(k)
				if v > item then
					i := k
				elseif v < item then
					j := k - 1
					go_i_th(j)
				else
					found := True
				end
			end
		end

end
