note
	description: "[
		Class containing state shared information regarding a specific test generation run.
		
		Note: the information provided in this class should be aggregated not inherited
		      through a {AUT_SESSION} instance.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_SHARED_INTERPRETER_INFO

feature -- Access

	system: SYSTEM_I
			-- System
		deferred
		ensure
			result_attached: Result /= Void
		end

	compute_interpreter_root_class
			-- Try assigning `interpreter_root_class'.
		local
			l_class: detachable EIFFEL_CLASS_C
		do
			l_class := system.test_system.library_class_named (interpreter_root_class_name)
			interpreter_root_class_cell.put (l_class)
		end

	interpreter_root_class: detachable EIFFEL_CLASS_C
			-- Compiled representation of "ITP_INTERPRETER_ROOT"
		do
			Result := interpreter_root_class_cell.item
		end

	feature_name_for_byte_code_injection: STRING = "execute_byte_code"
			-- Name of feature whose byte code is to be injected.

	feature_for_byte_code_injection: detachable FEATURE_I
			-- Feature whose byte-code is to be injected
		do
			if attached interpreter_root_class as l_class then
				Result := l_class.feature_named_32 (feature_name_for_byte_code_injection)
			end
		end

	interpreter_related_classes: DS_HASH_SET [STRING]
			-- List of names of classes which interpreter rely on,
			-- Make sure those classes are not tested.
			-- Fixme: Write
		once
			create Result.make (10)
			Result.set_equality_tester (
				create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (
					agent (str1, str2: STRING): BOOLEAN
						do
							Result := str1.is_equal (str2)
						end))

			Result.force_last ("ITP_INTERPRETER")
			Result.force_last ("ITP_INTERPRETER_ROOT")
			Result.force_last ("ITP_REQUEST_PARSER")
			Result.force_last ("ITP_STORE")
			Result.force_last ("ITP_EXPRESSION")
			Result.force_last ("ITP_CONSTANT")
			Result.force_last ("ITP_EXPRESSION_PROCESSOR")
			Result.force_last ("ITP_VARIABLE")
			Result.force_last ("ERL_LIST")
		ensure
			result_attached: Result /= Void
		end

feature -- Access: names

	interpreter_root_class_name: STRING
			-- Class name of the interpreter root
		do
			if attached interpreter_root_class_name_cell.item as l_name then
				Result := l_name
			else
				Result := {TEST_SYSTEM_I}.eqa_interpreter_name
			end
		end

	interpreter_root_feature_name: STRING
			-- Feature name of the interpreter root
		do
			if attached interpreter_root_feature_name_cell.item as l_name then
				Result := l_name
			else
				Result := {TEST_SYSTEM_I}.eqa_interpreter_creator
			end
		end

feature {NONE} -- Access: name cells

	interpreter_root_class_name_cell: CELL [detachable STRING]
			-- Once {CELL} for `interpreter_root_class_name'
		once
			create Result.put (Void)
		end

	interpreter_root_feature_name_cell: CELL [detachable STRING]
			-- Once {CELL} for `interpreter_root_feature_name'
		once
			create Result.put (Void)
		end

	interpreter_root_class_cell: CELL [detachable EIFFEL_CLASS_C]
			-- Once per thread cell for `interpreter_root_class'
		once
			create Result.put (Void)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
