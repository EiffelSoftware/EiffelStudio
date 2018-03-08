note
	description: "Validator for instance-free status of previously compiled features."

class
	AST_INSTANCE_FREE_CHECKER

inherit
	AST_ITERATOR
		redefine
			process_access_assert_as,
			process_access_id_as,
			process_agent_routine_creation_as,
			process_attribute_as,
			process_current_as,
			process_deferred_as,
			process_inline_agent_creation_as,
			process_once_as,
			process_precursor_as,
			process_static_access_as
		end

	SHARED_ERROR_HANDLER

	SHARED_SERVER
		export {NONE} all end

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Creation

	make
			-- Initialize the checker for examining one or more features for instance-free conditions.
			-- All features are assumed to be successfully compiled and are part of the same compilation run.
			-- The latter is used to cache instance-free status of the features.
		do
			create object.make (0)
			create features.make (0)
		end

feature -- Validation

	verify_class_feature (f: FEATURE_I; c: CLASS_C)
			-- Check whether a feature `f` from a class `c` satisfies class routine conditions
			-- and report an error if this is not the case.
			-- The checks also include those performed by `verify_non_object_calls`.
		require
			system_defined: workbench.system_defined
			class_has_feature_table: c.has_feature_table
			is_class: f.is_class
		do
			verify (True, f, c)
		end

	verify_non_object_calls (f: FEATURE_I; c: CLASS_C)
			-- Check whether non-object calls in a feature `f` from a class `c` use only features that do not require an object
			-- and report an error if this is not the case.
			-- Use `verify_class_feature` instead if `f` is declared as a class feature.
		require
			system_defined: workbench.system_defined
			class_has_feature_table: c.has_feature_table
			has_non_object_call: f.has_non_object_call
		do
			verify (False, f, c)
		end

feature {NONE} -- Validation

	verify (is_class_feature: BOOLEAN; f: FEATURE_I; c: CLASS_C)
			-- Verify that feature `f` from class `c` is correct with respect to instance-free calls:
			-- `is_class_feature`:
			-- 	`True` - `f` satisfies class feature conditions
			-- 	`False` - no non-object calls in `f` require an object even when the used features are not declared as instance-free
		require
			system_defined: workbench.system_defined
			class_has_feature_table: c.has_feature_table
			is_class: is_class_feature implies f.is_class
			has_non_object_call: not is_class_feature implies f.has_non_object_call
		do
			is_class_feature_verification := is_class_feature
			nesting_level := 0
			is_object := False
			checked_feature := f
			current_class := c
			process (f)
		end

	process (f: FEATURE_I)
			-- Inspect a feature `f` from a class `current_class` and
			-- make its instance-free status available in `is_object`.
		require
			system_defined: workbench.system_defined
			current_class_has_feature_table: current_class.has_feature_table
		local
			i: like feature_index
			a: INH_ASSERT_INFO
			j: INTEGER
			g: FEATURE_I
		do
			if not is_object then
					-- Retrieve an actual feature from the current class.
				g := current_class.feature_of_rout_id (f.rout_id_set.first)
				i := feature_index (g, current_class)
				object.search (i)
				if object.found then
					is_object := object.found_item
				elseif current_class.is_precompiled then
						-- Precompiled features are not subject to static analysis.
					is_object := not g.has_static_access
						-- Record object status of the feature.
					object.put (is_object, i)
				elseif not has_index (i) then
						-- Mark that the feature is processed.
					put_index (i)
					if g.is_attribute then
							-- A variable attribute requires an object.
						is_object := True
					else
							-- Process inherited assertions.
						if attached g.assert_id_set as s then
							from
								j := s.count
							until
								j <= 0
							loop
								a := s [j]
								if
									attached body_server.item (a.written_in, a.body_index) as p and then
									attached p.body as b and then
									attached {ROUTINE_AS} b.content as r
								then
									safe_process (r.precondition)
									safe_process (r.postcondition)
								end
								j := j - 1
							end
						end
							-- Process feature body.
						safe_process (g.body)
					end
						-- Record object status of the feature.
					object.put (is_object, i)
				end
			end
		end

feature {NONE} -- Status report

	is_object: BOOLEAN
			-- Is an object required to make a call on the feature being processed?

	is_class_feature_verification: BOOLEAN
			-- Should class feature conditions be verified?

feature {NONE} -- Access

	checked_feature: FEATURE_I
			-- A feature being checked.

	current_class: CLASS_C
			-- A class for which the code is being processed.

	object: HASH_TABLE [BOOLEAN, like feature_index]
			-- A table telling if a feature of the given index requires an object.

