indexing
	description: "Objects that represent a class on the configuration level, if the project is compiled."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	CONF_ACCESS

	DEBUG_OUTPUT

create {CONF_PARSE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING; a_group: like group; a_path: STRING; a_factory: like factory) is
			-- Create
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			a_factory_not_void: a_factory /= Void
		local
			l_cluster: CONF_CLUSTER
		do
			file_name := a_file_name
			group := a_group
			path := a_path
			is_valid := True
			check_changed

			if not is_error then
				check
					name_set: name /= Void and then not name.is_empty
				end

				l_cluster ?= a_group
			end
			is_renamed := False
			factory := a_factory
		ensure
			is_valid: is_valid
			factory_set: factory = a_factory
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error?

	last_error: CONF_ERROR
			-- Last error.

feature -- Access, in compiled only, not stored to configuration file

	name: STRING
			-- Class name without any renamings.

	options: CONF_OPTION is
			-- Options (Debuglevel, assertions, ...)
		do
			Result := actual_class.group.get_class_options (name)
			if Result.assertions = Void then
				Result.set_assertions (factory.new_assertions)
			end
		ensure
			Result_not_void: Result /= Void
			Result_assertions: Result.assertions /= Void
		end

	visible: EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]]
			-- The visible features.

	is_valid: BOOLEAN
			-- Is `Current' still valid, ie. still part of the system?

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

	is_partial: BOOLEAN
			-- Is the class generated out of partial classes?

	is_read_only: BOOLEAN is
			-- Is the class read only?
		local
			l_file: RAW_FILE
		do
			Result := is_partial or group.is_readonly
			if not Result then
					-- check if the file itself is read only
				create l_file.make (full_file_name)
				Result := not l_file.exists or else not l_file.is_writable
			end
		end

	is_overriden: BOOLEAN is
			-- Is the class overridden?
		do
			Result := overriden_by /= Void
		end

	is_class_assembly: BOOLEAN is
			-- Is class from an assembly?
		do

		end

	does_override: BOOLEAN is
			-- Does the class override other classes?
		do
			Result := overrides /= Void
		end

	is_modified: BOOLEAN
			-- Has the class been changed since last recompilation?

	is_removed: BOOLEAN
			-- Has the class been removed?

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

feature -- Status report

	has_modification_date_changed: BOOLEAN is
			-- Did modification date changed since last call to `check_changed'?
		local
			l_date: INTEGER
		do
			l_date := file_modified_date (full_file_name)
			Result := (l_date = -1) or (l_date /= date)
		end

feature -- Access queries

	actual_class: like class_type is
			-- Return the actual class (takes overriding into account).
		do
			if is_overriden then
				Result := overriden_by
			else
				Result := Current
			end
		ensure
			actual_class_not_void: Result /= Void
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		do
				-- compute hash code on demand
			if internal_hash_code = 0 then
				internal_hash_code := name.hash_code
			end
			Result := internal_hash_code
		end

