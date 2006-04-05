indexing
	description: "Object being debugged."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class DEBUGGED_OBJECT_DOTNET

inherit
	DEBUGGED_OBJECT

	SHARED_DEBUG_VALUE_KEEPER
		export
			{NONE} all
		end

create {DEBUGGED_OBJECT_MANAGER}
	make

feature {NONE} -- Access

	make (addr: like object_address; sp_lower, sp_upper: INTEGER) is
			-- Make debugged object with hector address `addr'
			-- with upper and lower bounds `sp_lower' and `sp_upper'.
			-- (At this stage we do not know if addr is a special object
			-- and we don't want to retrieve all of the special object 
			-- especially if it has thousands of entries).
			-- (-1 for `sp_upper' stands for the upper bound
			-- of the inspected special object)	
		local
			l_val: ABSTRACT_DEBUG_VALUE
			l_spec_val: ABSTRACT_SPECIAL_VALUE
			l_ref_val: EIFNET_DEBUG_REFERENCE_VALUE
			l_str_val: EIFNET_DEBUG_STRING_VALUE
		do
			debug ("debug_recv")
				print ("DEBUGGED_OBJECT_DOTNET.make%N")
			end
			l_val := kept_object_item (addr)
			if l_val /= Void then
				is_tuple := False --| We considers Tuple object as Ref with Array container
				
				l_spec_val ?= l_val
				if l_spec_val /= Void then
					is_special := True
					capacity := l_spec_val.capacity
				else
					l_str_val ?= l_val
					if l_str_val /= Void then
						is_string_value := True
						capacity := l_str_val.length				
					end			
				end

				dtype := l_val.dynamic_class
				if dtype = Void then
						-- Oops, the run-time returned a type that is not in the system.
						-- We then default to class ANY.
					dtype := eiffel_system.Any_class.compiled_class
				end

				l_ref_val ?= l_val
				if l_ref_val /= Void then
					class_type := l_ref_val.dynamic_class_type
				else
					class_type := dtype.types.first
				end

			end
			object_address := addr;
			max_capacity := -1
		end

feature {DEBUGGED_OBJECT_MANAGER} -- Refreshing

	refresh (sp_lower, sp_upper: INTEGER) is
		do
			internal_attributes := Void
		end		

feature -- Properties

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Attributes of object being inspected (sorted by name)
		local
			l_val: ABSTRACT_DEBUG_VALUE			
		do
			Result := internal_attributes
			if Result = Void then
				l_val := kept_object_item (object_address)
				if l_val /= Void then
					Result := l_val.children
					internal_attributes := Result
				end
			end
		end

	is_string_value: BOOLEAN
	
feature {NONE} -- Implementation

	internal_attributes: like attributes

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
		do
			Result := Debug_value_keeper.item (a_address)
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
