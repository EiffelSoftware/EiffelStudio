note
	description: "[
				The {_POOL} handles {G} for reuse. Number of {G} is not checked and no queueing support.
				Check {THREAD_POOL_MANAGER} for a managed {POOL}
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	POOL [G]

create
	make

feature -- Initialization

	make (init_size: NATURAL; an_object_spawner: FUNCTION[ANY, TUPLE, G])
			-- `spawn_function' generates new instances of {POOLED_THREAD}.
			--	`init_size' is the initial size of the list of threads. No boundaries check!
		require
			init_size_geq_0: init_size >= 0
		do
			count := 0
			spawner := an_object_spawner
			create unused_objects.make (init_size.as_integer_32)
			create pool_mutex.make
		end

feature {NONE} -- Access

	spawner: FUNCTION[ANY, TUPLE, G]
			-- An agent which spawns objects

	pool_mutex: MUTEX
			-- Mutex to lock the pool

	unused_objects: ARRAYED_STACK [G]
			-- Threads that can be reused

feature -- Access

	count: NATURAL
			-- Number of objects spawned since instantiation (running and waiting)

	retrieve_available_object: G
			-- Returns an available objects, if there are any
		require
			objects_available: unused_objects_count > 0
		do
			Result := unused_objects.item
			unused_objects.remove
		end

feature -- Status report

	has_unused_objects: BOOLEAN
			-- Is there an unused thread?
		do
			Result := unused_objects.count > 0
		end

feature -- Measurement

	unused_objects_count: NATURAL
			-- Number of unused threads
		do
			Result := unused_objects.count.as_natural_32
		end

feature -- Resizing

	spawn_new_object
			-- Increases the size of the pool.
		local
			object: G
		do
			--create thread.make (manager)
			object := spawner.item (Void)
			unused_objects.put (object)
			count := count + 1
		end

feature {THREAD_POOL_MANAGER} -- Implementation

	ready (an_object: detachable G)
			-- Used internally. When a thread has finished it's duty it will report to the pool manager.
			-- Thread will be stored for further use.
		require
			object_attached: an_object /= Void
		do
			pool_mutex.lock
			unused_objects.put (an_object)
			pool_mutex.unlock
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
