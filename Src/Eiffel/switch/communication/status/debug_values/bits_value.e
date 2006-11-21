indexing

	description:
		"Run time value representing bits."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class BITS_VALUE

inherit
	ABSTRACT_DEBUG_VALUE
		rename
			set_hector_addr as get_value,
			min as comp_min,
			max as comp_max
		redefine
			get_value,
			debug_value_type_id
		end

	DEBUG_EXT
		undefine
			is_equal
		end

	IPC_SHARED
		undefine
			is_equal
		end

	BEURK_HEXER
		undefine
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			is_equal
		end

create {DEBUG_VALUE_EXPORTER}

	make, make_attribute

feature {NONE} -- Initialization

	make (ref: POINTER; s: INTEGER) is
		do
			--| `s' is supposed to be the size, but it does not work.
			--| It is then computed from the bit value.
			set_default_name;
			value := ref.out
		end;

	make_attribute (attr_name: like name; a_class: like e_class; v: like value) is
		require
			not_attr_name_void: attr_name /= Void;
			not_value_void: v /= Void
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			value := v
		end;

feature -- Property

	value: STRING;
			-- Actual value of bit

feature -- Access

	dynamic_class: CLASS_C is
			-- Bit ref class
		do
			Result := Eiffel_system.bit_class.compiled_class
		end;

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		local
			l_type: STRING
		do
			create l_type.make (bit_label.count + 5)
			l_type.append (bit_label)
			l_type.append_integer (value.count - 1)
			Result := Debugger_manager.Dump_value_factory.new_bits_value (value, l_type, dynamic_class)
		end

feature {NONE} -- Output

	output_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			Result := value.twin
		end

	type_and_value: STRING_32 is
			-- Return a string representing `Current'.
		local
			cnt: INTEGER
		do
			cnt := value.count
			create Result.make (cnt + 15)
			Result.append (Bit_label)
			Result.append ((cnt - 1).out)
			Result.append (Equal_sign)
			Result.append (value)
		end

feature -- Output

	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := Void
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Immediate_value
		end


feature {NONE} -- Constants

	Equal_sign: STRING is " = "

	Bit_label: STRING is "BIT "

feature {NONE} -- Implementation

	get_value is
			-- Convert the physical address of the bit reference to
			-- its actual value. (should be called only once just after
			-- all the information has been received from the application.)
		do
			if not is_attribute then
				-- The `value' is the Physical address of the bit object
				send_rqst_3 (Rqst_inspect, In_bit_addr, 0, hex_to_pointer (value));
				value := c_tread
				-- This is actual `value' .
			end
		end;

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER is
		do
			Result := bits_value_id
		end

invariant

    not_value_void: value /= Void

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

end -- class BITS_VALUE
