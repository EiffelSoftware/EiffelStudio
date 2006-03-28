indexing
	description: "Objects that represent a class on the configuration level, if the project is compiled."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CLASS

inherit
	SHARED_CLASSNAME_FINDER
		export
			{NONE} all
		end

	COMPARABLE
		undefine
			is_equal
		end

	KL_SHARED_OPERATING_SYSTEM

	CONF_FILE_DATE

	HASHABLE

create
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING; a_group: like group; a_path: STRING) is
			-- Create
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			l_cluster: CONF_CLUSTER
		do
			file_name := a_file_name
			group := a_group
			path := a_path
			check_changed

			if not is_error then
				check
					name_set: name /= Void and then not name.is_empty
				end

				l_cluster ?= a_group
				if l_cluster /= Void and then l_cluster.visible /= Void then
					visible := l_cluster.visible.item (name)
				end
			end
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error?

	last_error: CONF_ERROR
			-- Last error.

feature -- Access, in compiled only, not stored to configuration file

	name: STRING
			-- Class name without any renamings.

	renamed_name: STRING
			-- Name with renamings/prefix of the own cluster applied.
			-- But not with the renamings due to use as library applied.

	options: CONF_OPTION is
			-- Options (Debuglevel, assertions, ...)
		do
			Result := actual_class.group.get_class_options (name)
		ensure
			Result_not_void: Result /= Void
		end

	visible: TUPLE [STRING, HASH_TABLE [STRING, STRING]]
			-- The visible features, "*" = all, mapped to their renamed name (if any).

	is_compiled: BOOLEAN is
			-- Has the class been compiled?
		once
			Result := False
		end

	is_always_compile: BOOLEAN is
			-- Does this class have to be always compiled?
		do
			Result := visible /= Void
		end

	is_precompiled: BOOLEAN
			-- Is the class precompiled?

	is_partial: BOOLEAN
			-- Is the class generated out of partial classes?

	is_library: BOOLEAN is
			-- Is the class part of a library?
		local
			l_lib: CONF_LIBRARY
		do
			l_lib ?= group
			Result := l_lib /= Void
		end

	is_read_only: BOOLEAN is
			-- Is the class read only?
		local
			l_file: RAW_FILE
		do
			Result := is_precompiled or is_partial or group.is_readonly
			if not Result then
					-- check if the file itself is read only
				create l_file.make (full_file_name)
				Result := not l_file.exists or else not l_file.writable
			end
		end

	is_overriden: BOOLEAN is
			-- Is the class overridden?
		do
			Result := overriden_by /= Void
		end

	does_override: BOOLEAN is
			-- Does the class override other classes?
		do
			Result := overrides /= Void
		end


	is_modified: BOOLEAN
			-- Has the class been changed since last recompilation?

	is_renamed: BOOLEAN
			-- Has the class been renamed since the last recompilation?

	date: INTEGER
			-- Date of the last modification of the class.

	group: CONF_PHYSICAL_GROUP
			-- The group this class belongs to.

	file_name: STRING
			-- The file name of the class.

	full_file_name: STRING is
			-- The full file name of the class (including path).
		do
			Result := group.location.build_path (path, file_name)
		end

	path: STRING
			-- The path of the class, relative to the group, in unix format.

	overriden_by: like class_type
			-- The class that overrides this class.

	overrides: ARRAYED_LIST [like class_type]
			-- The classes that this class overrides.

feature -- Access queries

	actual_class: like class_type is
			-- Return the actual class (takes overriding into account).
		do
			if is_overriden then
				Result := overriden_by
			else
				Result := Current
			end
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		do
				-- compute hash code on demand
			if internal_hash_code = 0 then
				internal_hash_code := renamed_name.hash_code
			end
			Result := internal_hash_code
		end

