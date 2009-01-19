note
	description: "[
		A safe (protectect) version of {DISPOSABLE_I}, linked with the well known GC linked {DISPOSABLE}.
		
		Note: Never call {DISPOSABLE}.dispose on objects that implement {DISPOSABLE_SAFE} because they
		      will be treated in the same manner as GC finalization calls.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DISPOSABLE_SAFE

inherit
	DISPOSABLE
		rename
			dispose as unmake
		export
			{NONE} all
		end

	DISPOSABLE_I

feature {NONE} -- Clean Up

	frozen unmake
			-- GC finalization call.
		do
			if not is_disposed then
				safe_dispose (False)
			end
		end

feature -- Clean Up

	dispose
			-- <Precursor>
		local
			l_active: BOOLEAN
			l_auto: like internal_automation
			retried: BOOLEAN
		do
			check not_is_in_final_collect: not is_in_final_collect end
			l_active := is_actively_disposing
			if not l_active then
				debug ("dispose")
					print ("Disposing of {" + generating_type + "}.%N")
				end

				is_actively_disposing := True

				if not retried then
					if not is_disposed then
						l_auto := internal_automation
						if l_auto /= Void then
								-- Clean up all other autonomously disposed objects.
							l_auto.perform_automotive_dispose (agent
								do
									safe_dispose (True)
									is_disposed := True
								rescue
									is_disposed := True
								end)
						else
								-- The handler was never used, just dispose normally.
							safe_dispose (True)
							is_disposed := True
						end
					else
						debug ("dispose")
							print ("Warning {" + generating_type + "} has already been disposed!%N")
						end
					end
				end

					-- Perform object clean up, if necessary
				clean_up

				is_actively_disposing := False
			end
		ensure then
			is_disposed: not old is_actively_disposing implies
				((not is_actively_disposing implies is_disposed) and
				(is_actively_disposing implies not is_disposed))
			not_is_actively_disposing: not old is_actively_disposing implies
				(is_disposed implies not is_actively_disposing)
			is_actively_disposing_unchanged: is_actively_disposing = old is_actively_disposing
		rescue
			is_actively_disposing := l_active
			is_disposed := True
			retried := True
			retry
		end

feature {NONE} -- Clean Up

	safe_dispose (a_explicit: BOOLEAN)
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Effect it in descendants to perform specific dispose
			-- actions. Those actions should only take care of freeing
			-- external resources; they should not perform remote calls
			-- on other objects since these may also be dead and reclaimed.
			--
			-- `a_explicit': True if Current is being explictly disposed of; False to indicate finalization
			--               via the GC, in which case no objects should be created or calls made upon.
		require
			not_is_disposed: not is_disposed
		deferred
		end

	frozen clean_up
			-- Resets state when `safe_dispose' raises an exception.
		require
			is_disposed: is_disposed
			is_actively_disposing: is_actively_disposing
		local
			retried: BOOLEAN
		do
			if not retried then
				safe_clean_up
			end
		ensure
			is_disposed_unchanged: is_disposed = old is_disposed
			is_actively_disposing_unchanged: is_actively_disposing = old is_actively_disposing
		rescue
			retried := True
			retry
		end

	safe_clean_up
			-- Resets state when `safe_dispose' raises an exception.
		require
			is_disposed: is_disposed
			is_actively_disposing: is_actively_disposing
		do
		ensure
			is_disposed_unchanged: is_disposed = old is_disposed
			is_actively_disposing_unchanged: is_actively_disposing = old is_actively_disposing
		end

feature -- Access

	automation: !DISPOSABLE_AUTOMATION_I
			-- <Precursor>
		local
			l_result: like internal_automation
		do
			l_result := internal_automation
			if l_result = Void then
				create l_result
				internal_automation := l_result
				Result := l_result
			else
				Result := l_result
			end
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := not is_disposed
		ensure then
			not_is_disposed: is_disposed implies not Result
		end

feature {DISPOSABLE_I} -- Status report

	is_disposed: BOOLEAN
			-- Indicates if `Current' has been disposed of.

feature {NONE} -- Status report

	is_actively_disposing: BOOLEAN
			-- Indicates if `Current' is actively being disposed of.

feature {DISPOSABLE_I, DISPOSABLE} -- Basic operation

	frozen auto_dispose (a_object: !ANY)
			-- <Precursor>
		do
			if not is_disposed and then not is_actively_disposing then
				automation.auto_dispose (a_object)
			else
				check cannot_dispose: False end
			end
		end

	frozen delayed_auto_dispose (a_action: !FUNCTION [ANY, ?TUPLE, !ANY])
			-- <Precursor>
		do
			if not is_disposed and then not is_actively_disposing then
				automation.delayed_auto_dispose (a_action)
			else
				check cannot_dispose: False end
			end
		end

feature {NONE} -- Implementation: Internal cache

	frozen internal_automation: ?DISPOSABLE_AUTOMATION_HANDLER
			-- Cached version of `automation'
			-- Note: Do not use directly!

invariant
	not_is_interface_usable: is_disposed implies not is_interface_usable

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
