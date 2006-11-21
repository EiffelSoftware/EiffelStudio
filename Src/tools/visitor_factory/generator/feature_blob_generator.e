indexing
	description: "[
		Generator for generating a feature blob containing zero or more feature declarations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	FEATURE_BLOB_GENERATOR

inherit
	ICLASS_GENERATOR

create {ICLASS_GENERATOR}
	default_create

feature -- Basic operations

	generate (a_opts: APPLICATION_OPTIONS; a_stub: BOOLEAN): STRING is
			-- Generates an Eiffel source file using the application parameters `a_opts'
		local
			l_files: LIST [STRING]
			l_cursor: CURSOR
		do
			l_files := a_opts.files
			l_cursor := l_files.cursor
			create Result.make (l_files.count * 256)
			from l_files.start until l_files.after loop
				Result.append (feature_for_file (l_files.item, a_opts, a_stub))
				Result.append_character ('%N')
				l_files.forth
			end
			l_files.go_to (l_cursor)
		end

	generate_query_features (a_opts: APPLICATION_OPTIONS; a_stub: BOOLEAN): STRING is
			-- Generates query features
		do
			create Result.make (128)
			if not a_stub and then a_opts.use_user_data then
				Result.append_character ('%T')
				Result.append (user_data_validation_function_name (a_opts))
				Result.append (once " (a_data: G): BOOLEAN is%N%T%T%T-- Determines if data `a_data' is valid for Current.%N%T%Tdo%N%T%T%TResult := True%N%T%Tend%N%N")
			end
		ensure
			result_attached: Result /= Void
		end

	generate_redefines_list (a_opts: APPLICATION_OPTIONS; a_stub: BOOLEAN): STRING is
			-- Generates redefine features list
		local
			l_files: LIST [STRING]
			l_feature_name: STRING
			l_cursor: CURSOR
		do
			l_files := a_opts.files

			create Result.make (l_files.count * 256)
			if a_stub then
				l_cursor := l_files.cursor
				from l_files.start until l_files.after loop
					Result.append (once "%T%T%T")
					l_feature_name := file_class_name (l_files.item)
					if l_feature_name /= Void then
						Result.append (item_feature_name (l_feature_name))
					else
							-- Could not parse file
						Result.append (could_not_parse_file_comment)
						Result.append (l_files.item)
					end
					if l_files.islast then
						Result.append_character ('%N')
					else
						Result.append (",%N")
					end
					l_files.forth
				end
				l_files.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	feature_for_file (a_file_name: STRING; a_opts: APPLICATION_OPTIONS; a_stub: BOOLEAN): STRING is
			-- Generates a feature for file `a_file_name' and makes it deferred or effective based on `a_stub'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_opts_attached: a_opts /= Void
			is_eiffel_file: helpers.has_eiffel_extension (a_file_name)
		local
			l_name: STRING
			l_valid_name: STRING
			l_use_user_data: BOOLEAN
		do
			create Result.make (256)
			l_use_user_data := a_opts.use_user_data
			l_name := file_class_name (a_file_name)
			if l_name /= Void then
				l_name.to_lower
				Result.append_character ('%T')
				Result.append (item_feature_name (l_name))
				Result.append (once " (a_value: ")
				Result.append (l_name.as_upper)
				if l_use_user_data then
					Result.append (once "; a_data: G")
				end
				Result.append (once ")%N%T%T%T-- Process object `a_")
				Result.append (l_name)
				Result.append_character ('%'')
				if l_use_user_data then
					Result.append (once" using user data `a_data'.")
				else
					Result.append_character ('.')
				end
				if not a_stub then
					Result.append ("%N%T%Trequire%N%T%T%Ta_")
					Result.append (l_name)
					Result.append (once "_attached: ")
					Result.append (l_name)

					Result.append (once " /= Void")
					if l_use_user_data then
						l_valid_name := user_data_validation_function_name (a_opts)
						Result.append (once "%N%T%T%T")
						Result.append (l_valid_name)
						Result.append (once ": ")
						Result.append (l_valid_name)
						Result.append (once " (a_data)")
					end
				end
				Result.append (once "%N%T%T")
				if a_stub then
					Result.append (once "do%N%T%T%Tcheck not_impl: False end")
				else
					Result.append (once "deferred")
				end
				Result.append (once "%N%T%Tend%N")
			else
					-- Could not parse file
				Result.append_character ('%T')
				Result.append (could_not_parse_file_comment)
				Result.append (a_file_name)
				Result.append_character ('%N')
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	item_feature_name (a_item: STRING): STRING is
			-- Formats `a_item' for use as a feature name
		require
			a_item_attached: a_item /= Void
			not_a_item_is_empty: not a_item.is_empty
		do
			create Result.make (a_item.count + 8)
			Result.append (once "process_")
			Result.append (a_item.as_lower)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	file_class_name (a_file_name: STRING): STRING is
			-- Extracts class name from `a_file'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_finder: CLASSNAME_FINDER
			l_table: like class_name_file_table
			l_file: KL_BINARY_INPUT_FILE
			retried: BOOLEAN
		do
			if not retried then
				l_table := class_name_file_table
				if l_table.has (a_file_name) then
					Result := l_table.item (a_file_name)
				else
					if Result = Void then
						create l_finder.make
						create l_file.make (a_file_name)
						l_file.open_read
						l_finder.parse (l_file)
						l_file.close
						Result := l_finder.classname
					end
					if Result /= Void and then Result.is_empty then
						Result := Void
					end
					l_table.put (Result, a_file_name)
				end
				if Result /= Void then
					Result := Result.twin
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		rescue
			Result := Void
			if l_file /= Void and then l_file.is_open_read then
				l_file.close
			end
			retried := True
			retry
		end

	class_name_file_table: DS_HASH_TABLE [STRING, STRING] is
			-- filename to class name table
			--
		local
			l_tester: KL_EQUALITY_TESTER [STRING]
		once
			l_tester := (create {KL_SHARED_STRING_EQUALITY_TESTER}).case_insensitive_string_equality_tester
			create Result.make_with_equality_testers (15, l_tester, l_tester)
		ensure
			result_attached: Result /= Void
		end

	user_data_validation_function_name (a_opts: APPLICATION_OPTIONS): STRING is
			-- Retrieves name of user data validation function
		require
			a_opts_attached: a_opts /= Void
			a_opts_uses_user_data: a_opts.use_user_data
		do
			create Result.make (35)
			Result.append (once "is_")
			Result.append (a_opts.user_data_class_name.as_lower)
			Result.append (once "_valid")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen helpers: HELPERS is
			-- Shared access to helpers
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	could_not_parse_file_comment: STRING = "-- Could not parse file: "

;indexing
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

end -- class {FEATURE_BLOB_GENERATOR}
