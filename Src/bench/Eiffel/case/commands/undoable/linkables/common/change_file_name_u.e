indexing

	description: 
		"Undoable command for changing the file name for linkable data.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_FILE_NAME_U 

inherit

	UNDOABLE_EFC;
	CONSTANTS
	ONCES

creation

	make

feature -- Initialization

	make (entity: LINKABLE_DATA; to: STRING) is
			-- Change the name of a data_container
		require
			valid_entity: entity /= Void;
			valid_to: to /= Void
		local
		--	class_data: CLASS_DATA;
		--	win: TOP;
		--	illegal_characters: BOOLEAN;
		--	i: INTEGER;
		--	ch: CHARACTER;
		do
--			if entity /= Void then
--				if not to.empty and then not equal (to, entity.file_name) then
--					from
--						i := 1
--					until
--						i > to.count or else illegal_characters
--					loop
--						ch := to.item (i);
--						illegal_characters := ch /= '_' and then 
--								ch /= '.' and then 
--								(ch < '0' or else ch > '9') and then 
--								(ch < 'A' or else ch > 'Z') and then 
--								(ch < 'a' or else ch > 'z');
--						i := i + 1;
--					end
--					if illegal_characters then
--						win := entity.window;
--						if win = Void then
--							win := Windows.main_graph_window
--						end;
--						Windows.error (win, Message_keys.illegal_filename_er, Void);
--					else
--						if entity /= System.root_cluster and then 
--								entity.parent_cluster.has_child_with_file_name (entity, to)
--						then
--							win := entity.window;
--							if win = Void then
--								win := Windows.main_graph_window
--							end;
--							Windows.error (win, Message_keys.filename_exists_in_parent_cluster_er, Void);
--						else
--							record;
--							data := entity;
--							new_name := clone (to);
--							old_name := clone (data.file_name);
--							if class_data /= Void then
--								old_name.head (old_name.count - 2);
--							end
--							redo
--						end
--					end
--				end
--			end
		end -- make

feature -- Property

	name: STRING is "Change filename"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			data.set_file_name (clone (new_name));
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.set_file_name (clone (old_name));
			update
		end;

feature {NONE} -- Implementation

	update is
		do
			observer_management.update_observer (data)
		end;

	data: LINKABLE_DATA;

	new_name: STRING;
			-- New name given to the data

	old_name: STRING;
			-- Data's old name

end -- class CHANGE_FILE_NAME_U
