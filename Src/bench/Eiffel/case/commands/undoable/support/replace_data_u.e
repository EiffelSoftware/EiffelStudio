indexing

	description: 
		"Undoable command to replace existing data with other data.";
	date: "$Date$";
	revision: "$Revision $"

class REPLACE_DATA_U

inherit

	UNDOABLE_EFC
		redefine
			request_for_data,
			free_data
		end
	CONSTANTS

creation

	make

feature -- Initializaton

	make (data_cont: like data_container; a_data, rep_d: DATA) is
		require
			valid_data_cont: data_cont /= Void;
			data_cont_has_elements: data_cont.has_elements
			rep_d_not_void: rep_d /= Void;
			a_data_not_void: a_data /= Void;
			same_stone_types: rep_d.stone_type = a_data.stone_type
		local
			fd: FEATURE_DATA;
			argument, changed_arg: ARGUMENT_DATA;
			arguments: ELEMENT_LIST [ARGUMENT_DATA];
			cd: CLASS_DATA;
			generic, changed_gen: GENERIC_DATA;
			generics: LINKED_LIST [GENERIC_DATA];
			name_found: BOOLEAN;
			tmp1, tmp2: STRING;
		do
--			generic ?= rep_d;
--			if generic /= Void then
--				cd ?= data_cont;
--				if cd /= Void then
--					generics := cd.generics;
--					changed_gen ?= a_data;
--					from
--						generics.start
--					until
--						generics.after or else name_found
--					loop
--						if generics.item /= changed_gen then
--							name_found := generic.name.is_equal (generics.item.name);
--						end;
--						generics.forth;
--					end;
--					if name_found then
--						Windows.error (Windows.main_graph_window,  -- 1812
--								Message_keys.generic_name_exists_er, Void);
--					end;
--				end
--			else
--				argument ?= rep_d;
--				if argument /= Void then
--					fd ?= data_cont;
--					if fd /= Void then
--						changed_arg ?= a_data;
--						arguments := fd.arguments;
--						from
--							arguments.start
--							tmp1 := clone (argument.id);
--							tmp1.to_lower;
--						until
--							arguments.after or else name_found
--						loop
--							if arguments.item /= changed_arg then
--								tmp2 := clone (arguments.item.id);
--								tmp2.to_lower;
--								name_found := tmp1.is_equal (tmp2);;
--							end;
--							arguments.forth;
--						end
--						if name_found then
--							Windows.error (Windows.main_graph_window , Message_keys.argument_name_exists_er, Void); -- 1812
--						end;
--					end
--				end
--			end;
--			if not name_found then
--				set_watch_cursor;
--				data_container := data_cont;
--				data := a_data;
--				old_data := clone (a_data);
--				replaced_data := rep_d;
--				record;
--				redo;
--				restore_cursor;
--			end;
		end;

feature -- Property

	name: STRING is 
		do
			!! Result.make (0);
			Result.append ("Replace ");
			Result.append (replaced_data.name_for_command)
		end;

feature -- Update

	redo is
			-- Execute command.
		do
			data.copy (replaced_data);
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.copy (old_data);
			update;
		end;

feature {NONE}

	request_for_data is
		do
			data_container.request_for_information;
		end;

	free_data is
		do
			data_container.free_information
		end;

	data_container: DATA;

	replaced_data: DATA;
			-- Data replacing `old_data'

	old_data: DATA;
			-- Data before being overriden by `replaced_data'

	data: DATA;
			-- Data being replaced

	update is
		require
			data_container_has_elements: data_container.has_elements
		do
--			if Windows.namer_window.namable /= Void then
--					-- Resync namer if popped up
--				Windows.namer_window.resync
--			end
--			data_container.update_display (old_data)
		end;

end -- class REPLACE_DATA_U
