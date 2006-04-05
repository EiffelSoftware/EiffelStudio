indexing
	description: "Task which reports progress"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date"
	revision: "$revision"

deferred class
	WIZARD_PROGRESS_REPORTING_TASK

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end
	
feature -- Access

	title: STRING is
			-- Task title, to be displayed to user
		deferred
		end

	steps_count: INTEGER is
			-- Number of steps involved in task
		deferred
		ensure
			valid_count: Result >= 0
		end

feature -- Basic Operation

	execute is
			-- Execute task
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				internal_execute
			else
				environment.set_abort (Exception_raised)
				environment.set_error_data ("Exception " +  tag_name + " occured in task " + title)
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
		deferred
		end

invariant
	valid_steps_count: steps_count > 0

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
end -- class WIZARD_PROGRESS_REPORTING_TASK

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
