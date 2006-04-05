indexing
	description: "objects that represent reflected features. a reflected %
                %feature is only a placeholder for a inherited %
                %feature that has not changed. it does not contain a lot of %
                %information. The most important feature of it is %
                %that it is able to point you to it's 'precursor'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
class
	JVM_REFLECTED_FEATURE
			
inherit
	JVM_FEATURE

	create
	make
			
feature {ANY} -- Initialisation
			
	make is
		do
		end
			
feature {ANY} -- Access
			
	written_type_id: INTEGER
			-- `type_id' of class this feature is written in
			-- use `written_type_id' and `routine_id' to locate the
			-- the written counterpart this feature referes to.
	
	written_class: JVM_CLASS is
			-- class object with type id `written_type_id'
		do
			Result := repository.item (written_type_id)
		ensure
			result_not_void: Result /= Void
		end
			
	written_feature: JVM_WRITTEN_FEATURE is
			-- retrieves the written feature
		do
			Result ?= written_class.feature_by_routine_id (routine_id)
		end

feature {ANY} -- Access
			
	set_written_type_id (i: INTEGER) is
			-- set the `writen_type_id'
		do
			written_type_id := i
		ensure
			written_type_id_set: written_type_id = i
		end
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



