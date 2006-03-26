indexing
	description: "Abstract description of a formal generic parameter. %
				%Instances produced by Yacc. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_CONSTRAINT_AS

inherit
	FORMAL_DEC_AS

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

create
	initialize

feature -- Status

	constraint_type: TYPE_A is
			-- Actual type of the constraint.
		do
			if constraint = Void then
					-- Default constraint to ANY
				Result := Any_constraint_type
			else
					-- No need to check validity of `Result' after converting
					-- TYPE_AS into TYPE_A because at this stage it should be
					-- a valid class.
				Result := type_a_generator.evaluate_type (constraint, System.current_class)
			end
		end

	has_computed_feature_table: BOOLEAN is
			-- Check that we can retrieve a FEATURE_TABLE from the class
			-- on which we want to check the validity rule about creation
			-- constraint.
			--| Basically, sometimes (degree 4) for example, we need to access
			--| the information on a class which has not been yet compiled, because
			--| of the order of the compilation which does not take into account
			--| the constraint part.
		local
			class_type: CL_TYPE_A
		do
			if creation_feature_list /= Void then
				class_type ?= constraint_type
				if class_type /= Void then
					Result := Feat_tbl_server.item (class_type.class_id) /= Void
				end
			end
		end

	constraint_creation_list: LINKED_LIST [FEATURE_I] is
			-- Actual creation routines from a constraint clause
		require
			has_creation_constraint: has_creation_constraint
			has_computed_feature_table: has_computed_feature_table
		local
			class_type: CL_TYPE_A
			feature_name: STRING
			feat_table: FEATURE_TABLE
		do
			class_type ?= constraint_type
			if class_type /= Void then
				feat_table := class_type.associated_class.feature_table
				check
						-- A feature table associated to `class_type' should
						-- always be in the system
					feature_table_exists: feat_table /= Void
				end
				from
					creation_feature_list.start
					create Result.make
				until
					creation_feature_list.after
				loop
					feature_name := creation_feature_list.item.internal_name
					feat_table.search (feature_name)
					Result.extend (feat_table.found_item)
					Result.forth

					if not has_default_create then
						has_default_create := feat_table.found_item.rout_id_set.first =
													System.default_create_id
					end
					creation_feature_list.forth
				end
			end
		end

feature {NONE} -- Access

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			create Result.make (System.any_id)
		end

feature -- Output

	append_signature (a_text_formatter: TEXT_FORMATTER; a_short: BOOLEAN) is
			-- Append the signature of current class in `a_text_formatter'
			-- If `a_short', use "..." to replace constrained generic type, so
			-- class {HASH_TABLE [G, H -> HASHABLE]} becomes {HASH_TABLE [G, H -> ...]}.
			--| We do not produce the creation constraint clause since
			--| it is useless in this case.
		require
			non_void_st: a_text_formatter /= Void
		local
			c_name: STRING
			eiffel_name: STRING
		do
			if is_reference then
				a_text_formatter.process_keyword_text (ti_reference_keyword, Void)
				a_text_formatter.add_space
			elseif is_expanded then
				a_text_formatter.process_keyword_text (ti_expanded_keyword, Void)
				a_text_formatter.add_space
			end
			c_name := name.as_upper
			a_text_formatter.process_generic_text (c_name)
			if has_constraint then
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (ti_Constraint)
				a_text_formatter.add_space
				if a_short then
					a_text_formatter.add_string (once "...")
				else
					if constraint_type.has_associated_class then
						a_text_formatter.process_class_name_text (constraint_type.associated_class.name,
																	constraint_type.associated_class.lace_class, False)
					else
						a_text_formatter.add_string (constraint.dump)
					end
					if has_creation_constraint then
						from
							creation_feature_list.start
							a_text_formatter.add_space
							a_text_formatter.process_keyword_text (ti_Create_keyword, Void)
						until
							creation_feature_list.after
						loop
							a_text_formatter.add_space
							eiffel_name := creation_feature_list.item.internal_name
							a_text_formatter.add (eiffel_name)
							creation_feature_list.forth
							if not creation_feature_list.after then
								a_text_formatter.process_symbol_text (ti_Comma)
							end
						end
						a_text_formatter.add_space
						a_text_formatter.process_keyword_text (ti_End_keyword, Void)
					end
				end

			end
		end

feature -- Validity checking

	check_constraint_creation (a_context_class: CLASS_C) is
			-- Check validity of the creation clause in the constraint
		require
			has_creation_constraint: has_creation_constraint
		local
			associated_class: CLASS_C
			class_i: CLASS_I
			cluster: CLUSTER_I
			feature_name: STRING
			feat_table: FEATURE_TABLE
			class_type: CLASS_TYPE_AS
			vtcg6: VTCG6
		do
			cluster := a_context_class.cluster
			class_type ?= constraint

			if class_type = Void then
					-- Generic constraint lists a type which is not a class type:
					--   fictitious class NONE
					--   tuple type
					--   formal generic parameter
					-- There are no features that can be used for creation.
				fixme ("Process formal generic parameter.")
				create vtcg6
				vtcg6.set_class (a_context_class)
				vtcg6.set_constraint_type (type_a_generator.evaluate_type (constraint, a_context_class))
				vtcg6.set_feature_name (creation_feature_list.first.internal_name)
				vtcg6.set_location (creation_feature_list.first.start_location)
				Error_handler.insert_error (vtcg6)
			else
				class_i := universe.class_named (class_type.class_name, cluster)
					-- We handle only the case where `class_i' is a valid reference
					-- because the case has been handled in `check_constraint_type'
					-- from CLASS_TYPE_AS which is called just before this feature.
				if class_i /= Void then
						-- Here we assume that the class is correct (cad `check_constraint_type'
						-- from CLASS_TYPE_AS did not add any error items to `Error_handler'.

						-- Here we will just check that the feature listed in the creation
						-- constraint part are effectively features of the constraint.
					from
						creation_feature_list.start
						associated_class := class_i.compiled_class
						feat_table := associated_class.feature_table
					until
						creation_feature_list.after
					loop
						feature_name := creation_feature_list.item.internal_name
						feat_table.search (feature_name)
						if
							not feat_table.found or else
							not is_valid_creation_routine (feat_table.found_item)
						then
								-- The feature listed in the creation constraint have not been
								-- declared in the constraint class.
							create vtcg6
							vtcg6.set_class (a_context_class)
							vtcg6.set_constraint_class (associated_class)
							vtcg6.set_feature_name (feature_name)
							vtcg6.set_location (creation_feature_list.item.start_location)
							Error_handler.insert_error (vtcg6)
						end
						creation_feature_list.forth
					end
				end
			end
		end

	is_valid_creation_routine (f: FEATURE_I): BOOLEAN is
			-- Does `f' have all the needed requirement to be
			-- used a creation routine for the future creation
			-- of the generic parameter.
		require
			feature_exists: f /= Void
		local
			p: PROCEDURE_I
		do
			p ?= f
			Result := p /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FORMAL_DEC_AS
