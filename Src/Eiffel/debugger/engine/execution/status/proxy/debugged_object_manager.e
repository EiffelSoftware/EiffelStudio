indexing
	description: "Objects that manages DEBUGGED_OBJECT instances."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGED_OBJECT_MANAGER

create {DEBUGGER_MANAGER}
	make

feature {NONE}-- Creation

	make (dbg_manager: DEBUGGER_MANAGER) is
			-- Instanciate with `dbg_manager'
		do
			debugger_manager := dbg_manager
			if dbg_manager.is_dotnet_project then
				set_dotnet_system
			end
			caching_enabled := False
		end

feature -- Reset

	reset is
			-- Reset Current
		do
			last_debugged_object := Void
		end

feature -- Settings

	set_dotnet_system is
			-- Set dotnet system behavior
		do
			is_dotnet := True
		end

feature -- Query

	class_type_at_address (addr: DBG_ADDRESS): CLASS_TYPE is
			-- CLASS_TYPE for remote object at address `addr'
		require
			address_not_void: addr /= Void and then not addr.is_void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.class_type
		end

	class_c_at_address (addr: DBG_ADDRESS): CLASS_C is
			-- CLASS_C for remote object at address `addr'
		require
			address_not_void: addr /= Void and then not addr.is_void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.dynamic_class
		end

	attributes_at_address (addr: DBG_ADDRESS; sp_lower, sp_upper: INTEGER): DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Attributes for remote object at address `addr'
		require
			address_not_void: addr /= Void and then not addr.is_void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, sp_lower, sp_upper)
			Result := dobj.attributes
		end

	sorted_attributes_at_address (addr: DBG_ADDRESS; sp_lower, sp_upper: INTEGER): DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Sorted attributes for remote object at address `addr'
		require
			address_not_void: addr /= Void and then not addr.is_void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, sp_lower, sp_upper)
			Result := dobj.sorted_attributes
		end

	object_at_address_has_attributes (addr: DBG_ADDRESS): BOOLEAN is
			-- Remote object at address `addr' has attribute ?
		require
			address_not_void: addr /= Void and then not addr.is_void
		local
			dobj: DEBUGGED_OBJECT
			lst: DS_LIST [ABSTRACT_DEBUG_VALUE]
		do
			dobj := debugged_object (addr, 0, 0)
			lst := dobj.sorted_attributes
			Result := lst /= Void and then not lst.is_empty
		end

	special_object_capacity_at_address (addr: DBG_ADDRESS): INTEGER is
			-- Capacity of SPECIAL remote object at address `addr'
		require
			address_not_void: addr /= Void and then not addr.is_void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.capacity
		end

feature -- Settings

	last_debugged_object: DEBUGGED_OBJECT
			-- Last debugged object

	last_sp_lower, last_sp_upper: INTEGER
			-- Last special lower and upper value

	debugger_manager: DEBUGGER_MANAGER
			-- Associated debugger manager

	caching_enabled: BOOLEAN
			-- Caching enabled?


feature -- Status report

	is_valid_object_address (addr: DBG_ADDRESS): BOOLEAN is
				-- Is `addr' a valid object address?
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application.is_valid_object_address (addr)
		end

	is_dotnet: BOOLEAN
			-- Is related to dotnet system?

feature -- Access

	classic_debugged_object_with_class (addr: DBG_ADDRESS; a_compiled_class: CLASS_C): DEBUGGED_OBJECT_CLASSIC is
			-- Debugged object at address `addr' for classic system
		require
			not is_dotnet
		do
			create Result.make_with_class (addr, a_compiled_class)
		end

	debugged_object (addr: DBG_ADDRESS; sp_lower, sp_upper: INTEGER): DEBUGGED_OBJECT is
				-- Debugged remote object located at address `addr'
		require
			non_void_addr: addr /= Void and then not addr.is_void
			valid_addr: is_valid_object_address (addr)
			valid_bounds: sp_lower >= 0 and (sp_upper >= sp_lower or else sp_upper = -1)
		do
			debug ("debugger_caching")
				print (generator + " : debugged_object for " + addr.output + " [" + sp_lower.out + ":" + sp_upper.out + "]%N")
			end
			if
				caching_enabled and then
				last_debugged_object /= Void
				and then last_debugged_object.object_address.is_equal (addr)
			then
				debug ("debugger_caching")
					print (generator + " : reused last debugged_object %N")
				end

				Result := last_debugged_object
				if last_sp_lower < sp_lower or last_sp_upper > sp_upper then
					debug ("debugger_caching")
						print (generator + " : but with slices ")
						print ("[" + sp_lower.out + ", " + sp_upper.out + "]" )
						print (" instead of ")
						print ("[" + last_sp_lower.out + ", " + last_sp_upper.out + "]" )
						print ("%N")
					end
					Result.refresh (sp_lower, sp_upper)
					debug ("debugger_caching")
						print (generator + " => capacity:" + Result.capacity.out + ", att_count:" + Result.attributes.count.out + " %N")
					end
				elseif last_sp_lower /= sp_lower or last_sp_upper /= sp_upper then
					debug ("debugger_caching")
						print (generator + " : slices already included into reused debugged object %N")
						print (generator + " : ["
								+ sp_lower.out + ":" + sp_upper.out
								+ "] included into ["
								+ last_sp_lower.out + ":" + last_sp_upper.out
								+"] %N")
					end
				end
			else
				debug ("debugger_caching")
					print (generator + " : new debugged_object %N")
				end
				if is_dotnet then
					create {DEBUGGED_OBJECT_DOTNET} Result.make (addr, sp_lower, sp_upper)
				else
					create {DEBUGGED_OBJECT_CLASSIC} Result.make (addr, sp_lower, sp_upper)
				end
			end
			last_debugged_object := Result
			last_sp_lower := sp_lower
			last_sp_upper := sp_upper
		ensure
			Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
