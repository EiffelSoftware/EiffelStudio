indexing
	description: "Abstract description of an Eiffel routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

	SHARED_TYPES
	SHARED_EVALUATOR

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			class_type ?= yacc_arg (0)
			feature_name ?= yacc_arg (1)
		ensure then
			feature_name_exists: feature_name /= Void
		end

feature -- Attributes

	class_type : TYPE
			-- Type from which the feature comes

	feature_name: FEATURE_NAME
			-- Feature name to address

	class_type_a : CL_TYPE_A
			-- Class from which the feature comes

	type : GEN_TYPE_A
			-- Type of routine object

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (class_type, other.class_type)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a routine creation expression
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			depend_unit: DEPEND_UNIT
			vxxx: VXXX
		do
			if class_type /= Void then
				-- Class is explicitly given
				class_type_a := computed_type
				a_class := class_type_a.associated_class
			else
				-- It's the current class
				class_type_a := context.actual_class_type
				a_class := context.a_class
			end

			a_table := a_class.feature_table
			a_feature := a_table.item (feature_name.internal_name)

			if (a_feature = Void) 
					or else
				(not (a_feature.is_function or else a_feature.is_procedure)
					or else
				a_feature.is_external) then
				!! vxxx
				context.init_error (vxxx)
				vxxx.set_address_name (feature_name.internal_name)
				Error_handler.insert_error (vxxx)
			else
					-- Dependance
				!! depend_unit.make (a_class.id, a_feature)
				context.supplier_ids.extend (depend_unit)

				type := routine_type (a_table, a_feature, a_class.id)
				System.instantiator.dispatch (type, context.a_class)
				context.put (type)
			end
			Error_handler.checksum
		end

	byte_node: ROUTINE_CREATION_B is
			-- Associated byte code.
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
		do
			a_class := class_type_a.associated_class
			a_table := a_class.feature_table
			a_feature := a_table.item (feature_name.internal_name)

			!!Result
			Result.init (class_type_a.type_i, a_class.id, a_feature, type.type_i)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin
			if class_type /= Void then
				-- FIXME: treat class_type, i.e "{TYPE}"
			end
			ctxt.prepare_for_feature (feature_name.internal_name, Void)
			if ctxt.is_feature_visible then
				ctxt.put_text_item_without_tabs (ti_Tilda)
				ctxt.put_current_feature;
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			l.add (feature_name.internal_name)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := clone (Current)
			ctxt.adapt_name (feature_name.internal_name)
			Result.feature_name.set_name (ctxt.adapted_name)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if class_type /= Void then
				-- FIXME: treat class_type, i.e "{TYPE}"
			end
			ctxt.prepare_for_feature (feature_name.internal_name, Void)
			ctxt.put_text_item_without_tabs (ti_Tilda)
			ctxt.put_current_feature
		end

feature {NONE} -- Type

	computed_type : CL_TYPE_A is
			-- Compute the class for 'class_type'
			-- return its type.
		require
			class_type_exists: class_type /= Void
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			any_type: CL_TYPE_A
			ttype: TYPE_A
			gen_type: GEN_TYPE_A
			formal_type: FORMAL_A
			formal_dec: FORMAL_DEC_AS
			formal_position: INTEGER
			not_supported: NOT_SUPPORTED
			vtug: VTUG
		do
			a_class := context.a_class
			a_table := a_class.feature_table
			a_feature := context.a_feature

			-- First check generic parameters

			ttype ?= class_type.actual_type

			if not ttype.good_generics then
				vtug := ttype.error_generics
				vtug.set_class (context.a_class)
				vtug.set_feature (context.a_feature)
				Error_handler.insert_error (vtug)
				Error_handler.raise_error
			end

			-- Now solve the type

			ttype := Creation_evaluator.evaluated_type (
										 class_type, a_table, a_feature
													   )
			ttype := ttype.actual_type

			if ttype.has_like then
				-- Not supported - doesn't make sense
				-- anyway.
				!!not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Target type of a ROUTINE may not involve anchors.")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			-- If it is a formal generic use its
			-- constraint if it has one or ANY otherwise.
			
			if ttype.is_formal then
				formal_type ?= ttype
				formal_position := formal_type.position
				-- Get the corresponding constraint type 
				-- of the current class
				formal_dec := a_class.generics.i_th (formal_position)
				if formal_dec.has_constraint then
					ttype := formal_dec.constraint_type
				else
					!!any_type
					any_type.set_base_class_id (System.any_id)
					ttype := any_type
				end
			end

			if ttype.is_basic then
				-- Not supported - doesn't make sense.
				!!not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Target type of a ROUTINE may not be a basic type.")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			gen_type ?= ttype
			if gen_type /= Void then
				System.instantiator.dispatch (gen_type, context.a_class)
			end

			-- Assignment attempt cannot fail
			Result ?= ttype
			Error_handler.checksum
		end
	
	routine_type (a_table: FEATURE_TABLE; a_feature: FEATURE_I; cid : CLASS_ID) : GEN_TYPE_A is
			-- Type of routine object
		require
			valid_table: a_table /= Void;
			valid_feature: a_feature /= Void;
			function_or_procedure: a_feature.is_function or else
								   a_feature.is_procedure;
			not_external: not a_feature.is_external
		local
			solved_type:TYPE_A
			generics: ARRAY [TYPE_A]
			args: FEAT_ARG
			argtypes: ARRAY [TYPE_A]
			tuple: TUPLE_TYPE_A
			idx: INTEGER
		do
			!!Result

			if a_feature.is_function then
				-- FUNCTION
				Result.set_base_class_id (System.function_class_id)
				-- generics are: target_type, argument_types, result_type
				!!generics.make (1, 3)
				solved_type := Creation_evaluator.evaluated_type (
										   a_feature.type, a_table, a_feature
																 )
				solved_type := solved_type.instantiation_in (class_type_a, cid)
				generics.put (solved_type.actual_type, 3)
			else
				-- PROCEDURE
				Result.set_base_class_id (System.procedure_class_id)
				-- generics are: target_type, argument_types
				!!generics.make (1, 2)
			end

			-- Put target type (type of enclosing class)
			generics.put (class_type_a, 1)

			-- Create argument types

			args := a_feature.arguments

			if args /= Void then
				from
					idx := 1
					!!argtypes.make (1, args.count)
					args.start
				until
					args.after
				loop
					solved_type := Creation_evaluator.evaluated_type (
										   args.item, a_table, a_feature
																	 )
					solved_type := solved_type.instantiation_in (class_type_a, cid)
					argtypes.put (solved_type.actual_type, idx)
					idx := idx + 1
					args.forth
				end
			end

			-- Create argument type tuple
			!!tuple
			tuple.set_base_class_id (System.tuple_id)
			tuple.set_generics (argtypes)
			generics.put (tuple, 2)

			Result.set_generics (generics)
		ensure
			exists: Result /= Void;
		end

end -- class ROUTINE_CREATION_AS

