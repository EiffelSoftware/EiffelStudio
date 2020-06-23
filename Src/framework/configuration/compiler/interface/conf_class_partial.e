note
	description: "Classes that where built from partial classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create {CONF_FACTORY}
	make_from_partial

feature {NONE} -- Initialization

	make_from_partial (a_partial_classes: ARRAYED_LIST [READABLE_STRING_GENERAL]; a_group: like group; a_base_location: like base_location; a_factory: like factory)
			-- Create.
		require
			a_partial_classes_not_void: a_partial_classes /= Void
			a_group_not_void: a_group /= Void
			a_base_location_not_void: a_base_location /= Void
			a_factory_not_void: a_factory /= Void
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

			name := ""
			path := ""
			file_name := ""
			check_changed
			if is_modified then
				build_partial
			end

			if
				attached {CONF_CLUSTER} a_group as l_cluster and then
				attached l_cluster.visible as v
			then
				visible := v.item (name)
			end
			is_valid := True
			factory := a_factory
		ensure
			is_valid: is_valid
		end

feature -- Access

	is_read_only: BOOLEAN = True
			-- Is the class read only?

	full_file_name: PATH
			-- The full file name of the class (including path).
		do
			Result := base_location.build_path (path, file_name)
		end

	base_location: CONF_DIRECTORY_LOCATION
			-- Base location where the generated files are stored.

	partial_classes: STRING_TABLE [INTEGER]
			-- Partial classes that are the source for this class, mapped to their last modification time.

feature {CONF_ACCESS} -- Update, in compiled only

	set_base_location (a_location: like base_location)
			-- Set `base_location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			base_location := a_location
		ensure
			base_location_set: base_location = a_location
		end

	rebuild_partial (a_partial_classes: ARRAYED_LIST [READABLE_STRING_GENERAL]; a_group: like group; a_base_location: like base_location)
			-- Rebuild.
		require
			a_partial_classes_not_void: a_partial_classes /= Void
			a_group_not_void: a_group /= Void
			a_base_location_not_void: a_base_location /= Void
		local
			l_old: like partial_classes
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

			if
				attached {CONF_CLUSTER} a_group as l_cluster and then
 				attached l_cluster.visible as v
 			then
				visible := v.item (name)
			end
		end

	check_changed
			-- Check if any of the partial classes that build this class have changed.
		local
			l_date: INTEGER
			l_key: READABLE_STRING_GENERAL
		do
			is_modified := False
			from
				partial_classes.start
			until
				partial_classes.after
			loop
				l_key := partial_classes.key_for_iteration
				l_date := file_modified_date (l_key)
				is_modified := partial_classes.item_for_iteration /= l_date
				if is_modified then
					partial_classes.replace (l_date, l_key)
				end
				partial_classes.forth
			end
			check_changed_options
		end

feature {NONE} -- Implementation

	build_partial
			-- Build the class from the partial class files.
		require
			base_location_not_void: base_location /= Void
			partial_classes_not_void: partial_classes /= Void
		local
			l_lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_file: PLAIN_TEXT_FILE
			l_name: detachable STRING
			u: FILE_UTILITIES
		do
			if not is_error then
				create l_lst.make_from_array (partial_classes.current_keys)
				epc_merger.merge (l_lst)
				if not epc_merger.successful or epc_merger.class_text.is_empty then
					if attached epc_merger.error_message as l_err then
						last_error := create {CONF_ERROR_PARTIAL}.make (l_err)
					else
						last_error := create {CONF_ERROR_PARTIAL}.make ("Unknown error in merging partial classes.")
					end
				else
					path := group.target.system.uuid.string + "/" + group.name

					u.create_directory_path (base_location.build_path (path, {STRING_32} ""))

						-- Use temporary file to get name of class.
					file_name := {STRING_32} "tmp.e"
					create l_file.make_with_path (full_file_name)
					l_file.open_write
					l_file.put_string (epc_merger.class_text)
					l_file.close

					l_name := name_from_associated_file
					if l_name /= Void then
						set_name (l_name)
							-- Rename file to class name.
						file_name := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (name).as_lower + {STRING_32} ".e"
						l_file.rename_path (full_file_name)
					else
						create {CONF_ERROR_PARTIAL} last_error.make ("Unable to find class name from associated file.")
					end
				end
			end
		ensure
			name: not is_error implies (not name.is_empty)
			location: not is_error implies (not path.is_empty and not file_name.is_empty)
		rescue
			if attached epc_merger.error_message as r_err then
				last_error := create {CONF_ERROR_PARTIAL}.make (r_err)
			else
				last_error := create {CONF_ERROR_PARTIAL}.make ("Unknown error during merging of partial classes.")
			end
			retry
		end

feature {NONE} -- Shared instances

	epc_merger: EPC_MERGER
			-- Shared instance of EPC_MERGER.
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
