indexing

	description: 
		"Transportable entity integer values.";
	date: "$Date$";
	revision: "$Revision$"

class EC_STONE_TYPES

feature -- Access

	Any_type: INTEGER is unique;
	Argument_type: INTEGER is unique;
	Class_type: INTEGER is unique
	Cluster_type: INTEGER is unique;
	Color_type: INTEGER is unique;
	Command_type: INTEGER is unique;
	Comment_type: INTEGER is unique;
	Constraint_type: INTEGER is unique;
	creation_type: INTEGER is unique
	Description_type: INTEGER is unique;
	element_type: INTEGER is unique;
	Feature_type: INTEGER is unique;
	Feature_clause_type: INTEGER is unique;
	Generic_type: INTEGER is unique;
	Group_type: INTEGER is unique;
	Handle_type: INTEGER is unique;
	Index_type: INTEGER is unique;
	Invariant_type: INTEGER is unique;
	Marker_type: INTEGER is unique;
	New_class_type: INTEGER is unique;
	New_cluster_type: INTEGER is unique;
	other_view_name_type: INTEGER is unique;
	Precondition_type: INTEGER is unique;
	Postcondition_type: INTEGER is unique;
	Query_type: INTEGER is unique;
	Relation_type: INTEGER is unique;
	Rename_type: INTEGER is unique;
	Result_type: INTEGER is unique;
	Specification_type: INTEGER is unique;
	Type_of_object_type: INTEGER is unique;
	Version_type: INTEGER is unique;
	view_name_type: INTEGER is unique
	Void_type: INTEGER is unique;
	add_class_list:INTEGER is unique
	add_color_list:INTEGER is unique
	parent_type	: INTEGER	is unique
	heir_type	: INTEGER	is unique
	client_type	: INTEGER	is unique
	supplier_type	: INTEGER	is unique
	string_type	: INTEGER	is unique

feature -- Pick and Drop

	any_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (any_type)
		end

	class_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (class_type)
		end

	cluster_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (cluster_type)
		end

	color_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (color_type)
		end

	creation_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (creation_type)
		end

	element_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (element_type)
		end

	feature_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (feature_type)
		end

	generic_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (generic_type)
		end

	handle_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (handle_type)
		end

	other_view_name_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (other_view_name_type)
		end

	new_class_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (relation_type)
		end

	new_cluster_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (relation_type)
		end

	relation_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (relation_type)
		end

	view_name_type_pnd: EV_PND_TYPE is 
		once
			!! Result.make_with_id (view_name_type)
		end

end -- class EC_STONE_TYPES
