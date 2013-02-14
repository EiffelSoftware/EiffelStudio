note

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

	DBG_CHARACTER_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

create {DEBUG_VALUE_EXPORTER}

	make_set_ref,
	make_attribute

feature {NONE} -- Initialization

	make_set_ref (ref: DBG_ADDRESS; id: INTEGER; scp_pid: like scoop_processor_id)
			-- Create Current as a standalone object
			-- i.e: not an attribute
			-- nevertheless at this point we don't have the `capacity'
			-- value, so we'll fetch this value when needed
		require
			ref_attached: ref /= Void
		do
			set_default_name
			is_attribute := False;
			address := ref
			scoop_processor_id := scp_pid
			if ref.is_void then
				is_null := True
				capacity := 0
			else
				set_sp_bounds (debugger_manager.min_slice, debugger_manager.max_slice)
				capacity := -1;
			end
		end

	make_attribute (attr_name: like name; a_class: like e_class;
						addr: like address; a_count: like count; a_capacity: like capacity; scp_pid: like scoop_processor_id)
		require
			not_attr_name_void: attr_name /= Void;
			not_addr_void: addr /= Void
		do
			name := attr_name
			if a_class /= Void then
				e_class := a_class
				is_attribute := True
			end
			address := addr
			is_null := address = Void or else address.is_void
			scoop_processor_id := scp_pid
			count := a_count
			capacity := a_capacity
				--| No need to preallocate area, since the fill_items or similar
				--| will change the capacity if needed
				--| We require only to get a non Void list
		end

feature -- Access

	count: INTEGER
			-- Number of items that SPECIAL object holds

	dynamic_class: CLASS_C
		once
			Result := Eiffel_system.special_class.compiled_class
		end

	string_value: STRING_32
			-- If `Current' represents a string then return its value.
			-- Else return Void.
		local
			l_items: like children
		do
			l_items := children
			if l_items.count /= 0 then
				if attached {CHARACTER_VALUE} l_items.first then
					create Result.make (l_items.count + 8)
				elseif attached {CHARACTER_32_VALUE} l_items.first then
					create Result.make (l_items.count + 8)
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

	truncated_raw_string_value (a_size: INTEGER): STRING_32
			-- If `Current' represents a string then return its value truncated to `a_size'.
			-- Else return Void.
			-- Do not convert special characters to an Eiffel representation.
		local
			l_items: like children
			l_first: ABSTRACT_DEBUG_VALUE
		do
			l_items := children
			if l_items.count /= 0 then
				l_first := l_items.first
				if attached {CHARACTER_VALUE} l_first then
					create Result.make (a_size.min (l_items.count + 1))
					across
						l_items as l_cursor
					until
						Result.count = a_size
					loop
						if attached {CHARACTER_VALUE} l_cursor.item as char_value then
							Result.append_character (char_value.value)
						else
							check is_char_value: False end
							Result.append_character ('?')
						end
					end
				elseif attached {CHARACTER_32_VALUE} l_first then
					create Result.make (a_size.min (items.count + 1))
					across
						l_items as l_cursor
					until
						Result.count = a_size
					loop
						if attached {CHARACTER_32_VALUE} l_cursor.item as wchar_value then
							Result.append_character (wchar_value.value)
						else
							check is_wchar_value: False end
							Result.append_character ('?')
						end
					end
				elseif attached {DEBUG_BASIC_VALUE [INTEGER_8]} l_first then
					create Result.make (a_size.min (items.count + 1))
					across
						l_items as l_cursor
					until
						Result.count = a_size
					loop
						if attached {DEBUG_BASIC_VALUE [INTEGER_8]} l_cursor.item as int8_value then
							Result.append_code (int8_value.value.as_natural_32)
						else
							check is_int8_value: False end
							Result.append_character ('?')
						end
					end
				elseif attached {DEBUG_BASIC_VALUE [INTEGER_32]} l_first then
					create Result.make (a_size.min (items.count + 1))
					across
						l_items as l_cursor
					until
						Result.count = a_size
					loop
						if attached {DEBUG_BASIC_VALUE [INTEGER_32]} l_cursor.item as int32_value then
							Result.append_code (int32_value.value.as_natural_32)
						else
							check is_int32_value: False end
							Result.append_character ('?')
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

	raw_string_value: STRING_32
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

	dump_value: DUMP_VALUE
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_object_value (address, dynamic_class, scoop_processor_id)
		end

feature -- Items

	get_items (a_min, a_max: INTEGER)
		local
			rqst: ATTR_REQUEST
		do
			set_sp_bounds (a_min, a_max)
			create rqst.make (address)
			rqst.set_sp_bounds (sp_lower, sp_upper)
			rqst.send
			count := rqst.capacity
			capacity := rqst.max_capacity
			items.append (rqst.attributes)
			items_computed := True
		end

feature -- Output

	children: DEBUG_VALUE_LIST
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

	set_hector_addr
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			if address /= Void and then not address.is_void then
				address := keep_object_as_hector_address (address);
			end
			is_null := (address = Void or else address.is_void)

				--| When created as local (for instance)
				--| we don't set the capacity right away
				--| so let's compute it when needed
			get_count_and_capacity
		end

	get_count_and_capacity
			-- Get SPECIAL capacity value
		local
			t: TUPLE [a_count: INTEGER; a_capacity: INTEGER]
		do
			if capacity < 0 then
				t := debugger_manager.object_manager.special_object_count_and_capacity_at_address (address)
				count := t.a_count
				capacity := t.a_capacity
			end
		end

invariant
	items_exists: items_computed implies items /= Void;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class SPECIAL_VALUE
