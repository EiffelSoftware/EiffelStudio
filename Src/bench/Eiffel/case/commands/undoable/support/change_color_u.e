indexing

	description: 
		"Undoable command to change a color of a colorable object.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_COLOR_U 

inherit

	UNDOABLE_EFC

creation

	make

feature 

	name: STRING is "Change color"

feature -- Initialization

	make (colorbles: like colorable_list; to: STRING) is
			-- Change the name of a partition
		require
			valid_colorbles: colorbles /= Void;
			valid_to: to /= Void;
		local
			is_new_color: BOOLEAN;
			old_color: STRING
		do
			if not to.empty then
				colorable_list := colorbles;
				!! old_name_list.make
				from
					colorable_list.start
				until
					colorable_list.after
				loop
					old_color := colorable_list.item.color_name;
					old_name_list.put_right (old_color);
					if not is_new_color then
						is_new_color := not equal (old_color, to)
					end;
					old_name_list.forth;
					colorable_list.forth
				end;
				if is_new_color then
					new_name := clone (to);
					record;
					redo
				end
			end
		ensure
			count_same: old_name_list.count = colorable_list.count
		end -- make

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			from
				colorable_list.start
			until
				colorable_list.after
			loop
				colorable_list.item.set_color_name (clone (new_name));
				colorable_list.forth
			end;
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			from
				colorable_list.start;
				old_name_list.start				
			until
				colorable_list.after
			loop
				colorable_list.item.set_color_name 
						(clone (old_name_list.item));
				old_name_list.forth;				
				colorable_list.forth;
			end;
			update
		end;

feature {NONE} -- Implementation

	update is
		do
			from
				colorable_list.start
			until
				colorable_list.after
			loop
				workareas.change_color_data (colorable_list.item);
				colorable_list.forth
			end;
			workareas.refresh;
			System.set_is_modified
		end;

	colorable_list: LINKED_LIST [COLORABLE];  
			-- Partition modified

	new_name: STRING;
			-- New name given to the data

	old_name_list: LINKED_LIST [STRING];
			-- Colorables' old name

end -- class CHANGE_COLOR_U
