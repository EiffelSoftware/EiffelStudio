indexing
	description: "Abstract description of a non-nested call."
	date: "$Date$"
	revision: "$Revision$"

deferred class ACCESS_AS

inherit
	CALL_AS
		redefine
			byte_node
		end

	SHARED_ARG_TYPES

feature -- Properties

	access_name: STRING is
		deferred
		end
		
	parameters: EIFFEL_LIST [EXPR_AS] is
			-- List of parameters if any
		deferred
		end

feature

	byte_node: ACCESS_B is
			-- Associated byte code
		deferred
		end

feature -- Convenience

	is_argument: BOOLEAN is
			-- Is this an access to an argument?
		do
		end

feature -- Error reporting

	insert_vuar2_error (a_feature: FEATURE_I; a_in_class_id, a_pos: INTEGER; a_actual_type, a_formal_type: TYPE_A) is
			-- Insert a VUAR2 error in call to `a_feature' from `a_in_class_id' class for argument
			-- at position `a_pos'.
		require
			a_feature_not_void: a_feature /= Void
			a_in_class_id_non_negative: a_in_class_id >= 0
			a_pos_positive: a_pos > 0
			a_pos_valid: a_pos <= a_feature.argument_count
			a_actual_type_not_void: a_actual_type /= Void
			a_formal_type_not_void: a_formal_type /= Void
		local
			l_vuar2: VUAR2
		do
			create l_vuar2
			context.init_error (l_vuar2)
			l_vuar2.set_called_feature (a_feature, a_in_class_id)
			l_vuar2.set_argument_position (a_pos)
			l_vuar2.set_argument_name (a_feature.arguments.item_name (a_pos))
			l_vuar2.set_actual_type (a_actual_type)
			l_vuar2.set_formal_type (a_formal_type)
			l_vuar2.set_location (parameters.i_th (a_pos).start_location)
			Error_handler.insert_error (l_vuar2)
		end

end -- class ACCESS_AS
