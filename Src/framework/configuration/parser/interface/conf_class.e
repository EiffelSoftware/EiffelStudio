note
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

	make (a_file_name: like file_name; a_group: like group; a_path: like path; a_classname: READABLE_STRING_32; a_factory: like factory)
			-- Create
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			a_classname_not_void: a_classname /= Void
			a_classname_not_empty: not a_classname.is_empty
			a_factory_not_void: a_factory /= Void
		do
			file_name := a_file_name
			group := a_group
			path := a_path
			name := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_classname)
			is_valid := True
			check_changed
			is_renamed := False
			factory := a_factory
		ensure
			is_valid: is_valid
			factory_set: factory = a_factory
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error?
		do
			Result := last_error /= Void
		end

	last_error: detachable CONF_ERROR
			-- Last error.

feature -- Access, in compiled only, not stored to configuration file

	name: STRING
			-- Class name without any renamings.

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		do
			if attached overriden_by as o then
					-- Retrieve options from the group with an overrride.
				Result := o.group.get_class_options (name)
					-- Use settings from the original group
					-- to make sure they are compatible to the rest of the original group.
				Result.override_settings_from (group.get_class_options (name))
			else
				Result := group.get_class_options (name)
			end
			if Result.assertions = Void then
				Result.set_assertions (factory.new_assertions)
			end
		ensure
			Result_not_void: Result /= Void
			Result_assertions: Result.assertions /= Void
		end

	visible: detachable TUPLE [class_renamed: READABLE_STRING_32; features: detachable STRING_TABLE [READABLE_STRING_32]]
			-- The visible features.

	is_valid: BOOLEAN
			-- Is `Current' still valid, ie. still part of the system?

	is_compiled: BOOLEAN
			-- Has the class been compiled?
		once
			Result := False
		end

	is_always_compile: BOOLEAN
			-- Does this class have to be always compiled?
		do
			Result := visible /= Void
		end

	is_partial: BOOLEAN
			-- Is the class generated out of partial classes?

	is_read_only: BOOLEAN
			-- Is the class read only?
		local
			l_file: RAW_FILE
		do
			Result := is_partial or group.is_readonly
			if not Result then
					-- check if the file itself is read only
				create l_file.make_with_path (full_file_name)
				Result := not l_file.exists or else not l_file.is_writable
			end
		end

	is_overriden: BOOLEAN
			-- Is the class overridden?
		do
			Result := overriden_by /= Void
		end

	is_class_assembly: BOOLEAN
			-- Is class from an assembly?
		do

		end

	does_override: BOOLEAN
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

	file_name: STRING_32
			-- The file name of the class.

	full_file_name: PATH
			-- The full file name of the class (including path).
		do
			Result := group.location.build_path (path, file_name)
		end

	path: STRING_32
			-- The path of the class, relative to the group, in Unix format.

	overriden_by: detachable like class_type
			-- The class that overrides this class.

	overrides: detachable ARRAYED_LIST [CONF_CLASS]
			-- The classes that this class overrides.

	is_class_name_confirmed: BOOLEAN
			-- Has the class name of current class been confirmed?

	last_class_name: detachable STRING
			-- Last found class name set by `rebuild'.

