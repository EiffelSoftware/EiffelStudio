indexing
	description:

		"Instruction that requests the execution of a feature and optionally the assignment of its result (if applicable)"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_INVOKE_FEATURE_REQUEST

inherit

	AUT_CALL_BASED_REQUEST
		rename
			make as make_request
		end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

create

	make,
	make_assign

feature {NONE} -- Initialization

	make (a_system: like system; a_feature_name: like feature_name; a_target: like target; an_argument_list: like argument_list) is
			-- Create new request to invoke a feature.
			-- If `a_feature' is a query its result will be ignored.
		require
			a_system_not_void: a_system /= Void
			a_feature_name_not_void: a_feature_name /= Void
			a_target_not_void: a_target /= Void
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		do
			make_request (a_system)
			feature_name := a_feature_name
			target := a_target
			argument_list := an_argument_list
		ensure
			system_set: system = a_system
			feature_name_set: feature_name = a_feature_name
			target_set: target = a_target
			argument_list_set:  argument_list = an_argument_list
		end

	make_assign (a_system: like system; a_receiver: like receiver; a_feature_name: like feature_name; a_target: like target; an_argument_list: like argument_list) is
			-- Create new request to invoke a query and to store its result in a
			-- variable.
		require
			a_system_not_void: a_system /= Void
			a_receiver_not_void: a_receiver /= Void
			a_feature_name_not_void: a_feature_name /= Void
			a_target_not_void: a_target /= Void
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		do
			make (a_system, a_feature_name, a_target, an_argument_list)
			receiver := a_receiver
		ensure
			receiver_set: receiver = a_receiver
		end

feature -- Status report

	is_setup_ready: BOOLEAN is
			-- Is setup of current request ready?
		do
			Result := target_type /= Void and then target_type.has_associated_class
		ensure then
			good_result: Result = (target_type /= Void) and then target_type.has_associated_class
		end

feature -- Access

	receiver: ITP_VARIABLE
			-- Variable where the result of `feature_to_call' is stored
			-- if `feature_to_call' is a query.

	feature_name: STRING
			-- Name of feature to invoke

	feature_to_call: FEATURE_I is
			-- Feature to invoke
		do
			Result := class_of_target_type.feature_named (feature_name)
		ensure then
			definition: Result = class_of_target_type.feature_named (feature_name)
		end

feature -- Settings

	set_target_type (a_type: like target_type) is
			-- Set `target_type' to `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_type_associated_with_class: a_type.has_associated_class
			a_type.associated_class.feature_named (feature_name) /= Void
		do
			target_type := a_type
		ensure
			type_set: target_type = a_type
		end

feature -- Processing

	process (a_processor: AUT_REQUEST_PROCESSOR) is
			-- Process current request.
		do
			a_processor.process_invoke_feature_request (Current)
		end

invariant

	feature_name_not_void: feature_name /= Void
	target_not_void: target /= Void
	argument_list_not_void: argument_list /= Void
	class_has_a_feature: target_type /= Void implies target_type.associated_class.feature_named (feature_name) /= Void
	no_argument_void: not argument_list.has (Void)

end
