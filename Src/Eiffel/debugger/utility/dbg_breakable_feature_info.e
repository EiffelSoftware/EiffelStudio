note
	description: "Debugger information for a feature."

class
	DBG_BREAKABLE_FEATURE_INFO

inherit
	DEBUG_OUTPUT

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_feat: E_FEATURE)
			-- Initialize `Current'.
		require
			a_feat_attached: a_feat /= Void
		do
			class_c := a_feat.associated_class
			feature_i := a_feat.associated_feature_i

			feature_id := a_feat.feature_id
			class_id := class_c.class_id
			create points.make (10)
			create object_test_locals.make (5)
		end

feature -- Status report

	error_occurred: BOOLEAN
			-- Error occurred while computing feature info.

feature -- Access

	breakable_count: INTEGER
			-- Last breakable index value.

	breakable_nested_count: INTEGER
			-- Last nested breakable index.

	class_c: CLASS_C
			-- Associated class_c.

	feature_i: FEATURE_I
			-- Associated feature_i.

	feature_id: INTEGER
			-- Associated feature's id.

	class_id: INTEGER
			-- Associated class's id.

	points: ARRAYED_LIST [DBG_BREAKABLE_POINT_INFO]
			-- List of breakable point (including nested location).

	locals: detachable LIST [TUPLE [id: INTEGER; type: detachable TYPE_AS]]
			-- List of local's info.

	object_test_locals: ARRAYED_LIST [DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO]
			-- List of object test local's info.

feature -- Access: resolved

	resolved: BOOLEAN
			-- Local variables resolved?

	local_table: detachable HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Table of resolved local variables info.
			-- require	resolved: resolved attribute end

	object_test_locals_resolved: ARRAYED_LIST [TUPLE [id: ID_AS; li: LOCAL_INFO]]
			-- List of object test local's info.
			-- require	resolved: resolved attribute end

feature -- Backup

	change_object_test_locals (v: detachable like object_test_locals)
		do
			if v /= Void then
				object_test_locals := v
			else
				create object_test_locals.make (5)
			end
		ensure
			object_test_locals_attached: object_test_locals /= Void
		end

	append_object_test_locals (v: like object_test_locals)
		do
			if v /= Void and then not v.is_empty then
				object_test_locals.append (v)
			end
		end

feature -- Breakable data

	reset_breakable_data
			-- Reset breakable indexes data.
		do
			breakable_count := 0
			breakable_nested_count := 0
		end

	breakable_data: TUPLE [bp: like breakable_count; bp_nested: like breakable_nested_count]
			-- Current breakable data.
		do
			Result := [breakable_count, breakable_nested_count]
		ensure
			Result_attached: Result /= Void
		end

	restore_breakable_data (a_data: like breakable_data)
			-- Restore breakable data from `a_data'.
		require
			a_data_attached: a_data /= Void
		do
			breakable_count := a_data.bp
			breakable_nested_count := a_data.bp_nested
		end

feature -- Element change

	set_error_occurred (b: BOOLEAN)
			-- Set `error_occurred' to `b'.
		do
			error_occurred := b
		end

	set_resolved (b: BOOLEAN)
			-- Set `resolved' to `b'.
		do
			resolved := b
		end

	set_locals (a_locals: like locals)
			-- Set `locals' to `a_locals'.
		do
			locals := a_locals
		end

	set_local_table (a_local_table: like local_table)
			-- Set `local_table' to `a_local_table'.
		do
			local_table := a_local_table
		end

	set_object_table_locals_resolved (a_object_test_locals_resolved: like object_test_locals_resolved)
			-- Set `object_test_locals_resolved' to `a_object_test_locals_resolved'.
		do
			object_test_locals_resolved := a_object_test_locals_resolved
		end

	add_point (a_class: CLASS_C; a_line: INTEGER; a_text: STRING)
			-- Add breakable point info.
		require
			a_class_attached: a_class /= Void
			a_line_valid: a_line > 0
			a_text_valid: a_text /= Void
		do
			breakable_count := breakable_count + 1
			breakable_nested_count := 0
			internal_add_point_info (a_class, a_line, a_text)
		end

	add_nested_point (a_class: CLASS_C; a_line: INTEGER; a_text: STRING)
			-- Add nested breakable point info.
		require
			a_class_attached: a_class /= Void
			a_line_valid: a_line > 0
			a_text_valid: a_text /= Void
		do
			breakable_nested_count := breakable_nested_count + 1
			internal_add_point_info (a_class, a_line, a_text)
		end

	add_object_test_local (a_name: detachable ID_AS; a_type: detachable TYPE_AS; a_exp: detachable EXPR_AS)
			-- Add object test local info.
		local
			t: DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO
			l_name: detachable ID_AS
		do
			create t.make (breakable_count, breakable_nested_count)
			l_name := a_name
			if l_name = Void then
				create l_name.initialize ("~unamed #" + (object_test_locals.count + 1).out)
			end
			t.name_id := l_name
			t.type := a_type
			t.expression := a_exp
			object_test_locals.force (t)
		end

feature {NONE} -- Implementation

	internal_add_point_info (a_class: CLASS_C; a_line: INTEGER; a_text: STRING)
			-- Implementation for `add(_*)_point_info'.
		require
			a_class_attached: a_class /= Void
			a_line_valid: a_line > 0
			a_text_valid: a_text /= Void
		local
			l_info: DBG_BREAKABLE_POINT_INFO
		do
			create l_info.make (breakable_count, breakable_nested_count)
			l_info.class_c := a_class
			l_info.line := a_line
			l_info.text := a_text
			points.force (l_info)
		end

feature -- Status report

	debug_output: STRING
		do
			create Result.make (20)
			Result.append_integer (class_id)
			Result.append_character ('.')
			Result.append_integer (feature_id)
			Result.append_character (':')
			Result.append_character (' ')
			Result.append_integer (breakable_count)
			Result.append_string (" breakable line")
			if breakable_count > 0 then
				Result.append_character ('s')
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
