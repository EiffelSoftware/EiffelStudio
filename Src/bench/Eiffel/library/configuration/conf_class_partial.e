indexing
	description: "Classes that where built from partial classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CLASS_PARTIAL

inherit
	CONF_CLASS
		redefine
			is_read_only,
			full_file_name,
			check_changed
		end

	REFACTORING_HELPER

create
	make_from_partial

feature {NONE} -- Initialization

	make_from_partial (a_partial_classes: ARRAYED_LIST [STRING]; a_group: CONF_GROUP; a_base_location: CONF_LOCATION) is
			-- Create.
		require
			a_partial_classes_not_void: a_partial_classes /= Void
			a_group_not_void: a_group /= Void
			a_base_location_not_void: a_base_location /= Void
		local
			l_cluster: CONF_CLUSTER
		do
			group := a_group
			base_location := a_base_location

			from
				create partial_classes.make (a_partial_classes.count)
				a_partial_classes.start
			until
				a_partial_classes.after
			loop
				partial_classes.force (0, a_partial_classes.item)
				a_partial_classes.forth
			end

			check_changed

			l_cluster ?= a_group
			if l_cluster /= Void and then l_cluster.visible /= Void then
				visible := l_cluster.visible.item (name)
			end
		end

feature -- Access

	is_read_only: BOOLEAN is True
			-- Is the class read only?

	full_file_name: STRING is
			-- The full file name of the class (including path).
		do
			Result := base_location.build_path (path, file_name)
		end

	base_location: CONF_LOCATION
			-- Base location where the generated files are stored.

feature {CONF_ACCESS} -- Update, in compiled only

	set_base_location (a_location: CONF_LOCATION) is
			-- Set `base_location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			base_location := a_location
		ensure
			base_location_set: base_location = a_location
		end

	rebuild_partial (a_partial_classes: ARRAYED_LIST [STRING]; a_group: CONF_GROUP; a_base_location: CONF_LOCATION) is
			-- Rebuild.
		require
			a_partial_classes_not_void: a_partial_classes /= Void
			a_group_not_void: a_group /= Void
			a_base_location_not_void: a_base_location /= Void
		local
			l_old: like partial_classes
			l_cluster: CONF_CLUSTER
		do
			group := a_group
			base_location := a_base_location

			from
				l_old := partial_classes
				create partial_classes.make (a_partial_classes.count)
				a_partial_classes.start
			until
				a_partial_classes.after
			loop
				partial_classes.force (l_old.item (a_partial_classes.item), a_partial_classes.item)
				a_partial_classes.forth
			end
			check_changed
			if is_modified then
				build_partial
			end

			l_cluster ?= a_group
			if l_cluster /= Void and then l_cluster.visible /= Void then
				visible := l_cluster.visible.item (name)
			end
		end

	check_changed is
			-- Check if any of the partial classes that build this class have changed.
		local
			l_file: RAW_FILE
		do
			from
				partial_classes.start
			until
				is_modified or partial_classes.after
			loop
				create l_file.make (partial_classes.key_for_iteration)
				is_modified := not l_file.exists or else partial_classes.item_for_iteration /= l_file.date
				partial_classes.forth
			end
			if is_modified then
				build_partial
			end
		end


feature {NONE} -- Implementation

	partial_classes: HASH_TABLE [INTEGER, STRING]
			-- Partial classes that are the source for this class, mapped to their last modification time.

	build_partial is
			-- Build the class from the partial class files.
		require
			base_location_not_void: base_location /= Void
			partial_classes_not_void: partial_classes /= Void
		local
			l_lst: ARRAYED_LIST [STRING]
			l_retried: BOOLEAN
			l_dir: KL_DIRECTORY
			l_file: PLAIN_TEXT_FILE
		do
			create l_lst.make_from_array (partial_classes.current_keys)
			epc_merger.merge (l_lst)
			if not epc_merger.successful then
				is_error := True
				last_error := create {CONF_ERROR_PARTIAL}.make (epc_merger.error_message)
				name := ""
				renamed_name := ""
				path := ""
				file_name := ""
			else
				path := group.name

				create l_dir.make (base_location.build_path (path, ""))
				l_dir.create_directory

					-- us temporary file to get name of class
				file_name := "tmp.e"
				create l_file.make_open_write (full_file_name)
				l_file.put_string (epc_merger.class_text)
				l_file.close

				set_name

				check
					name_set: name /= Void and then renamed_name /= Void
				end

					-- rename file to class name
				file_name := name.as_lower + ".e"
				l_file.change_name (full_file_name)
			end
		ensure
			name: not is_error implies (not name.is_empty and not renamed_name.is_empty)
			location: not is_error implies (not path.is_empty and not file_name.is_empty)
		rescue
			l_retried := True
			is_error := True
			last_error := create {CONF_ERROR_PARTIAL}.make ("Could not store merged class.")
			retry
		end

feature {NONE} -- Shared instances

	epc_merger: EPC_MERGER is
			-- Shared instance of EPC_MERGER.
		once
			create Result
		end


end
