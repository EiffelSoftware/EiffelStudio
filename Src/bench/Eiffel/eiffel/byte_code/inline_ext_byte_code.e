indexing
	description:
		"Encapsulation of a inline extension in C or C++ mode.";
	date: "$Date$";
	revision: "$Revision$"

class INLINE_EXT_BYTE_CODE

inherit
	EXT_BYTE_CODE
		redefine
			is_special, generate_body
		end

feature -- Properties

	is_cpp_code: BOOLEAN
			-- Is current inline to be generated in a CPP context?

feature -- Initialization

	set_is_cpp_code (v: BOOLEAN) is
			-- Assign `v' to `is_cpp_code'.
		do
			is_cpp_code := v
		ensure
			is_cpp_code_set: is_cpp_code = v
		end

feature -- Code generation

	generate_body is
			-- Generate the body for an external of type inline
		local
			l_inline_ext: INLINE_EXTENSION_I
			l_is_func: BOOLEAN
			l_ret_type: like result_type
		do
			if is_cpp_code then
				context.set_has_cpp_externals_calls (True)
			end
			l_inline_ext ?= context.current_feature.extension
			check
				l_inline_ext_not_void: l_inline_ext /= Void
			end
			if has_return_type or else not result_type.is_void then
				l_ret_type := Context.real_type (result_type)
				l_is_func := True
				buffer.putstring ("return ")
				l_ret_type.c_type.generate_cast (buffer)
				buffer.putstring (" (")
			else
				l_ret_type := result_type
			end
			l_inline_ext.generate_inline_body (buffer, l_ret_type.c_type)
			if l_is_func then
				buffer.putchar (')')
			end
			buffer.putchar (';')
		end

feature -- Convenience

	is_special: BOOLEAN is True

end -- class INLINE_EXT_BYTE_CODE
