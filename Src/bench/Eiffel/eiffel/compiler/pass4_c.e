class PASS4_C

inherit

	COMP_PASS_C;
	SHARED_SERVER

creation

	make

feature

	execute is
			-- Melt the features of the class
		do
			if associated_class.has_features_to_melt then
					-- Verbose
				io.error.putstring ("Pass 4 on class ");
				io.error.putstring (associated_class.class_name);
				io.error.new_line;

				associated_class.melt;
			end;
		end;

end
