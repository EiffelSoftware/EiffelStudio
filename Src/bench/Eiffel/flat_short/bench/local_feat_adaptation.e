indexing

	description: 
		"Local feature information currently being formatted.%
		%These features are within the global features being formatted."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class LOCAL_FEAT_ADAPTATION 

inherit
	SHARED_SERVER;
	SHARED_FORMAT_INFO;
	SHARED_INST_CONTEXT;
	COMPILER_EXPORTER
	PREFIX_INFIX_NAMES

feature -- Update
	
	update_from_global (global_adapt: GLOBAL_FEAT_ADAPTATION) is
			-- Make Current from `global_adapt' information.
		require
			valid_global: global_adapt /= Void;
			valid_source: global_adapt.source_enclosing_class /= Void;
			valid_target: global_adapt.target_enclosing_class /= Void;
		do
			source_type := global_adapt.source_enclosing_class.actual_type;
			target_type := global_adapt.target_enclosing_class.actual_type;
		ensure
			source_type.same_as (global_adapt.source_enclosing_class.actual_type)
			target_type.same_as (global_adapt.target_enclosing_class.actual_type)
		end;

feature -- Properties

	source_type: TYPE_A;
			-- Type of the feature in ancestor class

	target_type: TYPE_A;
			-- Redefined type in descendant class

	source_feature: FEATURE_I;
			-- feature called in ancestor
	
	target_feature: FEATURE_I;
			-- feature called in descendant

	final_name: STRING;
			-- name in descendant

	alias_name: STRING
			-- Associated alias name (if any)

	has_convert_mark: BOOLEAN
			-- Does operator feature have a convert mark?

	is_infix: BOOLEAN
			-- Is the final feature an infix?

	is_prefix: BOOLEAN is
			-- Is the final feature a prefix?
		require
			final_name_not_void: final_name /= Void
		do
			Result := not is_normal and then not is_infix and then not is_bracket
		end

	is_bracket: BOOLEAN is
			-- Is final feature a bracket one?
		require
			final_name_not_void: final_name /= Void
		do
			Result := syntax_checker.is_bracket_alias_name (final_name)
		end

	is_normal: BOOLEAN
			-- Is the final feature normal, ie not an operator

	already_evaluated_type: BOOLEAN;
			-- Has the source and target type been evaluated

	source_class: CLASS_C is
			-- Source class for current adaptation
		do
			if source_type /= Void then
				Result := source_type.associated_class;
			end;
		end;

	target_class: CLASS_C is
			-- Target class for current adaptation
		do
			if target_type /= Void then
				Result := target_type.associated_class;
			end;
		end;

feature -- Access

	is_visible (c: CLASS_C): BOOLEAN is
			-- Is the feature visible for class_c type clients
		do
			Result := c /= Void and then target_feature /= Void and then
				target_feature.is_exported_for (c) 
		end

	compute_feature (name: STRING): FEATURE_I is
			-- Compute feature with feature name `name' using
			-- source class.
		require
			name_not_void: name /= Void
		local
			l_source_class: like source_class
		do
			l_source_class := source_class
			if l_source_class /= Void then
				Result := l_source_class.feature_named (name)
			end
		end

	adapted_type (f: FORMAL_AS): TYPE_A is
			-- Adapted type of `source_class' for format `f'.
		require
			formal_not_void: f /= Void
		local
			l_source_class: like source_class
		do
			l_source_class := source_class
			if l_source_class /= Void then
				Result := f.actual_type.
					instantiation_in (target_type, l_source_class.class_id)
			end
		end

