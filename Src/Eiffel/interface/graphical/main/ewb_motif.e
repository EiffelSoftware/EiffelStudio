indexing

	description: 
		"Root cluster for eiffelbench under motif."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_MOTIF

inherit
	EWB
		redefine
			init_toolkit
		end;
	MEL_COMMAND;
	EB_CONSTANTS
	
create
	make

feature {NONE} -- Initialization

	init_toolkit: TOOLKIT_IMP is
		once
			create Result.make (Interface_names.n_X_resource_name)
		end;

feature -- Communications

    listen_to: RAW_FILE;
			-- File used to listen 

    create_handler is
		local
			app_context: MEL_APPLICATION_CONTEXT
        do
                -- Associate the file descriptor corresponding
                -- to the pipe on which reading is done
                -- with `listen_to'.
            create listen_to.make ("toto");
            listen_to.fd_open_read (Listen_to_const);
			app_context := init_toolkit.application_context;
                -- Add an IO handler which
                -- listens to the appropriate
                -- pipe.
                -- Set `Current' as callback to be called
                -- when there is something new to read on
                -- the `Listen_to_const' pipe.
			app_context.set_input_read_callback (listen_to, Current, Void)
        end;

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

end -- class EWB_MOTIF
