note
	description: "Method attributes constants"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_METHOD_ATTRIBUTES


feature -- Method attributes

	member_access_mask: INTEGER_16 = 0x0007

	compiler_controlled: INTEGER_16 = 0x0000
		-- Member not referenceable.

	private: INTEGER_16 = 0x0001
			-- Accessible only by the parent type.

	family_and_assembly: INTEGER_16 = 0x0002
			-- Accessible by sub-types only in this Assembly.

	assembly: INTEGER_16 = 0x0003
			-- Accessibly by anyone in the Assembly.

	family: INTEGER_16 = 0x0004
			-- Accessible only by type and sub-types.

	family_or_assembly: INTEGER_16 = 0x0005
			-- Accessibly by sub-types anywhere, plus anyone in assembly.

	public: INTEGER_16 = 0x0006
			-- Accessibly by anyone who has visibility to this scope.

	static: INTEGER_16 = 0x0010
			-- Defined on type, else per instance.

	final: INTEGER_16 = 0x0020
			-- Method may not be overridden.

	virtual: INTEGER_16 = 0x0040
			-- Method is virtual.

	hide_by_signature: INTEGER_16 = 0x0080
			-- Method hides by name+sig, else just by name.

	vtable_layout_mask: INTEGER_16 = 0x0100
			-- Use this mask to retrieve vtable attributes.

	reuse_slot: INTEGER_16 = 0x0000
			-- Method reuses existing slot in vtable.

	new_slot: INTEGER_16 = 0x0100
			-- Method always gets a new slot in the vtable.

	abstract: INTEGER_16 = 0x0400
			-- Method does not provide an implementation.

	special_name: INTEGER_16 = 0x0800
			-- Method is special.

feature -- Interop method attributes

	pinvoke_implementation: INTEGER_16 = 0x2000
			-- Implementation is forwarded through PInvoke.

	unmanaged_export: INTEGER_16 = 0x0008
			-- Reserved: shall be zero for conforming implementations.

feature -- Additional flags

	rt_special_name: INTEGER_16 = 0x1000
			-- CLI provides 'special' behavior, depending upon the name of the method.

	has_security: INTEGER_16 = 0x4000
			-- Method has security associate with it.

	require_security_object: INTEGER_16 = 0x8000
			-- Method calls another method containing security code..

feature -- Method implementation attributes

	code_type_mask: INTEGER_16 = 0x0003

	il: INTEGER_16 = 0x0000
			-- Method impl is CIL.

	native: INTEGER_16 = 0x0001
			-- Method impl is native.

	opt_il: INTEGER_16 = 0x0002
			-- Reserved: shall be zero in conforming implementations.

	runtime: INTEGER_16 = 0x0003
			-- Method impl is provided by the runtime.

	managed_mask: INTEGER_16 = 0x0004
			-- Flags specifying whether the code is managed or unmanaged..

	unmanaged: INTEGER_16 = 0x0004
			-- Method impl is unmanaged, otherwise managed.

	managed: INTEGER_16 = 0x0000
			-- Method impl is managed.

feature -- Method implementation info and interop.

	forward_ref: INTEGER_16 = 0x0010
			-- Indicates method is defined; used primarily in merge scenarios.

	preserve_sig: INTEGER_16 = 0x0080
			-- Reserved: conforming implementations may ignore.

	internal_call: INTEGER_16 = 0x1000
			-- Reserved: shall be zero in conforming implementations.

	synchronized: INTEGER_16 = 0x0020
			-- Method is single threaded through the body.

	no_inlining: INTEGER_16 = 0x0008
			-- Method may not be inlined.

	max_method_impl_value: INTEGER_16 = 0xffff;
			-- Range check value.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CIL_MD_METHOD_ATTRIBUTES
