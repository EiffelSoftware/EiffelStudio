indexing

	description:
		"Run time value representing of a special object."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SPECIAL_VALUE

inherit

	ABSTRACT_SPECIAL_VALUE
		redefine
			set_hector_addr
		end

	OBJECT_ADDR
		export
			{NONE} all
		undefine
			is_equal
		end

	CHARACTER_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

create {DEBUG_VALUE_EXPORTER}

	make_set_ref,
	make_attribute

feature {NONE} -- Initialization

	make_set_ref (a_reference: POINTER; id: INTEGER) is
			-- Create Current as a standalone object
			-- i.e: not an attribute
			-- nevertheless at this point we don't have the `capacity'
			-- value, so we'll fetch this value when needed
		do
			set_default_name
			is_attribute := False;
			if a_reference /= Default_pointer then
				address := a_reference.out
			end
			if address = Void then
				is_null := True
				capacity := 0
			else
				set_sp_bounds (debugger_manager.min_slice, debugger_manager.max_slice)
				capacity := -1;
			end
		end

	make_attribute (attr_name: like name; a_class: like e_class;
						addr: like address; cap: like capacity) is
		require
			not_attr_name_void: attr_name /= Void;
			not_addr_void: addr /= Void
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			address := addr;
			is_null := (address = Void)
			capacity := cap;
				--| No need to preallocate area, since the fill_items or similar
				--| will change the capacity if needed
				--| We require only to get a non Void list
		end

feature -- Access

	dynamic_class: CLASS_C is
		once
			Result := Eiffel_system.special_class.compiled_class
		end

	string_value: STRING_32 is
			-- If `Current' represents a string then return its value.
			-- Else return Void.
		local
			char_value: CHARACTER_VALUE
			wchar_value: CHARACTER_32_VALUE
			l_items: like children
		do
			l_items := children
			if l_items.count /= 0 then
				char_value ?= l_items.first
				if char_value /= Void then
					create Result.make (l_items.count + 8)
				else
					wchar_value ?= l_items.first
					if wchar_value /= Void then
						create Result.make (l_items.count + 8)
					end
				end
				if Result /= Void then
					if sp_lower > 0 then
						Result.append ("...")
					end
					Result.append_code (('%"').natural_32_code)
					Result.append (eiffel_string_32 (raw_string_value))
					Result.append_code (('%"').natural_32_code)
					if sp_upper <= capacity - 1 then
						Result.append ("...")
					end
				end
			end
		end

	truncated_raw_string_value (a_size: INTEGER): STRING_32 is
			-- If `Current' represents a string then return its value truncated to `a_size'.
			-- Else return Void.
			-- Do not convert special characters to an Eiffel representation.
		local
			int8_value: DEBUG_BASIC_VALUE [INTEGER_8]
			int32_value: DEBUG_BASIC_VALUE [INTEGER_32]
			char_value: CHARACTER_VALUE
			wchar_value: CHARACTER_32_VALUE
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			l_items: like children
		do
			l_items := children
			if l_items.count /= 0 then
				char_value ?= l_items.first
				if char_value /= Void then
					create Result.make (a_size.min (l_items.count + 1))
					from
						l_cursor := l_items.new_cursor
						l_cursor.start
					until
						l_cursor.after or Result.count = a_size
					loop
						char_value ?= l_cursor.item
						Result.append_code (char_value.value.natural_32_code)
						l_cursor.forth
					end
				else
					wchar_value ?= l_items.first
					if wchar_value /= Void then
						create Result.make (a_size.min (items.count + 1))
						from
							l_cursor := items.new_cursor
							l_cursor.start
						until
							l_cursor.after or Result.count = a_size
						loop
							wchar_value ?= l_cursor.item
							Result.append_code (wchar_value.value.natural_32_code)
							l_cursor.forth
						end
						l_cursor.go_after
					else
						int8_value ?= l_items.first
						if int8_value /= Void then
							create Result.make (a_size.min (items.count + 1))
							from
								l_cursor := items.new_cursor
								l_cursor.start
							until
								l_cursor.after or Result.count = a_size
							loop
								int8_value ?= l_cursor.item
								Result.append_code (int8_value.value.as_natural_32)
								l_cursor.forth
							end
							l_cursor.go_after
						else
							int32_value ?= l_items.first
							if int32_value /= Void then
								create Result.make (a_size.min (items.count + 1))
								from
									l_cursor := items.new_cursor
									l_cursor.start
								until
									l_cursor.after or Result.count = a_size
								loop
									int32_value ?= l_cursor.item
									Result.append_code (int32_value.value.as_natural_32)
									l_cursor.forth
								end
								l_cursor.go_after
							end
						end
					end
				end
			end
			if Result = Void then
				Result := ""
			end
		ensure
			raw_string_value_not_void: Result /= Void
		end

	raw_string_value: STRING_32 is
			-- If `Current' represents a string then return its value.
			-- Else return Void.
			-- Do not convert special characters to an Eiffel representation.
		local
			l_items: like children
		do
			l_items := children
			if l_items.count /= 0 then
				Result := truncated_raw_string_value (l_items.count + 4)
			end
			if Result = Void then
				Result := ""
			end
		ensure
			raw_string_value_not_void: Result /= Void
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_object_value (address, dynamic_class)
		end

feature -- Items

	get_items (a_min, a_max: INTEGER) is
		local
			rqst: ATTR_REQUEST
		do
			set_sp_bounds (a_min, a_max)
			create rqst.make (address)
			rqst.set_sp_bounds (sp_lower, sp_upper)
			rqst.send
			capacity := rqst.capacity
			items.append_last (rqst.attributes)
			items_computed := True
		end

feature -- Output

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			debug ("debug_recv")
				print (generator + ".children%N")
			end
			if items_computed then
				Result := items
			else
				reset_items
				get_items (sp_lower, sp_upper)
				Result := items
			end
		end

feature {NONE} -- Implementation

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			if address /= Void then
				address := keep_object_as_hector_address (address);
			end
			is_null := (address = Void)

				--| When created as local (for instance)
				--| we don't set the capacity right away
				--| so let's compute it when needed
			get_capacity
		end

	get_capacity is
			-- Get SPECIAL capacity value
		do
			if capacity < 0 then
				capacity := debugger_manager.object_manager.special_object_capacity_at_address (address)
			end
		end

invariant
	items_exists: items_computed implies items /= Void;

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

end -- class SPECIAL_VALUE
