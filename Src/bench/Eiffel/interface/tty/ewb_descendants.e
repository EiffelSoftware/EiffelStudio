

class EWB_DESCENDANTS 

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

	name: STRING is "compute the descendants";

	execute is
		local
			class_c: CLASS_C;
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_c := Universe.unique_class (class_name).compiled_class;
					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						print_descendants (class_c, 0);
					end;
				end;
			end;
		end;

	print_descendants (c: CLASS_C; i: INTEGER) is
		local
			descendants: LINKED_LIST [CLASS_C]
		do
			from	
				descendants := c.descendants;
				descendants.start
			until
				descendants.after
			loop
				io.error.putstring (tabs(i));
				io.error.putstring (descendants.item.signature);
				io.error.new_line;
				print_descendants (descendants.item, i + 1);
				descendants.forth
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
