indexing

	description: 
		"Display features's dependants in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DEPEND 

inherit

	EWB_FEATURE;
	SHARED_SERVER

creation

	make, do_nothing

feature

	display (class_c: CLASS_C; f: FEATURE_I) is
		local
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			supplier: CLASS_C;
			supp_f: FEATURE_I;
			class_id, fid: INTEGER;
		do
			dep := Depend_server.item (class_c.id);
			fdep := dep.item (f.feature_name);

			output_window.put_string ("Dependents:%N");
			from
				fdep.start
			until
				fdep.after
			loop
				class_id := fdep.item.id;
				fid := fdep.item.feature_id;

				supplier := System.class_of_id (class_id);
				supp_f := supplier.feature_table.feature_of_feature_id (fid);

				supplier.append_clickable_name (output_window);
				output_window.put_char ('.');
				supp_f.append_clickable_name (output_window, supplier);
				output_window.new_line;

				fdep.forth
			end;
		end;

end -- class EWB_DEPEND
