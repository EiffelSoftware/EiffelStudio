indexing

	description: 
		"Run time value representing bits.";
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
			get_value
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

creation {RECV_VALUE, ATTR_REQUEST}

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
		do
		end

feature -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is
		do 
			st.add_classi (dynamic_class.lace_class, "BIT");
			st.add (ti_Space);
			st.add_int (value.count - 1);
			st.add_string (Equal_sign);
			st.add_string (value)
		end;

	output_value: STRING is
			-- Return a string representing `Current'.
		do
			Result := clone (value)
		end

	type_and_value: STRING is
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

	Equal_sign: STRING is " = "

	Bit_label: STRING is "BIT "

	append_value (st: STRUCTURED_TEXT) is
			-- Append the value of `Current' to `st'. (Useful for pretty print).
		do
			st.add_string (value)
		end

	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: LIST [ABSTRACT_DEBUG_VALUE] is
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

feature {NONE} -- Implementation

	get_value is
			-- Convert the physical address of the bit reference to
			-- its actual value. (should be called only once just after
			-- all the information has been received from the application.)
		do
			if not is_attribute then
				-- The `value' is the Physical address of the bit object 
				send_rqst_3 (Rqst_inspect, In_bit_addr, 0, hex_to_integer (value));
				value := c_tread
				-- This is actual `value' .
			end
		end;

invariant

    not_value_void: value /= Void
	
end -- class BITS_VALUE