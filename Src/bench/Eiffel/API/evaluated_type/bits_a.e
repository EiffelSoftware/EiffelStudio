-- Actual type for bits: `base_type' is the bits value

class BITS_A

inherit

	BASIC_A
		rename
			internal_conform_to as old_conform_to
		redefine
			is_bits, associated_class, dump,
			heaviest, same_as, append_clickable_signature,
			check_conformance
		end;

	BASIC_A
		redefine
			is_bits, internal_conform_to, associated_class, dump,
			heaviest, same_as, append_clickable_signature,
			check_conformance
		select
			internal_conform_to
		end;

feature

	check_conformance (target_type: TYPE_A) is
			-- Check if Current conforms to `other'.
			-- If not, insert error into Error handler
			-- which uses `context' for initialisation of the
			-- error.
		local
			vncb: VNCB;
		do
			if not conform_to (target_type) then
				!!vncb;
				context.init_error (vncb);
				vncb.set_source_type (Current);
				vncb.set_target_type (target_type);
				Error_handler.insert_error (vncb);
			end;
		end;

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
			else
				Result := old_conform_to (other, False);
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

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("BITS ");
			a_clickable.put_int (base_type);
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
