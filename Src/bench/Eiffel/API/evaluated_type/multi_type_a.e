indexing

	description: 
		"Actual type for manifest array conformance.";
	date: "$Date$";
	revision: "$Revision $"

class MULTI_TYPE_A 
	
inherit

	TYPE_A
		rename
			duplicate as twin
		undefine
			copy, setup, consistent, is_equal
		redefine
			is_multi_type
		end;
	ARRAY [TYPE_A]
		rename
			make as array_make
		end

creation {COMPILER_EXPORTER}

	make
	
feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Initialization
		do
			array_make (1, n);
		end;

feature -- Property

	last_type: GEN_TYPE_A;
			-- Last type conforming to Current

	is_multi_type: BOOLEAN is
		do
			Result := True
		end;

	associated_eclass: E_CLASS is
			-- Associated eiffel class
		once
			Result := System.array_class.compiled_eclass;
		end;

feature -- Output

	dump: STRING is
			-- Dump trace
		local
			i: INTEGER
		do
			!!Result.make (10 * count);
			Result.append ("<<");
			from
				i := 1;
			until
				i > count
			loop
				Result.append (item (i).dump);
				if i /= count then
					Result.append (", ");
				end;
				i := i + 1;
			end;
			Result.append (">>");
		end;

	append_to (ow: OUTPUT_WINDOW) is
		local
			i: INTEGER
		do
			ow.put_string ("<<");
			from
				i := 1;
			until
				i > count
			loop
				item (i).append_to (ow);
				if i /= count then
					ow.put_string (", ");
				end;
				i := i + 1;
			end;
			ow.put_string (">>");
		end;

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		local
			gen_type: GEN_TYPE_A;
			i: INTEGER;
			generic_param: TYPE_A;
		do
			gen_type ?= other;
			if	gen_type /= Void
				and then
				gen_type.base_type = System.array_id
			then
				generic_param := gen_type.generics.item (1);
				from
					Result := True;
					i := 1;
				until
					(i > count) or else
					(not Result)
				loop
					Result := item (i).conform_to (generic_param) 
								and then not (item(i).is_expanded 
									and not generic_param.is_expanded);
					i := i + 1;
				end;
			end;
			if Result then
				last_type := gen_type;
			end;
		end;

	associated_class: CLASS_C is
			-- Class ARRAY
		require else
			array_class_compiled: System.array_class.compiled
		once
			Result := System.array_class.compiled_class;
		end;

	array_type_a: TYPE_A is
		once
			Result := System.instantiator.Array_type_a
		end;

	type_i: GEN_TYPE_I is
			-- Compiled type
		local
			b: BOOLEAN;
		do
			if last_type = Void then
				b := internal_conform_to (Array_type_a, False);
			end;
			check
				last_type_exists: last_type /= Void
			end;
			Result := last_type.type_i;
		end;

	create_info: CREATE_INFO is
			-- Creation information
		do
		ensure then
			False
		end;
	
feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info (classc: CLASS_C): S_GEN_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
			Result := last_type.storage_info (classc);
		end;

    storage_info_with_name (classc: CLASS_C): S_GEN_TYPE_INFO is
            -- Storage info for Current type in class `classc'
        do
            Result := last_type.storage_info_with_name (classc);
        end;

end -- class MULTI_TYPE_A
