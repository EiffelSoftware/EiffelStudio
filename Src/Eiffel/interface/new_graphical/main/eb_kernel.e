indexing
	description: "Core of the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_KERNEL

inherit
	ARGUMENTS

	SHARED_FLAGS

create
	make

feature {NONE} -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			compiler: ES
			graphic_compiler: ES_GRAPHIC
			--| uncomment the following line when profiling
			--prof_setting: PROFILING_SETTING
		do
			--| uncomment the following lines when profiling
			--create prof_setting.make
			--prof_setting.stop_profiling

			if
				argument_count > 0 and then
				(index_of_word_option ("gui") > 0 or else
				argument (1).is_equal ("-from_bench") or else argument (1).is_equal ("-bench"))
			then
				set_gui (True)
				create graphic_compiler.make
			else
					-- Start the compilation in batch mode from the bench executable.
				create compiler.make
			end

			--| uncomment the following line when profiling
			--prof_setting.start_profiling
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

end
