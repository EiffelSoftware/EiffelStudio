note
	description: "Wrapper for the NSAnimatablePropertyContainer Protocol."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

-- TODO: rename to NS_ANIMATABLE_PROPERTY_CONTAINER

deferred class
	NS_ANIMATABLE_PROPERTY_CONTAINER [G -> NS_ANIMATABLE_PROPERTY_CONTAINER[G] create share_from_pointer end]

inherit
	NS_OBJECT

feature -- Getting the Animator Proxy

	animator: G
			-- Returns a proxy object for the receiver that can be used to initiate implied animation for property changes.
		do
			-- FIXME: I'm not quite happy with the design at the moment. See the discussion on the Eiffel Software mailing list from 30.6.09
			create Result.share_from_pointer (animation_animator (item))
		end

feature -- Managing Animations for Properties

	animations: NS_DICTIONARY
			-- Returns the optional dictionary that maps event trigger keys to animation objects.
		do
			create Result.make_from_pointer (animation_animations (item))
		end

	set_animations (a_dict: NS_DICTIONARY)
			-- Sets the option dictionary that maps event trigger keys to animation objects.
		do
			animation_set_animations (item, a_dict.item)
		end

	animation_for_key (a_key: NS_STRING): detachable NS_OBJECT
			-- Returns the animation that should be performed for the specified key.
			-- FIXME: The result type is actually a subtype of CAAnimation
		local
			l_result_ptr: POINTER
		do
			l_result_ptr :=	animation_animation_for_key (item, a_key.item)
			if l_result_ptr /= default_pointer then
				create Result.share_from_pointer (l_result_ptr)
			end
		end

feature {NONE} -- Implementation

	frozen animation_animator (a_target: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(id <NSAnimatablePropertyContainer>)$a_target animator];"
		end

	frozen animation_animations (a_animation: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(id <NSAnimatablePropertyContainer>)$a_animation animations];"
		end

	frozen animation_set_animations (a_animation: POINTER; a_dict: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(id <NSAnimatablePropertyContainer>)$a_animation setAnimations: $a_dict];"
		end

	frozen animation_animation_for_key (a_animation: POINTER; a_key: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(id <NSAnimatablePropertyContainer>)$a_animation animationForKey: $a_key];"
		end
end
