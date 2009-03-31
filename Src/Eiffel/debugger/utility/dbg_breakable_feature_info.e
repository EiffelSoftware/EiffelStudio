note
	description: "Summary description for {DEBUGGER_BREAKABLE_FEATURE_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_BREAKABLE_FEATURE_INFO

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_feat: E_FEATURE) is
			-- Initialize `Current'.
		require
			a_feat_attached: a_feat /= Void
		do
			feature_id := a_feat.feature_id
			class_id := a_feat.associated_class.class_id
			create {ARRAYED_LIST [DBG_BREAKABLE_POINT_INFO]} points.make (10)
			create object_test_locals.make (5)
		end

feature -- Access

	breakable_count: INTEGER
			-- Last breakable index value

	breakable_nested_count: INTEGER
			-- Last nested breakable index

	feature_id: INTEGER
			-- Associated feature's id

	class_id: INTEGER
			-- Associated class's id

	points: LIST [DBG_BREAKABLE_POINT_INFO]
			-- List of breakable point (including nested location)

	object_test_locals: ARRAYED_LIST [DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO]
			-- List of object test local's info

feature -- Backup

	object_test_locals_backup: like object_test_locals
			-- Backup value for `object_test_locals'
		do
			create Result.make (object_test_locals.count)
			Result.append (object_test_locals)
		ensure
			Result_attached: Result /= Void
		end

	restore_object_test_locals_backup (v: like object_test_locals_backup)
			-- Restore `object_test_locals' from backup value `v'
		require
			v_attached: v /= Void
		do
			object_test_locals.append (v)
		end

feature -- Breakable data

	reset_breakable_data
			-- Reset breakable indexes data
		do
			breakable_count := 0
			breakable_nested_count := 0
		end

	breakable_data: TUPLE [bp: like breakable_count; bp_nested: like breakable_nested_count]
			-- Current breakable data
		do
			create Result
			Result.bp := breakable_count
			Result.bp_nested := breakable_nested_count
		ensure
			Result_attached: Result /= Void
		end

	restore_breakable_data (a_data: like breakable_data)
			-- Restore breakable data from `a_data"
		require
			a_data_attached: a_data /= Void
		do
			breakable_count := a_data.bp
			breakable_nested_count := a_data.bp_nested
		end

feature -- Change

	add_point (a_class: CLASS_C; a_line: INTEGER; a_text: STRING)
			-- Add breakable point info
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
			-- Add nested breakable point info
		require
			a_class_attached: a_class /= Void
			a_line_valid: a_line > 0
			a_text_valid: a_text /= Void
		do
			breakable_nested_count := breakable_nested_count + 1
			internal_add_point_info (a_class, a_line, a_text)
		end

	add_object_test_local (a_name: ID_AS; a_type: detachable TYPE_AS; a_exp: detachable EXPR_AS)
			-- Add object test local info
		local
			t: DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO
		do
			create t.make (breakable_count, breakable_nested_count)
			t.name_id := a_name
			t.type := a_type
			t.expression := a_exp
			object_test_locals.force (t)
		end

feature {NONE} -- Implementation

	internal_add_point_info (a_class: CLASS_C; a_line: INTEGER; a_text: STRING)
			-- Implementation for `add(_*)_point_info'
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
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
