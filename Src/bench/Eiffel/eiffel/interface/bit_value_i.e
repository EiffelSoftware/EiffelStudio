class BIT_VALUE_I 

inherit

	VALUE_I
		redefine
			is_bit,
			set_real_value
		end;
	SHARED_WORKBENCH
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := bit_count = other.bit_count and then
				bit_val.is_equal (other.bit_val)
		end

feature 

	bit_val: STRING;
			-- Integer constant value

	bit_count: INTEGER
			-- real number of bits

	set_bit_val (i: STRING) is
			-- Assign `i' to `bit_val'.
		do
			bit_val := i;
		end;

	set_real_value (t: TYPE_A) is
			-- Set the real number of bits
		local
			class_type: BITS_A
		do
			class_type ?= t
			if class_type /= Void then
				bit_count := class_type.bit_count
			end
		end

	is_bit: BOOLEAN is True
			-- Is the current constant a bit one ?

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring ("RTMB(%"");
			buffer.escape_string (buffer,bit_val);
			buffer.putchar ('"')
			buffer.putstring (", ")
			buffer.putint (bit_count)
			buffer.putchar (')');
		end;

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		local
			class_type: BITS_A;
		do
			class_type ?= t;
			Result :=	class_type /= Void 
						and then
						bit_val.count <= class_type.bit_count 
		end;

	generate_il is
			-- Generate IL code for BIT constant value.
		do
			check
				not_implemented: False
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a BIT constant value.
		do
			ba.append (Bc_bit);
			ba.append_integer (bit_count)
			ba.append_bit (bit_val);
		end;

	vqmc: VQMC is
		do
			!VQMC6!Result;
		end;

	dump: STRING is
		do
			Result := bit_val			
		end;

end
