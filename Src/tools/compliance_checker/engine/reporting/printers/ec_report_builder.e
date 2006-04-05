indexing
	description: "[
		Used in conjunction with `EC_CHECK_WORKER' to permit building of a compliance report
		when worker proffers generated information.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class 
	EC_REPORT_BUILDER

inherit
	EC_CHECK_PRINTER
		export
			{NONE} all
		end

create 
	make

feature {NONE} -- Initialization

	make (a_assembly: ASSEMBLY) is
			-- Create and initialize a new report builder
		require
			a_assembly_not_void: a_assembly /= Void
		do
			create report.make (a_assembly)
			create type_report_added_actions
			create type_member_report_added_actions
			create percentage_completed_changed_actions
			create report_completed_actions
		end
	
feature -- Access

	report: EC_REPORT
			-- Report built by current instance.

feature -- Action Subscriptions

	type_report_added_actions: ACTION_SEQUENCE [TUPLE [EC_REPORT_TYPE]]
			-- Actions called when a new type report has been added to `report'.
			
	type_member_report_added_actions: ACTION_SEQUENCE [TUPLE [EC_REPORT_TYPE, EC_REPORT_MEMBER]]
			-- Actions called when a new type member report has been added to `report'.
			
	percentage_completed_changed_actions: ACTION_SEQUENCE [TUPLE [NATURAL_8]]
			-- Actions called when overall percentage complete changes.
			-- 100% ensures `report' is fully completed
			
	report_completed_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN]]
			-- Actions called when `report' is complete.
			-- BOOLEAN indicates if report was fully generated.

feature -- Access

	should_continue: BOOLEAN is
			-- Should checking continue?
		do
			Result := True
		end

feature -- Starting

	notify_start is
			-- Called when checker is about to begin checking an assembly.
		do
			report.set_is_being_built (True)
		end
		
	start_type (a_type: SYSTEM_TYPE) is
			-- Called when checker is about to begin checking type `a_type'.
		do
		end

	start_constructor (a_ctor: CONSTRUCTOR_INFO) is
			-- Called when checker is about to begin checking constructor `a_ctor'.
		do
		end
		
	start_method (a_method: METHOD_INFO) is
			-- Called when checker is about to begin checking method `a_method'.
		do
		end
		
	start_property (a_property: PROPERTY_INFO) is
			-- Called when checker is about to begin checking property `a_property'.
		do
		end	
		
	start_field (a_field: FIELD_INFO) is
			-- Called when checker is about to begin checking field `a_field'.
		do
		end
	
	start_event (a_event: EVENT_INFO) is
			-- Called when checker is about to begin checking ecent `a_event'.
		do
		end	

feature -- Checked
		
	checked_type (a_type: EC_CHECKED_TYPE) is
			-- Called when checker is about to begin checking type `a_type'
		local
			l_type: EC_REPORT_TYPE
		do
			create l_type.make (a_type, report)
			report.add_type_report (l_type)
			last_report_type := l_type
		ensure then
			last_report_type_not_void: last_report_type /= Void
		end

	checked_constructor (a_ctor: EC_CHECKED_MEMBER_CONSTRUCTOR) is
			-- Called when checker is about to begin checking constructor `a_ctor'
		local
			l_member: EC_REPORT_MEMBER
			l_type: like last_report_type
		do
			l_type := last_report_type
			create l_member.make (a_ctor, l_type)
			l_type.add_member_report (l_member)
		end
		
	checked_method (a_method: EC_CHECKED_MEMBER_METHOD) is
			-- Called when checker is about to begin checking method `a_method'
		local
			l_member: EC_REPORT_MEMBER
			l_type: like last_report_type
		do
			l_type := last_report_type
			create l_member.make (a_method, l_type)
			l_type.add_member_report (l_member)
		end

	checked_property (a_property: EC_CHECKED_MEMBER) is
			-- Called when checker is about to begin checking property `a_property'
		local
			l_member: EC_REPORT_MEMBER
			l_type: like last_report_type
		do
			l_type := last_report_type
			create l_member.make (a_property, l_type)
			l_type.add_member_report (l_member)
		end
		
	checked_field (a_field: EC_CHECKED_MEMBER_FIELD) is
			-- Called when checker is about to begin checking field `a_field'
		local
			l_member: EC_REPORT_MEMBER
			l_type: like last_report_type
		do
			l_type := last_report_type
			create l_member.make (a_field, l_type)
			l_type.add_member_report (l_member)
		end
	
	checked_event (a_event: EC_CHECKED_MEMBER) is
			-- Called when checker is about to begin checking event `a_event'
		local
			l_member: EC_REPORT_MEMBER
			l_type: like last_report_type
		do
			l_type := last_report_type
			create l_member.make (a_event, l_type)
			l_type.add_member_report (l_member)
		end
		
feature -- Endding

	notify_end (a_complete: BOOLEAN) is
			-- Called when checker is finished.
			-- `a_complete' indicates if report is a full complete report.
		do
			report.set_is_being_built (False)
			report_completed_actions.call ([a_complete])
		end
		
	end_type is
			-- Called when checker is finished checking last started checked type.
		do
			type_report_added_actions.call ([last_report_type])
			last_report_type := Void
		end
		
	end_constructor is
			-- Called when checker is finished checking last started checked constructor.
		do
		end
		
	end_method is
			-- Called when checker is finished checking last started checked method.
		do
		end
		
	end_property is
			-- Called when checker is finished checking last started checked property.
		do
		end	
		
	end_field is
			-- Called when checker is finished checking last started checked field.
		do
		end
	
	end_event is
			-- Called when checker is about to begin checking event.
		do
		end	

feature -- Percentage

	notify_percentage_complete (a_percent: NATURAL_8) is
			-- Called when percentage changes.
		do
			percentage_completed_changed_actions.call ([a_percent])
		end
	
feature {NONE} -- Implementation

	last_report_type: EC_REPORT_TYPE
			-- Last report type
	
invariant
	report_not_void: report /= Void
	type_report_added_actions_not_void: type_report_added_actions /= Void
	type_member_report_added_actions_not_void: type_member_report_added_actions /= Void
	percentage_completed_changed_actions_not_void: percentage_completed_changed_actions /= Void
	report_completed_actions_not_void: report_completed_actions /= Void

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
end -- class EC_REPORT_BUILDER
