indexing
	description:
		"Implementation of transfer manager builder"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TRANSFER_MANAGER_BUILDER_IMPL inherit
	
	RESOURCE_FACTORY
		export
			{NONE} all
		end
		
create

	make

feature {NONE} -- Initialization

	make is
			-- Create transfer manager builder.
		do
			create transactions.make (1)
			create readable_set.make
			create writable_set.make
			create resource_hash.make (0)
		end

feature -- Constants

	Readable, Writable: INTEGER is unique
			-- Mode constants
			
feature -- Access

	manager: TRANSFER_MANAGER is
			-- The built manager
		require
			built: manager_built
		do
			Result := transfer_manager
		end

	transaction (n: INTEGER): TRANSACTION is
			-- `n'-th transaction
		require
			not_empty: not empty
			index_in_range: 1 <= n and n <= count
		do
			Result := transactions.i_th (n)
		ensure
			non_void: Result /= Void
		end
		
feature -- Measurement

	count: INTEGER is
			-- Number of transactions in builder
		do
			Result := transactions.count
		end
		
feature -- Status report

	empty: BOOLEAN is
			-- No transaction stored in builder?
		do
			Result := transactions.empty
		end

	manager_built: BOOLEAN is
			-- Has manager been built?
		do
			Result := transfer_manager /= Void and then 
				not transfer_manager.empty
		end

	is_address_correct (addr: STRING; mode: INTEGER): BOOLEAN is
			-- Is address `addr' correct?
		require
			non_empty_address: addr /= Void and then not addr.empty
			mode_in_range: Readable <= mode and mode <= writable
		local
			res: RESOURCE
			u: URL
		do
			resource_factory.set_address (addr)
			if resource_factory.is_address_correct then
				u := resource_factory.url
				resource_hash.search (u.location)
				if resource_hash.found then
					res := resource_hash.found_item
				else
					resource_factory.create_resource
					res := resource_factory.resource
				end
				inspect
					mode
				when Readable then
					Result := add_reference 
						(readable_set, res, res~is_readable)
				when Writable then
					Result := add_reference 
						(writable_set, res, res~is_writable)
				end
				if Result and not resource_hash.found then
					resource_hash.extend (res, res.location)
				end
			end
		end
	
	transfer_finished: BOOLEAN is
			-- Has a transfer occurred?
		do
			Result := manager_built and then manager.transfer_finished
		end

	transfer_succeeded: BOOLEAN is
			-- Has the last transfer succeeded?
		do
			Result := manager_built and then manager.transactions_succeeded
		end

			
feature -- Element change

	add_transaction (s, t: STRING) is
			-- Add transactiom from source `s' to target `t'.
		require
			source_exists: s /= Void
			target_exists: t /= Void
			source_address_correct: is_address_correct (s, Readable)
			target_address_correct: is_address_correct (t, Writable)
		local
			sr: RESOURCE
			tr: RESOURCE
			su: URL
			tu: URL
			ta: SINGLE_TRANSACTION
		do
			optimized_transactions := Void
			transfer_manager := Void

			resource_factory.set_address (s)
			su := resource_factory.url
			resource_hash.search (su.location)
				check
					found: resource_hash.found
						-- Because resource has been created during correctness
						-- check
				end
			sr := deep_clone (resource_hash.found_item)

			resource_factory.set_address (t)
			tu := resource_factory.url
			resource_hash.search (tu.location)
				check
					found: resource_hash.found
						-- Because resource has been created during correctness
						-- check
				end
			tr := deep_clone (resource_hash.found_item)

			create ta.make (sr, tr)
			transactions.extend (ta)
		ensure
			one_more_transaction: count = old count + 1
		end

