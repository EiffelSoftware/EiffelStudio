class EWB_DESCENDANTS 

inherit

	EWB_CMD

creation

	make, null

feature -- Creation

	make (cn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
		end;

	class_name: STRING;

feature

	name: STRING is "compute the descendants";

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			execute;
		end;

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
				io.putstring (tabs(i));
				io.putstring (descendants.item.signature);
				io.new_line;
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
