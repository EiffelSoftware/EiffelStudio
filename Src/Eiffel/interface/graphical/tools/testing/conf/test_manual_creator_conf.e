note
	description: "Summary description for {TEST_MANUAL_CREATOR_CONF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MANUAL_CREATOR_CONF

inherit
	TEST_MANUAL_CREATOR_CONF_I

	TEST_CREATOR_CONF
		redefine
			make,
			is_interface_usable
		end

create
	make

feature {NONE} -- Initialization

	make (a_preference: TEST_PREFERENCES)
			-- <Precursor>
		do
			create name_cache.make_from_string (default_name)
			Precursor (a_preference)
			has_prepare_cache := a_preference.prepare_routine.value
			has_clean_cache := a_preference.clean_routine.value
		end

feature -- Access

	name: STRING
			-- <Precursor>
		local
			l_name: like name_cache
		do
			l_name := name_cache
			check l_name /= Void end
			Result := l_name
		end

	test_class: EIFFEL_CLASS_I
			-- <Precursor>
		local
			l_class: like test_class_cache
		do
			l_class := test_class_cache
			check l_class /= Void end
			Result := l_class
		end

	feature_clause: FEATURE_CLAUSE_AS
			-- <Precursor>
		local
			l_fc: like feature_clause_cache
		do
			l_fc := feature_clause_cache
			check l_fc /= Void end
			Result := l_fc
		end

	feature_clause_name: STRING
			-- <Precursor>
		local
			l_name: like feature_clause_name_cache
		do
			l_name := feature_clause_name_cache
			check l_name /= Void end
			Result := l_name
		end

feature -- Access: caches

	name_cache: detachable like name assign set_name
			-- Cache for `name'

	test_class_cache: detachable like test_class assign set_test_class
			-- Cache for `test_class'

	feature_clause_cache: detachable like feature_clause assign set_feature_clause
			-- Cache for `feature_clause'

	feature_clause_name_cache: detachable like feature_clause_name assign set_feature_clause_name
			-- Cache for `feature_clause_name'

	is_new_feature_clause_cache: BOOLEAN assign set_is_new_feature_clause
			-- Cache for `is_new_feature_clause'

	has_prepare_cache: BOOLEAN assign set_has_prepare
			-- Cache for `has_prepare'

	has_clean_cache: BOOLEAN assign set_has_clean
			-- Cache for `has_clean'

	is_system_level_test_cache: BOOLEAN assign set_is_system_level_test
			-- Cache for `is_system_level_test'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			if name_cache /= Void and Precursor then
				if is_new_class then
					Result := True
				elseif test_class_cache /= Void then
					if is_new_feature_clause then
						Result := feature_clause_name_cache /= Void
					else
						Result := feature_clause_cache /= Void
					end
				end
			end
		end

	is_new_class: BOOLEAN = True
			-- <Precursor>

	is_multiple_new_classes: BOOLEAN = False
			-- <Precursor>

	has_prepare: BOOLEAN assign set_has_prepare
			-- <Precursor>
		do
			Result := has_prepare_cache
		end

	has_clean: BOOLEAN assign set_has_clean
			-- <Precursor>
		do
			Result := has_clean_cache
		end

	is_new_feature_clause: BOOLEAN assign set_is_new_feature_clause
			-- <Precursor>
		do
			Result := is_new_feature_clause_cache
		end

	is_system_level_test: BOOLEAN assign set_is_system_level_test
			-- Is new test a system level test?
		do
			Result := is_system_level_test_cache
		end

feature -- Status setting

	set_name (a_name: like name_cache)
			-- Set `name_cache' to `a_name'.
		do
			if a_name /= Void then
				name_cache := a_name.string
			else
				name_cache := Void
			end
		ensure
			name_set: same_string (name_cache, a_name)
		end

	set_test_class (a_test_class: like test_class_cache)
			-- Set `test_class_cache' to `a_test_class'.
		do
			test_class_cache := a_test_class
		ensure
			test_class_set: test_class_cache = a_test_class
		end

	set_feature_clause (a_feature_clause: like feature_clause_cache)
			-- Set `feature_clause_cache' to `a_feature_clause'.
		do
			feature_clause_cache := a_feature_clause
		ensure
			feature_clause_set: feature_clause_cache = a_feature_clause
		end

	set_feature_clause_name (a_name: like feature_clause_name_cache)
			-- Set `feature_clause_name_cache' to `a_name'.
		do
			if a_name /= Void then
				feature_clause_name_cache := a_name.string
			else
				feature_clause_name_cache := Void
			end
		ensure
			name_set: same_string (feature_clause_name_cache, a_name)
		end

	set_is_new_feature_clause (a_is_new_feature_clause: like is_new_feature_clause_cache)
			-- Set `is_new_feature_clause' to `a_is_new_feature_clause'.
		do
			is_new_feature_clause_cache := a_is_new_feature_clause
		ensure
			is_is_new_feature_clause: is_new_feature_clause_cache = a_is_new_feature_clause
		end

	set_has_prepare (a_has_prepare: like has_prepare_cache)
			-- Set `has_prepare' to `a_has_prepare'.
		do
			has_prepare_cache := a_has_prepare
		ensure
			has_prepare_set: has_prepare_cache = a_has_prepare
		end

	set_has_clean (a_has_clean: like has_clean_cache)
			-- Set `has_clean' to `a_has_clean'.
		do
			has_clean_cache := a_has_clean
		ensure
			has_clean_set: has_clean_cache = a_has_clean
		end

	set_is_system_level_test (a_is_system_level_test: like is_system_level_test)
			-- Set `is_system_level_test' to `a_is_system_level_test'.
		do
			is_system_level_test_cache := a_is_system_level_test
		ensure
			is_system_level_test_set: is_system_level_test = a_is_system_level_test
		end

feature {NONE} -- Constants

	default_name: STRING = "new_test_routine"

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
