indexing
	description: "Object to represent an exception"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION
	
inherit
	ANY
	
	IEIFFEL_EXCEPTION_IMPL_STUB
		redefine
			inner_exception,
			message,
			exception_code
		end
	
	EXCEPTIONS
		rename
			raise as raise_exceptions
		export
			{NONE} all
		end

creation
	make,
	make_with_child

feature {NONE} -- Implementation
		
	make (a_message: STRING; a_exception_code: INTEGER) is
			-- create execption with message `a_message'
		require
			non_void_message: a_message /= Void
			valid_message: not a_message.is_empty
			valid_exception_code: a_exception_code >= 0
		do
			message := clone (a_message)
			exception_code := a_exception_code
		ensure
			message_set: message.is_equal (a_message)
			exception_code_set: exception_code = a_exception_code
		end
		
	make_with_child (a_message: STRING; a_exception: EXCEPTION; a_exception_code: INTEGER) is
			-- create exception with inner child exception `a_exception'
		require
			non_void_message: a_message /= Void
			valid_message: not a_message.is_empty
			non_void_exception: a_exception /= Void
		do
			make (a_message, a_exception_code)
			inner_exception := a_exception
		ensure
			message_set: message.is_equal (a_message)
			non_void_inner_exception: inner_exception /= Void
			inner_exception_set: inner_exception.is_equal (a_exception)
			exception_code_set: exception_code = a_exception_code
		end		

feature -- Access

	inner_exception: EXCEPTION
			-- child exception

	message: STRING
			-- execption message
	
	exception_code: INTEGER 
			-- code for exception

feature -- Status setting
		
	set_inner_exception (a_exception: EXCEPTION) is
			-- set `inner_exception' to `a_exception'
		require
			non_void_exception: a_exception /= Void
		do
			inner_exception := a_exception
		ensure
			non_void_inner_exception: inner_exception /= Void
			inner_exception_set: inner_exception.is_equal (a_exception)
		end
		
feature -- Basic operations

	raise is
			-- raises current exception
		do
			raise_exceptions (message)
		end

invariant
	non_void_message: message /= Void

end -- class EXCEPTION
