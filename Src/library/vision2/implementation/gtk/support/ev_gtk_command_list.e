indexing
	description: "contains two LINKED_LIST, one for command and one for the%
		% associated connexion_id given by GTK"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_COMMAND_LIST

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			create command_list.make
			create connexion_id_list.make
		end

feature -- Access

	command_list: LINKED_LIST [EV_COMMAND]
			-- list of commands

	connexion_id_list: LINKED_LIST [INTEGER]
			-- list of the connexion id associated to the commands

	connexion_id: INTEGER is
			-- Connexion_id of the current item
		do
			Result := connexion_id_list.item
		end

feature -- Status report

	search_cmd (cmd: EV_COMMAND) is
			-- search for `cmd' through the command_list
			-- and set the position in `connexion_id_list' on the
			-- associated connexion_id for the `cmd'.
		do
			command_list.search (cmd)
			connexion_id_list.go_i_th (command_list.index)
		end

	search_con_id (id: INTEGER) is
			-- search for the connexion id, `id' through the connexion_id_list
			-- and set the position in `command_list' on the
			-- associated command for the `id'.
		do
			connexion_id_list.search (id)
			command_list.go_i_th (connexion_id_list.index)
		end

	exhausted: BOOLEAN is
			-- command_list is exhausted
		do
			Result := command_list.exhausted
		ensure
			connexion_id_list_coherent: Result = connexion_id_list.exhausted
		end

feature -- Status setting

	extend (cmd: EV_COMMAND; con_id: INTEGER) is
			-- add `cmd' to command_list and `con_id' to connexion_id_list
		do
			command_list.extend (cmd)
			connexion_id_list.extend (con_id)
		end

	forth is
		do
			command_list.forth
			connexion_id_list.forth
		end			

	remove is
			-- remove the current command of command_list
			-- and the associated connexion_id in connexion_id_list
		do
--			connexion_id_list.go_i_th (command_list.index)
			command_list.remove
			connexion_id_list.remove
		end

	start is
			-- set the position at the beginning of command_list
		do
			command_list.start
			connexion_id_list.start
		end

	finish is
			-- set the position at the end of command_list
		do
			command_list.finish
			connexion_id_list.finish
		end

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := command_list.after
		end

	remove_all_items is
			-- remove all the items.
		do
			from
				command_list.start
				connexion_id_list.start
			until
				command_list.empty
			loop
				command_list.remove
				connexion_id_list.remove
			end
		end

end -- class EV_GTK_COMMAND_LIST
