indexing
	description: "Summary description for {AUT_CALL_BASED_REQUEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_CALL_BASED_REQUEST

inherit
	AUT_REQUEST

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

feature -- Access

	target: ITP_VARIABLE
			-- Target for the call to feature `feature_to_call'
			-- In case of object creation, this means the object to be created

	target_type: TYPE_A
			-- Type of target for call to feature `feature_to_call'.
			-- In case of object creation, this means the type of the object to be created

	class_of_target_type: CLASS_C is
			-- Direct base class of `target_type'
		require
			ready: is_setup_ready
		do
			Result := target_type.associated_class
		ensure
			definition: Result = target_type.associated_class
		end

	argument_list: DS_LINEAR [ITP_EXPRESSION]
			-- Arguments used to invoke `procedure';
			-- Void if default creation procedure is to be used .

	feature_to_call: FEATURE_I is
			-- Feature to be called in current request
		require
			ready: is_setup_ready
		deferred
		ensure
			result_attached: Result /= Void
		end

	argument_count: INTEGER is
			-- Number of arguments in `feature_to_call'
			-- 0 if `feature_to_call' takes no argument.
		require
			ready: is_setup_ready
		do
			if feature_to_call /= Void then
				Result := feature_to_call.argument_count
			end
		ensure
			good_result:
				(feature_to_call /= Void implies Result = feature_to_call.argument_count) and then
				(feature_to_call = Void implies Result = 0)
		end

feature -- Status report

	is_setup_ready: BOOLEAN is
			-- Is setup of current request ready?
		deferred
		end

	is_feature_query: BOOLEAN is
			-- Is `feature_to_call' a query?
		require
			type_attached: target_type /= Void
		do
			Result := feature_to_call.type /= void_type
		ensure
			good_result: Result = (feature_to_call.type /= void_type)
		end

	has_argument: BOOLEAN is
			-- Does `feature_to_call' has any formal argument?
		require
			is_ready: is_setup_ready
		do
			Result := argument_count > 0
		ensure
			good_result: Result = (argument_count > 0)
		end

end
