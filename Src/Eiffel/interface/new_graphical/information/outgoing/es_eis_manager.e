indexing
	description: "EIS background visiting and storage management"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_MANAGER

inherit
	ES_EIS_SHARED

	SHARED_WORKBENCH

feature -- Operation

	retrieve_storage is
			-- Retrive storage from file
		do
			storage.retrieve_from_file
		end

	start_background_visitor is
			-- Start EIS background visitor.
		require
			universe_ready: workbench.universe_defined
		do
			if background_visitor = Void then
				create background_visitor.make
			end
			background_visitor.start
		end

	stop_background_visitor is
			-- Stop EIS background visitor.
		do
			if background_visitor /= Void then
				background_visitor.stop
			end
		end

feature -- Status report

	full_visited: BOOLEAN is
			-- Has background visiting fully visited?
		do
			if background_visitor /= Void then
				Result := background_visitor.full_visited
			else
				Result := True
			end
		end

feature -- Element Change

	add_observer (a_observer: !PROGRESS_OBSERVER) is
			-- Add observer to be managed
		do
			if background_visitor = Void then
				create background_visitor.make
			end
			background_visitor.add_observer (a_observer)
		end

	remove_observer (a_observer: !PROGRESS_OBSERVER) is
			-- Add observer to be managed
		do
			if background_visitor /= Void then
				background_visitor.remove_observer (a_observer)
			end
		end

feature {NONE} -- Implementation

	background_visitor: ?ES_EIS_BACKGROUND_VISITOR;

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
