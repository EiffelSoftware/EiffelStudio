note
	description:
		"Eiffel Vision tooltipable. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE_IMP

inherit
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING_32
			-- Tooltip that has been set.
		do
			if tooltip_text = void then
					create tooltip_text.make_unshared_with_eiffel_string ("")
			end
			Result := tooltip_text.string
		end

feature -- Element change

	set_tooltip (a_text: STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		local
			ret: INTEGER
		do
			create tooltip_text.make_unshared_with_eiffel_string (a_text)
			ret := set_tool_tip_external (tooltip_text.item, c_object)
		end



feature {NONE} -- Implementation

		set_tool_tip_external (a_cf_string_ptr: POINTER; a_object: POINTER): INTEGER
		-- set a boolean value with set_control_data
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					    OSStatus status;
					    HMHelpContentRec helpTag;
					    helpTag.version = kMacHelpVersion;
					    helpTag.tagSide = kHMDefaultSide;
					    SetRect (&helpTag.absHotRect, 0, 0, 0, 0);
					    helpTag.content[kHMMinimumContentIndex].contentType = kHMCFStringLocalizedContent;
					    helpTag.content[kHMMinimumContentIndex].u.tagCFString = $a_cf_string_ptr;
					    helpTag.content[kHMMaximumContentIndex].contentType = kHMNoContent;
					    status = HMSetControlHelpContent ($a_object, &helpTag);
					    return status;
				}
			]"
		end

		get_tool_tip_external (out_cfstring: POINTER; a_object: POINTER): INTEGER
			-- set a boolean value with set_control_data
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					    OSStatus status;
					    HMHelpContentRec helpTag;
					    status = HMGetControlHelpContent ($a_object, &helpTag);
					    $out_cfstring = (EIF_POINTER)helpTag.content[kHMMinimumContentIndex].u.tagCFString;
					    return status;
				}
			]"
		end

	tooltip_text : EV_CARBON_CF_STRING

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- EV_TOOLTIPABLE_IMP

