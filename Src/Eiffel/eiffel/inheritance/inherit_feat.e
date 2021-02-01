note
	description: "[
		Class for analysis of instances of FEATURE_I inherited under the
		same final name. Those features are divided into the sublists:
		the deferred features and the non-deferred features.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class INHERIT_FEAT

inherit

	SHARED_INHERITED
		undefine
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	SHARED_SERVER
		undefine
			is_equal
		end

	SHARED_ERROR_HANDLER
		undefine
			is_equal
		end

	SHARED_EXPORT_STATUS
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	COMPARABLE

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_ORIGIN_TABLE
		export
			{NONE} all
		undefine
			is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			is_equal
		end

	SHARED_DEGREES
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Creation

	make
			-- Lists creation
		do
			create features.make (1)
			create rout_id_set.make
		end

feature -- Status report

	has_deferred: BOOLEAN
			-- Are there deferred features?
		do
			Result := attached deferred_features_internal as d and then not d.is_empty
		end

feature

	deferred_features: ARRAYED_LIST [INHERIT_INFO]
			-- List of deferred inherited features informations
		do
			Result := deferred_features_internal
			if Result = Void then
				create Result.make (1)
				deferred_features_internal := Result
			end
		end

	deferred_features_internal: detachable like deferred_features
		note
			option: stable
		attribute
		end

	features: ARRAYED_LIST [INHERIT_INFO]
			-- List of informations on non-deferred inherited features

	inherited_info: INHERIT_INFO
			-- Feature inherited chosen among the deferred features and
			-- the non-deferred.  If a redefinition is expected, this
			-- attribute will be Void after feature `process'.

	rout_id_set: ROUT_ID_SET
			-- Set of routine ids computed for the inherited feature

--| FIXME IEK: The following two features are currently unused.
	has_assertion: BOOLEAN
			-- Do deferred_features or features have assertions?
			-- (for Merging)
		do
			Result := check_assertion (deferred_features) or else
						check_assertion (features)
		end

	check_assertion (list: like features): BOOLEAN
			-- Check to see if list has assertion
			-- (for merging)
		do
			from
				list.start
			until
				list.after or Result
			loop
				Result := list.item.inherited_assertion;
				list.forth
			end
		end

	reset
			-- Clear the structure
		do
			deferred_features.wipe_out
			features.wipe_out
			inherited_info := Void
			rout_id_set.wipe_out
		end

	set_inherited_info (f: INHERIT_INFO)
			-- Assign `f' to `inherited_info'.
		do
			inherited_info := f
		end

	is_empty: BOOLEAN
			-- Are the feature info lists empty ?
		do
			Result := features.is_empty and then not has_deferred
		end

	insert (info: INHERIT_INFO)
			-- Insert `info' in one of the two lists.
		require
			info_not_void: info /= Void
			a_feature_set: info.internal_a_feature /= Void
		do
				-- The position of the list of features must not change
				-- as `treat_renamings' may call it.
			if not info.internal_a_feature.is_deferred then
				features.extend (info)
			else
				deferred_features.extend (info)
			end
		end

	process (cl: CLASS_C; feature_name_id: INTEGER; a_check_undefinition, a_check_redefinition: BOOLEAN)
			-- Process the features inherited under the same final name
		require
			inherited_info = Void
		do
			if a_check_undefinition then
					-- If no parents have an undefine clause then we
					-- do not need to check for undefinition.
				process_undefinition (cl, feature_name_id)
			end
			if deferred_features.count > 0 then
					-- Update `rout_id_set'.
				rout_id_set.update (deferred_features)
			end
			if features.count > 0 then
				process_features (cl, feature_name_id, a_check_redefinition)
			end
		end

	process_undefinition (cl: CLASS_C; feature_name_id: INTEGER)
			-- Process possible undefinitions
		require
			cl_not_void: cl /= Void
			positive_feature_name_id: feature_name_id > 0
		local
			info, new_info: INHERIT_INFO
			a_feature: FEATURE_I
			vdus2: VDUS2
			vdus3: VDUS3
		do
			if has_deferred then
					-- Check unvalid undefinitions of deferred features.
				across
					deferred_features as d
				loop
					info := d.item
					if info.parent.is_undefining (feature_name_id) then
						create vdus3
						vdus3.set_class (System.current_class)
						vdus3.set_parent (info.parent.parent)
						vdus3.set_a_feature (info.a_feature)
						Error_handler.insert_error (vdus3)
					end
				end
			end
			from
				features.start
			until
				features.after
			loop
				info := features.item
				if info.parent.is_undefining (feature_name_id) then
					a_feature := info.internal_a_feature
					if not a_feature.undefinable then
						create vdus2
						vdus2.set_class (System.current_class)
						vdus2.set_parent (info.parent.parent)
						vdus2.set_a_feature (info.a_feature)
						Error_handler.insert_error (vdus2)
						features.forth
					else
						if info.a_feature_needs_instantiation then
							info.delayed_instantiate_a_feature
							a_feature := info.internal_a_feature
						end
							-- We initially set parent as Void in 'new_inherit_info' as `new_deferred' is instantiated.
						new_info := inherit_info_cache.new_inherited_info (a_feature.new_deferred, Void, Void)
						new_info.set_parent (info.parent)
						if a_feature.is_type_evaluation_delayed then
								-- Since type evaluation is delayed, the new deferred feature has to be updated with type information later.
							degree_4.put_action (
								agent (destination, source: FEATURE_I)
									do
										destination.set_type (source.type, destination.assigner_name_id)
										destination.set_arguments (source.arguments)
										destination.set_pattern_id (source.pattern_id)
									end
								(new_info.internal_a_feature, a_feature)
							)
						end
						insert (new_info)
						features.remove
					end
				else
					features.forth
				end
			end
		end

	check_deferred (cl: CLASS_C)
			-- Process the deferred features
		require
			deferred_features.count > 0
		do
				-- Update `rout_id_set'.
			rout_id_set.update (deferred_features)
		end

	process_features (cl: CLASS_C; feature_name_id: INTEGER; a_check_redefinition: BOOLEAN)
			-- Process the non-deferred inherited features.
		require
			features /= Void;
			features.count > 0;
		local
			vmfn2: VMFN2;
			l_exit_loop: BOOLEAN
		do
			if a_check_redefinition and then features_all_redefined (feature_name_id) then
					-- To be redefined later
					-- Update `rout_id_set'
				rout_id_set.update (features);
			elseif features_all_the_same then
					-- Shared features from the same parent.
				if
					features.count > 1 and then
					features.first.internal_a_feature.can_be_encapsulated and then
					attached {ENCAPSULATED_I} features.first.internal_a_feature as encapsulated_i and then
					encapsulated_i.generate_in = 0
				then
					from
							-- Go to the second item as the first has already been checked.
						features.start
						features.forth
					until
						features.after or else l_exit_loop
					loop
						if
							attached {ENCAPSULATED_I} features.item.internal_a_feature as l_item_encapsulated_i and then
							l_item_encapsulated_i.generate_in /= 0
						then
							inherited_info := features.item
							l_exit_loop := True
						end
						features.forth
					end
				end
				if inherited_info = Void then
					inherited_info := features.first
				end
					-- Add the selected inherited info's routine id to the set.
				rout_id_set.update (features)
			else
					-- Name clash
				create vmfn2;
				vmfn2.set_class (System.current_class);
				vmfn2.set_features (features);
				Error_handler.insert_error (vmfn2);
			end;
		end;

	features_all_redefined (feature_name_id: INTEGER): BOOLEAN
			-- Are all the non-deferred inherited features redefined?
		require
			features.count > 0
		local
			vdrs2: VDRS2;
		do
			from
				Result := True;
				features.start;
			until
				features.after or else not Result
			loop
				Result := features.item.parent.is_redefining (feature_name_id)
				if Result and then not features.item.internal_a_feature.redefinable then
						-- Cannot redefine frozen feature, constant or once
					create vdrs2;
					vdrs2.set_class (System.current_class);
					vdrs2.set_feature_name (names_heap.item (feature_name_id));
					vdrs2.set_parent (features.item.parent.parent);
					Error_handler.insert_error (vdrs2);
				end;
				features.forth;
			end
		end;

	features_all_the_same: BOOLEAN
			-- Are all the non-deferred features all the same ?
		require
			good_context: features.count > 0;
		local
			body_id: INTEGER
			written_id: INTEGER
			first_feature: FEATURE_I
			current_feature: FEATURE_I
			written_class: CLASS_C
			to_compare, written_actual_type: TYPE_A
		do
				-- First condition for sharing feature: same body id
			Result := True
			if features.count > 1 then
				from
					first_feature := features.first.internal_a_feature
					body_id := first_feature.code_id
					features.start
					features.forth
				until
					features.after or else not Result
				loop
					current_feature := features.item.internal_a_feature
					Result := body_id = current_feature.code_id
						-- Check that aliases are the same
					if not first_feature.is_same_alias (current_feature) then
						error_handler.insert_error (create {VMFN2_NEW}.make (system.current_class, first_feature, current_feature))
					end
					features.forth
				end
					-- Second condition: if the feature is written in a
					-- generic class, check if there is no generic derivation
				if Result then
					written_class := first_feature.written_class
					if written_class.generics /= Void then
							-- The class where the feature is written is a
							-- generic class
							-- Check if instantation has an effect.
						if features.first.a_feature_needs_instantiation then
							features.first.delayed_instantiate_a_feature
						end
						if features.first.a_feature_instantiated_for_feature_table then
								-- Instantiation has an effect so we need to check all of the features to make sure they are equivalent
							from
								written_actual_type := written_class.actual_type
								written_id := written_class.class_id
								to_compare := written_actual_type.instantiation_in (features.first.parent.parent_type, written_id)
									-- Go to the second item in 'features'

								features.start
								features.forth
							until
								features.after or else not Result
							loop
									-- Same instantiated parent type for
									-- sharing feature
								Result := to_compare.is_safe_equivalent (
									written_actual_type.instantiation_in (features.item.parent.parent_type, written_id)
								)
								features.forth
							end
						end
					end
				end
			end
		end

	all_attributes: BOOLEAN
			-- Are all the inherited features non-deferred attributes ?
		do
			if not has_deferred then
				from
					Result := True
					features.start
				until
					features.after or else not Result
				loop
					Result := features.item.internal_a_feature.is_attribute
					features.forth
				end
			end
		end

	exports (feature_name_id: INTEGER): EXPORT_I
			-- Concatenation of all the export statuses of the inherited
			-- features (`feature_name_id' is the renamed name...)
		require
			not_empty: not is_empty
			positive_feature_name_id: feature_name_id > 0
		local
			info: INHERIT_INFO
		do
				-- Default value: no export at all.
			Result := Export_none
			from
				features.start
			until
				features.after or else Result.is_all
			loop
				info := features.item
					-- Add adapted export status.
				Result := Result.concatenation (info.parent.new_export_for (feature_name_id,  info.internal_a_feature.export_status))
				features.forth
			end
			from
				deferred_features.start
			until
				deferred_features.after or else Result.is_all
			loop
				info := deferred_features.item
					-- Add adapted export status.
				Result := Result.concatenation (info.parent.new_export_for (feature_name_id,  info.internal_a_feature.export_status))
				deferred_features.forth
			end
		end

feature -- Debug

	trace
		do
			io.error.put_string ("INHERIT_FEAT%N")
			io.error.put_string ("%TDeferred%N")
			⟳ f: deferred_features ¦ f.trace ⟲
			io.error.put_string ("%TEffective%N")
			⟳ f: features ¦ f.trace ⟲
			if attached inherited_info as i then
				io.error.put_string ("Inherited info:%N")
				i.trace
			else
				io.error.put_string ("Void inherited info%N")
			end
		end

	is_less alias "<" (other: INHERIT_FEAT): BOOLEAN
			-- Is `other' less than `Current'
		do
			Result := other /= Current
		end

note
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
