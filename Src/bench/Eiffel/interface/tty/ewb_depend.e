indexing

	description: 
		"Display features's dependants in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DEPEND 

inherit
	EWB_FEATURE

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
			class_id: INTEGER;
			fid: INTEGER;
			st: STRUCTURED_TEXT
		do
			dep := Depend_server.item (class_c.id);
			fdep := dep.item (f.feature_name);

			!! st.make
			st.add_string ("Dependents:");
			st.add_new_line;
			from
				fdep.start
			until
				fdep.after
			loop
				class_id := fdep.item.id;
				fid := fdep.item.feature_id;

				supplier := System.class_of_id (class_id);
				supp_f := supplier.feature_table.feature_of_feature_id (fid);

				supplier.append_name (st);
				st.add_char ('.');
				supp_f.append_name (st, supplier);
				st.add_new_line;

				fdep.forth
			end;
			output_window.put_string (st.image);
			output_window.new_line
		end;

end -- class EWB_DEPEND
