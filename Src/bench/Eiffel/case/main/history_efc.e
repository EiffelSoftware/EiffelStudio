indexing

	description: "History list of undoable_rfc.";
	date: "$Date$";
	revision: "$Revision $"

class HISTORY_EFC 

inherit

	LINKED_LIST [UNDOABLE_EFC]
		rename
			go_i_th as list_go_i_th,
			back as list_back,
			forth as list_forth,
			wipe_out as list_wipe_out
		end;
	ONCES;
	CONSTANTS

creation

	make

feature -- Cursor movement

	back is
			-- Move cursor backward one position.
		require
			not_offleft: index > 0
		do
			item.undo
			list_back

			--if item /= Void then
			--	item.set_selected (true)
			--end

			observer_management.update_observer (Current)
		
		ensure
			index = old index - 1
		end

	forth is
			-- Move cursor forward one position.
		require
			not_empty_nor_islast: count > 0 and then index < count
		do
			list_forth
			item.redo

			--if item /= Void then
			--	item.set_selected (true)
			--end

			observer_management.update_observer (Current)

		ensure
			(index >= 1) and (index <= count)
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0
			index_small_enough: i <= count
			not_zero_unless_empty: not empty or i = 0
		do
			if i > index then
				from
				until
					i = index
				loop
					forth
				end
			elseif i < index then
				from
				until
					i = index
				loop
					back
				end
			end
		ensure
			index = i
		end;

feature -- Element change

	record (a_command: UNDOABLE_EFC) is
			-- Insert `a_command' after the cursor position, and place
			-- cursor upon it
		local
			elem: HISTORY_ITEM
			--index_history: INTEGER
		do
			-- New Vision
			--if count = Resources.history_size then
			--	start
			--	--item.destroy
			--	remove
			--end

			remove_after
			extend(a_command)
			list_forth

			observer_management.update_observer (Current)
		end

feature -- Removal

	remove_after is
			-- Remove all commands after the cursor position.
		do
			if (not islast) and (not empty) then
				from
					list_forth;
				until
					after
				loop
					--item.destroy
					remove
				end
				list_back
			end
		ensure
			islast_unless_empty: (not empty) implies islast
		end;

	wipe_out is
			-- Make history empty.
		do
			list_wipe_out
		end

end -- class HISTORY_EFC
