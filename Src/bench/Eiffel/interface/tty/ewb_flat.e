
class EWB_FLAT 

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

	name: STRING is "print %"flat%" form";

	execute is
		local
			class_c: CLASS_C;
			ctxt: FORMAT_CONTEXT
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
						!!ctxt.make (class_c, False);
						io.putstring (ctxt.text.image)
					end;
				end;
			end;
		end;

end
