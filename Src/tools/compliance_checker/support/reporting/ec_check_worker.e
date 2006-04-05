indexing
	description: "[
		Compliance checker worker thread. It will, when started, examine and report to a printer
		every member of an assembly and its compliance status.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECK_WORKER
	
inherit
	THREAD
	
	EC_CHECKED_ENTITY_FACTORY
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end
		
	EC_CHECKED_CACHE
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

	make (a_assembly: like assembly; a_printer: like printer) is
			-- Create an initialize a new checker worker thread.
		require
			a_assembly_not_void: a_assembly /= Void
			a_printer_not_void: a_printer /= Void
		do
			assembly := a_assembly
			printer := a_printer
		ensure
			assembly_set: assembly = a_assembly
			printer_set: printer = a_printer
		end
	
feature -- Access

	should_stop: BOOLEAN
			-- Should worker thread be stopped?

feature -- Basic Operations

	stop_checking is
			-- Stops thread from continuing to check for compliance
		require
			not_already_stopping: not should_stop
		do
			should_stop := True
		ensure
			should_stop_set: should_stop = True
		end
		
feature {NONE} -- Basic Operations

	execute is
			-- Routine executed by new thread.
		local		
			l_types: NATIVE_ARRAY [SYSTEM_TYPE]
			l_type: SYSTEM_TYPE
			l_count: INTEGER
			l_printer: like printer
			l_started: BOOLEAN
			retried: BOOLEAN
			l_stop: BOOLEAN
			i: INTEGER
		do
			if not retried then
				wipe_out_cache
				
				should_stop := False
				l_printer := printer
				
				l_printer.notify_start
				l_started := True
				l_printer.notify_percentage_complete (0)
				
				l_types := assembly.get_types
				l_count := l_types.count

				{SYSTEM_ARRAY}.sort (l_types, create {EC_TYPE_SORTER})

				from
					i := 0
				until
					l_stop or i = l_count
				loop
					l_type := l_types.item (i)
					process_type (l_printer, l_type)
					l_stop := should_stop
					i := i + 1
					l_printer.notify_percentage_complete (((i / l_count) * 100).truncated_to_integer.to_natural_8)
					sleep (1)
				end
				l_printer.notify_end (True)
			elseif l_started then
				l_printer.notify_end (False)
			end
		rescue
			retried := True
			retry
		end
		
feature {NONE} -- Implementation

	process_type (a_printer: like printer; a_type: SYSTEM_TYPE) is
			-- Processes `a_type'
		require
			a_printer_not_void: a_printer /= Void
			a_type_not_void: a_type /= Void
		local
			l_checked_type: EC_CHECKED_TYPE
		do
			if not a_type.is_not_public or a_type.is_nested_public or a_type.is_nested_family then
				a_printer.start_type (a_type)
				l_checked_type := checked_type (a_type) -- This will take cached version
				a_printer.checked_type (l_checked_type)
				process_members (a_printer, l_checked_type)				
				a_printer.end_type
			end
		end
	
	process_members (a_printer: like printer; a_type: EC_CHECKED_TYPE) is
			-- Process `a_type' members
		require
			a_printer_not_void: a_printer /= Void
			a_type_not_void: a_type /= Void
		local
			l_type: SYSTEM_TYPE
			l_members: NATIVE_ARRAY [MEMBER_INFO]
			l_member: MEMBER_INFO
			l_count: INTEGER
			i: INTEGER
			
			l_method: METHOD_INFO
			l_checked_method: EC_CHECKED_MEMBER_METHOD
			l_prop: PROPERTY_INFO
			l_checked_prop: EC_CHECKED_MEMBER_PROPERTY
			l_ctor: CONSTRUCTOR_INFO
			l_checked_ctor: EC_CHECKED_MEMBER_CONSTRUCTOR
			l_event: EVENT_INFO
			l_checked_event: EC_CHECKED_MEMBER_EVENT
			l_field: FIELD_INFO
			l_checked_field: EC_CHECKED_MEMBER_FIELD
		do
			l_type := a_type.type
			l_members := l_type.get_members
			l_count := l_members.count
			
			{SYSTEM_ARRAY}.sort (l_members, create {EC_MEMBER_SORTER})
			
			from
			until
				i = l_count
			loop
				l_member := l_members.item (i)
				l_method ?= l_member
				if l_method /= Void then
					a_printer.start_method (l_method)
					create l_checked_method.make (l_method)
					a_printer.checked_method (l_checked_method)
					a_printer.end_method
				else
					l_prop ?= l_member
					if l_prop /= Void then
						a_printer.start_property (l_prop)
						create l_checked_prop.make (l_prop)
						a_printer.checked_property (l_checked_prop)
						a_printer.end_property
					else
						l_ctor ?= l_member
						if l_ctor /= Void then
							a_printer.start_constructor (l_ctor)
							create l_checked_ctor.make (l_ctor)
							a_printer.checked_constructor (l_checked_ctor)
							a_printer.end_constructor
						else
							l_event ?= l_member
							if l_event /= Void then
								a_printer.start_event (l_event)
								create l_checked_event.make (l_event)
								a_printer.checked_event (l_checked_event)
								a_printer.end_event
							else
								l_field ?= l_member
								if l_field /= Void then
									a_printer.start_field (l_field)
									create l_checked_field.make (l_field)
									a_printer.checked_field (l_checked_field)
									a_printer.end_field
								end
							end	
						end			
					end
				end
				i := i + 1
			end
		end

	assembly: ASSEMBLY
			-- Assembly to check

	printer: EC_CHECK_PRINTER
			-- Printer to write output to
			
			
invariant
	printer_not_void: printer /= Void

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
end -- class EC_CHECK_WORKER
