class
	ACCELERATORS_WINDOWS

inherit
	WEL_ACCELERATORS

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a accelerator table.
		do
			!! accelerator_list.make
		end

feature -- Status setting

	add (acc: WEL_ACCELERATOR) is
			-- Add an accelerator to the table
		require
			acc_not_void: acc /= Void
			acc_exists: acc.exists
		do
			accelerator_list.extend (acc)
			recreate_accelerators
		ensure
			count_increased: accelerator_list.count =
				old accelerator_list.count + 1
		end

feature -- Removal

	remove (acc: WEL_ACCELERATOR) is
			-- Remove an accelerator from the table.
		require
			acc_not_void: acc /= Void
			acc_exists: acc.exists
		do
			from
				accelerator_list.start
			until
				accelerator_list.after
			loop
				if
					accelerator_list.item.command_id
					= acc.command_id
				then
					accelerator_list.remove
					accelerator_list.finish
				else
					accelerator_list.forth
				end
			end
			recreate_accelerators
		end

feature {NONE} -- Implementation

	recreate_accelerators is
			-- Recreate the accelerators
		require
			accelerator_list_not_void: accelerator_list /= Void
			accelerator_list_not_empty: not accelerator_list.empty
		local
			index: INTEGER
		do
			!! acc_array.make (accelerator_list.count, accelerator_list.first.structure_size)
			from
				index := 0
				accelerator_list.start
			until
				accelerator_list.after
			loop
				acc_array.put (accelerator_list.item, index)
				index := index + 1
				accelerator_list.forth
			end
			cwin_destroy_accelerator_table (item)
			item := cwin_create_accelerator_table (acc_array.to_c, acc_array.count)
		end

feature {NONE} -- Implementation

	accelerator_list: LINKED_LIST [WEL_ACCELERATOR]
			-- List to hold the accelerators.

	acc_array: WEL_ARRAY [WEL_ACCELERATOR]
			-- Array used to create and recreate the accelerators.

feature {NONE} -- Externals

	cwin_destroy_accelerator_table (p: POINTER) is
			-- SDK DestroyAcceleratorTable
		external
			"C [macro <wel.h>] (HACCEL)"
		alias
			"DestroyAcceleratorTable"
		end

	cwin_create_accelerator_table (p: POINTER; entries: INTEGER): POINTER is
			-- SDK CreateAcceleratorTable
		external
			"C [macro <wel.h>] (LPACCEL, int): EIF_POINTER"
		alias
			"CreateAcceleratorTable"
		end

end -- class ACCELERATOR_WINDOWS
