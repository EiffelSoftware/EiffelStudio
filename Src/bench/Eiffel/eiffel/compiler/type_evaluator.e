-- Type evaluator

deferred class TYPE_EVALUATOR 

inherit

	SHARED_LIKE_CONTROLER;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS
	
feature 

	evaluated_type
		(type: TYPE; feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Evaluation of type `type' in the context of the feature
			-- table `feat_table' and the feature `f'
		require
			type /= Void;
			feat_table /= Void;
			f /= Void;
		local
			error_msg: VTAT1;
		do
				-- Wipe out the like controler
			Like_control.wipe_out;
			Result := type.solved_type (feat_table, f);
		rescue
			if Rescue_status.is_like_exception then
					-- Cycle in anchor type or unvalid anchor: the
					-- exception is raise in routine `solved_type' of
					-- classes LIKE_ID_AS, LIKE_FEATURE and LIKE_ARGUMENT
				Rescue_status.set_is_like_exception (False);
				error_msg := new_error;
				error_msg.set_class (feat_table.associated_class);
				error_msg.set_type (type);
				update (error_msg);
				Error_handler.insert_error (error_msg);
					-- Exception propagation now: cannot go on...
			end;
		end;

	
	new_error: VTAT1 is
			-- New error message
		deferred
		ensure 
			Result /= Void
		end;

	update (error_msg: VTAT1) is
			-- Update error message
		do
			-- Do nothing
		end;

end
