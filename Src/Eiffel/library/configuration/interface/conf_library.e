indexing
	description: "A library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LIBRARY

inherit
	CONF_GROUP
		redefine
			process,
			is_library,
			is_readonly,
			is_group_equivalent
		end

	CONF_VISIBLE

create
	make

feature -- Status

	is_library: BOOLEAN is
			-- Is this a library?
		once
			Result := True
		end

	is_readonly: BOOLEAN is
			-- Is this library readonly?
		local
			l_lib: like Current
		do
			Result := internal_read_only
			if not Result and then is_used_library then
				l_lib := find_current_in_application_target
				if l_lib /= Void then
					Result := l_lib.is_readonly
				else
					Result := True
				end
			end
		end

feature -- Access, in compiled only, not stored to configuration file

	library_target: CONF_TARGET
			-- The library target.

feature -- Access queries

	uuid: UUID
			-- uuid of the used library.

	sub_group_by_name (a_name: STRING): CONF_GROUP is
			-- Return sub group with `a_name' if there is any.
		do
			if library_target /= Void then
				Result := library_target.groups.item (a_name)
			end
		end

	options: CONF_OPTION is
			-- Options (Debuglevel, assertions, ...)
		local
			l_lib: like Current
		do
				-- if used as library, get options from application level
				-- either if the library is defined there or otherwise directly from the application target
			if is_used_library then
				l_lib := find_current_in_application_target
				if l_lib /= Void then
					Result := l_lib.options
				else
					Result := target.application_target.options
				end
			else
				if internal_options /= Void then
					Result := internal_options.twin
				else
					create Result
				end
				Result.merge (target.options)
			end
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_uuid (an_uuid: UUID) is
			-- Set the uuid of the library.
		require
			an_uuid_not_void: an_uuid /= Void
		do
			uuid := an_uuid
		ensure
			uuid_set: uuid = an_uuid
		end


	set_library_target (a_target: CONF_TARGET) is
			-- Set `library_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			library_target := a_target
			library_target.add_library_usage (Current)
		ensure
			library_target_set: library_target = a_target
		end


feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_library (Current)
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal (visible, other.visible)
		end

feature {NONE} -- Implementation

	find_current_in_application_target: like Current is
			-- Find `Current' in `application_target' if it is defined there directly.
		require
			application_target_not_void: target.application_target /= Void
		local
			l_libs: HASH_TABLE [CONF_LIBRARY, STRING]
			l_lib: like Current
			l_app_target: CONF_TARGET
		do
			l_app_target := target.application_target
			if l_app_target.precompile /= Void and then l_app_target.precompile.uuid.is_equal (uuid) then
				Result := l_app_target.precompile
			else
				from
					l_libs := l_app_target.libraries
					l_libs.start
				until
					Result /= Void or l_libs.after
				loop
					l_lib := l_libs.item_for_iteration
					if l_lib.uuid /= Void and then l_lib.uuid.is_equal (uuid) then
						Result := l_lib
					end
					l_libs.forth
				end
			end
		end

invariant
	library_target_set: classes_set implies library_target /= Void
	uuid_set: classes_set implies uuid /= Void

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
