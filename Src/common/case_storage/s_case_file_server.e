indexing

	description: 
		"File server to store temporarily class and%
		%system data. All files are saved with a%
		%temporary file extension when information is%
		%cached and is not saved. When the information%
		%is saved all files are changed from .TMP to%
		%their respective file names.";
	date: "$Date$";
	revision: "$Revision $"

class S_CASE_FILE_SERVER

feature -- Initialization

	init (p: like path) is
			-- Initialize Current
		require
			valid_path: p /= Void
		do
			path := clone (p);
			!! saved_classes.make (2)
		ensure
			path_set: path.is_equal (p);
			valid_saved_classes: saved_classes /= Void
		end;

feature -- Properties

	saved_system: S_SYSTEM_DATA;
			-- System saved to disk

	saved_classes: HASH_TABLE [S_CLASS_DATA, INTEGER];
			-- Table of class content saved to disk hashed
			-- on view_id

	path: STRING;
			-- Path to store case format

	is_saving: BOOLEAN;
			-- Is the saved_classes being saved to disk?
	
	had_io_problems: BOOLEAN;
			-- Did we have IO exception when trying to save?

feature -- Access

	s_class_data_with (view_id: INTEGER): S_CLASS_DATA is
			-- S_CLASS_DATA with view_id `view_id'.
			-- (Void if not found).
		do
			Result := saved_classes.item (view_id);
			if Result /= Void then
				Result.retrieve_from_disk (path, True);
			end;
		ensure
			valid_result: Result /= Void implies Result.is_valid
		end

feature -- Output

	tmp_save_class (s_class_data: S_CLASS_DATA) is
			-- Temporarily save stored class data format
			-- `s_class_data' to disk.
		require
			valid_data: s_class_data /= Void;
		do
			s_class_data.tmp_store_to_disk (path);
			saved_classes.force (s_class_data, s_class_data.view_id);
		ensure
			has_class: saved_classes.has_item (s_class_data);
		rescue
			had_io_problems := True;
		end;

	tmp_save_system (s_system_data: S_SYSTEM_DATA) is
			-- Temporarily save stored system data format
			-- `s_system_data' to disk.
		require
			valid_data: s_system_data /= Void;
			valid_path: path /= Void
		do
			saved_system := s_system_data;
			saved_system.tmp_store_to_disk (path);
		ensure
			has_saved_system: saved_system = s_system_data
		rescue
			had_io_problems := True;
		end;

feature -- Saving information to disk

	save_eiffelcase_format is
			-- Save the eiffelcase format to disk.
		require
			path_set: path /= Void
		do
debug ("CASE_SERVER")
	io.error.putstring ("Saving into directory: ");		
	io.error.putstring (path);
	io.error.new_line
end
			is_saving := True;
			from
				saved_classes.start	
			until
				saved_classes.after	
			loop
				saved_classes.item_for_iteration.save_information (path);
				saved_classes.forth	
			end;
			saved_system.save_information (path)
			saved_classes.clear_all;
			saved_system := Void;
		end;

feature -- Removal

	clear is
			-- Clear Current.
		do
			path := Void;
			saved_system := Void;
			saved_classes := Void;
			is_saving := False;
			had_io_problems := False;
		ensure
			cleared: path = Void and then
					saved_system = Void and then
					saved_classes = Void and then
					not is_saving and then
					not had_io_problems
		end;

	remove_tmp_files is
			-- Remove temporary files (in case of a crash)
		do
			if saved_classes /= Void then
				from
					saved_classes.start	
				until
					saved_classes.after	
				loop
debug ("CASE_SERVER")
	io.error.putstring ("%T Removing tmp class: ");
	io.error.putstring (saved_classes.item_for_iteration.name);		
	io.error.new_line
end
					saved_classes.item_for_iteration.remove_tmp_file (path);
					saved_classes.forth	
				end
			end;
		end;

end -- class S_CASE_FILE_SERVER