feature {AST_EIFFEL} -- Visitor

	process_access_assert_as (a: ACCESS_ASSERT_AS)
			-- <Precursor>
		do
				-- Ignore non-feature accesses.
			if a.is_feature then
					-- Check if `a` does not require an object.
				process_access (a, a)
			end
		end

	process_access_id_as (a: ACCESS_ID_AS)
			-- <Precursor>
		do
				-- Ignore non-feature accesses.
			if a.is_feature then
					-- Check if `a` does not require an object.
				process_access (a, a)
			end
		end

	process_agent_routine_creation_as (a: AGENT_ROUTINE_CREATION_AS)
			-- <Precursor>
		do
			if attached a.target then
				Precursor (a)
			else
					-- TODO: implementation constraint: unqualified agents require an object.
				debug ("to_implement")
					;(create {REFACTORING_HELPER}).to_implement ("Support instance-free checks for unqualified agents.")
				end
				is_object := True
			end
		end

	process_attribute_as (a: ATTRIBUTE_AS)
			-- <Precursor>
		do
				-- Variable attributes require an object.
			is_object := True
		end

	process_current_as (a: CURRENT_AS)
			-- <Precursor>
		do
				-- "Current" requires an object.
			is_object := True
		end

	process_deferred_as (a: DEFERRED_AS)
			-- <Precursor>
		do
				-- Deferred features require an object.
			is_object := True
		end

	process_inline_agent_creation_as (a: INLINE_AGENT_CREATION_AS)
			-- <Precursor>
		do
				-- TODO: implementation constraint: inline agents require an object.
			debug ("to_implement")
				;(create {REFACTORING_HELPER}).to_implement ("Support instance-free checks for inline agents.")
			end
			is_object := True
		end

	process_once_as (a: ONCE_AS)
			-- <Precursor>
		do
			if a.has_key_object then
					-- Object-relative once features require an object.
				is_object := True
			else
				Precursor (a)
			end
		end

	process_precursor_as (a: PRECURSOR_AS)
			-- <Precursor>
		do
				-- Check if `a` does not require an object.
			process_access (a, a)
		end

	process_static_access_as (a: STATIC_ACCESS_AS)
			-- <Precursor>
		local
			old_is_object: BOOLEAN
			old_class: CLASS_C
			i: like {CLASS_C}.class_id
		do
				-- Skip the check if error report is disabled, that would mean analysis of a nested call.
			i := a.class_id
			if
				is_error_enabled and then
				i /= 0 and then
				system.has_class_of_id (i) and then
				attached system.class_of_id (i) as c and then
				c.has_feature_table
			then
					-- Change class context to the target one.
				old_is_object := is_object
				is_object := False
				old_class := current_class
				current_class := c
				verify_access (a, a.feature_name)
				current_class := old_class
				is_object := old_is_object
			end
		end

feature {NONE} -- Nesting level control

	nesting_level: NATURAL_32
			-- Nesting level of the checks: 0 means top-level, for which errors can be reported.

	is_error_enabled: BOOLEAN
			-- Can errors be reported?
		do
			Result := nesting_level = 0
		end

	enter
			-- Enter a new feature.
		do
			nesting_level := nesting_level + 1
		ensure
			nesting_level_increased: nesting_level = old nesting_level + 1
		end

	leave
			-- Leave a feature.
		require
			valid_nesting_level: nesting_level > 0
		do
			nesting_level := nesting_level - 1
		ensure
			nesting_level_decreased: nesting_level = old nesting_level - 1
		end

feature {NONE} -- Checking

	process_access (a: ID_SET_ACCESSOR; l: ACCESS_AS)
			-- Process access `a`.
			-- The argument `l` is passed to overcome a limitation that an argument cannot be specified with multiple types:
			-- `a: {ID_SET_ACCESSOR;  ACCESS_AS}`.
			-- Report an error if the corresponding feature requires an object when `is_class_feature_verification` is `True`
			-- and the check is done in the feature to be verified.
		require
			multiple_type_constraint_workaround: a = l
		do
			if not is_object and then is_class_feature_verification then
				verify_access (a, l)
			end
		end

	verify_access (a: ID_SET_ACCESSOR; l: AST_EIFFEL)
			-- Check that feature identified by `a` does not require an object
			-- and report an error at location identified by `l` otherwise.
			-- Update `is_object` to reflect whether the feature needs an object.
		local
			r: like {ID_SET}.first
			i: like {CLASS_C}.class_id
		do
			r := a.routine_ids.first
			i := a.class_id
			if
				r > 0 and then
				i /= 0 and then
				system.has_class_of_id (i) and then
				attached system.class_of_id (i) as c and then
				c.has_feature_table and then
				attached c.feature_of_rout_id (r) as f
			then
					-- Check if the non-object call is valid.
				enter
				process (f)
				leave
				if is_object and then is_error_enabled then
						-- The feature requires an object.
					if is_class_feature_verification then
						error_handler.insert_error (create {VUCR_BODY}.make_feature (f, checked_feature, current_class, checked_feature.written_class, l.first_token (match_list_server.item (current_class.class_id))))
					else
						error_handler.insert_error (create {VUNO_FEATURE}.make (f, checked_feature, current_class, checked_feature.written_class, l.first_token (match_list_server.item (current_class.class_id))))
					end
				end
			else
					-- Something went wrong, consider the feature as requiring an object.
				is_object := True
			end
		end

feature {NONE} -- Processed features: access

	feature_index  (f: FEATURE_I; c: CLASS_C): NATURAL_64
			-- A unique index of a feature `f` from class `c`.
		do
			Result := c.class_id.as_natural_64 |<< 32 + f.body_index.as_natural_64
		end

	features: SEARCH_TABLE [like feature_index]
			-- Features that have been processed.

feature {NONE} -- Processed features: status report

	has_index (i: like feature_index): BOOLEAN
			-- Has feature of index `i` been processed?
		do
			Result := features.has (i)
		end

feature {NONE} -- Processed features: modification

	put_index (i: like feature_index)
			-- Record that the feature of index `i` has been processed.
		do
			features.put (i)
		end

	put (f: FEATURE_I; c: CLASS_C)
			-- Record that the feature `f` from class `c` has been processed.
		do
			put_index (feature_index (f, c))
		end

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