feature -- Status update

	set_modified is
			-- Mark the class as modified.
		do
			is_modified := True
		end


	set_up_to_date is
			-- The class has been recompiled and is now up to date.
		do
			is_modified := False
			is_renamed := False
		ensure
			not_modified: not is_modified
			not_renamed: not is_renamed
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	rebuild(a_file_name: STRING; a_group: like group; a_path: STRING) is
			-- Update the informations during a rebuild.
			-- More or less the same thing as we during `make'.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			l_cluster: CONF_CLUSTER
		do
			file_name := a_file_name
			group := a_group
			path := a_path
			check_changed

			if not is_error then
				l_cluster ?= a_group
				if l_cluster /= Void and then l_cluster.visible /= Void then
					visible := l_cluster.visible.item (name)
				end
			end

				-- forget override informations except the one necessary for the
				-- check if a new override was added on a before not overriden class
			overrides := Void
			old_overriden_by := overriden_by
			overriden_by := Void
		end


	enable_precompiled is
			-- Set `is_precompiled' to true.
		do
			is_precompiled := True
		end

	check_changed is
			-- Check if the file was changed.
			-- And update name if necessary
		local
			l_str: ANY
			l_date: INTEGER
		do
			l_str := full_file_name.to_c
			eif_date ($l_str, $l_date)
			if date /= l_date then
				date := l_date
				is_modified := True

					-- check for a changed class name
				set_name
			end
		end

	set_name is
			-- Compute and set `name' and `renamed_name'.
		local
			l_file: KL_BINARY_INPUT_FILE
			l_name: like name
			l_renamings: HASH_TABLE [STRING, STRING]
			l_old_name: like renamed_name
		do
			create l_file.make (full_file_name)
			if l_file.exists then
				l_file.open_read
				classname_finder.parse (l_file)
				l_file.close
				l_name := classname_finder.classname
				if l_name = Void then
					set_error (create {CONF_ERROR_CLASSN}.make (full_file_name))
				else
					l_name.to_upper
					if name = Void or else not name.is_equal (l_name) then
						is_renamed := True
						l_old_name := renamed_name
						name := l_name.as_upper
						renamed_name := name.twin
						l_renamings := group.renaming
						if l_renamings /= Void and then l_renamings.has (name) then
							renamed_name := l_renamings.item (name)
						end
						if group.name_prefix /= Void then
							renamed_name.prepend (group.name_prefix)
						end
							-- if applicable, add new entry and remove old
						if group.classes /= Void and then l_old_name /= Void and then group.classes.has (l_old_name) then
							group.classes.remove (l_old_name)
							group.classes.force (Current, renamed_name)
						end
					end
				end
			end
		end


	set_overriden_by (a_class: like class_type) is
			-- `a_class' overrides `Current'.
		require
			a_class_not_void: a_class /= Void
			not_overriden: not is_overriden
		do
			overriden_by := a_class
				-- if compiled and the override changed
			is_modified := is_compiled and (old_overriden_by /= a_class or a_class.is_modified)
			old_overriden_by := Void
		ensure
			is_overriden: is_overriden
		end

	add_does_override (a_class: like class_type) is
			-- `Current' overrides `a_class'.
		do
			if overrides = Void then
				create overrides.make (1)
			end
			overrides.extend (a_class)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Class name alphabetic order
		do
			Result := name < other.name
		end

feature {NONE} -- Implementation

	internal_hash_code: like hash_code
			-- Computed `hash_code'.

	old_overriden_by: like overriden_by
			-- `overriden_by' from last compilation.

	set_error (an_error: CONF_ERROR) is
			-- Set `an_error'.
		do
			is_error := True
			last_error := an_error
		end

feature {NONE} -- Type anchor

	class_type: CONF_CLASS

invariant
	name_ok: name /= Void and then not name.is_empty
	name_upper: name.is_equal (name.as_upper)
	renamed_name_ok: renamed_name /= Void and then not renamed_name.is_empty
	renamed_name_upper: renamed_name.is_equal (renamed_name.as_upper)
	file_name_not_void: file_name /= Void
	group_not_void: group /= Void
	path_not_void: path /= Void
	is_error_set: is_error implies last_error /= Void

end
