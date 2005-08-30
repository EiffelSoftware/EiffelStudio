indexing
	description: "[
		A report entity for assembly type members.
	]"
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
	
end -- class EC_REPORT_MEMBER
