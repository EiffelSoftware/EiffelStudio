note
	description: "Object representing project statistics"
	date: "$Date$"
	revision: "$Revision$"

class EB_PROJECT_SESSION_STATISTICS


create
	make


feature {NONE} -- Initialization

	make
		do
		end

feature -- Statistic Report

	compilations: NATURAL
			-- Number of compilations.

	successful_compilations: NATURAL
			-- Number of successful compilations.

	failed_compilations: NATURAL
			-- Number of failed compilations.

	consecutive_successful_compilations: NATURAL
			-- Number of successful compilations in a row.		

feature -- Compiler event

	on_project_recompiled (a_is_successful: BOOLEAN)
			-- Increase `compilations' by one.
			-- Increase `successful_compilations` by one iff is_successful.
			-- Increase `consecutive_successful_compilations` by one iff is_successful.
			-- Increase `failed_compilations` by one iff not is_successful.	
		do
			increase_compilations
			if a_is_successful then
				increase_successful_compilations
				increase_consecutive_successful_compilations
			else
				increase_failed_compilations
				reset_consecutive_successful_compilations
			end
		end

feature -- Change element

	increase_compilations
			-- Increase `compilations` by one.
		do
			compilations := compilations + 1
		end

	increase_successful_compilations
			-- Increase `successfull_compilations` by one.
		do
			successful_compilations := successful_compilations + 1
		end

	increase_failed_compilations
			-- Increase `failed_compilations` by one.
		do
			failed_compilations := failed_compilations + 1
		end

	increase_consecutive_successful_compilations
			-- Increase `consecutive_successful_compilations` by one.
		do
			consecutive_successful_compilations := consecutive_successful_compilations + 1
		end

	reset_consecutive_successful_compilations
			-- Reset `consecutive_successful_compilations` to 0.
		do
			consecutive_successful_compilations := 0
		end

feature -- Reset

	reset
			-- Clean statistics to defaults.
		do
			compilations := 0
			successful_compilations := 0
			failed_compilations := 0
			consecutive_successful_compilations := 0
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
