indexing
	description: "Class used to store and retrieve a whole project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class STORER 

inherit
	SHARED_STORAGE_INFO

	SHARED_CONTEXT

	SHARED_APPLICATION

	WINDOWS

	CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make is
		do
			create context_storer
			create command_storer
			create state_storer
			create namer_storer
			create application_storer
			create group_storer
		end

feature -- Retrieved data

	contexts: LINKED_LIST [CONTEXT]

	commands: LINKED_LIST [LINKED_LIST [USER_CMD]]

	behaviors: LINKED_LIST [BEHAVIOR]

	states: LINKED_LIST [BUILD_STATE]

feature {NONE} -- Storers

	context_storer: CONTEXT_STORER

	command_storer: COMMAND_STORER

	state_storer: S_STORER

	application_storer: APPLICATION_STORER

	group_storer: GROUP_STORER

	namer_storer: NAMER_STORER

feature -- Access

	store (dir_name: STRING) is
			-- Store eiffelbuild application to
			-- directory `dir_name'.
		require
			valid_dir_name: dir_name /= Void
		do
				-- Save storer temporarily
			context_storer.tmp_store (dir_name)
			group_storer.tmp_store (dir_name)
			command_storer.tmp_store (dir_name)
			state_storer.tmp_store (dir_name)
			application_storer.tmp_store (dir_name)
			namer_storer.tmp_store (dir_name)

				-- Move tmp file to saved file name
			context_storer.save_stored_information (dir_name)
			group_storer.save_stored_information (dir_name)
			command_storer.save_stored_information (dir_name)
			state_storer.save_stored_information (dir_name)
			application_storer.save_stored_information (dir_name)
			namer_storer.save_stored_information (dir_name)
		end

	retrieve (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		local
			c: STATE_CIRCLE
			a_context: CONTEXT
		do
			clear_shared_storage_info
			group_storer.retrieve (dir_name)
			Shared_group_list.wipe_out
			Shared_group_list.merge_right (group_storer.retrieved_data)
			context_catalog.update_groups
			context_storer.retrieve (dir_name)

			command_storer.retrieve (dir_name)
			commands := command_storer.retrieved_data
			command_catalog.merge (commands)
			namer_storer.retrieve (dir_name)

				-- Display main windows
			display_init_windows
			contexts := context_storer.retrieved_data
			from
				contexts.start
			until
				contexts.after
			loop
				a_context := contexts.item
				a_context.retrieve_oui_widget
				contexts.forth
			end

				-- Order is important. Need to
				-- retrieve oui widgets before
				-- calling state storer.
			state_storer.retrieve (dir_name)
			states := state_storer.retrieved_data
			application_storer.retrieve (dir_name)
			application_storer.rebuild_graph
			if (application_storer.has_initial_circle) then
				c := circle_table.item (application_storer.initial_circle)
				app_editor.set_initial_state_circle (c)
				c.set_double_thickness
			end
			app_editor.set_default_selected

			clear_shared_storage_info
		end

end -- class STORER

