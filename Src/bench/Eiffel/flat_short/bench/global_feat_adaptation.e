indexing

	description: 
		"Global feature information currently being formatted.";
	date: "$Date$";
	revision: "$Revision $"

class GLOBAL_FEAT_ADAPTATION 

inherit
	SHARED_FORMAT_INFO

	SHARED_SERVER

	SHARED_INST_CONTEXT

	SHARED_EVALUATOR

	COMPILER_EXPORTER

	SHARED_ARG_TYPES

creation

	make, make_with_classes

feature -- Initialization

	make_with_classes (source_class, target_class: CLASS_C) is
			-- Initialize Current with `source_class' and
			-- `target_class'.
		do
			source_enclosing_class := source_class;
			target_enclosing_class := target_class;
		ensure
			source_enclosing_class = source_class;
			target_enclosing_class = target_class;
		end;

	make (source, target: FEATURE_I; target_class: CLASS_C) is
			-- Make Current for adaptation of source feature
			-- `source' in relation to evaluated `target' feature in 
			-- class `target_class'. The  purpose of this class is 
			-- to have access to the global information related to 
			-- the `source' and `target' features.
		require
			valid_source: source /= Void;
			valid_target: target /= Void;
			valid_target_class: target_class /= Void
		do
			source_enclosing_feature := source;
			target_enclosing_feature := target;
			source_enclosing_class := source.written_class;
			target_enclosing_class := target_class;
			target_feature_table := target_class.feature_table;
				-- Initialize the target arguments for evaluating arguments. 
			Argument_types.init1 (target);
debug ("FLAT_SHORT")
	io.error.putstring ("%Tsource feature: ");
	io.error.putstring (source.feature_name);
	io.error.putstring (" target feature: ");
	io.error.putstring (target.feature_name);
	io.error.new_line
end

		ensure
			set: source_enclosing_feature = source and then
				target_enclosing_feature = target and then
				source_enclosing_class = source.written_class and then
				target_enclosing_class = target_class and then
				target_feature_table = target_class.feature_table
		end;

	update_new_source_in_assertion (source: FEATURE_I) is
			-- Update Current the source of global feature adaptation to
			-- `source'. Do not evaluate locals.
		do
			source_enclosing_feature := source;
			source_enclosing_class := source_enclosing_feature.written_class;
			private_adapt_result := Void;
			private_adapt_current := Void;
			source_locals := Void;
			target_locals := Void;
		ensure
			source_locals = Void and then target_locals = Void
		end;

feature -- Properties

	source_enclosing_class: CLASS_C;
			-- Class where source_enclosing_feature is written in

	target_enclosing_class: CLASS_C;
			-- Class where target_enclosing_feature is targetted for

	source_enclosing_feature: FEATURE_I;
			-- Feature in source_enclosing_class

	target_enclosing_feature: FEATURE_I;
			-- Feature in target_enclosing_feature

	target_feature_table: FEATURE_TABLE;

	source_locals: EXTEND_TABLE [TYPE_A, STRING];
			-- Evaluated local types of source_enclosing_feature
			-- in source_enclosing_class

	target_locals: EXTEND_TABLE [TYPE_A, STRING];
			-- Evaluated local types of target_enclosing_feature
			-- in target_enclosing_class

feature -- Setting

	set_source_enclosing_class (c: CLASS_C) is
			-- Set source_enclosing_class to `c'.
		do
			source_enclosing_class := c
		ensure
			source_enclosing_class = c
		end;

