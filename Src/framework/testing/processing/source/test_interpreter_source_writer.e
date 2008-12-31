note
	description: "[
		Source writer for printing ITP_INTERPRETER_ROOT class.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTERPRETER_SOURCE_WRITER

inherit
	TEST_CLASS_SOURCE_WRITER
		redefine
			ancestor_names
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

feature -- Access

	class_name: !STRING = "ITP_INTERPRETER_ROOT"
			-- <Precursor>

	root_feature_name: !STRING = "execute"
			-- <Precursor>

	ancestor_names: !ARRAY [!STRING]
			-- <Precursor>
		do
			Result := << "ITP_INTERPRETER" >>
		end

feature {NONE} -- Access

	root_group: ?CONF_GROUP
	root_class: ?CLASS_C
	root_feature: ?FEATURE_I

feature -- Basic operations

	write_class (a_file: !KI_TEXT_OUTPUT_STREAM; a_type_list: !DS_LINEAR [STRING]; a_system: !SYSTEM_I)
			-- Print root class refering to types in `a_type_list'
		require
			a_file_open_write: a_file.is_open_write
		local
			l_root: SYSTEM_ROOT
			l_class: like root_class
		do
			create stream.make (a_file)
			put_indexing
			put_class_header

			if not a_system.root_creators.is_empty then
				l_root := a_system.root_creators.first
				root_group := l_root.cluster
				l_class := l_root.root_class.compiled_class
				if l_class /= Void then
					root_feature := l_class.feature_named (l_root.procedure_name)
					root_class := l_class
					if root_feature /= Void and root_group /= Void then
						put_anchor_routine (a_type_list)
					end
				end
			end

			put_class_footer
			stream := Void
		end

feature {NONE} -- Implementation

	put_anchor_routine (a_types: !DS_LINEAR [STRING])
			--
		require
			stream_valid: is_writing
			root_group_attached: root_group /= Void
			root_class_attached: root_class /= Void
			root_feature_attached: root_feature /= Void
		local
			l_type: STRING
		do
			stream.indent
			stream.put_line ("type_anchors")
			stream.indent
			stream.put_line ("local")
			stream.indent
			stream.put_line ("l_type: TYPE [ANY]")
			stream.dedent
			stream.put_line ("do")
			stream.indent
			stream.indent
			stream.put_line ("-- One assignment to avoid warnings")
			stream.dedent
			stream.put_line ("l_type := {ANY}")
			stream.put_line ("")

			from
				a_types.start
				type_a_checker.init_for_checking (root_feature, root_class, Void, Void)
			until
				a_types.after
			loop
				l_type := a_types.item_for_iteration
				put_type_assignment (l_type)
				a_types.forth
			end

			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_line ("")
		end

	put_type_assignment (a_type: STRING)
			-- Print valid assignment for `a_type'.
		require
			a_type_not_void: a_type /= Void
			root_group_attached: root_group /= Void
			root_class_attached: root_class /= Void
			root_feature_attached: root_feature /= Void
		local
			l_type_a, l_gtype: TYPE_A
			l_class: CLASS_C
			l_type: ?STRING
			i: INTEGER
		do
			type_parser.parse_from_string ("type " + a_type)
			error_handler.wipe_out
			if {l_type_as: CLASS_TYPE_AS} type_parser.type_node then
				l_type_a := type_a_generator.evaluate_type_if_possible (l_type_as, root_class)
				if l_type_a /= Void then
					create l_type.make (20)
					l_type.append (l_type_a.name)
					if l_type_a.generics = Void then
						l_class := l_type_a.associated_class
						check l_class /= Void end
						if l_class.is_generic then
								-- In this case we try to insert constrains to receive a valid type
							l_type.append (" [")
							from
								i := 1
							until
								not l_class.is_valid_formal_position (i)
							loop
								if i > 1 then
									l_type.append (", ")
								end
								if l_class.generics [i].is_multi_constrained (l_class.generics) then
									l_type.append ("NONE")
								else
									l_gtype := l_class.constrained_type (i)
									append_type (l_type, l_gtype)
								end
								i := i + 1
							end
							l_type.append ("]")
						end
					end
					stream.put_string ("l_type := {")
					stream.put_string (l_type)
					stream.put_line ("}")
				end
			end
		end

	append_type (a_string: !STRING; a_type: TYPE_A)
			-- Append type name for `a_type' to `a_string' without formal parameters.
		local
			i: INTEGER
		do
			if not a_type.is_formal and {l_class_type: CL_TYPE_A} a_type then
				a_string.append (l_class_type.associated_class.name)
				if l_class_type.has_generics then
					a_string.append (" [")
					from
						i := l_class_type.generics.lower
					until
						i > l_class_type.generics.upper
					loop
						if i > l_class_type.generics.lower then
							a_string.append (", ")
						end
						append_type (a_string, l_class_type.generics.item (i))
						i := i + 1
					end
					a_string.append ("]")
				end
			else
				a_string.append ("NONE")
			end
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
