
class EWB_FS 

inherit

	EWB_CMD;
	SHARED_SERVER

creation

	make

feature -- Creation

	make (cn: STRING; t: BOOLEAN; b: BOOLEAN) is
		do
			class_name := cn;
			class_name.to_lower;
			troffed := t;
			only_current_class := b
		end;

	class_name: STRING;

	troffed: BOOLEAN;

	only_current_class: BOOLEAN;
		-- Only do short for current class

feature

	name: STRING is "print %"flat-short%" form";

	execute is
		local
			class_c: CLASS_C;
			class_i: CLASS_I;
			ctxt: FORMAT_CONTEXT;
			troffer: TROFF_FORMATTER;
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
						!!ctxt.make (class_c);
						ctxt.set_is_short;
						if only_current_class then
							ctxt.set_current_class_only
						end;
						ctxt.execute;
						if troffed then
							!! troffer.make;
							troffer.process_text (ctxt.text);
							io.putstring (troffer.image)
						else
							io.putstring (ctxt.text.image)
						end
					end
				end;
			end;
		end;

end
