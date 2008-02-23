indexing
	description: "[
		Encapsulates a renaming of features together with a type.
		
		It is called renamed type because it carries extensions with it.
		The most prominent case where we use an instance of this class is the following:
		G -> {A rename f as f_of_a end, B rename f as f_of_b end}
		`A' together with its rename clause corresponds to one instance of this class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RENAMED_TYPE_A [G -> TYPE_A]

inherit
	COMPILER_EXPORTER

	TYPE_A
		redefine
			renaming, is_renamed_type, has_renaming, instantiated_in,
			instantiation_in, has_associated_class,
			to_type_set, conformance_type, actual_type
		end

create
	make

feature -- Initialization

	make (a_type: like type; a_renaming: like renaming) is
			-- Initialize
		require
			a_type_not_void: a_type /= Void
			a_type_is_not_a_type_set: not a_type.is_type_set
			a_type_is_not_renamed: not a_type.is_renamed_type
		do
			type := a_type
			renaming := a_renaming
		ensure
			type_set: a_type = type
			renaming_set: renaming = a_renaming
		end

feature -- Access

	hash_code: INTEGER is
		do
			Result := type.hash_code
		end

	actual_type, conformance_type: G
			-- Type to which the renaming `renaming' is applied. Can be used for conformance checks.
		do
			Result := type
		end

	type: G
			-- Type to which the renaming `renaming' is applied.

	renaming: RENAMING_A
			-- Renaming of features of type `type'.

feature {COMPILER_EXPORTER} -- Access

	associated_class: CLASS_C is
			-- Class associated to the current type.		
		do
			Result := type.associated_class
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' ?		
		do
			Result := type.conform_to (other)
		end

	--| Martins 1/23/07: instantiation*
	--| Should we return RENAMED_TYPE_A [TYPE_A]?
	--| Currently there seems no need for it and it might most likeley introduce bugs.

	instantiated_in (a_class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := type.instantiated_in (a_class_type)
		end

	instantiation_in (a_type: TYPE_A; a_written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the class of id `written_id'.
		do
			Result := type.instantiation_in (a_type, a_written_id)
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		do
			Result := type.create_info
		end

feature -- Conversion

	to_type_set: TYPE_SET_A
			-- Create a type set containing one element which is `Current'.
		do
			create Result.make (1)
			Result.extend (Current)
		end

feature -- Setters

	set_type (a_type: G)
			-- Set `type' to `a_type'
		require
			a_type_not_void: a_type /= Void
			a_type_is_not_a_type_set: not a_type.is_type_set
			a_type_is_not_renamed: not a_type.is_renamed_type
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_renaming (a_renaming: RENAMING_A) is
			-- Set `renaming' to `a_renaming'
		do
			renaming := a_renaming
		ensure
			renaming_set: renaming = a_renaming
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := type.is_equivalent (other.type)
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_renamed_type_a (Current)
		end

feature -- Status

	has_associated_class: BOOLEAN
			-- Does current type have an associated class?
		do
			Result := type.has_associated_class
		end

	has_renaming: BOOLEAN is
			-- Does current type have renamed features?
			-- This can occur in code like: "G -> A rename a as b end"
		do
			Result := renaming /= Void and then not renaming.is_empty
		end

	is_renamed_type: BOOLEAN is True
		-- Is current an instance of RENAMED_TYPE_A [TYPE_A]?
		-- An renamed type has the ability to carry a feature renaming.

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C) is
			-- Append `Current' to `text'.
			-- `f' is used to retreive the generic type or argument name as string.
			-- This replaces the old "G#2" or "arg#1" texts in feature signature views.
			-- Actually used in FORMAL_A and LIKE_ARGUMENT.		
		do
			type.ext_append_to (a_text_formatter, c)
			if has_renaming then
				if has_associated_class then
					renaming.append_to_with_pebbles (a_text_formatter, associated_class)
				else
					renaming.append_to (a_text_formatter)
				end

			end

		end

	dump: STRING is
			-- Dumped trace
		do
			Result := type.dump
			if has_renaming then
				Result.append (" ")
				Result.append (renaming.dump)
			end
		end

invariant
	type_not_void: type /= Void
	type_is_not_a_type_set: not type.is_type_set
	no_nested_renamed_types: not type.is_renamed_type

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

end -- class RENAMED_TYPE_A [TYPE_A]
