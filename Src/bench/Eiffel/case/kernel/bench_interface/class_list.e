indexing

	description: "List of class data.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_LIST

inherit

	LINKED_LIST [CLASS_DATA];
	CONSTANTS
		undefine
			copy, is_equal
		end;
	S_CASE_INFO
		undefine
			copy, is_equal
		end;

creation

	make

feature -- Storage

	store_information (storer: S_CLUSTER_DATA) is
		require
			valid_storer: storer /= Void;
			not_empty: not empty
		local
			class_l: FIXED_LIST [S_CLASS_DATA];
			path: STRING;
			s_class_data: S_CLASS_DATA;
			dir: DIRECTORY;
			class_path: STRING;
			class_data: CLASS_DATA
		do
			!! class_l.make_filled (count);
			from
				start;
                class_l.start
			until
				after
			loop
				class_data := item;
				s_class_data := class_data.storage_info;
				class_l.replace (s_class_data);
				class_l.forth;
				forth;
			end
			storer.set_classes (class_l);
		end

end -- class CLASS_LIST
