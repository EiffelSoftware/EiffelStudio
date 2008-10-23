indexing
	description: "[
		List of all C external features in IL code generation.
		For each class ID we have a SEARCH_TABLE [INTEGER] that
		represents all external names ID in class ID.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNALS

inherit
	HASH_TABLE [SEARCH_TABLE [INTEGER], INTEGER]
		export
			{EXTERNALS} all
			{ANY} has, remove, count, valid_key
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_CODE_FILES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_INCLUDE
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature -- Insertion/Removal

	add_external (ext: EXTERNAL_I) is
			-- Add `ext' in Current.
		require
			ext_not_void: ext /= Void
			is_c_external: ext.is_c_external
			valid_key: valid_key (ext.written_in)
		local
			l_s: SEARCH_TABLE [INTEGER]
		do
			l_s := item (ext.written_in)
			if l_s = Void then
				create l_s.make (1)
				force (l_s, ext.written_in)
			end
			l_s.force (ext.feature_name_id)
		ensure
			added: has (ext.written_in) and then item (ext.written_in).has (ext.feature_name_id)
		end

	remove_external (ext: EXTERNAL_I) is
			-- Remove `ext' in Current.
		require
			ext_not_void: ext /= Void
			is_c_external: ext.is_c_external
			valid_key: valid_key (ext.written_in)
			has_entry: has (ext.written_in)
		local
			l_s: SEARCH_TABLE [INTEGER]
		do
			l_s := item (ext.written_in)
			check
				l_s_not_void: l_s /= Void
			end
			l_s.remove (ext.feature_name_id)
			if l_s.is_empty then
				remove (ext.written_in)
			end
		ensure
			removed: not has (ext.written_in) or else not item (ext.written_in).has (ext.feature_name_id)
		end

feature -- Freeze externals.

	freeze is
			-- Save current version for later comparison for `is_equivalent'.
		local
			l_other: like Current
		do
			from
				create l_other.make (count)
				start
			until
				after
			loop
				l_other.put (item_for_iteration.twin, key_for_iteration)
				forth
			end
			old_externals := l_other
		ensure
			is_equivalent: is_equivalent
		end

feature -- Comparison

	is_equivalent: BOOLEAN is
			-- Is `Current' equivalent to last saved version of Current? That is to say for each
			-- class, external name set is identical to previous one.
		local
			l_list, l_other_list: SEARCH_TABLE [INTEGER]
			l_other: like Current
		do
			l_other := old_externals
			Result := l_other = Void
			if not Result then
				from
					Result := True
					start
				until
					after or not Result
				loop
					l_other.search (key_for_iteration)
					if l_other.found then
						l_list := item_for_iteration
						l_other_list := l_other.found_item
						check
							l_list_not_void: l_list /= Void
							l_other_list_not_void: l_other_list /= Void
						end
						if l_list.count = l_other_list.count then
							from
								l_list.start
							until
								l_list.after or not Result
							loop
								Result := l_other_list.has (l_list.item_for_iteration)
								l_list.forth
							end
						else
							Result := False
						end
					else
						Result := False
					end
					forth
				end
			end
		end

