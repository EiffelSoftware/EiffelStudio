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

	melt is
			-- Melt the features of the class
		local
			temp: STRING
		do
			associated_class.update_melted_set;
			if associated_class.has_features_to_melt then
					-- Verbose
				io.error.putstring ("Degree 2: class ");
					temp := associated_class.class_name.duplicate;
					temp.to_upper;
				io.error.putstring (temp);
				io.error.new_line;

				associated_class.melt;
			end;
		end;

	update_dispatch_table is
			-- Melt the features of the class
		local
			temp: STRING
		do
			associated_class.update_melted_set;
			if associated_class.has_features_to_melt then
					-- Verbose
				io.error.putstring ("Degree 2: class ");
					temp := associated_class.class_name.duplicate;
					temp.to_upper;
				io.error.putstring (temp);
				io.error.new_line;

				associated_class.update_dispatch_table;
			end;
		end;

end
