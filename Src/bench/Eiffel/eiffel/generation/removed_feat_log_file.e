class REMOVED_FEAT_LOG_FILE

inherit
	PLAIN_TEXT_FILE

create
	make

feature

	add (class_type: CLASS_TYPE; feature_name: STRING) is
			-- Add `class_type', `feature_name' in REMOVED file.
		require
			class_type_not_void: class_type /= Void
			feature_name_not_void: feature_name /= Void
		local
			s: GENERATION_BUFFER
		do
			put_string (class_type.associated_class.cluster.cluster_name)
			put_character ('%T')
			create s.make (128)
			class_type.type.dump (s)
			s.put_in_file (Current)
			put_character ('%T')
			put_string (feature_name)
			put_new_line
		end

end