feature -- Code generation

	generate_il (a_makefile_generator: MAKEFILE_GENERATOR) is
			-- Generate C encapsulation for all calls.
		require
			a_makefile_generator_not_void: a_makefile_generator /= Void
		do
			is_cpp := False
				-- Generate C code first and if `is_cpp' is set, then we will
				-- generate the C++ code.
			internal_generate_il (False)
			if is_cpp then
				internal_generate_il (True)
			end
				-- Generate Makefile
			a_makefile_generator.generate_il (is_cpp)
		end

feature {NONE} -- Implementation

	internal_generate_il (a_for_cpp: BOOLEAN)
			-- Generate externals which are only C externals when `a_for_cpp' is False, C++ otherwise.
		local
			buffer, headers, header_buffer, ext_inline_buffer: GENERATION_BUFFER
			external_file, header_file: INDENT_FILE
			final_mode: BOOLEAN
			l_extension: STRING
			l_file_name: STRING
			l_class: CLASS_C
			l_types: TYPE_LIST
		do
			from
				final_mode := context.final_mode
				buffer := context.generation_buffer
				header_buffer := context.header_generation_buffer
				buffer.set_is_il_generation (True)
				header_buffer.set_is_il_generation (True)
				context.set_buffer (buffer)
				context.set_header_buffer (header_buffer)
				extern_declarations.wipe_out

				buffer.start_c_specific_code
				header_buffer.put_string ("#include %"eif_eiffel.h%"")
				header_buffer.start_c_specific_code

				l_file_name := "lib" + System.name
				if a_for_cpp then
					l_file_name.append ("_cpp")
					l_extension := dot_cpp
				else
					l_extension := dot_c
				end

				create headers.make (100)
				headers.put_string ("#include %"eif_eiffel.h%"%N")
				headers.put_string ("#include %"" + l_file_name + ".h%"%N")

				ext_inline_buffer := generation_ext_inline_buffer
				ext_inline_buffer.clear_all
				ext_inline_buffer.start_c_specific_code
				context.clear_class_type_data

				start
			until
				after
			loop
				l_class := System.class_of_id (key_for_iteration)
				if l_class.has_types then
					from
						l_types := l_class.types
						l_types.start
					until
						l_types.after
					loop
						generate_class_il (item_for_iteration, l_class, l_types.item, a_for_cpp, buffer)
						l_types.forth
					end
					buffer.put_new_line
				end
				forth
			end
			buffer.end_c_specific_code
			header_buffer.end_c_specific_code
			ext_inline_buffer.end_c_specific_code

			create header_file.make_open_write (
				full_file_name (final_mode, Void, l_file_name, Dot_h))
			extern_declarations.generate_header_files (header_buffer)
			header_buffer.put_in_file (header_file)
			header_file.close

			create external_file.make_open_write (
				full_file_name (final_mode, Void, l_file_name, l_extension))
			headers.put_in_file (external_file)
			ext_inline_buffer.put_in_file (external_file)
			buffer.put_in_file (external_file)
			external_file.close

				-- Clean allocated data.
			extern_declarations.wipe_out
			buffer.clear_all
			header_buffer.clear_all

		end

	generate_class_il (a_s: SEARCH_TABLE [INTEGER]; class_c: CLASS_C; class_type: CLASS_TYPE; a_for_cpp: BOOLEAN; buffer: GENERATION_BUFFER) is
			-- Generate C il code
		require
			a_s_not_void: a_s /= Void
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			buffer_not_void: buffer /= Void
		local
			ext: EXTERNAL_I
			feat_tbl: FEATURE_TABLE
		do
			from
				feat_tbl := class_c.feature_table
				context.init (class_type)
				a_s.start
			until
				a_s.after
			loop
				ext ?= feat_tbl.item_id (a_s.item_for_iteration)
					-- Sometime an external disappeared but was not actually removed from Current.
					-- This happens in eweasel test#fake005 where 2 externals with errors are added
					-- and then removed in one compilation, they are not removed from EXTERNALS because
					-- we are always comparing against the original feature table which did not have them.
				if ext /= Void then
						-- We found that it might be Void time to time, thus
						-- the if statement in addition to the check so that in
						-- production we do not fail, but at least when debugging
						-- we get an exception.
					if ext.extension.is_cpp then
						is_cpp := True
						if a_for_cpp then
							ext.generate (class_type, buffer)
						end
					elseif not a_for_cpp then
						ext.generate (class_type, buffer)
					end
				else
					a_s.remove (a_s.item_for_iteration)
				end
				a_s.forth
			end
		end

	is_cpp: BOOLEAN
			-- Does current has some C++ externals?

feature {NONE} -- Previous version

	old_externals: like Current;
			-- Old version of Current.

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

end -- class EXTERNALS
