-- Actual type for manifest array conformance

class MULTI_TYPE_A 
	
inherit

	TYPE_A
		rename
			duplicate as twin
		undefine
			twin
		end;
	ARRAY [TYPE_A]
		rename
			make as array_make
		end

creation

	make
	
feature 

	last_type: GEN_TYPE_A;
			-- Last type conforming to Current

	make (n: INTEGER) is
			-- Initialization
		do
			array_make (1, n);
		end;

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
		once
			Result := System.array_class.compiled_class;
		end;

	type_i: GEN_TYPE_I is
			-- Compiled type
		do
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
	
end
