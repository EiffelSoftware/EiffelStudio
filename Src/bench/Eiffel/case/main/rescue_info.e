indexing

	description: "Rescuing the project in case of system crash.";
	date: "$Date$";
	revision: "$Revision $"

class RESCUE_INFO

inherit

	STORABLE;
	ONCES;
	CONSTANTS;
	SHARED_FILE_SERVER

creation

	make

feature -- Initialization

	make is
			-- Initialize current and save the project.
		local
		saved_classes: HASH_TABLE [S_CLASS_DATA, INTEGER];
			c_data: CLASS_DATA;
			s_c_data: S_CLASS_DATA;
			class_content: CLASS_CONTENT;
		do
			--Class_content_server.tmp_save_classes;
			--saved_classes := Temporary_system_file_server.saved_classes;
			system_data := System;
			--from
			--	!! classes.make (saved_classes.count);
			--	saved_classes.start
			--until
			--	saved_classes.after
			--loop
			--	s_c_data := saved_classes.item_for_iteration;
			--	s_c_data := Temporary_system_file_server.s_class_data_with 
			--		(s_c_data.view_id);
			--	c_data := system_data.class_of_id (s_c_data.id);
			--	if c_data /= Void then
			--		!! class_content.make_from_storer
			--			(s_c_data.disk_content, c_data);
			--		c_data.set_content (class_content);
			--		classes.extend (c_data)
			--	end;
			--	saved_classes.forth
			--end;
		end;

feature -- Properties

	classes: ARRAYED_LIST [CLASS_DATA];
			-- Stored classes 

system_data: SYSTEM_DATA;
			-- Stored system data 

feature -- Storing

	store_information is
			-- Store Current project to restore directory.
		local
			file: RAW_FILE;
			file_name: FILE_NAME;
			tmp: STRING
		do
			!! file_name.make_from_string (Environment.restore_directory);
			!! tmp.make (0);
			tmp.append (Environment.view_name);
			tmp.append_integer (system_data.view_id);
			file_name.set_file_name (tmp);
			!! file.make (file_name);
			file.open_write;
			independent_store (file);
			file.close
		end;

end -- class RESCUE_INFO
