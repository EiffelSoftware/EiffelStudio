indexing
	description:
		"Implementation of transfer manager builder"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TRANSFER_MANAGER_BUILDER_IMPL inherit
	
	DATA_RESOURCE_FACTORY
		export
			{NONE} all
		end
		
	HOST_VALIDITY_CHECKER

create

	make

feature {NONE} -- Initialization

	make is
			-- Create transfer manager builder.
		do
			create transactions.make (1)
			create readable_set.make
			readable_set.compare_objects
			create writable_set.make
			writable_set.compare_objects
			create resource_hash.make (0)
		end

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
			not_empty: not is_empty
			index_in_range: 1 <= n and n <= count
		do
			Result := transactions.i_th (n)
		ensure
			result_exists: Result /= Void
		end
		
feature -- Measurement

	count: INTEGER is
			-- Number of transactions in builder
		do
			Result := transactions.count
		end
		
feature -- Status report

	is_empty: BOOLEAN is
			-- No transaction stored in builder?
		do
			Result := transactions.is_empty
		end

	manager_built: BOOLEAN is
			-- Has manager been built?
		do
			Result := transfer_manager /= Void and then 
				not transfer_manager.is_empty
		end

	is_mode_valid (mode: INTEGER): BOOLEAN is
			-- Is `mode' valid?
		do
			Result := (Readable <= mode and mode <= Writable)
		end
		
	is_address_correct (addr: STRING; mode: INTEGER): BOOLEAN is
			-- Is address `addr' correct considering `mode'?
			-- (`mode' is `Readable' or `Writable')
		require
			non_empty_address: addr /= Void and then not addr.is_empty
			mode_valid: is_mode_valid (mode)
		local
			res: DATA_RESOURCE
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
					if res.is_proxy_supported then
						res.set_proxy_information (source_proxy)
					end
					Result := add_reference 
						(readable_set, res, agent res.is_readable)
				when Writable then
					if res.is_proxy_supported then
						res.set_proxy_information (target_proxy)
					end
					Result := add_reference 
						(writable_set, res, agent res.is_writable)
				end
				if Result and not resource_hash.found then
					resource_hash.put (res, res.location)
				end
			end
		end
	
	transfer_finished: BOOLEAN is
			-- Has a transfer occurred?
		do
			Result := manager_built and then manager.transfer_finished
		end

	error: BOOLEAN is
			-- Has an error occurred?
		do
			Result := manager_built and then manager.error
		end

	error_reason: STRING is
			-- Reason of most recent error
		require
			error_occurred: error
		do
			Result := manager.error_reason
		ensure
			non_empty_string: Result /= Void and then not Result.is_empty
		end

	transfer_succeeded: BOOLEAN is
			-- Has the last transfer succeeded?
		do
			Result := manager_built and then manager.transactions_succeeded
		end

	last_added_source_correct: BOOLEAN
			-- Is source address of the most recent transaction addition
			-- correct?

	last_added_target_correct: BOOLEAN
			-- Is target address of the most recent transaction addition
			-- correct?

feature -- Status setting

	set_timeout (s: INTEGER) is
			-- Set timeout to `s' seconds.
			-- (This feature must be called *before* adding transactions in
			-- order to affect the added transactions.)
		require
			non_negative: s >= 0
		do
			timeout := s
		ensure
			timeout_set: timeout = s
		end
			
	set_source_proxy (host: STRING; port: INTEGER) is
			-- Set source proxy host to `host' and port to `port'.
		require
			host_not_empty: host /= Void and then not host.is_empty
			port_non_negative: port >= 0
		do
			create source_proxy.make (host, port)
		ensure
			source_proxy_exists: source_proxy /= Void
			host_set: source_proxy.host = host
			port_set: source_proxy.port = port
		end

	set_target_proxy (host: STRING; port: INTEGER) is
			-- Set target proxy host to `host' and port to `port'.
		require
			host_not_empty: host /= Void and then not host.is_empty
			port_non_negative: port >= 0
		do
			create target_proxy.make (host, port)
		ensure
			target_proxy_exists: target_proxy /= Void
			host_set: target_proxy.host = host
			port_set: target_proxy.port = port
		end

	set_proxies (host: STRING; port: INTEGER) is
			-- Set source and target proxy host to `host' and 
			-- port to `port'.
		require
			host_not_empty: host /= Void and then not host.is_empty
			port_non_negative: port >= 0
		do
			create source_proxy.make (host, port)
			target_proxy := source_proxy
		ensure
			source_proxy_exists: source_proxy /= Void
			host_set: source_proxy.host = host
			port_set: source_proxy.port = port
			proxies_equal: source_proxy = target_proxy
		end

	reset_source_proxy is
			-- Reset source proxy.
		do
			source_proxy := Void
		ensure
			no_source_proxy_set: source_proxy = Void
		end

	reset_target_proxy is
			-- Reset target proxy.
		do
			target_proxy := Void
		ensure
			no_target_proxy_set: target_proxy = Void
		end

	reset_proxies is
			-- Reset source and target proxy.
		do
			source_proxy := Void
			target_proxy := Void
		ensure
			no_source_proxy_set: source_proxy = Void
			no_target_proxy_set: target_proxy = Void
		end

