-- Pattern of a feature: it is constitued of the meta types of the
-- arguments and result.

class PATTERN 

inherit

	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	HASHABLE
		redefine
			is_equal
		end;
	SHARED_CODE_FILES
		redefine
			is_equal
		end;

creation

	make

feature 

	result_type: TYPE_I;
			-- Meta type of the result

	argument_types: ARRAY [TYPE_I];
			-- Meta types of the arguments

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a;
		end;

	make (t: TYPE_I) is
			-- Creation of a pattern with a result meta type
		require
			good_argument: t /= Void;
		do
			result_type := t;
		end;

	argument_count: INTEGER is
			-- Number of arguments
		do
			if argument_types /= Void then
				Result := argument_types.count;
			end;
		end;

	is_equal (other: PATTERN): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			n, i: INTEGER;
		do
			n := argument_count;
			Result := n = other.argument_count and then
					type_deep_equal (result_type, other.result_type)
			from
				i := 1;
			until
				i > n or else not Result
			loop
				Result := type_deep_equal (argument_types.item (i),
										other.argument_types.item (i));
				i := i + 1;
			end;
		end;

	has_formal: BOOLEAN is
			-- Are some formal generic parameter in the current
			-- pattern ?
		local
			i, nb: INTEGER;
		do
			Result := result_type.has_formal;
			if not Result then
				from
					i := 1;
					nb := argument_count
				until
					i > nb or else Result
				loop
					Result := argument_types.item (i).has_formal;
					i := i + 1;
				end;
			end;
		end;

	duplicate: like Current is
			-- Duplication
		do
			!!Result.make (result_type);
			if argument_count > 0 then
				Result.set_argument_types (clone (argument_types));
			end;
		end;

	instantiation_in (gen_type: GEN_TYPE_I): PATTERN is
			-- Instantiated pattern in the context of generical type
			-- `gen_type'.
		require
			good_argument: gen_type /= Void;
			no_formal: not gen_type.has_formal;
			has_formal: has_formal;
		local
			i, n: INTEGER;
			new_arguments: like argument_types;
			type: TYPE_I;
		do
			!!Result.make (result_type.instantiation_in (gen_type));
			n := argument_count;
			if n > 0 then
				from
					i := 1;
					!!new_arguments.make (1, n);
					Result.set_argument_types (new_arguments);
				until
					i > n
				loop
					type := argument_types.item (i).instantiation_in (gen_type);
					new_arguments.put (type, i);
					i := i + 1;
				end;
			end;
		ensure
			no_formal: not Result.has_formal;
		end;

	c_pattern: C_PATTERN is
			-- C pattern
		require
			no_formal: not has_formal
		local
			new_arguments: ARRAY [TYPE_C];
			i, arg_count: INTEGER;
		do
			!!Result.make (result_type.c_type);
			arg_count := argument_count;
			if arg_count > 0 then
				!!new_arguments.make (1, arg_count);
				from
					i := 1;
				until
					i > arg_count
				loop
					new_arguments.put (argument_types.item (i).c_type, i);
					i := i + 1;
				end;
				Result.set_argument_types (new_arguments);
			end;
		end;

feature -- Hash code

	hash_code: INTEGER is
			-- Hash code for pattern
		local
			i, n: INTEGER
		do
			Result := result_type.hash_code
			n := argument_count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					Result := Result + (argument_types.item (i).hash_code |<< (i \\ 16))
					i := i + 1
				end
				Result := Result.abs
			end
		end

feature -- Debug

	trace is
			-- Debug purpose
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > argument_count
			loop
				argument_types.item (i).trace;
				io.error.putchar ('/');
				i := i + 1;
			end;
			io.error.putchar ('|');
			result_type.trace;
			io.error.putstring ("|");
		end;

feature {NONE} -- Implementation

	type_deep_equal (first_type, other_type: TYPE_I): BOOLEAN is
			-- Deep equal comparison wich does not compare the `cr_info´ attribute
			-- declared in CL_TYPE_I and the `true_generics' attributes declared
			-- in GEN_TYPE_I.
		require
			first_type_not_void: first_type /= Void
			other_type_not_void: other_type /= Void
		local
			bit_i, other_bit_i: BIT_I
			cl_type_i, other_cl_type_i: CL_TYPE_I
			gen_type_i, other_gen_type_i: GEN_TYPE_I
		do
			if (first_type.same_type (other_type)) then
				cl_type_i ?= first_type
				if cl_type_i /= Void then
					bit_i ?= first_type
					if bit_i /= Void then
						other_bit_i ?= other_type
						Result := bit_i.size = other_bit_i.size
					else
						Result := True
					end
					
					other_cl_type_i ?= other_type
					Result := Result and then deep_equal (cl_type_i.class_id, other_cl_type_i.class_id)
					Result := Result and then (cl_type_i.is_true_expanded = other_cl_type_i.is_true_expanded)
					Result := Result and then (cl_type_i.is_separate = other_cl_type_i.is_separate)

					gen_type_i ?= first_type
					if gen_type_i /= Void then
						other_gen_type_i ?= other_type
						Result := Result and then deep_equal (gen_type_i.meta_generic, other_gen_type_i.meta_generic)
					end
				else
						-- There is no attributes to compare in the case of
						-- VOID_I, REFERENCE_I and NONE_I
						-- and only one attribute in case of FORMAL_I
					Result := deep_equal (first_type, other_type)	
				end
			end
		end

invariant

	result_type_exists: result_type /= Void;

end
