indexing
	description: "Look for expanded circuit through the expanded client rule."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXPANDED_CHECKER

inherit
	SHARED_WORKBENCH

	SHARED_ERROR_HANDLER

	COMPILER_EXPORTER

create
	make

feature {NONE} -- Initialization

	make is
			-- Create current instance
		do
			create id_set.make
			id_set.compare_objects
		end

feature -- Access

	current_type: CLASS_TYPE
			-- Current class type to check

	id_set: TWO_WAY_SORTED_SET [INTEGER]
			-- Set of class id

feature -- Settings

	set_current_type (t: like current_type) is
			-- Assign `t' to `current_type'.
		do
			current_type := t
		end

feature -- Checking

	check_expanded is
			-- Check `current_type'
		require
			current_type_exists: current_type /= Void
		do
			debug
				io.error.put_string ("Check expanded%N")
				io.error.put_string (current_type.associated_class.class_signature)
				io.error.put_new_line
			end
			recursive_check (current_type)
			id_set.wipe_out
			Error_handler.checksum
			current_type := Void
		end

	check_actual_type (a_type: TYPE_A) is
		require
			type_has_generics: a_type.has_generics
		do
			recursive_check_type (a_type.conformance_type)
			Error_handler.checksum
			id_set.wipe_out
		end

feature {NONE} -- Implementation

	recursive_check (class_type: CLASS_TYPE) is
		require
			good_argument: class_type /= Void
		local
			current_skeleton: SKELETON
			expanded_desc: EXPANDED_DESC
			client_type: CLASS_TYPE
			client: CLASS_C
			current_id: INTEGER
			vlec: VLEC
			finished: BOOLEAN
			attr_desc: ATTR_DESC
			stop_recursion: BOOLEAN
			position: INTEGER
			attr: ATTRIBUTE_I
		do
			current_id := class_type.associated_class.class_id
			stop_recursion := id_set.has (current_id)
			from
				current_skeleton := class_type.skeleton
				current_skeleton.go_expanded
			until
				current_skeleton.after or else finished
			loop
				attr_desc := current_skeleton.item
				if not attr_desc.is_expanded then
					finished := True
				else
					position := current_skeleton.position
					expanded_desc ?= attr_desc
					client_type := expanded_desc.class_type
					client := client_type.associated_class
					if System.il_generation then
							-- In IL code generation, static fields are handled as Eiffel
							-- attribute, but they do not follow the rule about cycles
							-- in expanded creation and therefore we should discard
							-- them from the test.
						attr ?= class_type.associated_class.feature_table.feature_of_rout_id
							(attr_desc.rout_id)
						check
							has_attribute: attr /= Void
						end
					end
					if
						client_type = current_type and then
						(not System.il_generation or else (attr.extension = Void or else
						attr.extension.type /= {SHARED_IL_CONSTANTS}.static_field_type))
					then
							-- Found expanded circuit
						create vlec
						vlec.set_class (current_type.associated_class)
						vlec.set_client (class_type.associated_class)
						Error_handler.insert_error (vlec)
					else
						id_set.put (current_id)
						if not stop_recursion then
							recursive_check (client_type)
						end
					end
					current_skeleton.go_to (position)
				end

				current_skeleton.forth
			end
		end

	recursive_check_type (a_type: TYPE_A) is
		local
			ass_c: CLASS_C
			generics: ARRAY [TYPE_A]
			i: INTEGER
			vlec: VLEC
		do
			if a_type.has_generics then
				if a_type.is_expanded then
					ass_c := a_type.associated_class
					if not id_set.has (ass_c.class_id) then
						if ass_c.is_expanded then
							id_set.put (ass_c.class_id)
						end
					else
						create vlec
						vlec.set_class (System.current_class)
						vlec.set_client (ass_c)
						Error_handler.insert_error (vlec)
					end
				end
				from
					generics := a_type.generics
					i := generics.lower
				until
					i > generics.upper
				loop
					recursive_check_type (generics.item (i))
					i := i + 1
				end
			end
		end

invariant
	id_set_not_void: id_set /= Void

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

end