feature -- Removal

	remove_transaction (n: INTEGER) is
			-- Remove `n'-th transaction.
		require
			not_empty: not empty
			index_in_range: 1 <= n and n <= count
		local
			idx: INTEGER
		do
			optimized_transactions := Void
			transfer_manager := Void
			idx := transactions.index
			transactions.go_i_th (n)

			remove_reference (readable_set, transactions.item.source)
			remove_reference (writable_set, transactions.item.target)
			
			transactions.remove
			if idx > count then idx := count end
			transactions.go_i_th (idx)
		ensure
			one_less_item: count = count - 1
			index_unchanged: (old transactions.index < old count) 
				implies (transactions.index = old transactions.index)
			index_adapted: (old transactions.index = old count) 
				implies (transactions.index = old transactions.index - 1)
		end
			
	wipe_out is
			-- Clear manager.
		do
			transactions.wipe_out
			readable_set.wipe_out
			writable_set.wipe_out
			resource_hash.clear_all
			optimized_transactions := Void
			transfer_manager := Void
		ensure
			empty: empty
			no_optimized_transactions: optimized_transactions = Void
			no_manager: not manager_built
		end
		
feature -- Basic operations

	build_manager is
			-- Build manager.
		require
			not_empty: not empty
		do
			optimize_transactions
			setup_manager
		ensure
			manager_ready: manager_built
		end

feature {NONE} -- Implementation

	transactions: ARRAYED_LIST[TRANSACTION]
			-- Registered transactions

	optimized_transactions: ARRAYED_LIST[TRANSACTION]
			-- Optimized transactions

	transfer_manager: TRANSFER_MANAGER
			-- The manager

	readable_set: BINARY_SEARCH_TREE_SET[STRING]
			-- Set storing readable adresses

	writable_set: BINARY_SEARCH_TREE_SET[STRING]
			-- Set storing writable adresses

	resource_hash: HASH_TABLE[RESOURCE, STRING]
			-- Hash table of created resources

	optimized_count: INTEGER is
			-- Number of optimized transactions
		do
			if optimized_transactions /= Void and then not
				optimized_transactions.empty then
				from 
					optimized_transactions.start 
				until 
					optimized_transactions.after
				loop
					Result := Result + optimized_transactions.item.count
					optimized_transactions.forth
				end
			end
		end

	optimize_transactions is
			-- Optimize registered transactions.
		require
			not_empty: not empty
		local
			hash: HASH_TABLE[LINKED_LIST[INTEGER], URL]
			addr: URL
			lst: LINKED_LIST[INTEGER]
			multitrans: MULTIPLE_TRANSACTION
		do
			create hash.make (count)
			from transactions.start until transactions.after loop
				addr := transactions.item.source.address
				hash.search (addr)
				if hash.found then
					hash.found_item.extend (transactions.index)
				else
					create lst.make
					lst.extend (transactions.index)
					hash.put (lst, addr)
				end
				transactions.forth
			end
				
			create optimized_transactions.make (count)
			
			from transactions.start until transactions.after loop
				hash.search (transactions.item.source.address)
				if hash.found then
					lst := hash.found_item
					lst.start
					if not (transactions @ lst.item).source.
						supports_multiple_transactions or lst.count = 1 then
						from lst.start until lst.after loop
							optimized_transactions.extend 
								(transactions @ lst.item)
							lst.forth
						end
					else
						from 
							lst.start 
							create multitrans.make
						until 
							lst.after 
						loop
							multitrans.add_transaction (transactions @ lst.item)
							lst.forth
						end
						optimized_transactions.extend (multitrans)
					end
					hash.remove (transactions.item.source.address)
				end
				transactions.forth
			end
		ensure
			optimized: optimized_transactions /= Void and then not
					optimized_transactions.empty
		end

	setup_manager is
			-- Setup transfer manager.
		require
			no_manager: not manager_built
			optimized: optimized_count > 0
		do
			from 
				optimized_transactions.start
				create transfer_manager.make
			until 
				optimized_transactions.after
			loop
				transfer_manager.add_transaction (optimized_transactions.item)
				optimized_transactions.forth
			end
		ensure
			manager_set_up: manager_built
		end

	add_reference (s: SET[STRING]; r: RESOURCE;
				f: FUNCTION[RESOURCE, TUPLE, BOOLEAN]): BOOLEAN is
			-- Add `r' into `s' if `f' is true.
		require
			set_exists: s /= Void
			resource_exists: r /= Void
			function_exists: f /= Void
		do
			if not s.has (r.location) then
				f.call ([])
				Result := f.last_result
				if Result then s.extend (r.location) end
			else
				Result := True
			end
		ensure
			inserted: Result implies s.has (r.location)
		end

	remove_reference (s: SET[STRING]; r: RESOURCE) is
			-- Remove `r' from `s'.
		require
			set_exists: s /= Void
			resource_exists: r /= Void
			registered: s.has (r.location)
		do
			s.prune (r.location)
			resource_hash.remove (r.location)
		ensure
			removed: not s.has (r.location)
			resource_removed: not resource_hash.has (r.location)
		end

invariant

	readable_set_exists: readable_set /= Void
	writable_set_exists: writable_set /= Void
	resource_hash: resource_hash /= Void
	success_constraint: transfer_succeeded implies transfer_finished
	count_equality: (optimized_count > 0) implies (count = optimized_count)

end -- class TRANSFER_MANAGER_BUILDER_IMPL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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


