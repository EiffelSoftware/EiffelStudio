indexing
	description: "Abstract description of an Eiffel routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; f: like feature_name; o: like operands; has_target: BOOLEAN) is
			-- Create a new ROUTINE_CREATION AST node.
		require
			f_not_void: f /= Void
		local
			access_id_as: ACCESS_ID_AS
		do
			target := t
			feature_name := f
			operands := o
			if target /= Void then
				if target.target /= Void then
						-- Target is an entity
					create access_id_as
					access_id_as.set_feature_name (target.target)
					target_ast := access_id_as
				else
					if target.expression /= Void then
							-- Target is an expression
						target_ast := target.expression
					else
						if target.class_type = Void then
							if target.is_result then
									-- Target is Result
								create {RESULT_AS} target_ast
							else
									-- Target is Current
								create {CURRENT_AS} target_ast
							end
						end
					end
				end
			end

			create call_ast.make (feature_name, operands, has_target)
		ensure
			target_set: target = t
			feature_name_set: feature_name = f
			operands_set: operands = o
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_creation_as (Current)
		end

feature -- Attributes

	target: OPERAND_AS
			-- Target operand used when the feature will be called

	feature_name: ID_AS
			-- Feature name

	operands : EIFFEL_LIST [OPERAND_AS]
			-- List of operands used by the feature when called.

	target_ast: AST_EIFFEL
			-- Ast created for target during type checking.

	call_ast: DELAYED_ACCESS_FEAT_AS
			-- Ast created for delayed call during type checking.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			-- FIXME
--		end

feature {ROUTINE_CREATION_AS}

	set_target (t : like target) is
			-- Set `target' to `t'.
		do
			target := t
		end

	set_target_ast (t : like target_ast) is
			-- Set `target_ast' to `t'.
		do
			target_ast := t
		end

	set_feature_name (f : like feature_name) is
			-- Set `feature_name' to `f'.
		do
			feature_name := f
		end

	set_operands (o : like operands) is
			-- Set `operands' to `o'.
		do
			operands := o
		end

	set_call_ast (c : like call_ast) is
			-- Set `call_ast' to `c'.
		do
			call_ast := c
		end

end -- class ROUTINE_CREATION_AS
