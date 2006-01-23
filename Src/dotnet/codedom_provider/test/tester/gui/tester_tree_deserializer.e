indexing
	description: "Deserialize codedom trees"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_TREE_DESERIALIZER

inherit
	TESTER_SHARED_EVENT_MANAGER

	TESTER_CODEDOM_TYPES

feature -- Access

	compile_unit_from_file (a_path: STRING): SYSTEM_DLL_CODE_COMPILE_UNIT is
			-- De-serialized tree at `a_path' if any
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_formatter.make
				create l_stream.make (a_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
				Result ?= l_formatter.deserialize (l_stream)
				l_stream.close
			else
				if l_stream /= Void then
					l_stream.close
				end
			end
		rescue
			event_manager.raise_event (create {TESTER_EVENT}.make ("Could not deserialize compile unit at " + a_path, True))
			l_retried := True
			retry
		end
		
	namespace_from_file (a_path: STRING): SYSTEM_DLL_CODE_NAMESPACE is
			-- De-serialized tree at `a_path' if any
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_formatter.make
				create l_stream.make (a_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
				Result ?= l_formatter.deserialize (l_stream)
				l_stream.close
			else
				if l_stream /= Void then
					l_stream.close
				end
			end
		rescue
			event_manager.raise_event (create {TESTER_EVENT}.make ("Could not deserialize namespace at " + a_path, True))
			l_retried := True
			retry
		end
		
	type_from_file (a_path: STRING): SYSTEM_DLL_CODE_TYPE_DECLARATION is
			-- De-serialized tree at `a_path' if any
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_formatter.make
				create l_stream.make (a_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
				Result ?= l_formatter.deserialize (l_stream)
				l_stream.close
			else
				if l_stream /= Void then
					l_stream.close
				end
			end
		rescue
			event_manager.raise_event (create {TESTER_EVENT}.make ("Could not deserialize type at " + a_path, True))
			l_retried := True
			retry
		end
		
	expression_from_file (a_path: STRING): SYSTEM_DLL_CODE_EXPRESSION is
			-- De-serialized tree at `a_path' if any
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_formatter.make
				create l_stream.make (a_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
				Result ?= l_formatter.deserialize (l_stream)
				l_stream.close
			else
				if l_stream /= Void then
					l_stream.close
				end
			end
		rescue
			event_manager.raise_event (create {TESTER_EVENT}.make ("Could not deserialize expression at " + a_path, True))
			l_retried := True
			retry
		end
		
	statement_from_file (a_path: STRING): SYSTEM_DLL_CODE_STATEMENT is
			-- De-serialized tree at `a_path' if any
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_formatter.make
				create l_stream.make (a_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
				Result ?= l_formatter.deserialize (l_stream)
				l_stream.close
			else
				if l_stream /= Void then
					l_stream.close
				end
			end
		rescue
			event_manager.raise_event (create {TESTER_EVENT}.make ("Could not deserialize statement at " + a_path, True))
			l_retried := True
			retry
		end
	
	codedom_type_from_file (a_path: STRING): INTEGER is
			-- Type of codedom tree stored in `a_path' if any, 0 otherwise.
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_object: SYSTEM_OBJECT
			l_retried: BOOLEAN
			l_name: STRING
		do
			if not l_retried then
				create l_formatter.make
				create l_stream.make (a_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
				l_object ?= l_formatter.deserialize (l_stream)
				l_stream.close
				check
					has_data: l_object /= Void
				end
				l_name := l_object.get_type.full_name
				if l_name.is_equal ("System.CodeDom.CodeStatement") then
					Result := Codedom_statement_type
				elseif l_name.is_equal ("System.CodeDom.CodeExpression") then
					Result := Codedom_expression_type
				elseif l_name.is_equal ("System.CodeDom.CodeTypeDeclaration") then
					Result := Codedom_type_type
				elseif l_name.is_equal ("System.CodeDom.CodeNamespace") then
					Result := Codedom_namespace_type
				elseif l_name.is_equal ("System.CodeDom.CodeCompileUnit") then
					Result := Codedom_compile_unit_type
				else
					Event_manager.raise_event (create {TESTER_EVENT}.make ("Unknown serialized type " + a_path, True))
				end
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Cannot deserialize file " + a_path, True))
			end
		ensure
			valid_type: Result = 0 or else is_valid_codedom_type (Result)
		rescue
			l_retried := True
			if l_stream /= Void then
				l_stream.close
			end
			retry
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


end -- class TESTER_TREE_DESERIALIZER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------