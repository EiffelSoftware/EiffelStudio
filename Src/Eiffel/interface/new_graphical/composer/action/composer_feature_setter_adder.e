note
	description: "Add setter for a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOSER_FEATURE_SETTER_ADDER

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

	feature_set: BOOLEAN
			-- Has the the feature to process been set?
		do
			Result := feature_i /= Void
		end

feature -- Element change

	set_feature (a_feature: FEATURE_I)
			-- The feature that get's processed
		require
			a_feature_not_void: a_feature /= Void
		local
			sn: STRING_32
		do
			feature_i := a_feature
		ensure
			feature_set_correct: feature_set and feature_i = a_feature
		end

	set_setter_name (v: like setter_name)
		do
			setter_name := v
		end

	set_postconditions (v: BOOLEAN)
		do
			postconditions_included := v
		end

	set_preconditions (v: BOOLEAN)
		do
			preconditions_included := v
		end

feature -- Access

	feature_i: detachable FEATURE_I;
			-- The associated feature

	setter_name: detachable READABLE_STRING_32

	preconditions_included: BOOLEAN assign set_preconditions

	postconditions_included: BOOLEAN assign set_postconditions

feature -- Main operation

	execute
			-- Execute the composer operation.
		local
			ctm: ES_CLASS_TEXT_AST_MODIFIER
			pos: INTEGER
			l_setter_name: STRING_32
		do
				-- Only for attribute!
			if
				attached {ATTRIBUTE_I} feature_i as fi and then
				attached fi.written_class.original_class as l_class_i
			then
					-- FIXME: check first if setter does not already exists!
				create ctm.make (l_class_i)
				ctm.begin_batch_modifications (True)
				if ctm.is_prepared and then ctm.is_ast_available then
					l_setter_name := setter_name
					if l_setter_name = Void then
						l_setter_name := {STRING_32} "set_" + fi.feature_name_32
						setter_name := l_setter_name
					end
					if
						attached ctm.ast.feature_of_name_32 (fi.feature_name_32, False) as l_feature_as and then
						ctm.ast.feature_of_name_32 (l_setter_name, False) = Void
					then
						if attached feature_clause_position (ctm, "ANY", {FEATURE_CLAUSE_NAMES}.fc_Element_change, True) as tu then
							if tu.is_new then
								pos := tu.begin_position
							else
								pos := tu.end_position
							end
							insert_setter (l_setter_name, ctm, pos)

							if l_feature_as.body.assigner = Void then
								insert_assigner (l_setter_name, ctm, l_feature_as.body.type.end_position + 1)
							end

							succeed := True
						end
					else
						report_error ({STRING_32} "Feature %""+ l_setter_name + {STRING_32} "%" already exists")
					end
				end
				ctm.end_batch_modifications (True)
			end
		end

feature -- Helper

	insert_setter (a_setter_name: READABLE_STRING_32; ctm: ES_CLASS_TEXT_AST_MODIFIER; insertion_position: INTEGER)
			-- Insert in `insertion_position' a new setter.
		local
			s: STRING_32
			fn, argn: STRING_32
		do
			fn := feature_i.feature_name_32
			argn := "v"
			if
				fn.is_case_insensitive_equal_general (argn)
				or else attached ctm.ast as class_as and then class_as.feature_of_name_32 (argn, False) /= Void
			then
				argn := {STRING_32} "a_" + fn
			end
			create s.make (20)
			s.append_character ('%N')
				-- WARNING: do no remove first indentation
			s.append_string_general ("%T#SETTERNAME# (#ARGNAME#: like #NAME#)%N%T%T%T-- Assign `#NAME#` with `#ARGNAME#`.%N")
			if preconditions_included then
				s.append_string_general ("%T%Trequire%N%T%T%Tvalid_#ARGNAME#: True -- Please adjust%N")
			end
			s.append_string_general ("%T%Tdo%N%T%T%T#NAME# := #ARGNAME#%N")
			if postconditions_included then
				s.append_string_general ("%T%Tensure%N%T%T%T#NAME#_assigned: #NAME# = #ARGNAME#%N")
			end
			s.append_string_general ("%T%Tend%N")
			s.append_character ('%N')
			s.replace_substring_all ({STRING_32} "#SETTERNAME#", a_setter_name)
			s.replace_substring_all ({STRING_32} "#NAME#", fn)
			s.replace_substring_all ({STRING_32} "#ARGNAME#", argn)

			ctm.insert_code (insertion_position, s)
		end

	insert_assigner (a_setter_name: READABLE_STRING_32; ctm: ES_CLASS_TEXT_AST_MODIFIER; insertion_position: INTEGER)
		local
			s: STRING_32
		do
			create s.make_from_string_general (" assign ")
			s.append (a_setter_name)
			ctm.insert_code (insertion_position, s)
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
