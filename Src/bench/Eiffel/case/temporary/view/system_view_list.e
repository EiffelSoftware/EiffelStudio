indexing

	description: "List of system view information.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_VIEW_LIST

inherit

	ARRAYED_LIST [SYSTEM_VIEW_INFO];
	CONSTANTS
		undefine
			setup, copy, is_equal
		end;
	ONCES
		undefine
			setup, copy, is_equal
		end;
	STORABLE
		undefine
			setup, copy, is_equal
		end

creation

	make

feature -- Properties

	has_view_name (view_name: STRING): BOOLEAN is
			-- Does Current have view with name `view_name' ?
		require
			valid_view_name: view_name /= Void and then 
					not view_name.empty;
		local
			tmp1, tmp2: STRING
		do
			tmp2 := clone (view_name);
			tmp2.to_lower;
			from
				start
			until
				after or else Result
			loop
				tmp1 := clone (item.view_name);
				tmp1.to_lower;
				Result := equal (tmp1, tmp2);
				forth
			end
		end

feature -- Update

	add_view_with_name (view_name: STRING) is
			-- Add `view_name' to Current and
			-- store to disk. Copy the Current
			-- system view to `view_name'. 
		require
			valid_view_name: view_name /= Void and then 
					not view_name.empty;
			name_not_in_list: not has_view_name (view_name)
		local
			view_id: INTEGER;
			system_view_info: SYSTEM_VIEW_INFO;
			v: SYSTEM_VIEW
		do
			if empty then
				view_id := 1
			else
				view_id := last.view_id + 1
			end;
			!! v.make (System);
			v.set_view_details (view_name, view_id);
			v.tmp_store_to_disk;
			v.save_to_disk;
			!! system_view_info.make (view_id, view_name);
			extend (system_view_info);
			store_to_disk;	
	end;

	add_default is
			-- Add default view and
			-- update `System' view and save to disk
		local
			system_view_info: SYSTEM_VIEW_INFO;
			v: SYSTEM_VIEW;
		do
			!! system_view_info.make (count + 1, "default");
			System.set_view_id (count + 1);
			System.set_view_name ("default");
			extend (system_view_info);
			!! v.make (System);
			v.set_view_details ("default", count);
			v.tmp_store_to_disk;
			v.save_to_disk;
			store_to_disk
		end;

	update_list is
			-- Update Current list with system
			-- `System' and update `System' view
			-- and save to disk
		local
			view_id: INTEGER;
			system_view_info: SYSTEM_VIEW_INFO;
		do
			view_id := System.view_id;
			if view_id = 0 then
				-- View has been set
				add_default
			else
				from
					start
				until
					after or else
					item.view_id = view_id
				loop
					forth
				end;
				if after then
						-- This should never happen (well just in case...)
					add_default
				else
						-- Found. If system view name has changed then
						-- update.
					system_view_info := item;
					if not system_view_info.view_name.is_equal 
							(System.view_name) 
					then
						system_view_info.set_view_name (System.view_name);
						store_to_disk
					end
				end
			end
		end;

feature -- Storage

	store_to_disk is
			-- Store current to disk in file
			-- (Environment) view_file_name
		local
			view_file: RAW_FILE
		do
			!! view_file.make (Environment.view_file_name);
			view_file.open_write;
			independent_store (view_file);
			view_file.close;
		end;

feature -- Removal

	delete_view_with_id (system_view_id: INTEGER; view_path: STRING) is
			-- Remove system view data with id `system_view_id'.
			-- And store the result to disk.
		require
			valid_system_view_id: system_view_id > 0
			view_path_exists: view_path /= Void
		local
			view_file: RAW_FILE;
			view_file_name: FILE_NAME;
			tmp: STRING
		do
			from
				start
			until
				after or else
				item.view_id = system_view_id
			loop
				forth
			end;
			if not after then
				delete_view (view_path)
			end;
		end;

	delete_view_with_position (pos: INTEGER; view_path: STRING) is
			-- Remove `position'-th system view data
			-- And store the result to disk.
		require
			valid_position: valid_index (pos)
			view_path_exists: view_path /= Void
		local
			system_view_id: INTEGER
		do
			go_i_th (pos)
			delete_view (view_path)
		end;

feature {NONE} -- Implementation

	delete_view (view_path: STRING) is
			-- Delete view at current position,
			-- and update related information
		require
			inside: not off
			item_exists: item /= Void
		local
			view_file: RAW_FILE;
			view_file_name: FILE_NAME;
			tmp: STRING
			system_view_id: INTEGER
		do
			system_view_id := item.view_id
			remove;
				-- Update Current list
			!! view_file.make (view_path);
			view_file.open_write;
			independent_store (view_file);
			view_file.close;
				-- Remove the view
			tmp := clone (view_path);
			tmp.append_integer (system_view_id);
			!! view_file_name.make;
			view_file_name.set_file_name (tmp);
			!! view_file.make (view_file_name);
			if view_file.exists then
				view_file.delete
			end
			if System.view_id = system_view_id then
				System.wipe_out;
				-- 1812 Windows.main_panel.unset_project_initialized;
			end;
		end

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				item.trace;
				io.error.new_line;
				forth
			end
		end;

end -- class SYSTEM_VIEW_LIST
