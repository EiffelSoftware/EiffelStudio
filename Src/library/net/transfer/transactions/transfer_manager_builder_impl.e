note
	description: "Implementation of transfer manager builder"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
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

	manager: TRANSFER_MANAGER
			-- The built manager
		require
			manager_built: manager_built
		do
			check manager_built: attached transfer_manager as l_result then
				Result := l_result
			end
		end

	transaction (n: INTEGER): TRANSACTION
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

	count: INTEGER
			-- Number of transactions in builder
		do
			Result := transactions.count
		end

feature -- Status report

	is_empty: BOOLEAN
			-- No transaction stored in builder?
		do
			Result := transactions.is_empty
		end

	manager_built: BOOLEAN
			-- Has manager been built?
		local
			l_manager: like transfer_manager
		do
			l_manager := transfer_manager
			Result := l_manager /= Void and then not l_manager.is_empty
		end

	is_mode_valid (mode: INTEGER): BOOLEAN
			-- Is `mode' valid?
		do
			Result := Readable <= mode and mode <= Writable
		end

	is_address_correct (addr: STRING_8; mode: INTEGER): BOOLEAN
			-- Is address `addr' correct considering `mode'?
			-- (`mode' is `Readable' or `Writable')
		require
			non_empty_address: addr /= Void and then not addr.is_empty
			mode_valid: is_mode_valid (mode)
		local
			res: detachable DATA_RESOURCE
			u: detachable URL
		do
			resource_factory.set_address (addr)
			if resource_factory.is_address_correct then
				u := resource_factory.url
				if u /= Void and then attached resource_hash.item (u.location) as l_res then
					res := l_res
				else
					resource_factory.create_resource
					check attached resource_factory.resource as l_res then
						res := l_res
					end
				end
				inspect
					mode
				when Readable then
					if res.is_proxy_supported then
						check attached source_proxy as l_proxy then
							res.set_proxy_information (l_proxy)
						end
					end
					Result := add_reference (readable_set, res, agent res.is_readable)
				when Writable then
					if res.is_proxy_supported then
						check attached target_proxy as l_proxy then
							res.set_proxy_information (l_proxy)
						end
					end
					Result := add_reference (writable_set, res, agent res.is_writable)
				end
				if Result and not resource_hash.found then
					resource_hash.put (res, res.location)
				end
			end
		end

	transfer_finished: BOOLEAN
			-- Has a transfer occurred?
		do
			Result := manager_built and then manager.transfer_finished
		end

	error: BOOLEAN
			-- Has an error occurred?
		do
			Result := manager_built and then manager.error
		end

	error_reason: STRING
			-- Reason of most recent error
		require
			error_occurred: error
		do
			Result := manager.error_reason
		ensure
			non_empty_string: Result /= Void and then not Result.is_empty
		end

	transfer_succeeded: BOOLEAN
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

	set_timeout (s: INTEGER)
			-- Set timeout to `s' seconds.
			-- (This feature must be called *before* adding transactions in
			-- order to affect the added transactions.)
		require
			non_negative: s >= 0
		local
			l_timeout: like timeout
		do
			l_timeout := timeout
			if l_timeout = Void then
				create timeout.put (s)
			else
				l_timeout.put (s)
			end
		ensure
			timeout_set: attached timeout as l_timeout_var and then l_timeout_var.item = s
		end

	set_source_proxy (host: STRING_8; port: INTEGER)
			-- Set source proxy host to `host' and port to `port'.
		require
			host_not_empty: host /= Void and then not host.is_empty
			port_non_negative: port >= 0
		do
			create source_proxy.make (host, port)
		ensure
			source_proxy_exists: source_proxy /= Void
			host_port_set: attached source_proxy as l_proxy and then (l_proxy.host = host and l_proxy.port = port)
		end

	set_target_proxy (host: STRING_8; port: INTEGER)
			-- Set target proxy host to `host' and port to `port'.
		require
			host_not_empty: host /= Void and then not host.is_empty
			port_non_negative: port >= 0
		do
			create target_proxy.make (host, port)
		ensure
			target_proxy_exists: attached target_proxy
			host_port_set: attached target_proxy as p and then (p.host = host and p.port = port)
		end

	set_proxies (host: STRING_8; port: INTEGER)
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
			proxies_equal: source_proxy = target_proxy
			host_port_set: attached source_proxy as l_proxy and then (l_proxy.host = host and l_proxy.port = port)
		end

	reset_source_proxy
			-- Reset source proxy.
		do
			source_proxy := Void
		ensure
			no_source_proxy_set: source_proxy = Void
		end

	reset_target_proxy
			-- Reset target proxy.
		do
			target_proxy := Void
		ensure
			no_target_proxy_set: target_proxy = Void
		end

	reset_proxies
			-- Reset source and target proxy.
		do
			source_proxy := Void
			target_proxy := Void
		ensure
			no_source_proxy_set: source_proxy = Void
			no_target_proxy_set: target_proxy = Void
		end

