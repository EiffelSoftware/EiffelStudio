note
	description: "Wrapper for the NSAnimatablePropertyContainer Protocol."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_ANIMATION

inherit
	NS_OBJECT

feature -- Getting the Animator Proxy

	animator: like Current
		deferred
		ensure
			Result /= Void
		end

feature -- Managing Animations for Properties

	animations: NS_DICTIONARY
		do
			create Result.make_from_pointer (animation_animations (item))
		ensure
			Result /= void
		end

	set_animations (a_dict: NS_DICTIONARY)
		do
			animation_set_animations (item, a_dict.item)
		end

	animation_for_key (a_key: NS_STRING): NS_OBJECT
		do
			create Result.share_from_pointer (animation_animation_for_key (item, a_key.item))
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
