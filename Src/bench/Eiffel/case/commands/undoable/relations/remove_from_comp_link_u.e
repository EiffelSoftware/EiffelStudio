indexing

	description: 
		"Undoable command that removes a link from%
		%a compressed link.";
	date: "$Date$";
	revision: "$Revision $"

class REMOVE_FROM_COMP_LINK_U

inherit

	ADD_TO_COMPRESSED_LINK_U
		rename
			redo as old_redo,
			undo as old_undo
		redefine
			make, name
		end
	ADD_TO_COMPRESSED_LINK_U
		redefine
			make, undo, redo, name
		select
			undo, redo
		end

creation

	make, make_without_record

feature -- Initialization

	make (a_list: like relation_list; comp_l: like compressed_link) is
			-- Create a new cluster
		do
			is_recorded := True;
			from
				a_list.start
			until
				a_list.after
			loop
				if not a_list.item.is_in_compressed_link or else 
					not comp_l.has_link (a_list.item)
				then
					a_list.remove
				else
					a_list.forth
				end;
			end;
			if not a_list.empty then
				set_watch_cursor;
				relation_list := a_list;
				record;
				compressed_link := comp_l
				redo;
				restore_cursor;
			end;
		end

feature -- Property

	name: STRING is "Uncompress link";

feature -- Update

	undo is
		do
			if compressed_link.empty then
				if not compressed_link.is_in_system then
					compressed_link.put_relation_in_system;
					workareas.change_data (compressed_link);
				end;
			end
			old_redo;
		end;

	redo is
		local
			inh: INHERIT_DATA;
			cli_sup: CLI_SUP_DATA
		do
				-- Not to update workarea
			is_recorded := False;
			old_undo;
			if compressed_link.empty and then 
				compressed_link.is_in_system
			then
				inh ?= compressed_link;
				compressed_link.remove_relation_from_system;
				if inh /= Void then
					workareas.destroy_inherit (inh);
				else
					cli_sup ?= compressed_link;
					workareas.destroy_reference (cli_sup)
				end;
			end
			is_recorded := True;
			update;
		end;

end -- class REMOVE_FROM_COMP_LINK_U
