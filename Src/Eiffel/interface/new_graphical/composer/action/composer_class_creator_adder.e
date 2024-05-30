note
	description: "Add creator for a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOSER_CLASS_CREATOR_ADDER

inherit
	COMPOSER_ACTION

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			default_create
		end

create
	make

feature -- Status

	class_set: BOOLEAN
			-- Has the the class to process been set?
		do
			Result := class_i /= Void
		end

feature -- Element change

	set_class (a_class: CLASS_I)
			-- The class that get's processed
		require
			a_class_not_void: a_class /= Void
		do
			class_i := a_class
		ensure
			class_set_correct: class_set and class_i = a_class
		end

	set_creator_name (a_name: READABLE_STRING_GENERAL)
		do
			creator_name := a_name
		end

	set_attributes (a_attributes: detachable STRING_TABLE [ATTRIBUTE_I])
		do
			attributes := a_attributes
		end

	set_types (a_type_names: detachable STRING_TABLE [READABLE_STRING_32])
		do
			type_names := a_type_names
		end

	set_update_creator_list (v: like update_creator_list)
		do
			update_creator_list := v
		end

feature -- Access

	class_i: detachable CLASS_I
			-- The associated class

	creator_name: detachable READABLE_STRING_32

	attributes: detachable STRING_TABLE [ATTRIBUTE_I]

	type_names: detachable STRING_TABLE [READABLE_STRING_32]

	update_creator_list: BOOLEAN assign set_update_creator_list
			-- Update the list of creation procedures?

feature -- Main operation

	execute
			-- Execute the composer operation.
		local
			ctm: ES_CLASS_TEXT_AST_MODIFIER
			pos, epos: INTEGER
			l_creator_name: STRING_32
			l_creator_new: BOOLEAN
			create_tu: like create_insert_position
		do
			if attached class_i as l_class_i then
				create ctm.make (l_class_i)
				ctm.begin_batch_modifications (True)
				if ctm.is_prepared and then ctm.is_ast_available then
					l_creator_name := creator_name
					if l_creator_name = Void then
						l_creator_name := {STRING_32} "make"
					end
					if ctm.ast.feature_of_name_32 (l_creator_name, False) = Void then
						create_tu := create_insert_position (ctm)
						if attached feature_clause_position (ctm, "NONE", {FEATURE_CLAUSE_NAMES}.fc_Initialization, True) as tu then
							if tu.is_new then
								pos := tu.begin_position
							else
								pos := tu.end_position
							end
							epos := insert_creator (l_creator_name, ctm, pos)
							if update_creator_list then
								if create_tu /= Void then
									if not create_tu.exists then
										l_creator_new := True
										pos := create_tu.begin_position - 1
									elseif tu.is_new then
											-- Keep previous pos ...
										pos := pos - 1
									else
										pos := create_tu.end_position
									end
									insert_create_clause (l_creator_name, ctm, pos, l_creator_new)
								end
							end
							succeed := True
							succeed := True
						else
							report_error ({STRING_32} "Issue location the insertion position")
						end
					end
				end
				ctm.end_batch_modifications (True)
			end
		end

feature -- Helper / creator

	insert_create_clause (a_creator_name: READABLE_STRING_GENERAL; ctm: ES_CLASS_TEXT_AST_MODIFIER; insertion_position: INTEGER; is_new: BOOLEAN)
			-- Insert in `insertion_position' a new creation procedure.
		local
			s: STRING_32
		do
			create s.make (20)
			if is_new then
				s.append_string_general ("%Ncreate")
			else
				s.append_character (',')
			end
			s.append_character ('%N')
			s.append_character ('%T')
			s.append_string_general (a_creator_name)
			if is_new then
				s.append_character ('%N')
			end
			ctm.insert_code (insertion_position, s)
		end

	insert_creator (a_creator_name: READABLE_STRING_GENERAL; ctm: ES_CLASS_TEXT_AST_MODIFIER; insertion_position: INTEGER): INTEGER
			-- End position of the inserted at `insertion_position' of the new creation procedure.
		local
			s: STRING_32
			sig,
			comm,
			code, postcond: STRING_32
			att_name, arg_name: STRING_32
		do
			if attached attributes as attribs and then not attribs.is_empty then
				create sig.make (25)
				create comm.make (25)
				create code.make (100)
				create postcond.make (100)
				sig.append_character ('(')
				across
					attribs as ic
				loop
					if attached {ATTRIBUTE_I} ic.item as att then
						if sig [sig.count] /= '(' then
							sig.append ("; ")
						end
						att_name := att.feature_name_32
						arg_name := ic.key.to_string_32
						sig.append (arg_name)
						sig.append (": ")
						if
							attached type_names as l_type_names and then
							attached l_type_names [arg_name] as tn
						then
							sig.append (tn)
						else
							sig.append ("like ")
							sig.append (att_name)
						end
						if not comm.is_empty then
							comm.append (", ")
						end
						comm.append_character ('`')
						comm.append (arg_name)
						comm.append ("` for `")
						comm.append (att_name)
						comm.append_character ('`')

						code.append ("%N%T%T%T")
						code.append (att_name)
						code.append (" := ")
						code.append (arg_name)

						postcond.append ("%N%T%T%T")
						postcond.append (att_name)
						postcond.append ("_set: ")
						postcond.append (att_name)
						postcond.append (" = ")
						postcond.append (arg_name)
					end
				end
				sig.append_character (')')
			end
			create s.make (20)
			s.append_character ('%N')
			s.append_character ('%T')
			s.append_string_general (a_creator_name)
			if sig /= Void then
				s.append_character (' ')
				s.append (sig)
			end
			s.append_string_general ("%N%T%T%T-- Initialize")
			if comm /= Void then
				s.append_string_general (" with ")
				s.append (comm)
			end
			s.append_string_general (".%N%T%Tdo")
			if code /= Void then
				s.append (code)
			end
			if postcond /= Void then
				s.append_string_general ("%N%T%Tensure")
				s.append (postcond)
			end
			s.append_string_general ("%N%T%Tend%N")
			s.append_character ('%N')

			ctm.insert_code (insertion_position, s)
			Result := insertion_position + s.count
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
