
class EWB_FS 

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

	name: STRING is "print %"flat-short%" form";

	execute is
		local
			class_c: CLASS_C;
			ctxt: FORMAT_CONTEXT
		do
			init_project;
			if not (error_occurred or project_is_new) then
				suggest_precompilation_retrieval;
				retrieve_project;
				if not error_occurred then
					class_c := Universe.unique_class (class_name).compiled_class;
					!!ctxt.make (class_c, True);
					io.putstring (ctxt.text.image)
				end;
			end;
		end;

	suggest_precompilation_retrieval is
		do
			io.putstring ("Do you wish to include precompiled information?[y/n] ");
			io.readline;
			if (io.laststring.item (1) = 'y') then
				io.putstring ("Name of precompiled project (full path): ");
				io.readline;
				precompiled_project_name := io.laststring.duplicate;
				io.putstring ("Importing precompiled information from: ");
				io.putstring (precompiled_project_name);
				io.new_line;
			end;
		end;

end
