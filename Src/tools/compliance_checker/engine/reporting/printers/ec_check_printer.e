indexing
	description: "[
		Used in conjunction with `EC_CHECK_WORKER' as a means to recieve notification of proffered
		checked entities.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_CHECK_PRINTER

feature -- Access

	should_continue: BOOLEAN is
			-- Should checking continue?
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end

feature -- Starting

	notify_start is
			-- Called when checker is about to begin checking an assembly.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			should_continue: should_continue
		deferred
		end
		
	start_type (a_type: SYSTEM_TYPE) is
			-- Called when checker is about to begin checking type `a_type'.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_type_not_void: a_type /= Void
			should_continue: should_continue
		deferred
		end

	start_constructor (a_ctor: CONSTRUCTOR_INFO) is
			-- Called when checker is about to begin checking constructor `a_ctor'.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_ctor_not_void: a_ctor /= Void
			should_continue: should_continue
		deferred
		end
		
	start_method (a_method: METHOD_INFO) is
			-- Called when checker is about to begin checking method `a_method'.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_method_not_void: a_method /= Void
			should_continue: should_continue
		deferred
		end
		
	start_property (a_property: PROPERTY_INFO) is
			-- Called when checker is about to begin checking property `a_property'.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_property_not_void: a_property /= Void
			should_continue: should_continue
		deferred
		end	
		
	start_field (a_field: FIELD_INFO) is
			-- Called when checker is about to begin checking field `a_field'.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_field_not_void: a_field /= Void
			should_continue: should_continue
		deferred
		end
	
	start_event (a_event: EVENT_INFO) is
			-- Called when checker is about to begin checking ecent `a_event'.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_event_not_void: a_event /= Void
			should_continue: should_continue
		deferred
		end	

feature -- Checked
		
	checked_type (a_type: EC_CHECKED_TYPE) is
			-- Called when checker is about to begin checking type `a_type'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_type_not_void: a_type /= Void
		deferred
		end

	checked_constructor (a_ctor: EC_CHECKED_MEMBER_CONSTRUCTOR) is
			-- Called when checker is about to begin checking constructor `a_ctor'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end			
		require
			a_ctor_not_void: a_ctor /= Void
		deferred
		end
		
	checked_method (a_method: EC_CHECKED_MEMBER_METHOD) is
			-- Called when checker is about to begin checking method `a_method'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_method_not_void: a_method /= Void
		deferred
		end

	checked_property (a_property: EC_CHECKED_MEMBER) is
			-- Called when checker is about to begin checking property `a_property'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_property_not_void: a_property /= Void
		deferred
		end	
		
	checked_field (a_field: EC_CHECKED_MEMBER_FIELD) is
			-- Called when checker is about to begin checking field `a_field'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end			
		require
			a_field_not_void: a_field /= Void
		deferred
		end
	
	checked_event (a_event: EC_CHECKED_MEMBER) is
			-- Called when checker is about to begin checking event `a_event'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_event_not_void: a_event /= Void
		deferred
		end	
		
feature -- Endding

	notify_end (a_complete: BOOLEAN) is
			-- Called when checker is finished.
			-- `a_complete' indicates if report is a full complete report.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end
		
	end_type is
			-- Called when checker is finished checking last started checked type.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end			
		deferred
		end
		
	end_constructor is
			-- Called when checker is finished checking last started checked constructor.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end
		
	end_method is
			-- Called when checker is finished checking last started checked method.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end
		
	end_property is
			-- Called when checker is finished checking last started checked property.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end	
		
	end_field is
			-- Called when checker is finished checking last started checked field.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end
	
	end_event is
			-- Called when checker is about to begin checking event.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end	

feature -- Percentage

	notify_percentage_complete (a_percent: NATURAL_8) is
			-- Called when percentage changes.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_percent_small_enough: a_percent <= 100
		deferred
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
end -- class EC_CHECK_PRINTER
