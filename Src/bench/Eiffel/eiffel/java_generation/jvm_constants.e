indexing
	description: "Constants needed for generating JVM Byte Code"
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_CONSTANTS

inherit
	IL_CONST
				
feature {ANY} -- Access flags for Java Byte code files
			
	Acc_public: INTEGER is 0x0001
	Acc_final: INTEGER is 0x0010
	Acc_super: INTEGER is 0x0020
	Acc_interface: INTEGER is 0x0200
	Acc_abstract: INTEGER is 0x0400
	Acc_static: INTEGER is 0x0008
	Acc_transient: INTEGER is 0x0080
	Acc_volatile: INTEGER is 0x0040
	Acc_protected: INTEGER is 0x0004
	Acc_private: INTEGER is 0x0002
			
feature {ANY} -- Type sizes 
			
	Int_8_size: INTEGER is 1
			
	Int_16_size: INTEGER is 2
			
	Int_32_size: INTEGER is 4
			
	Int_64_size: INTEGER is 8
			
	Double_size: INTEGER is 8
			
	Float_size: INTEGER is 4
			
feature {ANY} -- JVM types
	void_type: INTEGER is 0
	object_type: INTEGER is 1
	int_type: INTEGER is 2
	long_type: INTEGER is 3
	float_type: INTEGER is 4
	double_type: INTEGER is 5
	short_type: INTEGER is 6
	bool_type: INTEGER is 7
	char_type: INTEGER is 8
	byte_type: INTEGER is 9
			
	valid_jvm_type (a_jvm_type: INTEGER): BOOLEAN is
			-- is `a_jvm_type' a valid jvm type ?
		do
			Result := a_jvm_type >= 0 and a_jvm_type <= 9
		end
	
	jvm_type_to_stack_size (a_jvm_type: INTEGER): INTEGER is
			-- takes a *_type from above and gives you the number of
			-- words a value of this type would take on the stack.
			-- note: unfortunatly the JVM has an untyped stack. that 
			-- means that the compiler (we) need to make sure i.e. what 
			-- add instructino (iadd, ladd, fadd, dadd) needs to be 
			-- applied. on the jvm some types take two words on the 
			-- stack and some take one (same goes for local variables 
			-- and slots). have a look at the jvm specs. for details.
		do
			inspect
				a_jvm_type
			when void_type then Result := 1
			when object_type then Result := 1
			when int_type then Result := 1
			when long_type then Result := 2
			when float_type then
				check False end -- FIXME
			when double_type then Result := 2
			when short_type then
			when bool_type then Result := 1
			when char_type then
				check False end -- FIXME
			when byte_type then
				check False end -- FIXME
			else
				check False end
			end
		end
				
	il_kind_to_jvm_type (il_kind: INTEGER): INTEGER is
			-- converts a il kind constant (see il_* in IL_CONST) to jvm type ids
			-- (see in Current *_type)
		require
			valid_type_kind: valid_type_kind (il_kind)
		do
			inspect
				il_kind
			when il_i1 then
				Result := byte_type
			when il_i2 then
				Result := short_type
			when il_i4 then
				Result := int_type
			when il_i8 then
				Result := long_type
			when il_r4 then
				Result := float_type
			when il_r8 then
				Result := double_type
			when il_ref then
				Result := object_type
			else
				check
					dead_end: False
				end
			end
		end
end -- class JVM_CONSTANTS





