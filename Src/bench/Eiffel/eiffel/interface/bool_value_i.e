indexing
	description: "Description of a boolean value."
	date: "$Date$"
	revision: "$Revision$"

class BOOL_VALUE_I 

inherit
	VALUE_I
		redefine
			generate, is_boolean, boolean_value
		end;

create
	make

feature {NONE} -- Initialization

	make (v: BOOLEAN) is
			-- Create current with value `v'.
		do
			boolean_value := v
		ensure
			boolean_value_set: boolean_value = v
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := boolean_value = other.boolean_value
		end
		
feature -- Access

	boolean_value: BOOLEAN;
			-- Integer constant value

	is_boolean: BOOLEAN is True
			-- Is the constant value a boolean one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_boolean;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `file'.
		do
			if boolean_value then
				buffer.putstring ("'\01'");
			else
				buffer.putstring ("'\0'");
			end;
		end;

	generate_il is
			-- Generate IL code for boolean constant value.
		do
			il_generator.put_boolean_constant (boolean_value)	
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a boolean constant value.
		do
			ba.append (Bc_bool);
			if boolean_value then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;
		end;

	dump: STRING is
		do
			Result := boolean_value.out			
		end;

end
