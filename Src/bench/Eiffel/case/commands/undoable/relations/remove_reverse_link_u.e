indexing

	description: 
		"Undoable command that removes the reverse link.";
	date: "$Date$";
	revision: "$Revision $"

class REMOVE_REVERSE_LINK_U

inherit

	ADD_REVERSE_LINK_U
		rename
			redo as old_redo,
			undo as old_undo,
			make as old_make
		redefine
			name
		end
	ADD_REVERSE_LINK_U
		rename
			make as old_make
		redefine
			undo, redo, name
		select
			undo, redo
		end

creation

	make

feature -- Initialization

	make (a_link: CLI_SUP_DATA) is
			-- add a reverse link to 'link' with `other_link'.
		require
			has_link: a_link /= Void;
			is_reversed: a_link.is_reverse_link
		do
			set_watch_cursor;
			record;
			other_link := a_link.reverse_link;
			link := a_link;
			if other_link.label.from_handle_nbr > 
				other_link.break_points.count + 1 then
				old_from_handle_nbr := 1;
				new_from_handle_nbr := other_link.label.from_handle_nbr;
			end;
			redo;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link
		end -- make

feature -- Property

	name: STRING is "Remove reverse link";

feature -- Update

	undo is
		do
			old_redo
		end;

	redo is
		do
			old_undo
		end;

end -- class REMOVE_REVERSE_LINK_U
