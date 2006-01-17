indexing
	description: "Describe one external clause node"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class LANG_TRIB_SD

inherit
	AST_LACE
		redefine
			adapt
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (ln: like language_name; fn: like file_names) is
			-- Create a new LANG_TRIB AST node.
		require
			ln_not_void: ln /= Void
			fn_not_void: fn /= Void
		do
			language_name := ln
			file_names := fn
		ensure
			language_name_set: language_name = ln
			file_names_set: file_names = fn
		end

feature -- Properties

	language_name: LANGUAGE_NAME_SD;
			-- Language name

	file_names: LACE_LIST [ID_SD];
			-- File names

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result.initialize (language_name.duplicate, file_names.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then language_name.same_as (other.language_name)
					and then file_names.same_as (other.file_names)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			st.put_new_line
			language_name.save (st)
			st.put_string (":%N%T%T")
			file_names.save_with_interval_separator (st, ",%N%T%T")
		end

feature {COMPILER_EXPORTER} -- Lace compilation

	adapt is
			-- External analysis
		local
			vd34: VD34;
		do
			if language_name.is_object then
				System.set_object_file_names (file_names)
			elseif language_name.is_include_path then
				System.set_include_paths (file_names)
			elseif language_name.is_assembly then
				System.set_assembly_names (file_names)
			elseif language_name.is_make then
				System.set_makefile_names (file_names)
			elseif language_name.is_c then
				System.set_c_file_names (file_names)
			elseif language_name.is_dotnet_resource then
				System.set_dotnet_resources_names (file_names)
			else
				create vd34
				vd34.set_language_name (language_name.language_name)
				Error_handler.insert_error (vd34)
			end;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class LANG_TRIB_SD


