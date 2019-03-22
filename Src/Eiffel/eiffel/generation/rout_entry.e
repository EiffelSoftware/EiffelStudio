note
	description: "Representation for an routine entry in an instance of ROUT_TABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUT_ENTRY

inherit
	ATTR_ENTRY
		rename
			make as make_attr
		redefine
			 is_attribute,
			 is_deferred
		end

	SHARED_ID_TABLES
	SHARED_EXEC_TABLE
	SHARED_PATTERN_TABLE
	SHARED_GENERATION
	COMPILER_EXPORTER

create
	make

feature {NONE} -- Creation

	make
		(a_type: like type;
		a_type_id: like type_id;
		a_feature_id: like feature_id;
		a_is_deferred: like is_deferred;
		a_body_index: like body_index;
		a_pattern_id: like pattern_id;
		a_access_type_id: like access_type_id;
		a_access_in: like access_in;
		a_written_in: like written_in;
		a_is_class_deferred: BOOLEAN;
		a_class_id: like class_id)
			--	Initialize an object with the corresponding data.
		do
			make_attr (a_type, a_type_id, a_feature_id, a_is_deferred or a_is_class_deferred, a_class_id)
			is_deferred := a_is_deferred
			body_index := a_body_index
			pattern_id := a_pattern_id
			access_type_id := a_access_type_id
			access_in := a_access_in
			written_in := a_written_in
		ensure
			type = a_type
			type_id = a_type_id
			feature_id = a_feature_id
			is_deferred = a_is_deferred
			body_index = a_body_index
			pattern_id = a_pattern_id
			access_type_id = a_access_type_id
			access_in = a_access_in
			written_in = a_written_in
			is_polymorphic /= (a_is_deferred or a_is_class_deferred)
			class_id = a_class_id
		end

feature -- Access

	body_index: INTEGER
			-- Body index

	access_type_id: INTEGER
			-- Type id where the feature is accessed through its routine id.

	pattern_id: INTEGER
			-- Pattern id of the entry when `access_class_type' is not specified,
			-- otherwise the C pattern ID. The later is used for finalization.

	access_in: INTEGER
			-- Id of the class where the associated feature can be access through its routine id.

	written_in: INTEGER
			-- Id of the class where the associated feature of the
			-- unit is written in

	is_attribute: BOOLEAN
			-- Is the entry associated with an attribute?

	is_deferred: BOOLEAN
			-- Is the entry associated with a deferred routine?

feature -- Comparison

	same_as (other: ROUT_ENTRY): BOOLEAN
			-- Is `Current' similar to `other'?
		require
			other_not_void: other /= Void
		do
			Result := access_type_id = other.access_type_id and body_index = other.body_index
		end

feature -- Settings

	set_access_type_id (i: INTEGER)
			-- Assign `i' to `written_type_id'.
		do
			access_type_id := i
		end

	set_access_in (i: INTEGER)
			-- Assign `i' to `written_in'.
		do
			access_in := i
		end

	set_written_in (i: INTEGER)
			-- Assign `i' to `written_in'.
		do
			written_in := i
		end

	set_is_attribute
			-- Mark this entry an attribute.
		do
			is_attribute := True
		ensure
			is_attribute: is_attribute
		end

feature -- previously in ROUT_UNIT

	access_class: CLASS_C

			-- Class where the feature can be accessed through its routine ID.
		do
			Result := System.class_of_id (access_in)
		end

	written_class: CLASS_C
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in)
		end

feature -- Status report

	used: BOOLEAN
			-- Is the entry used?
		do
			if is_polymorphic then
				Result :=
						-- Check if dead code removal is in place.
					attached system.remover as r implies
						-- Check if the class is alive when dead code removal takes place.
					r.is_code_reachable (body_index) and then r.is_class_alive (class_id)
			end
		end

feature -- Access

	routine_name: STRING
			-- Routine name to generate.
			-- ASCII compatible.
		do
			Result := Encoder.feature_name (access_type_id, body_index)
		end

	access_class_type: CLASS_TYPE
		do
			Result := System.class_type_of_id (access_type_id)
		end

	real_body_index: INTEGER
			-- Real body index.
		do
			Result := Execution_table.real_body_index (body_index, access_class_type)
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
