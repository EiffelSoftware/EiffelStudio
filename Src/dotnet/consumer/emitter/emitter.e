note
	description	: "Emitter's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	assembly_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (False) end,
		create {ASSEMBLY_COMPANY_ATTRIBUTE}.make ("Eiffel Software") end,
		create {ASSEMBLY_COPYRIGHT_ATTRIBUTE}.make ("Copyright Eiffel Software 1985-2006") end
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER

inherit
	SYSTEM_OBJECT

	CACHE_PATH
		export
			{NONE} all
		end

	SHARED_ASSEMBLY_LOADER
		export
			{NONE} all
		end

	AR_SHARED_SUBSCRIBER
		export
			{NONE} all
		end

	SHARED_LOGGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		do
			complete_initialization
		end

	complete_initialization
			-- Completes initialization of instance given it current state
		require
			non_void_clr_version: clr_version /= Void
			valid_clr_version: not clr_version.is_empty and then clr_version.item (1).as_lower = 'v'
		do
			create cache_writer.make
		ensure
			non_void_cache_writer: cache_writer /= Void
		end

feature {NONE} -- Implementation

	add_assembly_to_eac (a_path: STRING)
			-- Consume assembly `a_path' and put results in EAC
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_clr_version: clr_version /= Void
			non_void_cache_writer: cache_writer /= Void
		do
			cache_writer.add_assembly (a_path, False)
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			cache_writer.clean_cache
		end

	remove_assembly_from_eac (a_path: STRING)
			-- Remove assembly `a_path' from EAC
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_clr_version: clr_version /= Void
			non_void_cache_writer: cache_writer /= Void
		do
			cache_writer.remove_recursive_assembly (a_path)
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			cache_writer.clean_cache
		end

	cache_writer: CACHE_WRITER
			-- cache writer to manipulate contents of specified EAC.

invariant
	non_void_cache_writer: cache_writer /= Void

note
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


end -- class EMITTER
