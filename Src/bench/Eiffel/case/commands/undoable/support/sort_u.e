indexing

	description: 
		"Undoable command for sorting entities.";
	date: "$Date$";
	revision: "$Revision $"

class SORT_U

inherit

	UNDOABLE_EFC
		undefine
			request_for_data, free_data
		end

creation

	make

feature {NONE} -- Initialization

	make (data_cont: like data_container; ol: like list) is
		require
			valid_lists: ol /= Void;
			valid_data: data_cont /= Void;
			valid_ol: ol /= Void
		local
			different: BOOLEAN
		do
			if not ol.empty then
				set_watch_cursor;
				data_container := data_cont;
				list := ol;
				ol.start;
				old_list := ol.duplicate (ol.count);
				!! new_list.make;
				new_list.merge (old_list);
				from
					old_list.start;
					new_list.start
				until
					old_list.after or else different
				loop
					different := old_list.item /= new_list.item;
					old_list.forth;
					new_list.forth
				end
				if different then
					record;
					redo;
				end;
				restore_cursor;
			end;
		end;

feature {NONE} -- Implementation

	data_container: DATA;

	list: LINKED_LIST [NAME_DATA];
			-- Entity actual list

	new_list: SORTED_TWO_WAY_LIST [NAME_DATA];
			-- Entity after sort

	old_list: LINKED_LIST [NAME_DATA];
			-- Entity before sort

	request_for_data is
		local
			f_data: FEATURE_DATA
		do
			f_data ?= data_container;
			if f_data /= Void then
				f_data.class_container.request_for_information
			end
		end;

	free_data is
		local
			f_data: FEATURE_DATA
		do
			f_data ?= data_container;
			if f_data /= Void then
				f_data.class_container.free_information
			end	
		end;

feature {DESTROY_ENTITIES_U, DESTROY_FEATURES_U} -- Implementation

	redo is
		do
			list.wipe_out;
			new_list.start
			from
				new_list.start
			until
				new_list.after
			loop
				list.put_right (new_list.item);
				new_list.forth;
				list.forth
			end;
			data_container.update_display (data_container)
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			list.wipe_out;
			old_list.start
			from
				old_list.start
			until
				old_list.after
			loop
				list.put_right (old_list.item);
				old_list.forth;
				list.forth
			end;
			data_container.update_display (data_container)
		end;

	name: STRING is "Sort"

end -- class SORT_U
