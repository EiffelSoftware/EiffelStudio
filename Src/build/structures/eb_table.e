
--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

   date: "$Date$";
   revision: "$Revision$"

class EB_TABLE [T] 

inherit

   ARRAY [T]
		rename
			make as old_create,
			put as basic_put,
			count as max_size,
			extra_percentage as array_extra_percentage
		export
			{NONE} all;
			{ANY} item, max_size
		end


creation

	make

   
feature 

	make (size: INTEGER) is
		 -- Create an empty table of initial size `size'
	  require
		 Positive_argument: size >= 1
	  do
		 old_create (1, size)
	  end;

   count: INTEGER;

   put (v: T) is
		 -- insert `v' in the table.
	  local
		 extra_block_size: INTEGER
	  do
		 if
			(count >= upper - 1)
		 then
			extra_block_size := max (Block_threshold, (Extra_percentage * upper) // 100);
			resize (1, upper + extra_block_size)
		 end;
		 count := count + 1;
		 basic_put (v, count)
	  ensure
		 One_more_item: count = old count + 1
	  end;

   trim is
		 -- Free unused memory space.
	  do
		 --area := arycpy (area, count, 0, count);
		 --upper := count
	  --ensure
		 --Optimal_size: max_size = count
	  end;

   index_of (v: T): INTEGER is
		 -- index of `v' in the table.
		 -- `0' if not found.
		 -- (Shallow equality).
	  require
		 Non_void_argument: not (v = Void)
	  local
		 i: INTEGER
	  do
		 from
			i := 1
		 until
			(i > count) or else v.is_equal (item (i))
		 loop
			i := i + 1
		 end;
		 if
			i > count
		 then
			Result := 0
		 else
			Result := i
		 end
	  end;

   
feature {NONE}

	Block_threshold: INTEGER is 5;

   Extra_percentage: INTEGER is 10

invariant
   max_size = upper

end -- class TABLE 
