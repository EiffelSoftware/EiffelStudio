

class EWB_ANCESTORS 

inherit

	EWB_CMD;
	SHARED_SERVER

creation

	make

feature -- Creation

	make (cn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
		end;

	class_name: STRING;

feature

	name: STRING is "compute the ancestors";

	execute is
		local
			class_c: CLASS_C;
			class_i: CLASS_I
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_i := Universe.unique_class (class_name);
					if class_i /= Void then
						class_c := class_i.compiled_class;
					end;
					if class_c = Void then
						io.putstring (class_name);
						io.putstring (" not in system%N");
					else
						print_ancestors (class_c, 0);
					end;
				end;
			end;
		end;

	print_ancestors (c: CLASS_C; i: INTEGER) is
		local
			ancestors: FIXED_LIST [CL_TYPE_A]
		do
			from	
				ancestors := c.parents;
				ancestors.start
			until
				ancestors.after
			loop
				io.putstring (tabs(i));
				io.putstring (ancestors.item.associated_class.signature);
				io.new_line;
				print_ancestors (ancestors.item.associated_class, i + 1);
				ancestors.forth
			end
		end;

	tabs (i: INTEGER): STRING is
		local
			j: INTEGER
		do
			from
				j := 1;
				!!Result.make (4 * i)
			until
				j > i
			loop
				Result.append ("	");
				j := j + 1
			end;
		end;

end
