note
	description: "[
					Synchronizer for a value
					This class will synchronize a value with all registered hosts.
					For example, a preference item and its associated UI button.
					
					To register a host, a client needs to specify 4 things:
					(1) a register agent,  which is used to make sure that that host will call `on_value_change_from' when value in that host changes.
					(2) a deregister agent, which is used to detach `on_value_change_from' from that host to avoid possible memory leak.
					(3) a getter, which is used to retrieve value from that host,
					(4) a setter, which is used to set value into that host.
					
					After use, remember to deregister every host.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_VALUE_SYNCHRONIZER [G]

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_value,
	make_with_host

feature{NONE} -- Initialization

	default_create
			-- Process instances of classes with no creation clause.
			-- (Default: do nothing.)
		do
			create hosts.make (2)
			create hosts_agents.make (2)
			host_hash_code_internal := 1
		end

	make_with_value (a_value: G)
			-- Initialize `current_value' with `a_value'.
		do
			default_create
			set_value (a_value)
		ensure
			current_value_set: is_value_equal (current_value, a_value)
		end

	make_with_host (a_host: ANY; a_host_agents: like host_agents_type)
			-- Initialize Current and register `a_host' whose host agents are` a_host_agents' and
			-- make sure Current is synchronized with `a_host'.
		require
			a_host_attached: a_host /= Void
			a_host_agents_attached: a_host_agents /= Void
			a_host_agents_valid: is_host_agent_valid (a_host_agents)
		do
			default_create
			register_host (a_host, a_host_agents, True)
		ensure
			a_host_registered: has_host_registered (a_host)
			value_synchronized: is_value_synchronized and then is_value_equal (current_value, a_host_agents.getter.item (Void))
		end

feature -- Access

	current_value: G
			-- Current synchronized value

	host_agents_type: TUPLE [register: PROCEDURE [ANY, TUPLE [EB_VALUE_SYNCHRONIZER [ANY]]];
							deregister: PROCEDURE [ANY, TUPLE [EB_VALUE_SYNCHRONIZER [ANY]]];
							getter: FUNCTION [ANY, TUPLE, G];
							setter: PROCEDURE [ANY, TUPLE [G]]]
			-- Anchored type for host agents
			-- `register' is used to register Current synchronizer into that value host,
			-- this alway needs to make sure that that value host calls `on_value_change_from' when value changes.
			-- `deregister' is used to remove Current synchronizer from that value host,
			-- this always needs to detach `on_value_change_from' from that value host class.
			-- `setter' is used to set value into that

	value_equality_tester: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]
			-- Agent to test if 2 given values are equal
			-- If Void, `is_value_equal' will be used to test value equality.

feature -- Status report

	is_value_synchronized: BOOLEAN
			-- Is value from all registered value hosts synchronized?
		local
			l_agents: like hosts_agents
			l_current_value: like current_value
			l_cursor: CURSOR
		do
			l_agents := hosts_agents
			l_current_value := current_value
			Result := True
			l_cursor := l_agents.cursor
			from
				l_agents.start
			until
				l_agents.after or not Result
			loop
				Result := is_value_equal (l_current_value, l_agents.item_for_iteration.getter.item (Void))
				l_agents.forth
			end
			l_agents.go_to (l_cursor)
		end

	is_host_agent_valid (a_host_agents: like host_agents_type): BOOLEAN
			-- Are agents in `a_host_agents' valid?
		require
			a_host_agents_attached: a_host_agents /= Void
		do
			Result := a_host_agents.register /= Void and then
					  a_host_agents.deregister /= Void and then
					  a_host_agents.getter /= Void and then
					  a_host_agents.setter /= Void
		ensure
			good_result: Result implies (a_host_agents.register /= Void and then
					  					 a_host_agents.deregister /= Void and then
					  					 a_host_agents.getter /= Void and then
					  					 a_host_agents.setter /= Void)
		end

	has_host_registered (a_host: ANY): BOOLEAN
			-- Has `a_host' registered already?
		require
			a_host_attached: a_host /= Void
		local
			l_hosts: like hosts
			l_cursor: CURSOR
		do
			l_hosts := hosts
			l_cursor := l_hosts.cursor
			from
				l_hosts.start
			until
				l_hosts.after or Result
			loop
				Result := l_hosts.item_for_iteration = a_host
				l_hosts.forth
			end
			l_hosts.go_to (l_cursor)
		end

feature -- Synchronization

	on_value_change_from (a_host: ANY)
			-- Action to be performed when value from value in `a_host' changes
			-- This feature is invoked from some value host, and it is responsible to notify all other
			-- value host to synchronize.
		require
			a_host_attached: a_host /= Void
			a_host_registered: has_host_registered (a_host)
		local
			l_hosts: like hosts
			l_host: ANY
			l_value: like current_value
			l_cursor: CURSOR
		do
			l_value := agents_of_host (a_host).getter.item (Void)
			if not is_value_equal (current_value, l_value) then
				set_value (l_value)
				l_hosts := hosts
				l_cursor := l_hosts.cursor
				from
					l_hosts.start
				until
					l_hosts.after
				loop
					l_host := l_hosts.item_for_iteration
					if l_host /= a_host then
						agents_of_host (l_host).setter.call ([l_value])
					end
					l_hosts.forth
				end
				l_hosts.go_to (l_cursor)
			end
		ensure
			values_synchronized: is_value_synchronized
		end