feature -- Transformation

	adapt_main_feature: LOCAL_FEAT_ADAPTATION is
			-- Feature adaptation for the source and target features
		local
			tmp: STRING
		do
			create Result;
			Result.set_source_type (source_enclosing_class.actual_type);
			Result.set_target_type (target_enclosing_class.actual_type);
			Result.set_source_feature (source_enclosing_feature);
			Result.set_target_feature (target_enclosing_feature);
			Result.adapt_final_name;
			if target_enclosing_feature.is_constant then
				tmp := Result.final_name;
				tmp.put (tmp.item (1).upper, 1);
			end
		end;

	adapt_local (f_name: STRING): LOCAL_FEAT_ADAPTATION is 
			-- Feature adaptation for local variable `f_name'
		require
			valid_f_name: f_name /= Void
		local
			s_type, t_type: TYPE_A
		do
			if source_locals /= Void then
				s_type := source_locals.item (f_name)
				if s_type /= Void then
					t_type := target_locals.item (f_name)
					create Result
					Result.set_is_normal
					Result.set_source_type (s_type)
					Result.set_target_type (t_type)
					Result.set_feature_name (f_name)
					Result.set_evaluated_type
				end
			end
		end

	adapt_argument (feature_name: STRING): LOCAL_FEAT_ADAPTATION is
			-- Feature adaptation for argument with `feature_name'
			--| Return Void if not found
		require
			valid_feature_name: feature_name /= Void
		local
			i, nb: INTEGER;
			s_type, t_type: TYPE_A;
			arg_name: STRING
			source_arguments: FEAT_ARG;
			target_arguments: FEAT_ARG;
			formal_type: FORMAL_A
		do
			if source_enclosing_feature /= Void then
				source_arguments := source_enclosing_feature.arguments
				if source_enclosing_feature.arguments /= Void then
					from 
						target_arguments := target_enclosing_feature.arguments;
						i := 1
						nb := source_arguments.count;
					until
						i > nb or else Result /= Void
					loop
						arg_name := source_arguments.item_name (i);
						if feature_name.is_equal (arg_name) then
							s_type := source_arguments.i_th (i).actual_type;
							if s_type.is_formal then
								formal_type ?= s_type;
								s_type := source_enclosing_class.constraint (formal_type.position)
							end;
							t_type := target_arguments.i_th (i).actual_type;
							if t_type.is_formal then
								formal_type ?= t_type;
								t_type := target_enclosing_class.constraint (formal_type.position)
							end;
							create Result;
							Result.set_is_normal;
							Result.set_source_type (s_type);
							Result.set_target_type (t_type);
							Result.set_feature_name (arg_name);
							Result.set_evaluated_type
						else
							i := i + 1;
						end;
					end
				end;
			end;
		end;

	adapt_result: LOCAL_FEAT_ADAPTATION is
			-- Feature adaptation for instructions 
			-- with `Result' keyword
			--| Return Void if not found
		local
			s_type, t_type: TYPE_A;
			formal_type: FORMAL_A
		do
			if private_adapt_result = Void then
				if source_enclosing_feature = Void then	
					create private_adapt_result;
					private_adapt_result.set_is_normal;
					private_adapt_result.set_feature_name ("Result");
					private_adapt_result.set_source_type (Void);
					private_adapt_result.set_target_type (Void)
				else
					s_type := source_enclosing_feature.type.actual_type;
					if s_type.is_formal then
						formal_type ?= s_type;
			 			s_type := source_enclosing_class.constraint (formal_type.position)
					end;
					t_type := target_enclosing_feature.type.actual_type;
					if t_type.is_formal then
						formal_type ?= t_type;
			 			t_type := target_enclosing_class.constraint (formal_type.position)
					end;
					create private_adapt_result;
					private_adapt_result.set_is_normal;
					private_adapt_result.set_feature_name ("Result");
					private_adapt_result.set_source_type (s_type);
					private_adapt_result.set_target_type (t_type);
					private_adapt_result.set_evaluated_type
				end
			end;
			Result := private_adapt_result
		end;

	adapt_current: LOCAL_FEAT_ADAPTATION is
			-- Feature adaptation for instructions 
			-- with `Current' keyword
		local
			s_type, t_type: TYPE_A;
		do
			if private_adapt_current = Void then
				s_type := source_enclosing_class.actual_type;
				t_type := target_enclosing_class.actual_type;
				create private_adapt_current;
				private_adapt_current.set_is_normal;
				private_adapt_current.set_feature_name ("Current");
				private_adapt_current.set_source_type (s_type);
				private_adapt_current.set_target_type (t_type)
				private_adapt_current.set_evaluated_type
			end
			Result := private_adapt_current
		end;

feature {NONE} -- Implementation properites

	private_adapt_result: LOCAL_FEAT_ADAPTATION
			-- Feature adaptation for result 

	private_adapt_current: LOCAL_FEAT_ADAPTATION
			-- Feature adaptation for Current 

feature {FORMAT_CONTEXT} -- Implementation

	set_locals (body: FEATURE_AS) is
			-- Set source_locals and target_locals
			-- according to feature as `source_as'.
		local
			s_locals: EXTEND_TABLE [LOCAL_INFO, STRING]
			old_cluster: CLUSTER_I
			s_type, t_type: TYPE_A
			l_name: STRING
			local_info: LOCAL_INFO
			formal_type: FORMAL_A
		do	
			if not is_short then
				old_cluster := Inst_context.cluster;
				Inst_context.set_cluster (source_enclosing_class.cluster);
				System.set_current_class (source_enclosing_class);
					-- When evaluating like feature
				s_locals := body.local_table_for_format (source_enclosing_feature);
				System.set_current_class (target_enclosing_class);
				if s_locals = Void then
					Inst_context.set_cluster (old_cluster);
				else
					if (source_enclosing_class = target_enclosing_class) or else
						source_enclosing_feature = Void
					then
						from
							create source_locals.make (s_locals.count);
							s_locals.start;
						until
							s_locals.after
						loop
							l_name := s_locals.key_for_iteration;
							local_info := s_locals.item_for_iteration;
							if local_info = Void then
								s_type := Void
							else
								s_type := local_info.type.actual_type;
								if s_type.is_formal then
									formal_type ?= s_type;
				 					s_type := source_enclosing_class.constraint 
													(formal_type.position)
								end;
							end;
							source_locals.put (s_type, l_name);
							s_locals.forth;
						end;	
						target_locals := source_locals
					else
						from
							create source_locals.make (s_locals.count);
							create target_locals.make (s_locals.count);
							s_locals.start;
						until
							s_locals.after
						loop
							l_name := s_locals.key_for_iteration;
							local_info := s_locals.item_for_iteration;
							if local_info = Void then
								s_type := Void;
								t_type := Void
							else
								s_type := s_locals.item_for_iteration.type;
								t_type := Local_evaluator.evaluated_type_for_format
										(s_type,
										target_feature_table,
										target_enclosing_feature);
								if t_type = Void then
									s_type := Void;
									t_type := Void
								else
									s_type := s_type.actual_type;
									if s_type.is_formal then
										formal_type ?= s_type;
				 						s_type := source_enclosing_class.constraint 
													(formal_type.position)
									end;
				 					t_type := t_type.instantiation_in 
											(target_enclosing_class.actual_type,
											source_enclosing_class.class_id).actual_type;
									if t_type.is_formal then
										formal_type ?= t_type;
				 						t_type := target_enclosing_class.constraint 
												(formal_type.position)
									end
								end;
							end;
							source_locals.put (s_type, l_name);
							target_locals.put (t_type, l_name);
							s_locals.forth;
						end	
					end;
					Inst_context.set_cluster (old_cluster);
				end;
			end;
		end

end -- class GLOBAL_FEAT_ADAPTATION
