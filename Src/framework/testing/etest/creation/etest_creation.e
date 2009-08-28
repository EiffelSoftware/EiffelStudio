note
	description: "[
		Class providing base implementation for {ETEST} creation sessions.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETEST_CREATION

inherit
	TEST_CREATION
		rename
			make as make_creation
		end

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite; a_etest_suite: like etest_suite)
			-- Initialize `Current'.
			--
			-- `a_test_suite': {TEST_SUITE_S} instance.
			-- `a_etest_suite': {ETEST_SUITE} instance.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_etest_suite_attached: a_etest_suite /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
		do
			make_creation (a_test_suite)
			etest_suite := a_etest_suite
			create path.make_empty
			class_name := default_class_name
			create internal_tags.make_default
			internal_tags.set_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [READABLE_STRING_8]})
		ensure
			test_suite_set: test_suite = a_test_suite
			etest_suite_set: etest_suite = a_etest_suite
		end

feature -- Access

	cluster: detachable CONF_CLUSTER
			-- Cluster in which new tests will be created.
			--
			-- Note: we do not store the cluster object directly since that might change after compiling.
		local
			l_universe: UNIVERSE_I
		do
			if attached cluster_name as l_name then
				l_universe := etest_suite.project_access.project.universe
				Result := l_universe.cluster_of_name (l_name)
			end
		end

	path: IMMUTABLE_STRING_8
			-- Additional path in `cluster' where tests will be created.
			--
			-- Note: by default empty.

	class_name: IMMUTABLE_STRING_8
			-- Name of new test class.
			--
			-- Note: is used as prefix if `creates_multiple_classes' is True.

	tags: DS_ARRAYED_LIST [READABLE_STRING_8]
			-- Tags with which new test routine(s) are tagged.
		do
			create Result.make_from_linear (internal_tags)
		end

feature {NONE} -- Access

	etest_suite: ETEST_SUITE
			-- Test suite containing project information

	class_name_counter: NATURAL
			-- Counter used by `create_new_class' to generate class names

	cluster_name: detachable STRING
			-- Optional name of cluster and path where new tests should be created

	internal_tags: DS_HASH_SET [READABLE_STRING_8]
			-- Internal storage for `tags'

feature {NONE} -- Status report

	creates_multiple_classes: BOOLEAN
			-- Does current create multiple new test classes during one creation?

feature {TEST_SUITE_S} -- Status setting

	frozen start
			-- <Precursor>
		do
			class_name_counter := 1
			start_creation
		end

feature -- Status setting

	set_cluster_name (a_name: READABLE_STRING_8)
			-- Set `cluster_name' to given name.
			--
			-- `a_name': Name of cluster in which new tests should be created.
		require
			a_name_attached: a_name /= Void
			not_running: not has_next_step
		do
			create cluster_name.make_from_string (a_name)
		ensure
			cluster_name_set: attached cluster_name as l_name and then l_name.same_string (a_name)
		end

	set_path_name (a_name: READABLE_STRING_8)
			-- Set `path_name' to given path.
			--
			-- `a_name': Name of new path.
		require
			a_name_attached: a_name /= Void
			not_running: not has_next_step
		do
			create path.make_from_string (a_name)
		ensure
			path_name_set: path.same_string (a_name)
		end

	set_class_name (a_name: READABLE_STRING_8)
			-- Set `class_name' to given name.
			--
			-- `a_name': New name for `class_name'.
		require
			a_name_attached: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			not_running: not has_next_step
		do
			create class_name.make_from_string (a_name)
		ensure
			class_name_set: class_name.same_string (a_name)
		end

	add_tag (a_tag: READABLE_STRING_8)
			-- Add given tag to `tags'.
		require
			a_tag_attached: a_tag /= Void
			a_tag_not_empty: not a_tag.is_empty
			not_running: not has_next_step
		do
			internal_tags.force_last (a_tag.twin)
		ensure
			added: tags.there_exists (agent {READABLE_STRING_8}.same_string (a_tag))
		end

feature {NONE} -- Status setting

	start_creation
			-- Start creation session.
		require
			usable: is_interface_usable
			not_running: not has_next_step
		deferred
		end

feature {NONE} -- Basic operations

	create_new_class
			-- Create a new class according to `configuration'.
		require
			usable: is_interface_usable
			running: has_next_step
		local
			l_cluster: like cluster
			l_location: DIRECTORY_NAME
			l_directory: DIRECTORY
			l_path: detachable FILE_NAME
			l_file: KL_TEXT_OUTPUT_FILE
			l_filename: STRING
			l_class_name: STRING
		do
			l_cluster := cluster
			if l_cluster /= Void and then not l_cluster.is_readonly then
				create l_location.make_from_string (l_cluster.location.build_path (path.as_string_8, ""))
				create l_directory.make (l_location)
				if l_directory.exists and l_directory.is_writable then
					from until
						l_filename /= Void
					loop
						create l_path.make_from_string (l_location)
						l_class_name := class_name.as_string_8
						l_class_name.to_lower
						if creates_multiple_classes then
							create l_filename.make (l_class_name.count + 6)
							l_filename.append (l_class_name)
							l_filename.append_character ('_')
							if class_name_counter < 10 then
								l_filename.append ("00")
							elseif class_name_counter < 100 then
								l_filename.append ("0")
							end
							l_filename.append_natural_32 (class_name_counter)
						else
							l_filename := l_class_name
						end
						l_filename.append (".e")
						l_path.set_file_name (l_filename)
						create l_file.make (l_path)
						if creates_multiple_classes then
							if l_file.exists then
								class_name_counter := class_name_counter + 1
								if class_name_counter <= 999 then
									l_filename := Void
								end
							end
						end
					end

					if not l_file.exists then
						l_file.open_write
						if l_file.is_open_write then
							l_class_name := l_filename.substring (1, l_filename.count - 2)
							check l_class_name /= Void end
							l_class_name.to_upper
							print_new_class (l_file, l_class_name)
							if l_file.is_open_write then
								l_file.close
							end
							if l_file.exists and then l_file.count > 0 then
								etest_suite.project_helper.add_class (l_cluster, path, l_filename, l_class_name)
							end
						else
							error_event.publish ([Current, locale.formatted_string (e_file_not_creatable, [l_location, l_filename])])
						end
					else
						error_event.publish ([Current, locale.formatted_string (e_file_already_exists, [l_location, l_filename])])
					end
				else
					if l_directory.exists then
						error_event.publish ([Current, locale.formatted_string (e_directory_not_writable, [l_location])])
					else
						error_event.publish ([Current, locale.formatted_string (e_directory_does_not_exist, [l_location])])
					end
				end
			else
				error_event.publish ([Current, locale.formatted_string (e_cluster_read_only, [l_location])])
			end
		end

	print_new_class (a_file: KL_TEXT_OUTPUT_FILE; a_class_name: STRING)
			-- Print new class text to `a_file'.
		require
			a_file_attached: a_file /= Void
			a_class_name_attached: a_class_name /= Void
			usable: is_interface_usable
			running: has_next_step
			a_class_name_not_empty: not a_class_name.is_empty
			a_file_open_write: a_file.is_open_write
		deferred
		end

feature {NONE} -- Constants

	default_class_name: STRING = "TEST_"

feature {NONE} -- Internationalization

	e_can_not_create_new_class_file: STRING = "Can not create new class file in $1:%N%N"
	e_cluster_read_only: STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Cluster is read only.")
		end
	e_directory_does_not_exist: STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Path does not exist.")
		end
	e_directory_not_writable: STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Path is not writable.")
		end
	e_file_already_exists: STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("File $2 already exists.")
		end
	e_file_not_creatable: STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Unable to create file $2.")
		end

invariant
	class_name_not_empty: not class_name.is_empty

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
