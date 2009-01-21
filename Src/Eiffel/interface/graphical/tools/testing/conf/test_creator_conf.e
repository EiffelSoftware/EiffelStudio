note
	description: "Summary description for {TEST_CREATOR_CONF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CREATOR_CONF

inherit
	TEST_CREATOR_CONF_I

feature {NONE} -- Initialization

	make (a_preference: TEST_PREFERENCES)
			-- Initialize `Current'.
		require
			a_preference_attached: a_preference /= Void
		do
			create tags_cache.make_default
			tags_cache.set_equality_tester (create {KL_EQUALITY_TESTER_A [!STRING]})
			create new_class_name_cache.make_from_string (default_new_class_name)
		end

feature -- Access

	new_class_name: !STRING
			-- <Precursor>
		local
			l_name: like new_class_name_cache
		do
			l_name := new_class_name_cache
			check l_name /= Void end
			Result := l_name
		end

	cluster: !CONF_CLUSTER
			-- <Precursor>
		local
			l_cluster: like cluster_cache
		do
			l_cluster := cluster_cache
			check l_cluster /= Void end
			Result := l_cluster
		end

	path: !STRING
			-- <Precursor>
		local
			l_path: like path_cache
		do
			l_path := path_cache
			check l_path /= Void end
			Result := l_path
		end

	tags: !DS_LINEAR [!STRING]
			-- <Precursor>
		do
			Result := tags_cache
		end

feature -- Access: cache

	new_class_name_cache: ?like new_class_name assign set_new_class_name
			-- Cache for `new_class_name'

	tags_cache: !DS_HASH_SET [!STRING]
			-- List of tags for new test routine

	cluster_cache: ?like cluster assign set_cluster
			-- Cache for `cluster'

	path_cache: ?like path assign set_path
			-- Cache for `path'

feature {NONE} -- Query

	same_string (a_string1, a_string2: ?READABLE_STRING_8): BOOLEAN
			-- Do `a_string1' and `a_string2' represent the same string?
		do
			if a_string1 /= Void and a_string2 /= Void then
				Result := a_string1.same_string (a_string2)
			else
				Result := a_string1 = a_string2
			end
		ensure
			definition: Result implies ((a_string1 = Void and a_string2 = Void) or
				(a_string1 /= Void and then a_string2 /= Void and then a_string1.same_string (a_string2)))
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := not is_new_class or
				(new_class_name_cache /= Void and
				 cluster_cache /= Void and
				 path_cache /= Void)
		end

feature -- Status setting

	set_new_class_name (a_name: like new_class_name_cache)
			-- Set `new_class_name_cache' to `a_name'.
		do
			if a_name /= Void then
				new_class_name_cache := a_name.string
			else
				new_class_name_cache := Void
			end
		ensure
			new_class_name_cache_set: same_string (new_class_name_cache, a_name)
		end

	set_cluster (a_cluster: like cluster_cache)
			-- Set `cluster_cache' to `a_cluster'.
		do
			cluster_cache := a_cluster
		ensure
			cluster_set: cluster_cache = a_cluster
		end

	set_path (a_path: like path_cache)
			-- Set `path_cache' to `a_path'.
		do
			if a_path /= Void then
				path_cache := a_path.string
			else
				path_cache := Void
			end
		ensure
			path_set: same_string (path_cache, a_path)
		end
feature {NONE} -- Constants

	default_new_class_name: STRING = "NEW_TEST_CLASS"

;note
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
