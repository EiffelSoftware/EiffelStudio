indexing

	description: 
		"Undoable command to change the reversed engineered path.";
	date: "$Date$";
	revision: "$Revision $"


class CHANGE_RE_PATH_U 

inherit

	UNDOABLE_EFC;
	CONSTANTS

creation

	make

feature 

	name: STRING is "Change reverse engineering path"

feature -- Redo/undo

	redo is
			-- Re-execute command (after it was undone).
		do
			data.set_reversed_engineered_file_name (clone (new_name));
			data.set_modified_since_re_all_classes;
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.set_reversed_engineered_file_name (clone (old_name));
		data.set_modified_since_re_all_classes;
			update
		end;

feature {NONE} -- Private datas

	update is
		do
--			data.update_title;
--			windows.system_window.update;
--			System.set_is_modified;
		end;

	data: CLUSTER_DATA;

	new_name: STRING;
			-- New name given to the data

	old_name: STRING;
			-- Data's old name

feature 

	make (entity: CLUSTER_DATA; to: STRING) is
			-- Change the name of a data_container
		require
			valid_entity: entity /= Void;
			valid_to: to /= Void
		local
		--	class_data: CLASS_DATA;
		--	tmp: STRING;
		--	win: TOP;
		--	filename_error,
		--	illegal_characters: BOOLEAN;
		--	i: INTEGER;
		--	ch: CHARACTER;
		do
--			if not equal (to, entity.reversed_engineered_file_name) then
--				if not to.empty then
--					from
--						i := 1
--					until
--						i > to.count or else illegal_characters
--					loop
--						ch := to.item (i);
--						illegal_characters := ch /= '_' and then 
--								ch /= '.' and then 
--								ch /= Environment.directory_separator and then
--								ch /= '$' and then
--								ch /= ':' and then
--								(ch < '0' or else ch > '9') and then 
--								(ch < 'A' or else ch > 'Z') and then 
--								(ch < 'a' or else ch > 'z');
--						i := i + 1;
--					end
--					if illegal_characters then
--					--	win := entity.window;
--						if win = Void then
--							win := Windows.main_graph_window
--						end;
--						Windows.error (win, Message_keys.illegal_filename_er, Void);
--						filename_error := True;
--					end
--				end
--				if not filename_error then
--					class_data ?= entity;
--					if class_data /= Void then
--						tmp := clone (to);
--					else
--						tmp := to
--					end;
--					if not tmp.empty and then 
--						entity /= System.root_cluster and then 
--						entity.parent_cluster.has_child_with_file_name (entity, tmp)
--					then
--						win := entity.window;
--						if win = Void then
----							win := Windows.main_graph_window
--						end;
--						Windows.error (win, Message_keys.filename_exists_in_parent_cluster_er, Void);
--					else
--						record;
--						data := entity;
--						new_name := clone (to);
--						old_name := clone (data.reversed_engineered_file_name);
--						if class_data /= Void then
--							old_name.head (old_name.count - 2);
--						end
--						redo
--					end
--				end
--			end
		end -- make

end -- class CHANGE_RE_PATH_U
