indexing
	description: "Code generation manager."

class
	WIZARD_MANAGER

inherit
	SHARED_DATA
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent) is
			-- Initialize manager.
		require
			non_void_parent: a_parent /= Void
			valid_parent: a_parent.exists
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	parent: MAIN_WINDOW
			-- Parent window used to display messages

	Idl_compilation_title: STRING is "IDL Compilation"
			-- IDL compilation title
	
	Iid_compilation_title: STRING is "C Compilation Step 1"
			-- Iid generated C file compilation title
	
	Data_compilation_title: STRING is "C Compilation Step 2"
			-- Inprocess dll generated C file compilation title
	
	Ps_compilation_title: STRING is "C Compilation Step 3"
			-- Proxy/stub generated C file compilation title
	
	Link_title: STRING is "Creating Proxy Stub Dll"
			-- Link title

feature -- Basic Operations

	run is
			-- Start generation.
		do
			-- Compile IDL
			display (Idl_compilation_title)
			Idl_compiler.compile_idl
			if shared_wizard_environment.abort then
				finish
			else
			
				-- Create Proxy/Stub
				if not shared_wizard_environment.use_universal_marshaller then
					-- Compile c iid file
					display (Iid_compilation_title)
					Idl_compiler.compile_iid
					if shared_wizard_environment.abort then
						finish
					else

						-- Compile c dlldata file
						display (Data_compilation_title)
						Idl_compiler.compile_data
						if shared_wizard_environment.abort then
							finish
						else

							-- Compile c proxy/stub file
							display (Ps_compilation_title)
							Idl_compiler.compile_ps
							if shared_wizard_environment.abort then
								finish
							else

								-- Final link
								display (Link_title)
								Idl_compiler.link
								if shared_wizard_environment.abort then
									finish
								else
									generate
								end
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	generate is
			-- Generate Eiffel/C++ code
		do
		end
		
	finish is
			-- Abort code generation.
		local
			a_string: STRING
		do
			a_string := "Failed with return code "
			a_string.append_integer (shared_wizard_environment.return_code)
			display (a_string)
		end

	display (a_string: STRING) is
			-- Display `a_string' in `parent'.
		require
			non_void_string: a_string /= Void
		do
			parent.new_line
			parent.add_title (a_string)
			parent.new_line
			parent.process_messages
		end

	Idl_compiler: WIZARD_IDL_COMPILER is
			-- IDL compiler
		once
			create Result.make (parent)
		end

end -- class WIZARD_MANAGER
	
