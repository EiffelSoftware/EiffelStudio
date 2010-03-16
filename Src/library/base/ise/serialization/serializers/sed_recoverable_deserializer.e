note
	description: "[
		Decoding of arbitrary objects graphs between sessions of programs
		containing the same types or potentially different types (which can
		be mapped to the new type system via a correction mechanism,). It
		also basically takes care of potential reordering of attributes
		from one system to the other.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_RECOVERABLE_DESERIALIZER

inherit
	SED_INDEPENDENT_DESERIALIZER
		redefine
			make,
			read_header,
			read_attributes,
			clear_internal_data,
			decode_normal_object,
			decode_objects,
			has_version
		end

	MISMATCH_CORRECTOR

create
	make

feature {NONE} -- Initialization

	make (a_deserializer: SED_READER_WRITER)
		do
			Precursor (a_deserializer)
			create mismatches.make (0)
			create mismatched_object.make (0)
		end

feature {NONE} -- Implementation: access

	class_type_translator: detachable FUNCTION [ANY, TUPLE [STRING], STRING]
			-- Provide a mapping between a class type from the storable to a class type
			-- in the retrieving system.

	attribute_name_translator: detachable FUNCTION [ANY, TUPLE [STRING, INTEGER], STRING]
			-- Provide a mapping for an attribute name for a give type ID.

	is_conforming_mismatch_allowed: BOOLEAN
			-- Do we not trigger a mismatch when an attribute type in the stored system is
			-- different from the retrieving system but conforming?

	is_attribute_removal_allowed: BOOLEAN
			-- Do we not trigger a mismatch when an attribute has been removed?

	is_stopping_on_data_retrieval_error: BOOLEAN
			-- When retrieving objects, should we stop at the first occurrence of a mismatch?

	is_checking_data_consistency: BOOLEAN
			-- After retrieving objects, should we check that all objects are consistent?

feature -- Settings

	set_class_type_translator (a_translator: like class_type_translator)
			-- Set `class_type_translator' with `a_translator'.
		do
			class_type_translator := a_translator
		ensure
			class_type_translator_set: class_type_translator = a_translator
		end

	set_attribute_name_translator (a_translator: like attribute_name_translator)
			-- Set `attribute_name_translator' with `a_translator'.
		do
			attribute_name_translator := a_translator
		ensure
			attribute_name_translator_set: attribute_name_translator = a_translator
		end

	allow_conforming_mismatches
			-- Set `is_conforming_mismatch_allowed' to True.
		do
			is_conforming_mismatch_allowed := False
		ensure
			is_conforming_mismatch_allowed_set: is_conforming_mismatch_allowed
		end

	disallow_conforming_mismatches
			-- Set `is_conforming_mismatch_allowed' to False.
		do
			is_conforming_mismatch_allowed := False
		ensure
			is_conforming_mismatch_allowed_set: not is_conforming_mismatch_allowed
		end

	allow_attribute_removal
			-- Set `is_attribute_removal_allowed' to True.
		do
			is_attribute_removal_allowed := True
		ensure
			is_attribute_removal_allowed_set: is_attribute_removal_allowed
		end

	disallow_attribute_removal
			-- Set `is_attribute_removal_allowed' to False.
		do
			is_attribute_removal_allowed := False
		ensure
			is_attribute_removal_allowed_set: not is_attribute_removal_allowed
		end

	stop_on_data_retrieval_error
			-- Set `is_stopping_on_data_retrieval_error' to False.
		do
			is_stopping_on_data_retrieval_error := True
		ensure
			is_stopping_on_data_retrieval_error_set: is_stopping_on_data_retrieval_error
		end

	continue_on_data_retrieval_error
			-- Set `is_attribute_removal_allowed' to False.
		do
			is_stopping_on_data_retrieval_error := False
		ensure
			is_stopping_on_data_retrieval_error_set: not is_stopping_on_data_retrieval_error
		end

	set_is_checking_data_consistency (v: like is_checking_data_consistency)
			-- Set `is_checking_data_consistency' with `v'.
		do
			is_checking_data_consistency := v
		ensure
			is_checking_data_consistency_set: is_checking_data_consistency = v
		end

