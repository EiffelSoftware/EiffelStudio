-- Type evaluator

deferred class
	TYPE_EVALUATOR 

inherit
	SHARED_LIKE_CONTROLER

	SHARED_ERROR_HANDLER

	SHARED_RESCUE_STATUS

	COMPILER_EXPORTER
	
feature 

	evaluated_type (type: TYPE; feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Evaluation of type `type' in the context of the feature
			-- table `feat_table' and the feature `f'
		require
			non_void_type: type /= Void
			non_void_feat_table: feat_table /= Void
			non_void_feature: f /= Void
		local
			error_msg: VTAT1
		do
				-- Wipe out the like controler
			Like_control.wipe_out
			Result := type.solved_type (feat_table, f)
		rescue
			if Rescue_status.is_like_exception then
					-- Cycle in anchored type or unvalid anchor: the
					-- exception is raise in routine `solved_type' of
					-- classes LIKE_ID_AS, LIKE_FEATURE and LIKE_ARGUMENT
				Rescue_status.set_is_like_exception (False)
				error_msg := new_error
				error_msg.set_class (feat_table.associated_class)
				error_msg.set_type (type)
				update (error_msg)
				Error_handler.insert_error (error_msg)
					-- Exception propagation now: cannot go on...
				Rescue_status.set_is_error_exception (True)
			end
		end

	evaluated_type_for_format
		(type: TYPE; feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Evaluation of type `type' in the context of the feature
			-- table `feat_table' and the feature `f'
		require
			type /= Void
			feat_table /= Void
			f /= Void
		do
			if Rescue_status.is_like_exception or else 
				Rescue_status.is_error_exception
			then
				Error_handler.wipe_out
				Rescue_status.set_is_like_exception (False)
			else
					-- Wipe out the like controler
				Like_control.wipe_out
				Result := type.solved_type_for_format (feat_table, f)
			end
		rescue
			if Rescue_status.is_like_exception or else 
				Rescue_status.is_error_exception
			then
					-- Cycle in anchored type or unvalid anchor: the
					-- exception is raise in routine `solved_type' of
					-- classes LIKE_ID_AS, LIKE_FEATURE and LIKE_ARGUMENT
				retry
			end
		end
	
	new_error: VTAT1 is
			-- New error message
		deferred
		ensure 
			Result /= Void
		end

	update (error_msg: VTAT1) is
			-- Update error message
		deferred
		end

end