feature -- Setting

	set_feature_name (name: STRING) is
			-- Set final_name to `name'.
		require
			valid_name: name /= Void
		do
			final_name := name;
		ensure
			set: final_name = name
		end;

	set_alias_name (name: STRING) is
			-- Set alias_name to `name'.
		require
			valid_name: name /= Void
		do
			alias_name := name
		ensure
			set: alias_name = name
		end

	set_source_type (t: TYPE_A) is
			-- Set source_type to `t'.
		do
			source_type := t;
		ensure
			set: source_type = t
		end;

	set_target_type (t: TYPE_A) is
			-- Set target type to `t'.
		do
			target_type := t;
		ensure
			set: target_type = t
		end;

	set_source_feature (f: FEATURE_I) is
			-- Set source_feature to `f'.
		do
			source_feature := f;
		ensure
			set: source_feature = f
		end;
		
	set_target_feature (f: FEATURE_I) is
			-- Set target_feature to `f'.
		do
			target_feature := f;
		ensure
			set: target_feature = f
		end;
		
	set_is_normal is
			-- Set `is_normal' to True.
		do
			is_normal := True;
		ensure
			is_normal: is_normal
		end;

	set_is_infix is
			-- Set `is_infix' to True.
		do
			is_infix := True;
		ensure
			is_infix: is_infix
		end;

	set_evaluated_type is
			-- Set already_evaluated_type to `True'.
		do
			already_evaluated_type := True
		ensure
			already_evaluated_type: already_evaluated_type
		end;

feature -- Transformation

	adapt_feature (feature_name: STRING;
				global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation with feature `feature_name'
		require
			valid_feature_name: feature_name /= Void;
			valid_global_type: global_type /= Void
		local
			new_feat: FEATURE_I
		do
			new_feat := compute_feature (feature_name)
			if new_feat /= Void then
				create Result
				Result.set_is_normal
				Result.set_feature_name (feature_name)
				Result.set_source_feature (new_feat)
				Result.set_source_type (source_type)
				Result.set_target_type (target_type)
				Result.set_private_select_table 
							(global_type.target_feature_table)
				Result.adapt
			else
				Result := global_type.adapt_argument (feature_name)
				if Result = Void then
					Result := global_type.adapt_local (feature_name)
					if Result = Void then
						create Result
						Result.set_is_normal
						Result.set_feature_name (feature_name)
						Result.set_source_type (source_type)
						Result.set_target_type (target_type)
						Result.set_source_feature (new_feat)
						Result.set_private_select_table 
								(global_type.target_feature_table)
						Result.adapt
					end
				end
			end
		end

	adapt_nested_feature (feature_name: STRING; 
				global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation within nested calls with
			-- feature `feature_name'
		require
			valid_feature_name: feature_name /= Void;
			valid_global_type: global_type /= Void
		do
			Result := new_adapt_from_current (global_type);
			Result.set_is_normal;
			Result.set_feature_name (feature_name);
			Result.set_source_feature (Result.compute_feature 
									(feature_name));
			Result.adapt 
		end;

	adapt_infix (int_name, v_name: STRING;
				global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation for infix feature `int_name'
		require
			valid_int_name: int_name /= Void;
			valid_global_type: global_type /= Void
		do
			Result := new_adapt_from_current (global_type);
			Result.set_is_infix;
			Result.set_feature_name (v_name);
			Result.set_source_feature (Result.compute_feature (int_name));
			Result.adapt 
		end;

	adapt_prefix (int_name, v_name: STRING; global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation for prefix feature `int_name'
		require
			valid_int_name: int_name /= Void
			valid_global_type: global_type /= Void
		do
			Result := new_adapt_from_current (global_type);
			Result.set_feature_name (v_name);
			Result.set_source_feature (Result.compute_feature (int_name));
			Result.adapt
		end;

	adapt_bracket (global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation for bracket feature
		require
			valid_global_type: global_type /= Void
		do
			Result := new_adapt_from_current (global_type)
			Result.set_feature_name (bracket_str)
			Result.set_source_feature (Result.compute_feature (bracket_str))
			Result.adapt
		end

feature {LOCAL_FEAT_ADAPTATION, GLOBAL_FEAT_ADAPTATION} -- Implementation

	adapt is
		local
			rout_id : INTEGER
			select_table : SELECT_TABLE
			new_feat: FEATURE_I
		do
debug ("LOCAL_FEAT_ADAPTATION") 
	io.error.put_string ("before adapting%N");
	trace;
end;
			if source_feature = Void or else 
				source_type = Void or else target_type = Void 
			then
				clear
			elseif (source_type.is_deep_equal (target_type)) then
				if in_bench_mode then 
						-- If it is the same source and target type
						-- then the target feature is the source feature
					target_feature := source_feature
				else
						-- Optimization: in batch mode we don't need
						-- items to be clickable.
					clear
				end
			else
					--| If in bench mode make everything clickable
				rout_id := source_feature.rout_id_set.first;
				select_table := target_select_table;
				if select_table /= Void then
					new_feat := select_table.item (rout_id);
				end
				target_feature := new_feat;
				if new_feat = Void then
					clear
				end;
				if new_feat /= Void then
					adapt_final_name
				end;
			end;
debug ("LOCAL_FEAT_ADAPTATION") 
	io.error.put_string ("After adapting%N");
	trace;
end
		end;

	adapt_final_name is
			-- Evaluate final_name in target_feature.
		require
			valid_target_feature: target_feature /= Void
		do
			final_name := target_feature.feature_name.twin
			if final_name.item (final_name.count) = '%"' and final_name.count > Infix_str.count then
				if final_name.substring_index_in_bounds (Prefix_str, 1, Prefix_str.count) = 1 then
					final_name := extract_symbol_from_prefix (final_name)
					is_infix := False
					is_normal := False
				else
					final_name := extract_symbol_from_infix (final_name)
					is_normal := False
					is_infix := True
				end
			else
				is_normal := True
				is_infix := False
				alias_name := target_feature.alias_name
				if alias_name /= Void then
						-- Get visual representation of the alias name.
					alias_name := extract_alias_name (alias_name)
					has_convert_mark := target_feature.has_convert_mark
				end
			end
		ensure
			valid_final_name: final_name /= Void;
		end

feature {LOCAL_FEAT_ADAPTATION}

	set_private_select_table (t: FEATURE_TABLE) is
			-- Set `private_target_select_table' to t origin_table.
		do
			if t /= Void then
				private_target_select_table := t.origin_table
			end;
		ensure
			t /= Void implies private_target_select_table = t.origin_table
		end; 

feature {NONE} -- Implementation

	private_target_select_table: SELECT_TABLE;
			-- Private select table. Used for 

	target_select_table: SELECT_TABLE is
			-- Select table for the target_id
		require
			valid_target_class: target_type /= Void
		do
			Result := private_target_select_table;
			if Result = Void and then target_class /= Void then
				Result := Feat_tbl_server.item (target_class.class_id).origin_table
			end;
		end;
				
	clear is
			-- Clear Current.
		do
			source_feature := Void;
			target_feature := Void;
			source_type := Void;
			target_type := Void;
		ensure
			cleared: source_feature = Void and then
					target_feature = Void and then
					source_type = Void and then
					target_type = Void
		end;

	new_adapt_from_current (global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Update the adaptation `adapt' source and target
			-- types with result types information from previous
			-- analyzed features (which is Current).
			--| eg a.b  a->A then A becomes source_type for b
		local
			type: TYPE_A;
			f: FEATURE_I;
			enclosing_class: CLASS_C;
			formal_type: FORMAL_A
			l_type_feature: TYPE_FEATURE_I
		do
			create Result;
			if already_evaluated_type then
				Result.set_source_type (source_type);
				Result.set_target_type (target_type);
			else
				type := source_type;
				f := source_feature;
				if type /= Void and then f /= Void then
					type := evaluate_type (type, f.type);
					if type.is_formal then
							-- If result is formal then get the
							-- the constraint type from last_class.
						formal_type ?= type;
						enclosing_class := global_type.source_enclosing_class;
						type := enclosing_class.constraint (formal_type.position)
					end;
					check
						is_not_formal: not type.is_formal
					end;
					Result.set_source_type (type);
					type := evaluate_type (target_type, target_feature.type);
					if type.is_formal then
						formal_type ?= type
							-- Find type feature associated to formal in parent `enclosing_class',
						l_type_feature := enclosing_class.formal_at_position (formal_type.position)

							-- Then find current class.						
						enclosing_class := global_type.target_enclosing_class
						
							-- Finally search for definition of `l_type_feature'
							-- in `enclosing_class'.
						check
							target_has_generic_features:
								enclosing_class.generic_features /= Void
						end
						type := enclosing_class.generic_features.item
							(l_type_feature.rout_id_set.first).type

							-- It is still a formal, therefore `enclosing_class' has some generics
							-- and we can safely call `constraint' on it.
						if type.is_formal then
							formal_type ?= type
							check
								has_generics: enclosing_class.generics /= Void
								has_valid_position:
									enclosing_class.generics.valid_index (formal_type.position)
							end
							type := enclosing_class.constraint (formal_type.position)
						end
					end
					check
						is_not_formal: not type.is_formal
					end;
					Result.set_target_type (type);
				end
			end;
		end;

feature {NONE} -- Implementation

	evaluate_type (last_type: TYPE_A; type: TYPE_AS): TYPE_A is
			-- Evaluate type `type' in relation to `last_type'.
		local
			last_constrained: TYPE_A;
			old_cluster: CLUSTER_I;
			last_class: CLASS_C;
			formal_type: FORMAL_A
		do
			Result ?= type;
			if Result = Void then	
					-- This is done since the target feature is retrieved from the
					-- select table which doesn't evaluate types (ie. TYPE_A)
				Result := type.actual_type
			end;
			last_class := last_type.associated_class;
			if last_type.is_formal then
				formal_type ?= last_type;
				last_constrained := 
					last_class.constraint (formal_type.position)
			end;
			if last_type.is_formal and then Result.is_formal then
				old_cluster := Inst_context.cluster;
				Inst_context.set_cluster (last_class.cluster);
				formal_type ?= Result;
				Result := last_constrained.generics.item (formal_type.position)
				Inst_context.set_cluster (old_cluster);
			end;
				-- Do not forget to call `actual_type' on `last_type' because
				-- `last_type' is not enough by itself:
				-- For example when `last_type' in an anchored type we
				-- need to find out its real type in the current context,
				-- which is done by applying `actual_type'.
				-- Manus: 10/06/1999
			Result := Result.instantiation_in 
						(last_type.actual_type, last_class.class_id).actual_type;
		end

feature -- Debug

	trace is
		do
			io.error.put_string ("Adapting feature: ");
			if final_name /= Void then
				io.error.put_string ("[");
				io.error.put_string (final_name);
				io.error.put_string ("] ");
			end;
			if source_feature = Void then
				io.error.put_string ("VOID");
			else
				io.error.put_string (source_feature.feature_name);
				io.error.put_string (" ");
				io.error.put_string (source_feature.type.out);
			end;
			io.error.put_string (" (");
			if source_class = Void then
				io.error.put_string ("VOID");
			else
				io.error.put_string (source_class.name);
			end;
			io.error.put_string (")");
			io.error.put_string (" target: ");
			if target_feature = Void then
				io.error.put_string ("VOID");
			else
				io.error.put_string (target_feature.feature_name);
				io.error.put_string (" ");
				io.error.put_string (target_feature.type.out);
			end;
			io.error.put_string (" (");
			if target_class = Void then
				io.error.put_string ("VOID");
			else
				io.error.put_string (target_class.name);
			end
			io.error.put_string (")");
			io.error.put_new_line;
		end;

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

end