feature -- Element change

	add_transaction (s, t: STRING_8)
			-- Add transaction from source `s' to target `t'.
		require
			source_exists: s /= Void
			target_exists: t /= Void
		local
			l_sr: detachable DATA_RESOURCE
			l_tr: detachable DATA_RESOURCE
			l_timeout: like timeout
		do
			last_added_source_correct := is_address_correct (s, Readable)
			last_added_target_correct := is_address_correct (t, Writable)
			if last_added_source_correct and last_added_target_correct then
				optimized_transactions := Void
				transfer_manager := Void

					-- Set `address' and `url'.
				resource_factory.set_address (s)
				check
					attached resource_factory.url as su and then
					attached resource_hash.item (su.location) as sr
				then
					l_sr := sr.deep_twin
				end

					-- Set `address' and `url'.
				resource_factory.set_address (t)
				check
					attached resource_factory.url as tu and then
					attached resource_hash.item (tu.location) as tr
				then
					l_tr := tr.deep_twin
				end
				l_timeout := timeout
				if l_timeout /= Void then
					l_sr.set_timeout (l_timeout.item)
					l_tr.set_timeout (l_timeout.item)
					debug
						Io.error.put_string ("Timeout set to ")
						Io.error.put_integer (l_timeout.item)
						Io.error.put_string (" seconds%N")
					end
				end
				transactions.extend (create {SINGLE_TRANSACTION}.make (l_sr, l_tr))
			end
		ensure
			one_more_transaction_if_correct:
				(last_added_source_correct and
				last_added_target_correct) implies count = old count + 1
		end

feature -- Removal

	remove_transaction (n: INTEGER)
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

	wipe_out
			-- Clear manager.
		do
			transactions.wipe_out
			readable_set.wipe_out
			writable_set.wipe_out
			resource_hash.wipe_out
			optimized_transactions := Void
			transfer_manager := Void
		ensure
			empty: is_empty
			no_optimized_transactions: optimized_transactions = Void
			no_manager: not manager_built
		end

feature -- Basic operations

	build_manager
			-- Build manager.
		require
			not_empty: not is_empty
		do
			optimize_transactions
			setup_manager
		ensure
			manager_ready: manager_built
		end

	transfer
			-- Start transfer.
		require
			manager_built: manager_built
		do
			manager.transfer
		ensure
			transfer_finished: transfer_finished
		end

feature {NONE} -- Constants

	Readable: INTEGER = 1
	Writable: INTEGER = 2
			-- Mode constants

feature {NONE} -- Implementation

	transactions: ARRAYED_LIST [TRANSACTION]
			-- Registered transactions

	optimized_transactions: detachable ARRAYED_LIST [TRANSACTION]
			-- Optimized transactions

	transfer_manager: detachable TRANSFER_MANAGER
			-- Transfer manager

	readable_set: BINARY_SEARCH_TREE_SET [STRING]
			-- Set storing readable adresses

	writable_set: BINARY_SEARCH_TREE_SET [STRING]
			-- Set storing writable adresses

	resource_hash: HASH_TABLE [DATA_RESOURCE, STRING]
			-- Hash table of created resources

	timeout: detachable CELL [INTEGER]
			-- Duration of timeout in seconds
			-- (If `Void' the default value is used.)

	source_proxy: detachable PROXY_INFORMATION
			-- Information about proxy for the source resource

	target_proxy: detachable PROXY_INFORMATION
			-- Information about proxy for the target resource

	optimized_count: INTEGER
			-- Number of optimized transactions
		do
			if
				attached optimized_transactions as l_optimized_transactions and then
				not l_optimized_transactions.is_empty
			then
				⟳ t: l_optimized_transactions ¦ Result := Result + t.count ⟲
			end
		end

	optimize_transactions
			-- Optimize registered transactions.
		require
			not_empty: not is_empty
		local
			hash: HASH_TABLE [LINKED_LIST [INTEGER], URL]
			addr: URL
			l_list: LINKED_LIST [INTEGER]
			multitrans: MULTIPLE_TRANSACTION
			l_optimized_transactions: like optimized_transactions
		do
			create hash.make (count)
			across transactions as t loop
				addr := t.item.source.address
				if attached hash.item (addr) as lst then
					lst.extend (t.target_index)
				else
					create l_list.make
					l_list.extend (t.target_index)
					hash.put (l_list, addr)
				end
			end

			create l_optimized_transactions.make (count)
			optimized_transactions := l_optimized_transactions

			across transactions as t loop
				if attached hash.item (t.item.source.address) as lst then
					if not transactions [lst.first].source.supports_multiple_transactions or lst.count = 1 then
						across lst as c loop
							l_optimized_transactions.extend (transactions [c.item])
						end
					else
						create multitrans.make
						across
							lst as c
						loop
							multitrans.add_transaction (transactions [c.item])
						end
						l_optimized_transactions.extend (multitrans)
					end
					hash.remove (t.item.source.address)
				end
			end
		ensure
			optimized:
				attached optimized_transactions as l_optimized_transactions_var and then
					l_optimized_transactions_var.is_empty
		end

	setup_manager
			-- Setup transfer manager.
		require
			no_manager: not manager_built
			optimized: optimized_count > 0
		local
			l_manager: like transfer_manager
		do
			create l_manager.make
			transfer_manager := l_manager
			if attached optimized_transactions as l_optimized_transactions then
				l_manager.stop_on_error
				across
					l_optimized_transactions as t
				loop
					l_manager.add_transaction (t.item)
				end
			end
		ensure
			manager_set_up: manager_built
		end

	add_reference (s: SET [STRING]; r: DATA_RESOURCE;
				f: FUNCTION [BOOLEAN]): BOOLEAN
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

	remove_reference (s: SET [STRING]; r: DATA_RESOURCE)
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

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
