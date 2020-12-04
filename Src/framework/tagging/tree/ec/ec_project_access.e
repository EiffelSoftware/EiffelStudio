note
	description: "[
		Objects that provide an Eiffel project to {ES_TAG_TREE_NODE}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_PROJECT_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_project: like project)
			-- Initialize `Current'.
			--
			-- `a_project': An Eiffel project.
		local
			l_manager: EB_PROJECT_MANAGER
			l_agent: PROCEDURE
		do
			project := a_project
			l_manager := project.manager
			l_agent := agent (s: like {WORKBENCH_I}.compilation_status)
				do
					increase_build
				end
			l_manager.compile_stop_agents.extend (l_agent)
			l_manager.load_agents.extend (agent increase_build)
		end

feature -- Access

	project: E_PROJECT
			-- Eiffel project

	revision: NATURAL
			-- Revision used for versioning compiler information

feature -- Status report

	is_initialized: BOOLEAN
			-- Is `eiffel_project' initialized?
		local
			l_project: like project
		do
			l_project := project
			Result := l_project.initialized and then
				l_project.workbench.universe_defined and then
				l_project.system_defined and then
				l_project.system.universe.target /= Void
		end

feature -- Status setting

	increase_build
			-- Increase `build' by one.
		do
			revision := revision + 1
		end

feature -- Element retrival

	class_from_name (a_name: STRING; a_group: detachable CONF_GROUP): detachable CLASS_I
			-- Try to retrieve {CLASS_I} instance for given class name, optionally the cluster in which the
			-- class exists can be provided.
			--
			-- `a_name': Name of class to be retrieved.
			-- `a_group': Optional cluster of class.
		require
			a_name_attached: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			project_initialized: is_initialized
		local
			l_group: CONF_GROUP
			l_list: LIST [CLASS_I]
		do
			if a_group /= Void then
				l_group := a_group
			else
				if not project.system.system.root_creators.is_empty then
					l_group := project.system.system.root_creators.first.cluster
				end
			end
			if l_group /= Void then
				Result := project.universe.safe_class_named (a_name, l_group)
				if Result = Void then
					l_list := project.universe.classes_with_name (a_name)
					if not l_list.is_empty then
						Result := l_list.first
					end
				end
			end
		end

	feature_of_name (a_class: CLASS_I; a_feature: READABLE_STRING_32): detachable FEATURE_I
			-- {FEATURE_I} instance from given class for given name, Void if class is not compiled or no
			-- feature with that name exists.
		do
			if attached a_class.compiled_representation as l_class then
				if attached l_class.feature_named_32 (a_feature) as l_feature then
					Result := l_feature
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
