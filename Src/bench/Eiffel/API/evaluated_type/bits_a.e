-- Actual type for bits: `base_type' is the bits value

class BITS_A

inherit

	BASIC_A
		redefine
			is_bits, internal_conform_to, associated_class, dump,
			heaviest, same_as
		end;

feature

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		local
			other_actual: TYPE_A;
		do
			other_actual := other.actual_type;
			if other_actual.is_bits then
				if in_generics then
					Result := other_actual.base_type = base_type;
				else
					Result := other_actual.base_type >= base_type;
				end;
			end;
		end;

	is_bits: BOOLEAN is
			-- Is the current actual type a bits type ?
		do
			Result := True;
		end;

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		require else
			good_argument: type /= Void;
			consistency: is_bits and then type.is_bits;
		local
			other: BITS_A;
		do
			other ?= type;
			if other.base_type > base_type then
				Result := type;
			else
				Result := Current;
			end;
		end;

	associated_class: CLASS_C is
			-- Associated class
		require else
			bit_class_compiled: System.bit_class.compiled;
		once
			Result := System.bit_class.compiled_class;
		end;

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (9);
			Result.append ("BITS ");
			Result.append_integer (base_type);
		end;

	type_i: BIT_I is
			-- C type
		do
			!!Result;
			Result.set_size (base_type);
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_bits: BITS_A
		do
			other_bits ?= other;
			Result :=	other_bits /= Void
						and then
						other_bits.base_type /= base_type
		end;
			
end
