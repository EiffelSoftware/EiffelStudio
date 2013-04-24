note
	description:
		"Implementation of transfer manager builder"
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
			built: manager_built
		local
			l_result: like transfer_manager
		do
			l_result := transfer_manager
			check l_result_attached: l_result /= Void end
			Result := l_result
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
			Result := (Readable <= mode and mode <= Writable)
		end

	is_address_correct (addr: STRING; mode: INTEGER): BOOLEAN
			-- Is address `addr' correct considering `mode'?
			-- (`mode' is `Readable' or `Writable')
		require
			non_empty_address: addr /= Void and then not addr.is_empty
			mode_valid: is_mode_valid (mode)
		local
			res: detachable DATA_RESOURCE
			u: detachable URL
			l_proxy: detachable PROXY_INFORMATION
		do
			resource_factory.set_address (addr)
			if resource_factory.is_address_correct then
				u := resource_factory.url
				check u_attached: u /= Void end
				resource_hash.search (u.location)
				if resource_hash.found then
					res := resource_hash.found_item
				else
					resource_factory.create_resource
					res := resource_factory.resource
				end
				check res_attached: res /= Void end
				inspect
					mode
				when Readable then
					if res.is_proxy_supported then
						l_proxy := source_proxy
						check l_proxy_attached: l_proxy /= Void end
						res.set_proxy_information (l_proxy)
					end
					Result := add_reference (readable_set, res, agent res.is_readable)
				when Writable then
					if res.is_proxy_supported then
						l_proxy := target_proxy
						check l_proxy_attached: l_proxy /= Void end
						res.set_proxy_information (l_proxy)
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

	set_source_proxy (host: STRING; port: INTEGER)
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

	set_target_proxy (host: STRING; port: INTEGER)
			-- Set target proxy host to `host' and port to `port'.
		require
			host_not_empty: host /= Void and then not host.is_empty
			port_non_negative: port >= 0
		do
			create target_proxy.make (host, port)
		ensure
			target_proxy_exists: target_proxy /= Void
			host_port_set: attached {like source_proxy} target_proxy as l_proxy and then (l_proxy.host = host and l_proxy.port = port)
		end

	set_proxies (host: STRING; port: INTEGER)
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

	add_transaction (s, t: STRING)
			-- Add transaction from source `s' to target `t'.
		require
			source_exists: s /= Void
			target_exists: t /= Void
		local
			sr: detachable DATA_RESOURCE
			tr: detachable DATA_RESOURCE
			su: detachable URL
			tu: detachable URL
			ta: SINGLE_TRANSACTION
			l_timeout: like timeout
		do
			last_added_source_correct := is_address_correct (s, Readable)
			last_added_target_correct := is_address_correct (t, Writable)
			if last_added_source_correct and last_added_target_correct then
				optimized_transactions := Void
				transfer_manager := Void

				resource_factory.set_address (s)
				su := resource_factory.url
				check su_attached: su /= Void end
				resource_hash.search (su.location)
				check
						-- Because resource has been created during correctness check
					found: resource_hash.found
				end
				sr := resource_hash.found_item
				check sr_attached: sr /= Void end
				sr := sr.deep_twin

				resource_factory.set_address (t)
				tu := resource_factory.url
				check tu_attached: tu /= Void end
				resource_hash.search (tu.location)
				check
						-- Because resource has been created during correctness check
					found: resource_hash.found
				end
				tr := resource_hash.found_item
				check tr_attached: tr /= Void end
				tr := tr.deep_twin
				debug
					Io.error.put_string (s)
					Io.error.put_string (" -> ")
					Io.error.put_string (t)
					Io.error.put_string (" added.%N")
				end
				l_timeout := timeout
				if l_timeout /= Void then
					sr.set_timeout (l_timeout.item)
					tr.set_timeout (l_timeout.item)
					debug
						Io.error.put_string ("Timeout set to ")
						Io.error.put_integer (l_timeout.item)
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
		local
			l_optimized_transactions: like optimized_transactions
		do
			l_optimized_transactions := optimized_transactions
			if l_optimized_transactions /= Void and then not l_optimized_transactions.is_empty then
				from
					l_optimized_transactions.start
				until
					l_optimized_transactions.after
				loop
					Result := Result + l_optimized_transactions.item.count
					l_optimized_transactions.forth
				end
			end
		end

	optimize_transactions
			-- Optimize registered transactions.
		require
			not_empty: not is_empty
		local
			hash: HASH_TABLE [LINKED_LIST [INTEGER], URL]
			addr: URL
			lst: detachable LINKED_LIST [INTEGER]
			multitrans: MULTIPLE_TRANSACTION
			l_optimized_transactions: like optimized_transactions
		do
			create hash.make (count)
			from transactions.start until transactions.after loop
				addr := transactions.item.source.address
				hash.search (addr)
				if hash.found then
					lst := hash.found_item
					check lst_attached: lst /= Void end
					lst.extend (transactions.index)
				else
					create lst.make
					lst.extend (transactions.index)
					hash.put (lst, addr)
				end
				transactions.forth
			end

			create l_optimized_transactions.make (count)
			optimized_transactions := l_optimized_transactions

			from transactions.start until transactions.after loop
				hash.search (transactions.item.source.address)
				if hash.found then
					lst := hash.found_item
					check lst_attached: lst /= Void end
					lst.start
					if not (transactions @ lst.item).source.supports_multiple_transactions or lst.count = 1 then
						from lst.start until lst.after loop
							l_optimized_transactions.extend (transactions @ lst.item)
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
						l_optimized_transactions.extend (multitrans)
					end
					hash.remove (transactions.item.source.address)
				end
				transactions.forth
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
			l_optimized_transactions: like optimized_transactions
			l_manager: like transfer_manager
		do
			l_optimized_transactions := optimized_transactions
			check l_optimized_transactions_attached: l_optimized_transactions /= Void end
			from
				l_optimized_transactions.start
				create l_manager.make
				transfer_manager := l_manager
				l_manager.stop_on_error
			until
				l_optimized_transactions.after
			loop
				l_manager.add_transaction (l_optimized_transactions.item)
				l_optimized_transactions.forth
			end
		ensure
			manager_set_up: manager_built
		end

	add_reference (s: SET [STRING]; r: DATA_RESOURCE;
				f: FUNCTION [DATA_RESOURCE, TUPLE, BOOLEAN]): BOOLEAN
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TRANSFER_MANAGER_BUILDER_IMPL

