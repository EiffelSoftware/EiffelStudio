indexing

	description: 
		"Class content information server which caches or%
		%stores class content information to disk.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_CONTENT_SERVER

inherit

	HASH_TABLE [CLASS_DATA, INTEGER]
		rename
			make as old_make
		export
			{NONE} all;
			{CLASS_DATA} has, has_item, item;
		end;
	SHARED_FILE_SERVER
		undefine
			copy, setup, is_equal
		end;
	CONSTANTS
		undefine
			copy, setup, is_equal
		end;

creation

	make

feature {NONE} -- Initialization

	make is
		do
			old_make (10);
			!! removed_classes.make
		end;
	
feature -- Properties

	removed_classes: LINKED_LIST [CLASS_DATA];

feature -- Removal

	remove_class_data (class_data: CLASS_DATA) is
		require
			not_going_to_be_removed: not removed_classes.has (class_data)
		do
			removed_classes.put_front (class_data)
		ensure
			going_to_be_removed: removed_classes.has (class_data)
		end;

	undo_remove_class_data (class_data: CLASS_DATA) is
		do
			removed_classes.start;
			removed_classes.prune (class_data);
		ensure
			not_going_to_be_removed: not removed_classes.has (class_data)
		end

	delete_classes_not_in_system is
			-- Delete class information from disk for removed classes.
		do
			from
				removed_classes.start
			until
				removed_classes.after
			loop
				removed_classes.item.remove_class_content_from_disk;
				removed_classes.forth
			end
			removed_classes.wipe_out;
		end;

	clear is
			-- Clear Current
		do
			clear_all
		end

feature {CLASS_DATA} -- Implementation

	rescued: BOOLEAN
			-- Used for rescueing

	request_for_data (c_data: CLASS_DATA) is
			-- Request data `class_data' content to
			-- be held in memory.
		do
		end;

	free_data (class_data: CLASS_DATA) is
			-- Free data `class_data' content 
			-- from memory.
		do
	
		end;

feature {CLASS_DATA, RETRIEVE_PROJECT} -- Implementation

	tmp_save_class (class_data: CLASS_DATA) is
			-- Save `s_class_data' to disk temporarily.
		require
			valid_class_data: class_data /= Void
		local
			tmp_class_data: S_CLASS_DATA
		do
		end

feature {SYSTEM_DATA, RESCUE_INFO, EIFFELCASE} -- Implementation

	tmp_save_classes is
			-- Save content for all modified classes.
		do
		end;

end -- class CLASS_CONTENT_SERVER
