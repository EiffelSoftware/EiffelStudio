class REMOVED_FEAT_LOG_FILE

inherit
	PLAIN_TEXT_FILE

create
	make

feature

	add (class_type: CLASS_TYPE; feature_name: STRING) is
		local
			s: GENERATION_BUFFER
		do
			putstring (class_type.associated_class.cluster.cluster_name);
			putchar ('%T');
			create s.make (128)
			class_type.type.dump (s);
			s.put_in_file (Current)
			putchar ('%T');
			putstring (feature_name);
			new_line;
		end

end

