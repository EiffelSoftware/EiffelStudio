indexing
	description: "Abstract description for `like id' type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_ID_AS

inherit
	TYPE
		redefine
			has_like, simple_format,
			fill_calls_list, replicate
		end

	SHARED_LIKE_CONTROLER

feature {AST_FACTORY} -- Initialization

	initialize (a: like anchor) is
			-- Create a new LIKE_ID AST node.
		require
			a_not_void: a /= Void
		do
			anchor := a
		ensure
			anchor_set: anchor = a
		end

feature -- Attributes

	anchor: ID_AS
			-- Anchor name

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (anchor, other.anchor)
		end

feature -- Access

	has_like: BOOLEAN is True
			-- Has the type anchored type in its definition ?

feature -- Implementation of inherited deferred features

	actual_type: UNEVALUATED_LIKE_TYPE is
			-- Create an UNEVALUATED_LIKE_TYPE
		do
			create Result.make (anchor)
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feauure `f' which has
			-- the type Current and the feautre table `feat_table'
			-- Case of errors: Result is Void if anchored type cannot be
			-- evaluated. If the anchor itself has anchored type in its
			-- type definition, then attribute `actual_type' of Result is Void.
		local
			anchor_feature: FEATURE_I
			anchor_type: TYPE
			argument_position: INTEGER
			rout_id: INTEGER
			like_argument: LIKE_ARGUMENT
			like_feature: LIKE_FEATURE
			depend_unit: DEPEND_UNIT
			veen: VEEN
		do
			anchor_feature := feat_table.item (anchor)
			if anchor_feature /= Void then
					-- It is an anchored type on a feature: check if the
					-- anchor feature has not an anchor type itself.
				anchor_type := anchor_feature.type
				rout_id := anchor_feature.rout_id_set.first

					-- Set the like controler on
				Like_control.on
					-- Check if there is a cycle
				if Like_control.has (rout_id) or else anchor_type.is_void then
						-- Error because of cycle
					Like_control.raise_error
				else
						-- Update anchored type controler
					Like_control.put (rout_id)
						-- Create instance of LIKE_FEATURE
					!! like_feature.make (anchor_feature)
					like_feature.set_rout_id (rout_id)
					like_feature.set_actual_type (anchor_type.solved_type (feat_table, anchor_feature).actual_type)
					Result := like_feature
					if System.in_pass3 then
							-- There is a dependance between `f' and the `anchor_feature'
							-- Record it for the propagation of the recompilations
						!! depend_unit.make (context.a_class.class_id, anchor_feature)
						context.supplier_ids.extend (depend_unit)
					end
				end
			else
				argument_position := f.argument_position (anchor)
				if argument_position /= 0 then
						-- Found argument
					if Like_control.is_on then
							-- There cannot be any like argument targeted
							-- direclty or indirectly by a type anchored on a
							-- feature
						Like_control.raise_error
					else
						if
							Like_control.arguments.has (argument_position)
						then
								-- Cycle involving anchors on arguments
							Like_control.raise_error
						end
						Like_control.arguments.put (argument_position)	
						anchor_type := f.arguments.i_th (argument_position)
						!!like_argument
						like_argument.set_position (argument_position)
						like_argument.set_actual_type
						(anchor_type.solved_type (feat_table, f).actual_type)
						Result := like_argument
					end
				else
					!!veen
					veen.set_class (System.current_class)
					veen.set_feature (f)
					veen.set_identifier (anchor)
					Error_handler.insert_error (veen)
					Error_handler.raise_error
				end
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			l.add (anchor)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := clone (Current)
			Result.set_anchor (anchor.replicate (ctxt))
		end

feature -- Output

	dump: STRING is
			-- Dump string
		do
			!! Result.make (5 + anchor.count)
			Result.append ("like ")
			Result.append (anchor)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Like_keyword)
			ctxt.put_space
			ctxt.prepare_for_feature (anchor, Void)
			ctxt.put_current_feature
		end
	
feature {LIKE_ID_AS} -- Replication

	set_anchor (a: like anchor) is
		do
			anchor := a
		end

end -- class LIKE_ID_AS
