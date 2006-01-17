indexing

	description: 
		"Run time value representing of reference object."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class REFERENCE_VALUE

inherit

	ABSTRACT_REFERENCE_VALUE
		redefine
			set_hector_addr, sorted_children
		end

	OBJECT_ADDR
		export
			{NONE} all
		undefine
			is_equal
		end;
	CHARACTER_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end;

	SHARED_DEBUG
		export
			{NONE} all
		undefine
			is_equal
		end;

create {DEBUG_VALUE_EXPORTER}

	make, make_attribute

feature {NONE} -- Initialization

	make (a_reference: POINTER; id: like dynamic_type_id) is
			-- Set `address' to `a_reference' address
			-- and `dynamic_type_id' to `id'.
		do
			set_default_name;
			if a_reference /= Default_pointer then
				address := a_reference.out
				is_null := (address = Void)
				dynamic_type_id := id;
			end;
		end;

	make_attribute (attr_name: like name; a_class: like e_class;
						type: like dynamic_type_id; addr: like address) is
		require
			not_attr_name_void: attr_name /= Void;
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			dynamic_type_id := type;
			address := addr
			is_null := (address = Void)
		end;

feature -- Access

	dynamic_class: CLASS_C is
		do
			Result := private_dynamic_class
			if Result = Void then
				if Eiffel_system.valid_dynamic_id (dynamic_type_id) then
					--| Extra safe test. The dynamic type should be known
					--| from the system, but somehow Dino managed to crash
					--| ebench here. This is very weird!!!
					Result := Eiffel_system.class_of_dynamic_id (dynamic_type_id)
					private_dynamic_class := Result
				end
			end
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		local
			l_cl: CLASS_C
		do
			debug ("debug_recv")
				print ("Dumping value ")
				print (address)
				print (dynamic_class /= Void)
				if dynamic_class /= Void then
					print (" ")
					print (dynamic_class.name_in_upper)
				end
				print ("%N")
			end
			if dynamic_class /= Void then
				l_cl := dynamic_class
			else
				l_cl := static_class
			end
			create Result.make_object (address, l_cl)
		end

feature {NONE} -- Output value

	type_and_value: STRING is
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
		do
			if address = Void then
				Result := NONE_representation
			else
				ec := dynamic_class;
				if ec /= Void then
					create Result.make (60)
					Result.append (ec.name_in_upper)
					Result.append (Left_address_delim)
					Result.append (address)
					Result.append (Right_address_delim)
				else
					create Result.make (20)
					Result.append (Any_class.name_in_upper)
					Result.append (Is_unknown)
				end
			end
		end

feature -- Output

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. 
			-- May be void if there are no children.
			-- Generated on demand.
		local
			obj: DEBUGGED_OBJECT
		do
			debug ("debug_recv")
				print ("REFERENCE_VALUE.children%N")
			end
			obj := debugged_object_manager.debugged_object (address, min_slice, max_slice)
			is_already_sorted := obj.is_tuple or obj.is_special
			Result := obj.attributes
		end

	sorted_children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- sort `children' and return it.
		do
			Result := children
			if 
				Result /= Void and then not is_already_sorted
			then
				sort_debug_values (Result)
			end
		end

feature {NONE} -- Implementation

	is_already_sorted: BOOLEAN
			-- Does the children are attached to a Tuple or Special object?
			-- i.e: is Current a Tuple or a Special object ?
			--| Nota: may be used only after a call to `children'
		
	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
			-- If referenced object is a STRING, get its value.
		do
			if address /= Void then
				address := keep_object_as_hector_address (address);
			end
			is_null := (address = Void)
		end;

feature {NONE} -- Property

	min_slice: INTEGER is
			-- From which attribute number should special objects be displayed?
		do
			Result := min_slice_ref.item
		end

	max_slice: INTEGER is
			-- Up to which attribute number should special objects be displayed?
		do
			Result := max_slice_ref.item
		end

	dynamic_type_id: INTEGER;
			-- Dynamic type id of return type

	private_dynamic_class: CLASS_C;
			-- Saved class 
			

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class REFERENCE_VALUE
