
class EWB_DEPEND 

inherit

	WINDOWS;
	EWB_CMD;
	SHARED_SERVER

creation

	make

feature -- Creation

	make (cn, fn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
			feature_name := fn;
			feature_name.to_lower
		end;

	class_name, feature_name: STRING;

feature

	name: STRING is "compute the dependents";

	execute is
		local
			class_c: CLASS_C;
			f: FEATURE_I;
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
						-- Get the class
						-- Note: class name amiguities are not resolved.
					class_c := Universe.unique_class (class_name).compiled_class;
					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						f := class_c.feature_table.item (feature_name);
						if f = Void then
							io.error.putstring (feature_name);
							io.error.putstring (" is not a feature of ");
							io.error.putstring (class_name);
							io.error.new_line
						else
							display_depend (error_window, class_c, f);
						end;
					end;
				end;
			end;
		end;

	display_depend (display: CLICK_WINDOW; class_c: CLASS_C; f: FEATURE_I) is
		local
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			supplier: CLASS_C;
			supp_f: FEATURE_I;
			class_id, fid: INTEGER;
		do
			dep := Depend_server.item (class_c.id);
			fdep := dep.item (f.feature_name);

			display.put_string ("Dependents:%N");
			from
				fdep.start
			until
				fdep.after
			loop
				class_id := fdep.item.id;
				fid := fdep.item.feature_id;

				supplier := System.class_of_id (class_id);
				supp_f := supplier.feature_table.feature_of_feature_id (fid);

				supplier.append_clickable_name (display);
				display.put_string (".");
				supp_f.append_clickable_name (display, supplier);
				display.new_line;

				fdep.forth
			end;
		end;

end
