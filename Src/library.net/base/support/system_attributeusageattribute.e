indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.AttributeUsageAttribute"

frozen external class
	SYSTEM_ATTRIBUTEUSAGEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_attribute_usage_attribute

feature {NONE} -- Initialization

	frozen make_attribute_usage_attribute (valid_on2: INTEGER) is
			-- Valid values for `valid_on2' are a combination of the following values:
			-- Assembly = 1
			-- Module = 2
			-- Class = 4
			-- Struct = 8
			-- Enum = 16
			-- Constructor = 32
			-- Method = 64
			-- Property = 128
			-- Field = 256
			-- Event = 512
			-- Interface = 1024
			-- Parameter = 2048
			-- Delegate = 4096
			-- ReturnValue = 8192
			-- All = 16383
		require
			valid_attribute_targets: (1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16383) & valid_on2 = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16383
		external
			"IL creator signature (enum System.AttributeTargets) use System.AttributeUsageAttribute"
		end

feature -- Access

	frozen get_inherited: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AttributeUsageAttribute"
		alias
			"get_Inherited"
		end

	frozen get_allow_multiple: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AttributeUsageAttribute"
		alias
			"get_AllowMultiple"
		end

	frozen get_valid_on: INTEGER is
		external
			"IL signature (): enum System.AttributeTargets use System.AttributeUsageAttribute"
		alias
			"get_ValidOn"
		ensure
			valid_attribute_targets: Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096 or Result = 8192 or Result = 16383
		end

feature -- Element Change

	frozen set_inherited (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.AttributeUsageAttribute"
		alias
			"set_Inherited"
		end

	frozen set_allow_multiple (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.AttributeUsageAttribute"
		alias
			"set_AllowMultiple"
		end

end -- class SYSTEM_ATTRIBUTEUSAGEATTRIBUTE
