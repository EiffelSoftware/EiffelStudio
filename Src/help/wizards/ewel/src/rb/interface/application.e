indexing
	description: "Root class of Resource Bench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	WEL_APPLICATION
		rename 
			make as wel_make
		redefine
			init_application, accelerators
		end

	INTERFACE_MANAGER

	APPLICATION_IDS

creation
	make


feature -- Initialization

	make is
		local
			retried: BOOLEAN
		do
			if not retried then
				wel_make
			else
				interface.display_text (std_error, "An internal error occurred%NPlease contact <support@eiffel.com>")
			end
		rescue
			retried := true
			retry
		end

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			!! Result.make
		end

	accelerators: WEL_ACCELERATORS is
			-- Create the application's accelerator
		once
			!! Result.make_by_id (Idr_accelerator)
		end

	init_application is
			-- Load the common controls dll
		do
			!! common_controls_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL;

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
end -- class APPLICATION
