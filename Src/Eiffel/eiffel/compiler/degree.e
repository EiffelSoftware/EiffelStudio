indexing

	description: "Degrees during Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class DEGREE

inherit

	SHARED_WORKBENCH
	SHARED_EIFFEL_PROJECT

feature {NONE} -- Initialization

	make is
			-- Create a new degree.
		do
		end

feature -- Access

	Degree_number: INTEGER is
			-- Degree number
		deferred
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no class to be processed?
		do
			Result := count = 0
		ensure
			definition: Result = (count = 0)
		end

feature -- Measurement

	count: INTEGER
			-- Number of classes to be processed

feature -- Processing

	execute is
			-- Process all classes.
		deferred
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	insert_new_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
			-- Mark it as new compilation.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	wipe_out is
			-- Remove all classes.
		deferred
		ensure
			wiped_out: is_empty
		end

invariant

	count_positive: count >= 0

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

end -- class DEGREE


