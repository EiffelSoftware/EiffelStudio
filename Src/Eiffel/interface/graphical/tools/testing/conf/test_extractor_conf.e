note
	description: "Summary description for {TEST_EXTRACTOR_CONF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXTRACTOR_CONF

inherit
	TEST_CREATOR_CONF
		rename
			make as make_conf
		end

	TEST_EXTRACTOR_CONF_I

create
	make

feature {NONE} -- Initialization

	make (a_cs: EIFFEL_CALL_STACK; a_preference: TEST_PREFERENCES)
			-- Initialize `Current'.
			--
			-- `a_cs': Current call stack.
			-- `a_preference': Preferences.
		require
			a_cs_attached: a_cs /= Void
			a_preference_attached: a_preference /= Void
		do
			create call_stack_elements_cache.make_default
			make_conf (a_preference)
		end

	initialize_cs_elements (a_cs: EIFFEL_CALL_STACK)
			-- Initialize `call_stack_elements_cache' for `a_cs'.
			--
			-- `a_cs': Current call stack element.
		require
			a_cs_attached: a_cs /= Void
		do
			from
				a_cs.start
			until
				a_cs.after
			loop
				if {l_cse: EIFFEL_CALL_STACK_ELEMENT} a_cs.item then
					if is_selected_cse (l_cse) then
						call_stack_elements_cache.force (l_cse.level_in_stack)
					end
				end
				a_cs.forth
			end
		end

feature -- Access

	call_stack_elements: !DS_LINEAR [INTEGER]
			-- <Precursor>
		do
			Result := call_stack_elements_cache
		ensure then
			result_equals_cache: Result = call_stack_elements_cache
		end

feature -- Access: cache

	call_stack_elements_cache: !DS_HASH_SET [INTEGER]

feature {NONE} -- Query

	is_selected_cse (a_cse: EIFFEL_CALL_STACK_ELEMENT): BOOLEAN
			-- Is `a_cse' selected by default?
		require
			a_cse_attached: a_cse /= Void
		do
			if {l_ec: EIFFEL_CLASS_C} a_cse.dynamic_class then
				Result := a_cse.level_in_stack = 1 or not
					(l_ec.cluster.is_used_in_library and l_ec.cluster.is_readonly)
			end
		end

feature -- Status report

	is_new_class: BOOLEAN = True
			-- <Precursor>

	is_multiple_new_classes: BOOLEAN = False
			-- <Precursor>

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
