indexing
	description:
		" EiffelVision accelerator table. This table keep a%
		% of all the differents accelerators of the system and%
		% it pass this table to windows."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_TABLE_IMP

inherit
	WEL_ACCELERATORS

feature -- Status report

	empty: BOOLEAN is
			-- Is the `accelerator_list' empty?
		do
			Result := accelerator_list = Void or else
						accelerator_list.empty
		end

feature -- Status setting

	destroy is
			-- Destroy the actual table.
		do
			cwin_destroy_accelerator_table (item)
		end

feature -- Element change

	add (acc: EV_ACCELERATOR) is
			-- Add accel to the list of accelerators.
		local
			internal: EV_INTERNAL_ACCELERATOR_IMP
		do
			-- If the list doesn't exists, we create it.
			if accelerator_list /= Void then
				internal := find_accelerator (acc)
			else
				!! accelerator_list.make
			end

			-- Then we add a new accelerator if necessary.
			-- We increment the number of references on this
			-- accelerator to be sure not to destroy it when
			-- it is still necessary.
 			if internal = Void then
				!! internal.make (acc)
 				accelerator_list.force (internal)
 				recreate_accelerators
 			end
			internal.reference
		end

	remove (acc: EV_ACCELERATOR) is
			-- Remove an accelerator from the table.
		local
			internal: EV_INTERNAL_ACCELERATOR_IMP
		do
			if accelerator_list /= Void then
				internal := find_accelerator (acc)
				if internal /= Void then
					internal.unreference
					if internal.clients = 0 then	
						accelerator_list.prune_all (internal)
						recreate_accelerators
					end
	 			end
			end
		end

feature {NONE} -- Basic operation

	find_accelerator (acc: EV_ACCELERATOR): EV_INTERNAL_ACCELERATOR_IMP is
			-- Does the system know already the accelerator?
		require
			valid_list: accelerator_list /= Void
		local
			list: LINKED_LIST [EV_INTERNAL_ACCELERATOR_IMP]
			cur: CURSOR
		do
			from
				list := accelerator_list
				cur := list.cursor
				list.start
			until
				list.after or Result /= Void
			loop
				if acc.id = list.item.command_id then
					Result := list.item
				end
				list.forth
			end
			list.go_to (cur)
		end

feature {NONE} -- Implementation

	accelerator_list: LINKED_LIST [EV_INTERNAL_ACCELERATOR_IMP]
			-- List to hold the accelerators.

	recreate_accelerators is
			-- Recreate the accelerators
		require
			valid_list: accelerator_list /= Void
		local
			wel: WEL_ARRAY [WEL_ACCELERATOR]
			list: LINKED_LIST [EV_INTERNAL_ACCELERATOR_IMP]
		do
			-- A local variable to gain some speed
 			list := accelerator_list

			if list.empty then
 				cwin_destroy_accelerator_table (item)
				accelerator_list := Void
			else
				-- We create a WEL array to send it to the system
	 			!! wel.make (list.count, list.first.structure_size)
	 			from
	 				list.start
				until
					list.after
				loop
					wel.put (list.item, list.index - 1)
					list.forth
	 			end
	 			if item /= default_pointer then
	 				cwin_destroy_accelerator_table (item)
	 			end
	 			item := cwin_create_accelerator_table (wel.item, wel.count)
			end
		end

end -- class EV_ACCELERATOR_TABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