feature -- Element change

	add_transaction (s, t: STRING) is
			-- Add transaction from source `s' to target `t'.
		require
			source_exists: s /= Void
			target_exists: t /= Void
		local
			sr: DATA_RESOURCE
			tr: DATA_RESOURCE
			su: URL
			tu: URL
			ta: SINGLE_TRANSACTION
		do
			last_added_source_correct := is_address_correct (s, Readable)
			last_added_target_correct := is_address_correct (t, Writable)
			if last_added_source_correct and last_added_target_correct then
				optimized_transactions := Void
				transfer_manager := Void

				resource_factory.set_address (s)
				su := resource_factory.url
				resource_hash.search (su.location)
					check
						found: resource_hash.found
							-- Because resource has been created during 
							-- correctness check
					end
				sr := resource_hash.found_item.deep_twin

				resource_factory.set_address (t)
				tu := resource_factory.url
				resource_hash.search (tu.location)
					check
						found: resource_hash.found
							-- Because resource has been created during 
							-- correctness check
					end
				tr := resource_hash.found_item.deep_twin
					debug
						Io.error.put_string (s)
						Io.error.put_string (" -> ")
						Io.error.put_string (t)
						Io.error.put_string (" added.%N")
					end
				if timeout /= Void then
					sr.set_timeout (timeout.item)
					tr.set_timeout (timeout.item)
						debug
							Io.error.put_string ("Timeout set to ")
							Io.error.put_integer (timeout.item)
							Io.error.put_string (" seconds%N")
						end
				end
				create ta.make (sr, tr)
				transactions.extend (ta)
			end
		ensure
			one_more_transaction_if_correct: 
				(last_added_source_correct and 
				last_added_target_correct) implies count = old count + 1
		end

feature -- Removal

	remove_transaction (n: INTEGER) is
			-- Remove `n'-th transaction.
		require
			not_empty: not is_empty
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
			empty: is_empty
			no_optimized_transactions: optimized_transactions = Void
			no_manager: not manager_built
		end
		
feature -- Basic operations

	build_manager is
			-- Build manager.
		require
			not_empty: not is_empty
		do
			optimize_transactions
			setup_manager
		ensure
			manager_ready: manager_built
		end

	transfer is
			-- Start transfer.
		require
			manager_built: manager_built
		do
			manager.transfer
		ensure
			transfer_finished: transfer_finished
		end

feature {NONE} -- Constants

	Readable: INTEGER is 1
	Writable: INTEGER is 2
			-- Mode constants
			
feature {NONE} -- Implementation

	transactions: ARRAYED_LIST [TRANSACTION]
			-- Registered transactions

	optimized_transactions: ARRAYED_LIST [TRANSACTION]
			-- Optimized transactions

	transfer_manager: TRANSFER_MANAGER
			-- Transfer manager

	readable_set: BINARY_SEARCH_TREE_SET [STRING]
			-- Set storing readable adresses

	writable_set: BINARY_SEARCH_TREE_SET [STRING]
			-- Set storing writable adresses

	resource_hash: HASH_TABLE [DATA_RESOURCE, STRING]
			-- Hash table of created resources

	timeout: INTEGER_REF
			-- Duration of timeout in seconds
			-- (If `Void' the default value is used.)
			
	source_proxy: PROXY_INFORMATION
			-- Information about proxy for the source resource

	target_proxy: PROXY_INFORMATION
			-- Information about proxy for the target resource

	optimized_count: INTEGER is
			-- Number of optimized transactions
		do
			if optimized_transactions /= Void and then not
				optimized_transactions.is_empty then
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
			not_empty: not is_empty
		local
			hash: HASH_TABLE [LINKED_LIST [INTEGER], URL]
			addr: URL
			lst: LINKED_LIST [INTEGER]
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
					optimized_transactions.is_empty
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
				transfer_manager.stop_on_error
			until 
				optimized_transactions.after
			loop
				transfer_manager.add_transaction (optimized_transactions.item)
				optimized_transactions.forth
			end
		ensure
			manager_set_up: manager_built
		end

	add_reference (s: SET [STRING]; r: DATA_RESOURCE;
				f: FUNCTION [DATA_RESOURCE, TUPLE, BOOLEAN]): BOOLEAN is
			-- Add `r' into `s' if `f' is true.
		require
			set_exists: s /= Void
			resource_exists: r /= Void
			function_exists: f /= Void
		do
			if not s.has (r.location) then
				Result := f.item (Void)
				if Result then s.extend (r.location) end
			else
				Result := True
			end
		ensure
			inserted: Result implies s.has (r.location)
		end

	remove_reference (s: SET [STRING]; r: DATA_RESOURCE) is
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

