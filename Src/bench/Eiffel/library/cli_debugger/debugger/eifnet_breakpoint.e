indexing
	description: ".NET breakpoint"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_BREAKPOINT
	
inherit
	
	DEBUG_OUTPUT
		redefine
			is_equal
		end
	
	HASHABLE
		redefine
			is_equal
		end
	
	ICOR_EXPORTER
		export
			{NONE} all
		redefine
			is_equal
		end
	
create
	make
	
feature
	
	make (a_module_key: STRING; a_class, a_feature: INTEGER; a_line: INTEGER_64) is
			-- Initialize BP item data
		require
			module_key_lower_case: is_lower_case (a_module_key)
		do
			module_key := a_module_key
			class_token := a_class
			feature_token := a_feature
			break_index := a_line
		end

feature -- Hashable interface

	hash_code: INTEGER is
		do
			Result := ([module_key, class_token, feature_token, break_index]).hash_code
			--| if overflow
			if Result < 0 then
				Result := - Result
			end
		end

feature -- comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to `Current'?
			-- `other' equals to `Current' if they represent
			-- the same physical breakpoint, in other words they
			-- have the same `body_index' and `offset'. 
			-- We use 'body_index' because it does not change after
			-- a recompilation
		do
			Result := (other.break_index = break_index) 
					and then other.module_key.is_equal (module_key)
					and then other.class_token = class_token
					and then other.feature_token = feature_token					
		end
		
feature -- Access assertion

	is_lower_case (a_string: STRING): BOOLEAN is
		require
			not_void: a_string /= Void
		local
			l_str: STRING
		do
			l_str:= clone (a_string)
			l_str.to_lower
			Result := l_str.is_equal (a_string)
		end
		
feature -- access

	module_key: STRING

	class_token: INTEGER
	
	feature_token: INTEGER
	
	break_index: INTEGER_64
	
feature -- dotnet properties

	icor_breakpoint: ICOR_DEBUG_BREAKPOINT
	
	set_icor_breakpoint (a_val: like icor_breakpoint) is
		do
			icor_breakpoint := a_val
			icor_breakpoint.add_ref
		end	
	
feature -- status
	
	is_active: BOOLEAN
	
	enabled: BOOLEAN
	
feature -- change

	enable is
			-- 
		do
			enabled := True
		end
		
	disable is
			-- 
		do
			enabled := False
		end

	activate is
			-- 
		do
			is_active := True				
		end
		
	unactivate is
			-- 
		do
			is_active := False				
		end		
		
feature -- debug output

	debug_output: STRING is
			-- 
		do
			Result := "BP: "
						+ "Class  [" + class_token.out + "] " 
						+ "Feature[" + feature_token.out +"] "
						+ "Index  [" + break_index.out +"] "
						+ "Module [" + module_key + "] " 
		end

end -- class EIFNET_BREAKPOINT
