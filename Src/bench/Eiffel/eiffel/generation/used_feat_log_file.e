class USED_FEAT_LOG_FILE

inherit
	PLAIN_TEXT_FILE

create
	make

feature

	add (class_type: CLASS_TYPE; feature_name, encoded_name: STRING) is
		local
			s: GENERATION_BUFFER
		do
			putstring (class_type.associated_class.cluster.cluster_name);
			putchar ('%T');
			create s.make (0)
			class_type.type.dump (s);
			putstring (s)
			putchar ('%T');
			putstring (feature_name);
			putchar ('%T');
			putstring (encoded_name);
			putchar ('%T');
			putstring (class_type.relative_file_name);
			new_line;
		end

end