feature {NONE} -- Status report

	has_version: BOOLEAN
			-- Recoverable format needs to read the version from the storable.
		do
			Result := True
		end

	mismatches: HASH_TABLE [SED_TYPE_MISMATCH, INTEGER]
			-- Set of mismatches recorded during retrieval indexed by dynamic types.

	mismatched_object: ARRAYED_LIST [TUPLE [object: ANY; info: MISMATCH_INFORMATION]]
			-- List of all mismatched objects found during retrieval.

feature {NONE} -- Implementation

	read_header (a_count: NATURAL_32)
			-- Read header which contains mapping between dynamic type and their
			-- string representation.
		local
			i, nb: INTEGER
			l_deser: like deserializer
			l_int: like internal
			l_table: like dynamic_type_table
			l_old_dtype, l_new_dtype: INTEGER
			l_old_type_str, l_new_type_str: STRING
			l_old_version, l_new_version: detachable IMMUTABLE_STRING_8
		do
			l_int := internal
			l_deser := deserializer

			if has_version then
				version := l_deser.read_compressed_natural_32
				inspect version
				when {SED_VERSIONS}.recoverable_version_6_6 then

				else
						-- Unknown version read or not a independent/recoverable format.
					raise_fatal_error (error_factory.new_format_mismatch (version, {SED_VERSIONS}.session_version))
				end
			else
				version := 0
			end

				-- Number of dynamic types in storable
			nb := l_deser.read_compressed_natural_32.to_integer_32
			create l_table.make_filled (0, nb)
			create attributes_mapping.make_filled (Void, nb)

				-- Read table which will give us mapping between the old dynamic types
				-- and the new ones.
			from
				i := 0
			until
				i = nb
			loop
					-- Read old dynamic type
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32

					-- Read type string associated to `l_old_dtype' and find dynamic type
					-- in current system.
				l_old_type_str := l_deser.read_string_8
				if attached class_type_translator as l_translator then
					l_new_type_str := l_translator.item ([l_old_type_str])
				else
					l_new_type_str := l_old_type_str
				end
				l_new_dtype := l_int.dynamic_type_from_string (l_new_type_str)
				if l_new_dtype >= 0 then
					if not l_table.valid_index (l_old_dtype) then
						l_table := l_table.aliased_resized_area_with_default (0, (l_old_dtype + 1).max (l_table.count * 2))
					end
					l_table.put (l_new_dtype, l_old_dtype)
				else
						-- It is a fatal error, but we still continue to make sure
						-- we collect all errors.
					add_error (error_factory.new_missing_type_error (l_old_type_str, l_new_type_str))
				end

					-- Do we have a version to read?
				if l_deser.read_boolean then
					l_old_version := l_deser.read_immutable_string_8
				else
					l_old_version := Void
				end
				if l_new_dtype /= -1 then
					l_new_version := l_int.storable_version_of_type (l_new_dtype)
					if l_old_version /~ l_new_version then
							-- We record the mismatch for later when retrieving instances of `l_new_dtype'.
						associated_mismatch (l_new_dtype).add_version_mismatch (l_old_version, l_new_version)
					end
				end
				i := i + 1
			end

				-- Read table which will give us mapping between the old dynamic types
				-- and the new ones.
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
			until
				i = nb
			loop
					-- Read old dynamic type
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32

					-- Read type string associated to `l_old_dtype' and find dynamic type
					-- in current system.
				l_old_type_str := l_deser.read_string_8
				if attached class_type_translator as l_translator then
					l_new_type_str := l_translator.item ([l_old_type_str])
				else
					l_new_type_str := l_old_type_str
				end
				l_new_dtype := l_int.dynamic_type_from_string (l_new_type_str)
				if l_new_dtype >= 0 then
					if not l_table.valid_index (l_old_dtype) then
						l_table := l_table.aliased_resized_area_with_default (0, (l_old_dtype + 1).max (l_table.count * 2))
					end
					l_table.put (l_new_dtype, l_old_dtype)
				else
						-- It is a fatal error, but we still continue to make sure
						-- we collect all errors.
					add_error (error_factory.new_missing_type_error (l_old_type_str, l_new_type_str))
				end
				i := i + 1
			end

				-- Now set `dynamic_type_table' as all old dynamic type IDs have
				-- be read and resolved.
			dynamic_type_table := l_table

				-- Read attributes map for each dynamic type.
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
			until
				i = nb
			loop
					-- Read old dynamic type.
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32

					-- Read attributes description
				if l_table.valid_index (l_old_dtype) then
					read_attributes (l_table.item (l_old_dtype))
				else
					raise_fatal_error (error_factory.new_internal_error ("Cannot read attributes data"))
				end
				i := i + 1
			end

				-- Read object_table if any.
			read_object_table (a_count)
		end

	read_attributes (a_dtype: INTEGER)
			-- Read attribute description for `a_dtype' where `a_dtype' is a dynamic type
			-- from the current system.
		local
			l_deser: like deserializer
			l_int: like internal
			l_map: like attributes_map
			l_mapping: SPECIAL [INTEGER]
			l_old_name, l_new_name: STRING
			l_old_dtype, l_dtype: INTEGER
			i, nb, l_not_founds: INTEGER
			l_old_count, l_new_count: INTEGER
			a: like attributes_mapping
			l_attribute_type: INTEGER
		do
			l_deser := deserializer
			l_int := internal

				-- Compare count of attributes
			l_old_count := l_deser.read_compressed_natural_32.to_integer_32
			l_new_count := l_int.persistent_field_count_of_type (a_dtype)
			if l_old_count /= l_new_count then
					-- Stored type has a different number of attributes than the type
					-- from the retrieving system.
				associated_mismatch (a_dtype).add_attribute_count_mismatch (l_old_count, l_new_count)
			end

			from
				i := 1
				l_map := attributes_map (a_dtype)
				nb := l_old_count + 1
				create l_mapping.make_empty (nb)
				l_mapping.extend (0)
			until
				i = nb
			loop
					-- Read attribute static type
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32
				l_dtype := new_dynamic_type_id (l_old_dtype)
					-- Read attribute name
				l_old_name := l_deser.read_string_8
				if attached attribute_name_translator as l_translator then
					l_new_name := l_translator.item ([l_old_name, a_dtype])
				else
					l_new_name := l_old_name
				end

					-- If `l_dtype' is negatif then somehow the data we read is corrupted, we
					-- skip that attribute and record the mismatch and mark it as a fatal error.
				if l_dtype >= 0 then
					if attached l_map.item (l_new_name) as l_item then
						l_attribute_type := l_item.dtype
						if l_attribute_type /= l_dtype then
								-- Case #1: types are different but we allow retrieval if the old type conforms
								-- to the new one and taking into account attachment marks.
							if is_conforming_mismatch_allowed then
								if not l_int.type_conforms_to (l_dtype, l_attribute_type) then
										-- No conformance, let's check if it conforms to the detachable type to
										-- have an autofix mismatch. In either case the `l_mismatch' instance
										-- has to be created
									if l_int.is_attached_type (l_attribute_type) and then l_int.type_conforms_to (l_dtype, l_int.detachable_type (l_attribute_type)) then
											-- We do, we do not trigger a mismatch but we let the system know
											-- that upon retrieval if the retrieved attribute is Void, we will
											-- trigger a correct mismatch.
										associated_mismatch (a_dtype).add_void_safe_mismatch (l_dtype, l_attribute_type, l_old_name, l_new_name, i, l_item.position)
									else
										associated_mismatch (a_dtype).add_attribute_mismatch (l_dtype, l_attribute_type, l_old_name, l_new_name, i, l_item.position)
									end
								end
							else
									-- Case #2: types are different but we only accept it if they only differ
									-- by their attachment mark.
								if l_int.is_attached_type (l_attribute_type) then
									if l_int.detachable_type (l_attribute_type) = l_dtype then
											-- We do, we do not trigger a mismatch but we let the system know
											-- that upon retrieval if the retrieved attribute is Void, we will
											-- trigger a correct mismatch.
										associated_mismatch (a_dtype).add_void_safe_mismatch (l_dtype, l_attribute_type, l_old_name, l_new_name, i, l_item.position)
									else
										associated_mismatch (a_dtype).add_attribute_mismatch (l_dtype, l_attribute_type, l_old_name, l_new_name, i, l_item.position)
									end
								else
									if l_int.is_attached_type (l_dtype) and then l_int.detachable_type (l_dtype) = l_attribute_type then
											-- Nothing to do, old attribute type was attached while the
											-- new one is not.
									else
										associated_mismatch (a_dtype).add_attribute_mismatch (l_dtype, l_attribute_type, l_old_name, l_new_name, i, l_item.position)
									end
								end
							end
						end
							--- Regardless of the mismatch status, we record the mapping.
						l_mapping.extend (l_item.position)
					else
						l_not_founds := l_not_founds + 1
						if not is_attribute_removal_allowed then
							associated_mismatch (a_dtype).add_removed_attribute (l_dtype, l_old_name, l_new_name, i)
						end
					end
				else
					add_error (error_factory.new_unknown_attribute_type_error (a_dtype, l_new_name))
				end
				i := i + 1
			end
				-- Check if some attributes have been added.
			if l_old_count - l_not_founds < l_new_count then
				associated_mismatch (a_dtype).add_new_attribute_mismatch (l_new_count - (l_old_count - l_not_founds))
			end
			check attached attributes_mapping as l_a then
				if not l_a.valid_index (a_dtype) then
					a := l_a.aliased_resized_area_with_default (Void, (a_dtype + 1).max (l_a.count * 2))
					attributes_mapping := a
				else
					a := l_a
				end
				a.put (l_mapping, a_dtype)
			end
		end

	associated_mismatch (a_dtype: INTEGER): SED_TYPE_MISMATCH
			-- Associated mismatch for `a_dtype'.
		require
			a_dtype_non_negative: a_dtype >= 0
		do
			if attached mismatches.item (a_dtype) as l_mis then
				check valid_mismatch: l_mis.type_id = a_dtype end
				Result := l_mis
			else
				create Result.make (a_dtype)
				mismatches.put (Result, a_dtype)
			end
		end

	has_mismatch (a_dtype: INTEGER): BOOLEAN
			-- Is there a mismatch triggered for `a_dtype'?
		require
			a_dtype_non_negative: a_dtype >= 0
		do
			Result := mismatches.has (a_dtype)
		end

	decode_objects (a_count: NATURAL_32)
			-- <Precursor>
		local
			i, nb: INTEGER
		do
				-- Perform retrieval
			Precursor (a_count)

				-- Let's fix mismatches
			from
				mismatched_object.start
			until
				mismatched_object.after
			loop
				safe_mismatch_correction (mismatched_object.item.object, mismatched_object.item.info)
				mismatched_object.forth
			end

				-- Let's verify the consistency of our objects.
			if is_checking_data_consistency then
				from
					i := 0
					nb := object_references.upper
				until
					i > nb
				loop
					if attached object_references.item (i) as l_obj then
						if not is_object_valid (l_obj, True) then
							add_error (error_factory.new_invalid_object_error (l_obj))
						end
					end
					i := i + 1
				end
			end
		end

	safe_mismatch_correction (an_obj: ANY; a_mismatch_information: MISMATCH_INFORMATION)
			-- Try to apply `{MISMATCH_CORRECTOR}.correct_mismatch' to `an_obj' using `a_mismatch_information'
			-- to solve the mismatch.
		local
			retried: BOOLEAN
			l_check, l_mismatch_called: BOOLEAN
		do
			if not retried then
				if attached {MISMATCH_CORRECTOR} an_obj as l_corrector then
					l_mismatch_called := True
					l_check := {ISE_RUNTIME}.check_assert (False)
					a_mismatch_information.put (internal.type_name (an_obj), {MISMATCH_INFORMATION}.type_name_key)
					mismatch_information.copy (a_mismatch_information)
					l_corrector.correct_mismatch
					l_check := {ISE_RUNTIME}.check_assert (l_check)
					if not is_object_valid (an_obj, False) then
						add_error (error_factory.new_invalid_object_error (an_obj))
					end
				else
					add_error (error_factory.new_object_mismatch_error (an_obj))
				end
			else
				if l_mismatch_called then
					l_check := {ISE_RUNTIME}.check_assert (l_check)
				end
				add_error (error_factory.new_object_mismatch_error (an_obj))
			end
		rescue
			retried := True
			retry
		end

	is_object_valid (an_obj: ANY; a_verify_invariant: BOOLEAN): BOOLEAN
			-- Is object content valid, i.e. are all attached attributes really attached?
		local
			l_int: INTERNAL
			l_dtype, i, nb: INTEGER
			retried: BOOLEAN
		do
			if not retried then
					-- Let's verify attachment status of our objects
				from
					l_int := internal
					l_dtype := l_int.dynamic_type (an_obj)
					i := 1
					nb := l_int.field_count_of_type (l_dtype)
					Result := True
				until
					i > nb or not Result
				loop
					Result := not l_int.is_attached_type (l_int.field_static_type_of_type (i, l_dtype)) or else l_int.field (i, an_obj) /= Void
					i := i + 1
				end
				if a_verify_invariant then
						-- Let's verify the invariant
					an_obj.do_nothing
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

	decode_normal_object (an_obj: ANY; a_dtype, an_index: INTEGER)
			-- <Precursor>
		local
			l_int: like internal
			l_deser: like deserializer
			i, nb: INTEGER
			l_new_offset: INTEGER
			l_mismatch_info: SED_TYPE_MISMATCH
			l_info: detachable MISMATCH_INFORMATION
			l_check_for_non_void: BOOLEAN
			l_has_mismatch: BOOLEAN
			l_field_info: detachable TUPLE [old_name, new_name: STRING; old_attribute_type, new_attribute_type, old_position, new_position: INTEGER; is_changed, is_removed, is_attachment_check_required: BOOLEAN]
		do
			if not has_mismatch (a_dtype) then
				Precursor (an_obj, a_dtype, an_index)
			else
				l_mismatch_info := associated_mismatch (a_dtype)
				if l_mismatch_info.has_version_mismatch then
					create l_info.make (l_mismatch_info.old_count)
					l_info.set_versions (l_mismatch_info.old_version, l_mismatch_info.new_version)
				end
				l_int := internal
				l_deser := deserializer
				from
					i := 1
					nb := read_persistent_field_count (a_dtype) + 1
				until
					i = nb
				loop
					l_field_info := l_mismatch_info.mismatches_by_stored_position.item (i)
					if l_field_info /= Void then
						l_check_for_non_void := l_field_info.is_attachment_check_required
						l_has_mismatch := l_field_info.is_changed or (not is_attribute_removal_allowed and then l_field_info.is_removed)
						if not l_has_mismatch then
							l_field_info := Void
						elseif l_info = Void then
							create l_info.make (l_mismatch_info.old_count)
						end
					else
						l_check_for_non_void := False
						l_has_mismatch := False
					end
					if l_field_info = Void then
						l_new_offset := new_attribute_offset (a_dtype, i)
						inspect l_int.field_type_of_type (l_new_offset, a_dtype)
						when {INTERNAL}.boolean_type then
							l_int.set_boolean_field (l_new_offset, an_obj, l_deser.read_boolean)

						when {INTERNAL}.character_8_type then
							l_int.set_character_8_field (l_new_offset, an_obj, l_deser.read_character_8)
						when {INTERNAL}.character_32_type then
							l_int.set_character_32_field (l_new_offset, an_obj, l_deser.read_character_32)

						when {INTERNAL}.natural_8_type then
							l_int.set_natural_8_field (l_new_offset, an_obj, l_deser.read_natural_8)
						when {INTERNAL}.natural_16_type then
							l_int.set_natural_16_field (l_new_offset, an_obj, l_deser.read_natural_16)
						when {INTERNAL}.natural_32_type then
							l_int.set_natural_32_field (l_new_offset, an_obj, l_deser.read_natural_32)
						when {INTERNAL}.natural_64_type then
							l_int.set_natural_64_field (l_new_offset, an_obj, l_deser.read_natural_64)

						when {INTERNAL}.integer_8_type then
							l_int.set_integer_8_field (l_new_offset, an_obj, l_deser.read_integer_8)
						when {INTERNAL}.integer_16_type then
							l_int.set_integer_16_field (l_new_offset, an_obj, l_deser.read_integer_16)
						when {INTERNAL}.integer_32_type then
							l_int.set_integer_32_field (l_new_offset, an_obj, l_deser.read_integer_32)
						when {INTERNAL}.integer_64_type then
							l_int.set_integer_64_field (l_new_offset, an_obj, l_deser.read_integer_64)

						when {INTERNAL}.real_32_type then
							l_int.set_real_32_field (l_new_offset, an_obj, l_deser.read_real_32)
						when {INTERNAL}.real_64_type then
							l_int.set_real_64_field (l_new_offset, an_obj, l_deser.read_real_64)

						when {INTERNAL}.pointer_type then
							l_int.set_pointer_field (l_new_offset, an_obj, l_deser.read_pointer)

						when {INTERNAL}.reference_type then
							decode_reference (an_obj, an_index, l_new_offset)
								-- We check now that for an attached attribute, we have indeed retrieved a non-void
								-- attribute, otherwise we will generate a mismatch.
							if l_check_for_non_void and then l_int.field (l_new_offset, an_obj) = Void then
								if l_info = Void then
									create l_info.make (l_mismatch_info.old_count)
								end
								l_info.put (Void, l_int.field_name_of_type (l_new_offset, a_dtype))
							end
						else
							check
								False
							end
						end
					else
							-- We are having a mismatch, so here we are going to record the info in `l_info'.
						if l_info = Void then
							create l_info.make (l_mismatch_info.old_count)
						end
						inspect abstract_type (l_field_info.old_attribute_type)
						when {INTERNAL}.boolean_type then l_info.put (l_deser.read_boolean, l_field_info.new_name)
						when {INTERNAL}.character_8_type then l_info.put (l_deser.read_character_8, l_field_info.new_name)
						when {INTERNAL}.character_32_type then l_info.put (l_deser.read_character_32, l_field_info.new_name)

						when {INTERNAL}.natural_8_type then l_info.put (l_deser.read_natural_8, l_field_info.new_name)
						when {INTERNAL}.natural_16_type then l_info.put (l_deser.read_natural_16, l_field_info.new_name)
						when {INTERNAL}.natural_32_type then l_info.put (l_deser.read_natural_32, l_field_info.new_name)
						when {INTERNAL}.natural_64_type then l_info.put (l_deser.read_natural_64, l_field_info.new_name)

						when {INTERNAL}.integer_8_type then l_info.put (l_deser.read_integer_8, l_field_info.new_name)
						when {INTERNAL}.integer_16_type then l_info.put (l_deser.read_integer_16, l_field_info.new_name)
						when {INTERNAL}.integer_32_type then l_info.put (l_deser.read_integer_32, l_field_info.new_name)
						when {INTERNAL}.integer_64_type then l_info.put (l_deser.read_integer_64, l_field_info.new_name)

						when {INTERNAL}.real_32_type then l_info.put (l_deser.read_real_32, l_field_info.new_name)
						when {INTERNAL}.real_64_type then l_info.put (l_deser.read_real_64, l_field_info.new_name)

						when {INTERNAL}.pointer_type then l_info.put (l_deser.read_pointer, l_field_info.new_name)

						when {INTERNAL}.reference_type then l_info.put (read_reference, l_field_info.new_name)
						else
							check
								False
							end
						end
					end
					i := i + 1
				end
			end
			if l_info /= Void then
					-- There was a mismatch, we store it for later when trying
					-- to correct mismatches.
				mismatched_object.extend ([an_obj, l_info])
			end
		end

	read_reference: detachable ANY
			-- Read reference.
		local
			l_nat32: NATURAL_32
		do
			l_nat32 := deserializer.read_compressed_natural_32
			check
				l_nat32_valid: l_nat32 < {INTEGER}.max_value.as_natural_32
			end
			Result := object_references.item (l_nat32.to_integer_32)
		end


feature {NONE} -- Cleaning

	clear_internal_data
			-- <Precursor>
		do
			Precursor {SED_INDEPENDENT_DESERIALIZER}
			mismatches.wipe_out
			mismatched_object.wipe_out
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
