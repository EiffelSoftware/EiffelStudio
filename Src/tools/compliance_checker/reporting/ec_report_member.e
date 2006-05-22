indexing
	description: "[
		A report entity for assembly type members.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_REPORT_MEMBER

inherit
	EC_REPORT_BASE
		redefine
			is_equal
		end
	
	COMPARABLE
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_member: like member; a_type: like parent) is
			-- Create an initialize a report for a type's member `a_member'.
		require
			a_member_not_void: a_member /= Void
			a_type_not_void: a_type /= Void
		do
			member := a_member
			parent := a_type
		ensure
			member_set: member = a_member
			parent_set: parent = a_type
		end
		
feature -- Access

	report: EC_REPORT is
			-- Report member is associated with
		do
			Result := parent.report
		end

	parent: EC_REPORT_TYPE
			-- Parent report entity

	member: EC_CHECKED_MEMBER
			-- Member associated with report entity
	
feature -- Comparison {COMPARABLE}

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := {SYSTEM_STRING}.compare (member.member.name, other.member.member.name) < 0
		end
		
	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := {SYSTEM_STRING}.compare (member.member.name, other.member.member.name) = 0
		end
	
invariant
	parent_not_void: parent /= Void
	member_not_void: member /= Void
	
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
end -- class EC_REPORT_MEMBER
