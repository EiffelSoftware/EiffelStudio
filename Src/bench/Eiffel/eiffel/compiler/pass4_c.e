class PASS4_C

inherit

	COMP_PASS_C
		rename
			execute as melt
		end;
	SHARED_SERVER

creation

	make

feature

	melt (degree_output: DEGREE_OUTPUT; to_go: INTEGER) is
			-- Melt the features of the class
		do
			associated_class.update_melted_set;
			if associated_class.has_features_to_melt then
				degree_output.put_degree_2 (associated_class, to_go);
				associated_class.melt;
			end;
		end;

	update_dispatch_table (degree_output: DEGREE_OUTPUT; to_go: INTEGER) is
			-- Melt the features of the class
		do
			associated_class.update_melted_set;
			if associated_class.has_features_to_melt then
				degree_output.put_degree_2 (associated_class, to_go);
				associated_class.update_dispatch_table;
			end;
		end;

end