feature -- Status report

	has_modification_date_changed: BOOLEAN
			-- Did modification date changed since last call to `check_changed'?
		local
			l_date: INTEGER
		do
			l_date := file_path_modified_date (full_file_name)
			Result := (l_date = -1) or (l_date /= date)
		end

feature -- Access queries

	actual_class: like class_type
			-- Return the actual class (takes overriding into account).
		do
			if attached overriden_by as l_overriden_by then
				Result := l_overriden_by
			else
				Result := Current
			end
		ensure
			actual_class_not_void: Result /= Void
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
				-- compute hash code on demand
			if internal_hash_code = 0 then
				internal_hash_code := name.hash_code
			end
			Result := internal_hash_code
		end

feature -- Status update

	set_modified
			-- Mark the class as modified.
		do
			is_modified := True
		end

	reset_error
			-- Reset the error.
		do
			last_error := Void
		ensure
			not_error: not is_error
			last_error_void: last_error = Void
		end

	set_up_to_date
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

	confirm_class_name
			-- Class name of Current was confirmed.
		do
			is_class_name_confirmed := True
		ensure
			is_class_name_confirmed_set: is_class_name_confirmed
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	add_visible (a_vis: attached like visible)
			-- Add visible rules to `visible'. Set `is_error' and `last_error' if there is a conflict.
		require
			a_vis_not_void: a_vis /= Void
			a_renamed_not_void: a_vis.class_renamed /= Void
		local
			l_vis_check, l_vis_other: detachable STRING_TABLE [READABLE_STRING_32]
			l_other: detachable READABLE_STRING_32
			l_error: BOOLEAN
			l_visible_item_features, l_vis_item_features: detachable STRING_TABLE [READABLE_STRING_32]
			l_visible: like visible
		do
				-- easy case first, most of the time this will be the only thing that is needed to do
			l_visible := visible
			if l_visible = Void then
				visible := a_vis
			else
					-- check final external class name
				if l_visible.class_renamed.is_equal (a_vis.class_renamed) then
					l_visible_item_features := l_visible.features
					l_vis_item_features := a_vis.features
					if l_vis_item_features = Void and l_visible_item_features = Void then
							-- done, both are Void
					else
						if l_vis_item_features ~ l_visible_item_features then
							-- done, same features are visible
						else
							if l_visible_item_features /= Void and l_vis_item_features /= Void then
									-- check if there are no conflicting feature definitions
								if l_visible_item_features.count >= l_vis_item_features.count then
									l_vis_check := l_visible_item_features
									l_vis_other := l_vis_item_features
								else
									l_vis_check := l_vis_item_features
									l_vis_other := l_visible_item_features
								end
								from
									l_vis_check.start
								until
									l_error or l_vis_check.after
								loop
									l_other := l_vis_other.item (l_vis_check.key_for_iteration)
									l_error := not (l_other = Void or else l_other.same_string (l_vis_check.item_for_iteration))
									l_vis_check.forth
								end
								if l_error then
										-- conflict, conflicting feature renamings
									last_error := create {CONF_ERROR_VISI_CONFL02}.make (l_visible.class_renamed)
								else
										-- merge
										-- twin because we may change something
									l_visible_item_features := l_visible_item_features.twin
									l_visible.features := l_visible_item_features
									l_visible_item_features.merge (l_vis_item_features)
								end
							else
								if l_visible_item_features = Void then
									l_vis_check := l_vis_item_features
								else
										-- This is guaranteed since at least one of them is not Void.
									check l_vis_item_features = Void end
									l_vis_check := l_visible_item_features
								end
								if l_vis_check = Void then
									check code_implies_l_vis_check_attached: False end
								else
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
										last_error := create {CONF_ERROR_VISI_CONFL01}.make (l_visible.class_renamed)
									else
											-- done, everything is visible and we had no renamings
											-- twin because we may change something
										l_visible := l_visible.twin
										l_visible.features := Void
										visible := l_visible
									end
								end
							end
						end
					end
				else
						-- conflict, different final external class name
					last_error := create {CONF_ERROR_VISI_CONFL03}.make (l_visible.class_renamed, a_vis.class_renamed)
				end
			end
		end

	invalidate
			-- Set `is_valid' to False.
		do
			is_valid := False
		end

	resurect
			-- Set `is_valid' to True.
		do
			is_valid := True
		end

	rebuild (a_file_name: like file_name; a_group: like group; a_path: like path)
			-- Update the informations during a rebuild.
			-- More or less the same thing as we during `make'.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		do
			group := a_group
			file_name := a_file_name
			path := a_path
			is_valid := True
			check_changed
			if is_modified and not is_class_name_confirmed then
				last_class_name := name_from_associated_file
				is_renamed := not attached last_class_name as l_class_name or else not l_class_name.is_equal (name)
			else
				last_class_name := name
			end

				-- do not lose information if we were renamed as we build a new class if we
				-- are renamed and we want the old information to deal with removed overrides.
			if not is_renamed then
				if not is_error then
					visible := Void
				end

					-- forget override informations except the one necessary for the
					-- check if a new override was added on a before not overriden class
				overrides := Void
				old_overriden_by := overriden_by
				overriden_by := Void
			end
		ensure
			last_class_name_set: (last_class_name = Void and not is_class_name_confirmed)
					or else (attached last_class_name as l_class_name and then not l_class_name.is_empty)
		end

	check_changed
			-- Check if the file was changed and if the options were changed.
			-- Update name if necessary.
		local
			l_date: INTEGER
		do
			l_date := file_path_modified_date (full_file_name)
			if l_date = -1 then
				is_removed := True
				date := 0
			elseif date /= l_date then
				date := l_date
				is_modified := True
					-- File was changed, its name cannot be confirmed anymore
				is_class_name_confirmed := False
			end
			check_changed_options
		end

	check_changed_options
			-- Check if any options of the class were changed.
		do
		end

	set_name (a_name: STRING)
			-- Compute and set (if we are not rebuilding) `name' and `renamed_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			name := a_name.as_upper
		ensure
			name_set: name ~ a_name.as_upper
		end

	name_from_associated_file: detachable STRING
			-- Read associated file and extract the name from it if possible.
		local
			l_file: KL_BINARY_INPUT_FILE_32
			l_classname_finder: like classname_finder
		do
			reset_error
			create l_file.make_with_path (full_file_name)
			if l_file.exists then
				l_classname_finder := classname_finder
				l_file.open_read
				l_classname_finder.parse (l_file)
				l_file.close
				Result := l_classname_finder.classname
				if Result = Void then
					date := -1
					if attached group as l_group then
						set_error (create {CONF_ERROR_CLASSN}.make (full_file_name.name, l_group.target.system.file_name))
					else
						set_error (create {CONF_ERROR_CLASSN}.make (full_file_name.name, Void))
					end
				else
					Result.to_upper
				end
			end
		ensure
			valid_name_in_upper: Result = Void or else Result.as_upper.is_equal (Result)
		end

	set_overriden_by (a_class: like class_type)
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

	add_does_override (a_class: like class_type)
			-- `Current' overrides `a_class'.
		local
			l_overrides: like overrides
		do
			l_overrides := overrides
			if l_overrides = Void then
				create l_overrides.make (1)
				overrides := l_overrides
			end
			l_overrides.extend (a_class)
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Class name alphabetic order
		do
			Result := name < other.name
		end

feature -- Output

	debug_output: STRING
			-- Generate a nice representation of Current to be seen
			-- in debugger.
		do
			Result := name
		end

feature {NONE} -- Implementation

	factory: CONF_PARSE_FACTORY
			-- Factory to create new config objects.

	internal_hash_code: like hash_code
			-- Computed `hash_code'.

	old_overriden_by: like overriden_by
			-- `overriden_by' from last compilation.

	set_error (an_error: CONF_ERROR)
			-- Set `an_error'.
		require
			an_error_attached: an_error /= Void
		do
			last_error := an_error
		ensure
			last_error_when_is_error: is_error and (last_error = an_error)
		end

feature {NONE} -- Type anchors

	class_type: CONF_CLASS
			-- Class type anchor.
		require
			do_not_call: False
		do
			check False then
				-- used only for typing
			end
		end

invariant
	name_ok: name /= Void and then not name.is_empty
	name_upper: name.same_string (name.as_upper)
	file_name_not_void: file_name /= Void
	group_not_void: group /= Void
	path_not_void: path /= Void
	is_error_same_as_last_error: is_error = (last_error /= Void)
	compiled_or_overrides: is_compiled implies not does_override
	factory_not_void: factory /= Void

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
