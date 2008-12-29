note
	description : "Ancestor which can attach to docking manager."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	EB_DOCKING_MANAGER_ATTACHABLE

inherit
	HASHABLE

feature -- Attachement

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			-- Attach to `a_docking_manager'.
		require
			not_void: a_docking_manager /= Void
		do
			if content = Void then
				build_docking_content (a_docking_manager)
			end

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		ensure
			added: a_docking_manager.has_content (content)
		end

	attach_to_docking_manager_with (a_docking_manager: SD_DOCKING_MANAGER; a_attachable: EB_DOCKING_MANAGER_ATTACHABLE)
			-- Attach to `a_docking_manager' with `a_attachable'.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
			a_attachable_not_void: a_attachable /= Void
		do
			attach_to_docking_manager (a_docking_manager)
			if content /= a_attachable.content then
				content.set_tab_with (a_attachable.content, False)
			end
		end

feature -- Access

	content: SD_CONTENT
			-- Content assiociate with Current.

	hash_code: INTEGER
			-- Hash code
		do
			Result := title_for_pre.hash_code
		end

	title_for_pre: STRING
			-- Title of the tool
		deferred
		ensure then
			valid_title: title_for_pre /= Void and then not title_for_pre.is_empty
		end

feature {NONE} -- Build implementation

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER)
			-- Build the associated widget and
			-- Add it to `explorer_bar'
		require
			not_void: a_docking_manager /= Void
		deferred
		ensure
			created: content /= Void
		end

note
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

end -- class EB_DOCKING_MANAGER_ATTACHABLE
