note
	description: "A configuration target option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_TARGET_OPTION

inherit
	CONF_OPTION
		redefine
			copy,
			default_create,
			is_empty,
			make_6_3,
			make_16_11,
			make_19_05,
			merge
		end

create
	default_create,
	make_6_3,
	make_6_4,
	make_7_0,
	make_7_3,
	make_14_05,
	make_15_11,
	make_16_11,
	make_18_01,
	make_19_05,
	make_19_11,
	make_21_05

feature {NONE} -- Creation

	default_create
			-- <Precursor>
		do
			make_21_05
		end

	make_6_3
			-- <Precursor>
		do
			Precursor
			create concurrency.make (concurrency_name, concurrency_index_none)
			create array_override.make (array_override_name, array_override_index_default)
			create dead_code.make (dead_code_name, dead_code_index_feature)
			create void_safety_capability.make (void_safety)
			create catcall_safety_capability.make (catcall_detection)
			create concurrency_capability.make (concurrency)
		end

	make_16_11
			-- <Precursor>
			-- Difference from `make_15_11`: SCOOP for concurrency.
		do
			Precursor
			concurrency.put_default_index (concurrency_index_scoop)
		end

	make_19_05
			-- <Precursor>
			-- Difference from `make_18_01`: "all" for dead code removal.
		do
			Precursor
			dead_code.put_default_index (dead_code_index_all)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then
				not catcall_safety_capability.is_root_set and then
				not concurrency.is_set and then
				not array_override.is_set and then
				not dead_code.is_set and then
				not concurrency_capability.is_root_set and then
				not void_safety_capability.is_root_set
		end

	has_capability: BOOLEAN
			-- Are there explicitly set capabilities?
		do
			Result :=
				catcall_detection.is_set or else
				catcall_safety_capability.is_root_set or else
				concurrency.is_set or else
				concurrency_capability.is_root_set or else
				void_safety.is_set or else
				void_safety_capability.is_root_set
		end

feature -- Capability

	void_safety_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for void safety.

	catcall_safety_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for catcall safety.

	concurrency_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for concurrency.

feature -- Access: concurrency

	concurrency: CONF_VALUE_CHOICE
			-- Concurrency option.

	concurrency_index_thread: NATURAL_8 = 1
			-- Option index for thread-based concurrency.
			-- This is the lowest level, least restricted.

	concurrency_index_none: NATURAL_8 = 2
			-- Option index for no concurrency.

	concurrency_index_scoop: NATURAL_8 = 3
			-- Option index for SCOOP concurrency.
			-- This is the highest level, most restricted.

	is_concurrency_index (index: like {CONF_VALUE_CHOICE}.index): BOOLEAN
			-- Does `index` correspond to a valid concurrency index?
		do
			inspect index
			when
				concurrency_index_thread,
				concurrency_index_none,
				concurrency_index_scoop
			then
				Result := True
			else
					-- False by default.
			end
		ensure
			instance_free: class
			definition: Result =
				(index = concurrency_index_thread or index = concurrency_index_none or index = concurrency_index_scoop)
		end

	concurrency_mode_from_index (index: like {CONF_VALUE_CHOICE}.index): like {CONF_STATE}.concurrency
			-- Concurrency mode corresponding to concurrency index `index`.
		require
			is_concurrency_index (index)
		do
			inspect index
			when concurrency_index_none then Result := concurrency_none
			when concurrency_index_thread then Result := concurrency_multithreaded
			when concurrency_index_scoop then Result := concurrency_scoop
			end
		ensure
			instance_free: class
			definition:
				index = concurrency_index_none  and Result = concurrency_none or
				index = concurrency_index_thread and Result = concurrency_multithreaded or
				index = concurrency_index_scoop and Result = concurrency_scoop
		end

	concurrency_mode: like {CONF_STATE}.concurrency
			-- Concurrency mode corresponding to currently selected concurrency.
			-- See also:  `concurrency`.
		do
			Result := concurrency_mode_from_index (concurrency.index)
		end

