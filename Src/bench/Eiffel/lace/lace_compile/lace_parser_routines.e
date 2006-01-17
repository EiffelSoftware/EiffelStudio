indexing
	description: "Set of features needed for parsing of Lace files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: "
	revision: "$Revision: "

deferred class
	LACE_PARSER_ROUTINES

inherit
	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	SHARED_WORKBENCH
	COMPILER_EXPORTER

feature -- Access

	ast: AST_LACE
			-- Last AS description

	is_in_use_file: BOOLEAN
			-- Are we parsing `use' specification of Lace or Lace itself?

feature -- Parsing

	build_ast (file_name: STRING) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			file: KL_BINARY_INPUT_FILE
			vd21: VD21
		do
			create file.make (file_name)
			file.open_read

			if not file.is_open_read then
				create vd21
				vd21.set_file_name (file_name)
				Error_handler.insert_error (vd21)
				Error_handler.raise_error
			else
				parse_lace (file)
				if Workbench.automatic_backup then
					save_ace_in_backup (file)
				end
				file.close
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Close file in case of syntax error in lace file
				if file /= Void then
					file.close
				end
			end
		end

	parse_file (file_name: STRING; in_use_file: BOOLEAN) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			retried: BOOLEAN
			syntax_error: SYNTAX_ERROR
		do
			is_in_use_file := in_use_file
			if not retried then
				set_last_syntax_error (Void)
				build_ast (file_name)
			else
				syntax_error ?= Error_handler.error_list.first
				check
					syntax_error_not_void: syntax_error /= Void
				end
				set_last_syntax_error (syntax_error)
				retried := False
			end
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False)
				retried := True
				retry
			end
		end	

feature -- Shared once

	last_syntax_error: SYNTAX_ERROR is
			-- Last syntax error generated after calling
			-- routine `parse_ast'
		do
			Result := last_syntax_cell.item
		end

	set_last_syntax_error (s: SYNTAX_ERROR) is
			-- Put the last syntax error in last_syntax_error
		do
			last_syntax_cell.put (s)
		end

feature -- Removal

	clear_syntax_error is
			-- Clear the syntax error information.
		do
			Error_handler.error_list.wipe_out
			last_syntax_cell.put (Void)
		end

feature {NONE} -- Implementation

	last_syntax_cell: CELL [SYNTAX_ERROR] is
			-- Stored value of last generated syntax error generated calling
			-- routine `parse_ast'
		once
			create Result.put (Void)
		end

	parse_lace (a_file: KL_BINARY_INPUT_FILE) is
			-- Call lace parser with a source file.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		deferred
		end

	save_ace_in_backup (file: RAW_FILE) is
			-- Take existing valid parsed ace `file' and update it
			-- for easy recompilation of BACKUP directory.
		require
			backup_is_on: Workbench.automatic_backup
			file_not_void: file /= Void
			file_not_closed: file.is_open_read
		local
			f_name: FILE_NAME
			f_count: INTEGER
			copy_file: RAW_FILE
			l_ace: ACE_SD
			l_file_name: STRING
			l_path: ID_SD
			l_cluster: CLUSTER_SD
			st: GENERATION_BUFFER
		do
			Workbench.create_backup_directory

				-- If parsing was successful, save an modified copy of AST
			l_ace ?= ast
			if l_ace /= Void and then l_ace.clusters /= Void then
				from
					l_ace := l_ace.duplicate
					l_file_name := "Ace.original"
					l_ace.clusters.start
				until
					l_ace.clusters.after
				loop
					l_cluster := l_ace.clusters.item
					create l_path.initialize (l_cluster.cluster_name)
					l_path.set_is_string
					l_cluster.set_directory_name (l_path)
					l_ace.clusters.forth
				end
				
				create st.make (2048)
				l_ace.save (st)
				create f_name.make_from_string (Workbench.backup_subdirectory)
				f_name.set_file_name ("Ace.ace")
				create copy_file.make_open_write (f_name)
				st.put_in_file (copy_file)
				copy_file.close
			else
				l_file_name := "Ace.ace"
			end

				-- Then save original in a Backup directory
			create f_name.make_from_string (Workbench.backup_subdirectory)
			f_name.set_file_name (l_file_name)
			create copy_file.make (f_name)
			if copy_file.is_creatable then
				copy_file.open_write
				file.start
				f_count := file.count
				if f_count > 0 then
					file.read_stream (f_count)
					copy_file.put_string (file.last_string)
				end
				copy_file.close
			end
		end

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

end -- class LACE_PARSER_ROUTINES