feature -- Setting

	set_value_equality_tester (a_tester: like value_equality_tester)
			-- Set `value_equality_tester' with `a_tester'.
		do
			value_equality_tester := a_tester
		ensure
			value_equality_tester_set: value_equality_tester = a_tester
		end

feature -- Host registration

	register_host (a_host: ANY; a_host_agents: like host_agents_type; a_force_synchronize: BOOLEAN)
			-- Register `a_host' whose synchronization agents are `a_host_agents' into Current.
			-- If `a_force_synchronize' is True, force other registered hosts to synchronize their value with `a_host'.
			-- If `a_force_synchronize' is False, use `current_value' to synchronize `a_host'.
		require
			a_host_attached: a_host /= Void
			a_host_agents_attached: a_host_agents /= Void
			a_host_agents_valid: is_host_agent_valid (a_host_agents)
			a_host_not_registered: not has_host_registered (a_host)
		local
			l_hash_code: like hash_code_for_host
		do
			l_hash_code := hash_code_for_host (a_host)
			hosts.put (a_host, l_hash_code)
			hosts_agents.put (a_host_agents, l_hash_code)
			a_host_agents.register.call ([Current])
			if a_force_synchronize then
				on_value_change_from (a_host)
			else
				a_host_agents.setter.call ([current_value])
			end
		ensure
			host_registered: has_host_registered (a_host)
			agents_registered: hosts_agents.item (hash_code_of_registered_host (a_host)) = a_host_agents
			value_synchronized:
				is_value_synchronized and then (
					(a_force_synchronize implies is_value_equal (current_value, old (a_host_agents.getter.item (Void)))) and then
					(not a_force_synchronize implies is_value_equal (old current_value, a_host_agents.getter.item (Void))))
		end

	deregister_host (a_host: ANY)
			-- Deregister `a_host'.
		require
			a_host_attached: a_host /= Void
			a_host_registered: has_host_registered (a_host)
		local
			l_hash_code: INTEGER
		do
			l_hash_code := hash_code_of_registered_host (a_host)
			agents_of_host (a_host).deregister.call ([Current])
			hosts.remove (l_hash_code)
			hosts_agents.remove (l_hash_code)
		ensure
			host_deregistered: not has_host_registered (a_host)
			agents_removed: not hosts_agents.has (old hash_code_of_registered_host (a_host))
		end

	wipe_out_hosts
			-- Deregister all hosts.
		local
			l_hosts: like hosts
			l_cursor: CURSOR
		do
			l_hosts := hosts
			l_cursor := l_hosts.cursor
			from
				l_hosts.start
			until
				l_hosts.after
			loop
				deregister_host (l_hosts.item_for_iteration)
				l_hosts.forth
			end
			l_hosts.go_to (l_cursor)
			l_hosts.wipe_out
			hosts_agents.wipe_out
		ensure
			hosts_wiped_out: hosts.count = 0 and then hosts_agents.count = 0
		end

feature{NONE} -- Implementation

	hash_code_for_host (a_host: ANY): INTEGER
			-- Hash code for `a_host'.
		require
			a_host_attached: a_host /= Void
		do
			Result := host_hash_code_internal
			host_hash_code_internal := host_hash_code_internal + 1
		ensure
			good_result: Result = old host_hash_code_internal
		end

	hosts: HASH_TABLE [ANY, INTEGER]
			-- Hosts: [host object, host hash code]

	hosts_agents: HASH_TABLE [like host_agents_type, INTEGER]
			-- Agents used for every host to sychronize value.
			-- [[register, deregister, getter, setter], host hash code]

	is_value_equal (a_value, b_value: G): BOOLEAN
			-- Is `a_value' equal to `b_value'?
		do
			Result := equal (a_value, b_value)
		end

	actual_value_tester: like value_equality_tester
			-- Actual value tester
		do
			Result := value_equality_tester
			if Result = Void then
				Result := agent is_value_equal
			end
		ensure
			result_attached: Result /= Void
		end

	set_value (a_value: G)
			-- Set `current_value' with `a_value'.
		do
			if not is_value_equal (a_value, current_value) then
				current_value := a_value
			end
		ensure
			current_value_set: is_value_equal (a_value, current_value)
		end

	host_hash_code_internal: INTEGER
			-- Internal hash code for new host

	hash_code_of_registered_host (a_host: ANY): INTEGER
			-- Hash code of `a_host'
		require
			a_host_attached: a_host /= Void
			a_host_registered: has_host_registered (a_host)
		local
			l_hosts: like hosts
			done: BOOLEAN
			l_cursor: CURSOR
		do
			l_hosts := hosts
			l_cursor := l_hosts.cursor
			from
				l_hosts.start
			until
				l_hosts.after or done
			loop
				if l_hosts.item_for_iteration = a_host then
					Result := l_hosts.key_for_iteration
					done := True
				end
				l_hosts.forth
			end
			l_hosts.go_to (l_cursor)
		end

	agents_of_host (a_host: ANY): like host_agents_type
			-- Agents for `a_host'.
		require
			a_host_attached: a_host /= Void
			a_host_registered: has_host_registered (a_host)
		do
			Result := hosts_agents.item (hash_code_of_registered_host (a_host))
		ensure
			result_attached: Result /= Void
		end

invariant
	hosts_agents_attached: hosts_agents /= Void
	hosts_attached: hosts /= Void

end
