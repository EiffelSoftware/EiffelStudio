indexing
	description: "[
		A report entity for assembly types.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_REPORT_TYPE

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

	make (a_type: like type; a_parent: like parent) is
			-- Create an initialize a report for type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_parent_not_void: a_parent /= Void
		do
			type := a_type
			parent := a_parent
			create internal_checked_members.make (0)
		ensure
			type_set: type = a_type
			parent_set: parent = a_parent
		end
		
feature -- Access

	report: EC_REPORT is
			-- Report member is associated with
		do
			Result := parent
		end

	parent: EC_REPORT
			-- Parent report entity.
			
	type: EC_CHECKED_TYPE
			-- Type associated with report entity
			
	members: DYNAMIC_LIST [EC_REPORT_MEMBER] is
			-- List of checked report type members.
		do
			Result := internal_checked_members
		ensure
			result_not_void: Result /= Void
		end
	
feature {EC_REPORT_BUILDER} -- Basic Operations

	add_member_report (a_report: EC_REPORT_MEMBER) is
			-- Adds `a_report' to `members'
		require
			a_report_not_void: a_report /= Void
			not_already_added: not members.has (a_report)
			is_being_build: report.is_being_built
		do
			internal_checked_members.extend (a_report)
		ensure
			members_has_report: members.has (a_report)
		end
		
feature -- Comparison {COMPARABLE}

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := {SYSTEM_STRING}.compare (type.type.full_name, other.type.type.full_name) < 0
		end
		
	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := {SYSTEM_STRING}.compare (type.type.full_name, other.type.type.full_name) = 0
		end
		
feature {NONE} -- Internal Cached Information

	internal_checked_members: ARRAYED_LIST [EC_REPORT_MEMBER]
			-- Internal mutable list of report type members
		
invariant
	parent_not_void: parent /= Void
	type_not_void: type /= Void
	internal_checked_members_not_void: internal_checked_members /= Void
	
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
end -- class EC_REPORT_TYPE
