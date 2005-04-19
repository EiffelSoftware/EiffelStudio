indexing
	description: "Given a CLICKABLE_AST node, return the associated CLASS_I instance it represents."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CLICKABLE_INFO_VISITOR

inherit
	AST_NULL_VISITOR
		redefine
			process_precursor_as,
			process_class_type_as,
			process_class_as
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Queries
	
	associated_eiffel_class (a_class_i: CLASS_I; a_node: CLICKABLE_AST): CLASS_I is
		require
			a_class_i_not_void: a_class_i /= Void
			a_node_not_void: a_node /= Void
			a_node_is_class_or_precursor: a_node.is_class or a_node.is_precursor
		do
			reference_class := a_class_i
			a_node.process (Current)
			Result := last_class
			last_class := Void
			reference_class := Void
		end

feature {NONE} -- Implementation

	reference_class: CLASS_I
			-- Class in which `last_class' will be resolved

	last_class: CLASS_I
			-- Last computed class

	process_precursor_as (l_as: PRECURSOR_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.class_named (l_as.parent_base_class.class_name, reference_class.cluster)
		end
		
	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.class_named (l_as.class_name, reference_class.cluster)
		end

	process_class_as (l_as: CLASS_AS) is
		do
			check
				reference_class_not_void: reference_class /= Void
			end
			last_class := Universe.class_named (l_as.class_name, reference_class.cluster)
		end
		
end
