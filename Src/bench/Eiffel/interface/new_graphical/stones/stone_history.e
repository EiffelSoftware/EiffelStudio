indexing
	description: "Lists of a given number of stones. Stones are added %
			%to the end and older stones are thrown away."
	date: "$Date$"
	revision: "$Revision $"

class
	STONE_HISTORY

inherit
	TWO_WAY_LIST [STONE]
		redefine
			make
		end

	EB_TOOL_DATA

	EB_RESOURCE_USER
		redefine
--			update_integer_resource
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize Current
		do
			{TWO_WAY_LIST} Precursor
			register
			Object_comparison := True
		end

feature -- Destruction

	destroy is
			-- Remove Current from list of objects to
			-- be updated when resources change. This
			-- function has to be called for Current to
			-- be recyclied by the garbage collector.
		do
			unregister
		end

feature -- Access

	do_not_update: BOOLEAN
			-- Update the stone history?	

feature -- Resource Update

	register is
			-- Ask the resource manager to notify Current (i.e. to call `update') each
			-- time one of the resources he needs has changed.
			-- Is called by `make'.
		do
			register_to ("history_size")
		end

	update is
			-- Update Current with the registred resources.
		do
			rearrange_history
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed.
			-- Is called by `destroy'.
		do
			unregister_to ("history_size")
		end

--	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
--			-- Update `old_res' with `new_res', if the value of
--			-- `new_res' is applicable.
--			-- Also, update the interface.
--		do
--			if old_res = General_resources.history_size then
--				if new_res.actual_value >= 1 and new_res.actual_value <= 100 then
--					{EB_RESOURCE_USER} Precursor (old_res, new_res)
--					rearrange_history
--				end
--			end
--		end

feature -- Status setting

	set_do_not_update (b: BOOLEAN) is
			-- Set `do_not_update' to `b'.
		do
			do_not_update := b
		end

feature -- Element change

	add_stone (v: like item) is
			-- Add `v' to `Current'. Throw away the older item
			-- if the capacity has been reached.
			-- Do not insert `v' if it was the last inserted item.
			-- Move the cursor to the last inserted stone.
		do
			if
				not do_not_update and then v /= Void and then
				(empty or else not v.same_as (last) or else
				not equal (v.stone_signature, last.stone_signature))
			then
				if
					not empty and then
					not islast and then
					(not item.same_as (last) or else not equal (item.stone_signature, last.stone_signature))
				then
					extend (item)
				end

				extend (v)

				rearrange_history				

				finish
			end
		end

feature {NONE} -- Measurement

	capacity: INTEGER is
			-- Maximum number of items
		do
			Result := editor_history_size
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
	value_comparison: object_comparison = True

end -- class STONE_HISTORY
