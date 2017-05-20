note
	description: "{POOLED_THREAD} is used in combination with {THREAD_POOL} to allow for pooled threads."
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	POOLED_THREAD [G]

inherit
	THREAD
		rename
			make as thread_make
		end

create {THREAD_POOL}
	make

feature {NONE} -- Initialization

	make (a_thread_pool: THREAD_POOL [G]; a_semaphore: SEMAPHORE)
			-- `a_thread_pool', the pool in which this thread is managed
			-- `a_semaphore' is used for execution suspending
		do
			thread_make
			thread_pool := a_thread_pool
			semaphore := a_semaphore
		end

feature {NONE} -- Access

	thread_pool: THREAD_POOL [G]
			-- Pool manager in which this thread is pooled

	target: detachable G
			-- Target on which the `thread_procedure' should be applied
			-- Depending on which launch is used, target is not used

	thread_procedure: detachable PROCEDURE
			-- Work that should be executed by the thread

	semaphore: SEMAPHORE
			-- Semaphore share with all threads in a thread pool
			-- to suspend execution until more work is available

feature -- Access

	set_target (a_target: G)
			-- Sets the target on which the work should be executed
		do
			target := a_target
		end

feature {NONE} -- Implementation

	execute
			-- <Precursor>
		local
			done: BOOLEAN
		do
			from
				semaphore.wait
				thread_procedure := thread_pool.get_work (Current)
			until
				done
			loop
				if attached thread_procedure as l_work then
					if attached target as t then
						l_work.call ([t])
					else
						l_work.call (Void)
					end
				end
				if thread_pool.over then
					done := True
				else
					thread_procedure := thread_pool.get_work (Current)
					if thread_procedure = Void then
						semaphore.wait
						thread_procedure := thread_pool.get_work (Current)
					end
				end
			end
			thread_pool.thread_terminated (Current)
		end

note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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


