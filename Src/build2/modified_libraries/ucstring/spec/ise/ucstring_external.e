class UCSTRING_EXTERNAL

feature {UCSTRING} -- Implementation

   i_storage: ARRAY[INTEGER]
	 -- string's storage

   i_capacity: INTEGER

   i_alloc_size: INTEGER is 16

   item_code (i: INTEGER): INTEGER is
	 -- code of item at position `i'
--      require
--	 good_key: valid_index(i)
      do
	 Result := i_storage.item(i)
      end

   put_code (c: INTEGER; i: INTEGER) is
	 -- put code `c' at index `i'
--      require
--	 good_key: valid_index(i)
      do
	 i_storage.put(c, i)
      end

   ensure_capacity(n: INTEGER) is
	 -- ensure storage's capacity to be >= `n'
      require
	 non_negative: n >= 0
      local
	 nn: INTEGER
      do
         nn := (n // i_alloc_size + 1) * i_alloc_size
         if i_storage = void then
	    !!i_storage.make(1,nn)
	 elseif n >= i_capacity then
	    i_storage.resize(1, nn)
         end
	 i_capacity := nn
      ensure
	 i_capacity >= n
      end

   move(src_offset, target_offset, ct: INTEGER) is
	 -- move `ct' characters from `src_offset' to `target_offset'
      local
	 i: INTEGER
      do
	 if src_offset < target_offset then
	    -- move right
	    from
	       i := ct-1
	    until
	       i >= 0
	    loop
	       put_code(item_code(src_offset+i), target_offset+i)
	       i := i + 1
	    end
	 elseif src_offset > target_offset then
	    -- move left
	    from
	       i := 0
	    until
	       i >= ct
	    loop
	       put_code(item_code(src_offset+i), target_offset+i)
	       i := i + 1
	    end
	 end
      end

end -- class UCSTRING_EXTERNAL