feature -- Status update

	set_modified is
			-- Mark the class as modified.
		do
			is_modified := True
		end

	reset_error is
			-- Reset the error.
		do
			is_error := False
			last_error := Void
		ensure
			not_error: not is_error
			last_error_empty: last_error = Void
		end

	set_up_to_date is
			-- The class has been recompiled and is now up to date.
		do
			is_modified := False
			is_renamed := False
			is_removed := False
		ensure
			not_modified: not is_modified
			not_renamed: not is_renamed
			not_removed: not is_removed
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	add_visible (a_vis: like visible) is
			-- Add visible rules to `visible'. Set `is_error' and `last_error' if there is a conflict.
		require
			a_vis_not_void: a_vis /= Void
			a_renamed_not_void: a_vis.item.class_renamed /= Void
		local
			l_vis_check, l_vis_other: EQUALITY_HASH_TABLE [STRING, STRING]
			l_other: STRING
			l_error: BOOLEAN
		do
				-- easy case first, most of the time this will be the only thing that is needed to do
			if visible = Void then
				visible := a_vis
			else
					-- check final external class name
				if visible.item.class_renamed.is_equal (a_vis.item.class_renamed) then
					if equal (a_vis.item.features, visible.item.features) then
						-- done, same features are visible
					else
						if visible.item.features = Void then
							l_vis_check := a_vis.item.features
						elseif a_vis.item.features = Void then
							l_vis_check := visible.item.features
						end
						if l_vis_check /= Void then
								-- check for renamings
							from
								l_vis_check.start
							until
								l_error or l_vis_check.after
							loop
								l_error := not l_vis_check.key_for_iteration.is_equal (l_vis_check.item_for_iteration)
								l_vis_check.forth
							end
							if l_error then
									-- conflict, all features visible vs some features visible with renaming
								is_error := True
								last_error := create {CONF_ERROR_VISI_CONFL01}.make (visible.item.class_renamed)
							else
									-- done, everything is visible and we had no renamings
									-- twin because we may change something
								visible := visible.twin
								visible.item.features := Void
							end
						else
								-- check if there are no conflicting feature definitions
							if visible.item.features.count >= a_vis.item.features.count then
								l_vis_check := visible.item.features
								l_vis_other := a_vis.item.features
							else
								l_vis_check := a_vis.item.features
								l_vis_other := visible.item.features
							end
							from
								l_vis_check.start
							until
								l_error or l_vis_check.after
							loop
								l_other := l_vis_other.item (l_vis_check.key_for_iteration)
								l_error := not (l_other = Void or l_other.is_equal (l_vis_check.item_for_iteration))
								l_vis_check.forth
							end
							if l_error then
									-- conflict, conflicting feature renamings
								is_error := True
								last_error := create {CONF_ERROR_VISI_CONFL02}.make (visible.item.class_renamed)
							else
									-- merge
									-- twin because we may change something
								visible.item.features := visible.item.features.twin
								visible.item.features.merge (a_vis.item.features)
							end
						end
					end
				else
						-- conflict, different final external class name
					is_error := True
					last_error := create {CONF_ERROR_VISI_CONFL03}.make (visible.item.class_renamed, a_vis.item.class_renamed)
				end
			end
		end

	invalidate is
			-- Set `is_valid' to False.
		do
			is_valid := False
		end

	resurect is
			-- Set `is_valid' to True.
		do
			is_valid := True
		end

	rebuild(a_file_name: STRING; a_group: like group; a_path: STRING) is
			-- Update the informations during a rebuild.
			-- More or less the same thing as we during `make'.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			l_cluster: CONF_CLUSTER
			l_old_name: STRING
		do
			is_rebuilding := True

			l_old_name := name.twin
			group := a_group
			if not equal (l_old_name, name)	then
				is_renamed := True
				date := 0
			end
			file_name := a_file_name
			path := a_path
			check_changed

				-- do not loose information if we where renamed as we build a new class if we were renamed and we want the old information
				-- to deal with removed overrides
			if not is_renamed then
				if not is_error then
					l_cluster ?= a_group
					visible := Void
				end

					-- forget override informations except the one necessary for the
					-- check if a new override was added on a before not overriden class
				overrides := Void
				old_overriden_by := overriden_by
				overriden_by := Void
			end

			is_rebuilding := False
		end

	check_changed is
			-- Check if the file was changed.
			-- And update name if necessary
		local
			l_date: INTEGER
		do
			l_date := file_modified_date (full_file_name)
			if l_date = -1 then
				is_removed := True
				date := 0
			elseif date /= l_date then
				date := l_date
				is_modified := True

					-- check for a changed class name
				set_name
			end
		end

	set_name is
			-- Compute and set (if we are not rebuilding) `name' and `renamed_name'.
		local
			l_file: KL_BINARY_INPUT_FILE
			l_name: like name
		do
			reset_error
			create l_file.make (full_file_name)
			if l_file.exists then
				l_file.open_read
				classname_finder.parse (l_file)
				l_file.close
				l_name := classname_finder.classname
				if l_name = Void then
					date := -1
					set_error (create {CONF_ERROR_CLASSN}.make (full_file_name, group.target.system.file_name))
				else
					l_name.to_upper
					if name = Void or else not name.is_equal (l_name) then
						is_renamed := True
						if not is_rebuilding then
							name := l_name
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

feature -- Output

	debug_output: STRING is
			-- Generate a nice representation of Current to be seen
			-- in debugger.
		do
			Result := name
		end

feature {NONE} -- Implementation

	factory: CONF_PARSE_FACTORY
			-- Factory to create new config objects.

	is_rebuilding: BOOLEAN
			-- Are we currently rebuilding an old class?

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

feature {NONE} -- Type anchors

	class_type: CONF_CLASS
			-- Class type anchor.

invariant
	name_ok: name /= Void and then not name.is_empty
	name_upper: name.is_equal (name.as_upper)
	file_name_not_void: file_name /= Void
	group_not_void: group /= Void
	path_not_void: path /= Void
	is_error_set: is_error implies last_error /= Void
	compiled_or_overrides: is_compiled implies not does_override
	factory_not_void: factory /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
