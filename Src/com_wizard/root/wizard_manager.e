indexing
	description: "Code generation manager."

class
	WIZARD_MANAGER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	WIZARD_MESSAGE_OUTPUT
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
		do
			set_output_window (a_parent)
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	parent: MAIN_WINDOW
			-- Parent window used to parent.add_title messages

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

	Analysis_title: STRING is "Analysing Type Library"
			-- Analysis title

feature -- Basic Operations

	run is
			-- Start generation.
		do
			-- Compile IDL
			if shared_wizard_environment.abort then
				finish
			else
				parent.add_title (Idl_compilation_title)
				parent.process_messages
				Idl_compiler.compile_idl
				if shared_wizard_environment.abort then
					finish
				else
					-- Create Proxy/Stub
					if not shared_wizard_environment.use_universal_marshaller then
						-- Compile c iid file
						parent.add_title (Iid_compilation_title)
						parent.process_messages
						Idl_compiler.compile_iid
						if shared_wizard_environment.abort then
							finish
						else
							-- Compile c dlldata file
							parent.add_title (Data_compilation_title)
							parent.process_messages
							Idl_compiler.compile_data
							if shared_wizard_environment.abort then
								finish
							else
								-- Compile c proxy/stub file
								parent.add_title (Ps_compilation_title)
								parent.process_messages
								Idl_compiler.compile_ps
								if shared_wizard_environment.abort then
									finish
								else
									-- Final link
									parent.add_title (Link_title)
									parent.process_messages
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
		rescue
			shared_wizard_environment.set_abort (10)
			retry
		end

feature {NONE} -- Implementation

	generate is
			-- Generate Eiffel/C++ code
		do
			parent.add_title (Analysis_title)
			parent.process_messages
			set_system_descriptor (create {WIZARD_SYSTEM_DESCRIPTOR}.make)
			system_descriptor.generate (shared_wizard_environment.type_library_file_name)
		end
		
	finish is
			-- Abort code generation.
		local
			a_string: STRING
		do
			a_string := "Failed with return code "
			a_string.append_integer (shared_wizard_environment.return_code)
			parent.add_error (a_string)
		end

	Idl_compiler: WIZARD_IDL_COMPILER is
			-- IDL compiler
		once
			create Result.make (parent)
		end

end -- class WIZARD_MANAGER
	
