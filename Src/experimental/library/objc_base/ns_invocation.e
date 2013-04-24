note
	description: "Summary description for {NS_INVOCATION}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INVOCATION

inherit
	NS_OBJECT

create
	invocation_with_method_signature
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Creating NSInvocation Objects

	invocation_with_method_signature (a_sig: NS_METHOD_SIGNATURE)
			-- Returns an `NSInvocation' object able to construct messages using a given method signature.
		do
			make_from_pointer ({NS_INVOCATION_API}.invocation_with_method_signature (a_sig.item))
		end

feature -- Configuring an Invocation Object

	set_selector (a_selector: OBJC_SELECTOR)
			-- Sets the receiver`s selector.
		do
			{NS_INVOCATION_API}.set_selector (item, a_selector.item)
		end

	selector: OBJC_SELECTOR
			-- Returns the receiver`s selector, or 0 if it hasn`t been set.
		do
			create Result.make_from_pointer ({NS_INVOCATION_API}.selector (item))
		end

	set_target (a_target: NS_OBJECT)
			-- Sets the receiver`s targe.
		do
			{NS_INVOCATION_API}.set_target (item, a_target.item)
		end

	target: NS_OBJECT
			-- Returns the receiver`s target, or `nil' if the receiver has no target.
		do
			create Result.share_from_pointer ({NS_INVOCATION_API}.target (item))
		end

	set_argument_at_index (a_buffer: POINTER; a_idx: INTEGER)
			-- Sets an argument of the receiver.
		do
			{NS_INVOCATION_API}.set_argument_at_index (item, a_buffer, a_idx)
		end

	get_argument_at_index (a_buffer: POINTER; a_idx: INTEGER)
			-- Returns by indirection the receiver`s argument at a specified index.
		do
			{NS_INVOCATION_API}.get_argument_at_index (item, a_buffer, a_idx)
		end

	arguments_retained: BOOLEAN
			-- Returns `YES' if the receiver has retained its arguments, `NO' otherwise.
		do
			Result := {NS_INVOCATION_API}.arguments_retained (item)
		end

	retain_arguments
			-- If the receiver hasn`t already done so, retains the target and all object arguments of the receiver and copies all of its C-string arguments.
		do
			{NS_INVOCATION_API}.retain_arguments (item)
		end

	set_return_value (a_ret_loc: POINTER)
			-- Sets the receiver`s return value.
		do
			{NS_INVOCATION_API}.set_return_value (item, a_ret_loc)
		end

	get_return_value (a_ret_loc: POINTER)
			-- Gets the receiver`s return value.
		do
			{NS_INVOCATION_API}.get_return_value (item, a_ret_loc)
		end

feature -- Dispatching an Invocation

	invoke
			-- Sends the receiver`s message (with arguments) to its target and sets the return value.
		do
			{NS_INVOCATION_API}.invoke (item)
		end

	invoke_with_target (a_target: NS_OBJECT)
			-- Sets the receiver`s target, sends the receiver`s message (with arguments) to that target, and sets the return value.
		do
			{NS_INVOCATION_API}.invoke_with_target (item, a_target.item)
		end

feature -- Getting the Method Signature

	method_signature: NS_METHOD_SIGNATURE
			-- Returns the receiver`s method signature.
		do
			create Result.share_from_pointer ({NS_INVOCATION_API}.method_signature (item))
		end

end
