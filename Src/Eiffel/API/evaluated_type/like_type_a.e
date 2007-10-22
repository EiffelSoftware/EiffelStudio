indexing
	description: "Representation of an anchored type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIKE_TYPE_A

inherit
	TYPE_A
		undefine
			instantiation_in, same_as
		redefine
			actual_type,
			conformance_type,
			convert_to,
			has_associated_class,
			has_like,
			instantiated_in,
			is_attached,
			is_basic,
			is_expanded,
			is_external,
			is_like,
			is_loose,
			is_none,
			is_reference,
			is_valid,
			meta_type,
			set_attached_mark
		end

feature -- Properties

	actual_type: TYPE_A
			-- Actual type of the anchored type in a given class

	conformance_type: TYPE_A is
			-- Type which is used to check conformance
		do
				-- `conformance_type' has to be called because
				-- `actual_type' may yield yet another anchored type.
			Result := actual_type.conformance_type
		end

	has_attached_mark: BOOLEAN is
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_attached_mark_mask /= 0
		end

	has_detachable_mark: BOOLEAN is
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_detachable_mark_mask /= 0
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then
				actual_type.has_associated_class
		end

	has_like: BOOLEAN is True
			-- Does the type have anchored type in its definition ?

	is_like: BOOLEAN is True
			-- Is the type anchored one ?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

	is_external: BOOLEAN is
			-- Is current type based on an external class?
		do
			Result := actual_type.is_external
		end

	is_reference: BOOLEAN is
			-- Is current actual type a reference one?
		do
			Result := actual_type.is_reference
		end

	is_expanded: BOOLEAN is
			-- Is current actual type an expanded one?
		do
			Result := actual_type.is_expanded
		end

	is_none: BOOLEAN is
			-- Is current actual type NONE?
		do
			Result := actual_type.is_none
		end

	is_valid: BOOLEAN is
			-- Is current type valid?
		do
			Result := actual_type /= Void
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		deferred
		end

	is_attached: BOOLEAN is
			-- Is type attached?
		do
			if has_attached_mark then
				Result := True
			elseif not has_detachable_mark then
				Result := conformance_type.is_attached
			end
		end

feature -- Access

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := actual_type.associated_class
		end

feature -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a
		end

	set_attached_mark is
			-- Mark type declaration as having an explicit attached mark.
		do
			attachment_bits := has_attached_mark_mask
		ensure then
			has_attached_mark
		end

	set_detachable_mark is
			-- Set class type declaration as having an explicit detachable mark.
		do
			attachment_bits := has_detachable_mark_mask
		ensure
			has_detachable_mark
		end

	instantiation_in (type: TYPE_A written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		deferred
		end

	instantiated_in (class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiated_in (class_type))
			Result := t
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does `actual_type' conform to `other'?
		do
			Result := actual_type.conform_to (other.conformance_type)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		do
			Result := actual_type.convert_to (a_context_class, a_target_type)
		end

	type_i: TYPE_I is
			-- Reduced type of `actual_type'
		local
			cl_type : CL_TYPE_I
		do
			Result := actual_type.type_i
			cl_type ?= Result

			if cl_type /= Void and then not cl_type.is_expanded then
					-- Remember that it's an anchored type, not needed
					-- when handling expanded types.
				cl_type.set_cr_info (create_info)
			end
		end

	meta_type: TYPE_I is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end

feature {NONE} -- Attachment properties

	attachment_bits: NATURAL_8
			-- Associated attachment flags

	has_detachable_mark_mask: NATURAL_8 is 1
			-- Mask in `attachment_bits' that tells whether the type has an explicit detachanble mark

	has_attached_mark_mask: NATURAL_8 is 2;
			-- Mask in `attachment_bits' that tells whether the type has an explicit attached mark

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end -- class LIKE_TYPE_A
