indexing
	description: "[
		Safe version of DISPOSABLE.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	SAFE_DISPOSABLE

inherit
	DISPOSABLE
		rename
			dispose as unmake
		export
			{NONE} all
		end

	USEABLE_I

feature {NONE} -- Clean Up

	frozen unmake is
			-- GC finalization call.
		local
			retried: BOOLEAN
		do
			if not retried and not is_zombie then
				safe_dispose (False)
			end
		rescue
			retried := True
			retry
		end

feature -- Clean Up

	dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		local
			retried: BOOLEAN
		do
			if not is_actively_disposing then
				debug ("trace")
					print ("Disposing of {" + generating_type + "}.%N")
				end

				is_actively_disposing := True

				if not retried and then not is_zombie then
					safe_dispose (True)
				elseif not retried then
					debug ("trace")
						print ("Warning {" + generating_type + "} has already been disposed!%N")
					end
				end
				clean_up
				is_zombie := True
				is_actively_disposing := False
			end
		ensure then
			is_zombie: (not is_actively_disposing implies is_zombie) and
				(is_actively_disposing implies not is_zombie)
			not_is_actively_disposing: is_zombie implies not is_actively_disposing
		rescue
			retried := True
			retry
		end

feature {NONE} -- Clean Up

	frozen clean_up is
			-- Resets state when `safe_dispose' raises an exception.
		local
			retried: BOOLEAN
		do
			if not retried then
				safe_clean_up
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	is_zombie: BOOLEAN
			-- Has `Current' been disposed of?

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := not is_zombie
		end

feature {NONE} -- Status report

	is_actively_disposing: BOOLEAN
			-- Indicates if `Current' is actively being disposed of

feature {NONE} -- Implementation

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Effect it in descendants to perform specific dispose
			-- actions. Those actions should only take care of freeing
			-- external resources; they should not perform remote calls
			-- on other objects since these may also be dead and reclaimed.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		require
			not_is_zombie: not is_zombie
		deferred
		end

	safe_clean_up is
			-- Resets state when `safe_dispose' raises an exception.
		do
		end

invariant
	not_is_interface_usable: is_zombie implies not is_interface_usable

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
