indexing
	description: "Lists of a given number of stones. Stones are added %
			%to the end and older stones are thrown away."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	STONE_HISTORY

inherit
	TWO_WAY_LIST [STONE]
		rename
			extend as twl_extend
		redefine
			make, has
		end

	EB_CONSTANTS
		undefine
			copy, is_equal
		end

	RESOURCE_USER
		undefine
			copy, is_equal
		redefine
			update_integer_resource
		end

create
	make

feature -- Initialization

	make is
			-- Initialze Current
		do
			Precursor {TWO_WAY_LIST}
			General_resources.add_user (Current)
		end

feature -- Access

	do_not_update: BOOLEAN
			-- Update the stone history?

	has (v: like item): BOOLEAN is
			-- Does chain include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			pos: CURSOR
		do
			pos := cursor;
			from
				start
			until
				after or Result
			loop
				Result := item.same_as (v)
				forth
			end
			go_to (pos)
		end;

feature -- Resource Update

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with `new_res', if the value of
			-- `new_res' is applicable.
			-- Also, update the interface.
		do
			if old_res = General_resources.history_size then
				if new_res.actual_value >= 1 and new_res.actual_value <= 100 then
					Precursor {RESOURCE_USER} (old_res, new_res)
					rearrange_history
				end
			end
		end

feature -- Status setting

	set_do_not_update (b: BOOLEAN) is
			-- Set `do_not_update' to `b'.
		do
			do_not_update := b
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to `Current'. Throw away the older item
			-- if the capacity has been reached.
			-- Do not insert `v' if it was the last inserted item.
			-- Move the cursor to the last inserted stone.
		do
			if
				not do_not_update and then v /= Void and then
				(is_empty or else not v.same_as (last) or else
				not equal (v.stone_signature, last.stone_signature))
			then
				if
					not is_empty and then
					not islast and then
					(not item.same_as (last) or else not equal (item.stone_signature, last.stone_signature))
				then
					twl_extend (item)
				end

				twl_extend (v)

				rearrange_history				

				finish
			end
		end

feature {NONE} -- Measurement

	capacity: INTEGER is
			-- Maximum number of items
		do
			Result := General_resources.history_size.actual_value
			if Result < 1 or Result > 100 then
					-- Just in case the user specified some weird values.
				Result := 20
			end
		end

feature {NONE} -- Resizing

	rearrange_history is
			-- Rearrange the history according to the resource value.
		local
			c: CURSOR
		do
			from
				c := cursor
				start
			until
				count <= capacity 
			loop
				remove
				start
			end		
			go_to (c)		
		end

feature -- Synchronization

	synchronize is
			-- Synchronize held stones. Reset the cursor position to the 
			-- last inserted stone. Some of the stones may become Void 
			-- (not valid anymore) and are therefore removed from the history.
		local
			new_stone: STONE
		do
			from
				start
			until
				after
			loop
				new_stone := item.synchronized_stone
				if new_stone /= Void then
					put (new_stone)
					forth
				else
					remove
				end
			end
			finish
		end
	
invariant

	positive_capacity: capacity > 0
	bounded_count: count <= capacity

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class STONE_HISTORY
