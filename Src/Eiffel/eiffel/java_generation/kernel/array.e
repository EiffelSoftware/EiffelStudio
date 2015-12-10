		external class
			ARRAY [G]

						--inherit
						--   SYSTEM_ARRAY
						--      export
						--	 {NONE} all
						--      end

			create
			make

feature {NONE} -- Initialization

   make (n: INTEGER)
			-- Create an array with `n' elements.
      do
			-- Built-in
      end

feature

   put (i: INTEGER; v:G)
      do
      end

   item (i: INTEGER): G
      do
      end

   upper: INTEGER
      do
      end
   
   lower: INTEGER
      do
      end

   count: INTEGER
      do
			Result := upper - lower + 1
      end
   
end