feature -- Access: void safety

	is_void_safety_index (index: like {CONF_VALUE_CHOICE}.index): BOOLEAN
			-- Does `index` correspond to a valid void safety index?
		do
			inspect index
			when
				void_safety_index_none,
				void_safety_index_conformance,
				void_safety_index_initialization,
				void_safety_index_transitional,
				void_safety_index_all
			then
				Result := True
			else
					-- False by default.
			end
		ensure
			instance_free: class
			definition: Result =
				(index = void_safety_index_none or
				index = void_safety_index_conformance or
				index = void_safety_index_initialization or
				index = void_safety_index_transitional or
				index = void_safety_index_all)
		end

	void_safety_mode_from_index (index: like {CONF_VALUE_CHOICE}.index): like {CONF_STATE}.concurrency
			-- Void safety mode corresponding to void safety index `index`.
		require
			is_void_safety_index (index)
		do
			inspect index
			when void_safety_index_none then Result := void_safety_none
			when void_safety_index_conformance then Result := void_safety_conformance
			when void_safety_index_initialization then Result := void_safety_initialization
			when void_safety_index_transitional then Result := void_safety_transitional
			when void_safety_index_all then Result := void_safety_all
			end
		ensure
			instance_free: class
			definition:
				index = void_safety_index_none  and Result = void_safety_none or
				index = void_safety_index_conformance and Result = void_safety_conformance or
				index = void_safety_index_initialization and Result = void_safety_initialization or
				index = void_safety_index_transitional and Result = void_safety_transitional or
				index = void_safety_index_all and Result = void_safety_all
		end

	void_safety_mode: like {CONF_STATE}.void_safety
			-- Void safety mode corresponding to currently selected void safety level.
			-- See also:  `void_safety`.
		do
			Result := void_safety_mode_from_index (void_safety.index)
		end

feature -- Access: manifest array type checks

	array_override: CONF_VALUE_CHOICE
			-- Manifest artray type checks override.

	array_override_index_default: NATURAL_8 = 1
			-- Option index for no override.

	array_override_index_standard: NATURAL_8 = 2
			-- Option index for override with standard behavior.

	array_override_index_mismatch_warning: NATURAL_8 = 3
			-- Option index for override with mismatch warning.

	array_override_index_mismatch_error: NATURAL_8 = 4
			-- Option index for override with mismatch error.

feature -- Access: dead code removal

	dead_code: CONF_VALUE_CHOICE
			-- Manifest artray type checks override.

	dead_code_index_none: NATURAL_8 = 1
			-- Option index for no dead code removal.

	dead_code_index_feature: NATURAL_8 = 2
			-- Option index for feature-only dead code removal.

	dead_code_index_all: NATURAL_8 = 3
			-- Option index for feature and class dead code removal.

feature -- Merging

	merge (other: like Current)
			-- <Precursor>
		do
			Precursor (other)
				-- Merge concurency capability.
			concurrency_capability.set_safely (other.concurrency_capability)
				-- Merge CAT-call and void safety: only root settings need to be merged because capabilities are merged by precursor.
			catcall_safety_capability.set_safely_root (other.catcall_safety_capability)
			void_safety_capability.set_safely_root (other.void_safety_capability)
				-- Merge manifest array type and dead code removal settings.
			array_override.set_safely (other.array_override)
			dead_code.set_safely (other.dead_code)
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				Precursor (other)
					-- Duplicate options that are not included in {CONF_OPTION}.
					-- Take into account that they are
				array_override := array_override.twin
				concurrency := concurrency.twin
				dead_code := dead_code.twin
					-- Make copies of capabilities with appropriate values and update root values.
				create catcall_safety_capability.make (catcall_detection)
				catcall_safety_capability.put_root_index (other.catcall_safety_capability.custom_root_index)
				create concurrency_capability.make (concurrency)
				concurrency_capability.put_root_index (other.concurrency_capability.custom_root_index)
				create void_safety_capability.make (void_safety)
				void_safety_capability.put_root_index (other.void_safety_capability.custom_root_index)
			end
		end

feature {NONE} -- Access: concurrency

	concurrency_name: ARRAY [READABLE_STRING_32]
			-- Available values for `concurrency' option.
		once
			Result := <<
					{CONF_CONSTANTS}.concurrency_multithreaded_name.as_string_32,
					{CONF_CONSTANTS}.concurrency_none_name.as_string_32,
					{CONF_CONSTANTS}.concurrency_scoop_name.as_string_32
				>>
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access: manifest array type

	array_override_name: ARRAY [READABLE_STRING_32]
			-- Available values for `manifest_array_type` setting.
		once
			Result := <<
					{CONF_CONSTANTS}.sv_array_default,
					{CONF_CONSTANTS}.sv_array_standard,
					{CONF_CONSTANTS}.sv_array_mismatch_warning,
					{CONF_CONSTANTS}.sv_array_mismatch_error
				>>
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access: dead code removal

	dead_code_name: ARRAY [READABLE_STRING_32]
			-- Available values for "dead_code_removal" setting.
		once
			Result := <<
					{CONF_CONSTANTS}.sv_dead_code_none,
					{CONF_CONSTANTS}.sv_dead_code_feature,
					{CONF_CONSTANTS}.sv_dead_code_all
				>>
		ensure
			result_attached: Result /= Void
		end

invariant
	consistent_catcall_detection: catcall_safety_capability.value = catcall_detection
	consistent_concurrency: concurrency_capability.value = concurrency
	consistent_void_safety: void_safety_capability.value = void_safety

note
	ca_ignore: "CA093", "CA093: manifest array type mismatch"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
