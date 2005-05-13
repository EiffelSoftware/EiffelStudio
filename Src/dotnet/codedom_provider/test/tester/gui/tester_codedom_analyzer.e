indexing
	description: "Analyze codedom provider dll"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_CODEDOM_ANALYZER

inherit
	TESTER_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	language_extension: STRING
			-- File extension of language associated with codedom provider last given to `analyze'
			
	is_case_sensitive: BOOLEAN
			-- Is language associated with codedom provider last given to `analyze' case sensitive?
	
	analysis_successful: BOOLEAN
			-- Was last call to `analyze' successful?
	
	codedom_provider: SYSTEM_DLL_CODE_DOM_PROVIDER
			-- Codedom provider instance

feature -- Basic Operations

	analyze (a_codedom_provider: STRING) is
			-- Analyze `a_codedom_provider' and initialized internal data accordingly.
		require
			non_void_provider: a_codedom_provider /= Void
		local
			l_config: CODE_MACHINE_CONFIGURATION
			l_assembly: ASSEMBLY
			l_types: NATIVE_ARRAY [SYSTEM_TYPE]
			i: INTEGER
			l_found: BOOLEAN
			l_retried: BOOLEAN
		do
			analysis_successful := False
			codedom_provider := Void
			language_extension := Void
			if not l_retried then
				create l_config.make
				if l_config.languages.has (a_codedom_provider) then
					codedom_provider ?= {ACTIVATOR}.create_instance ({SYSTEM_TYPE}.get_type (l_config.language_provider (a_codedom_provider)))
				else
					if {SYSTEM_FILE}.exists (a_codedom_provider) then
						l_assembly := {ASSEMBLY}.load_from (a_codedom_provider)
						from
							l_types := l_assembly.get_types
						until
							i = l_types.count or l_found
						loop
							l_found := l_types.item (i).base_type.name.equals (("System.CodeDom.Compiler.CodeDomProvider").to_cil)
							i := i + 1
						end
					end
					if l_found then
						codedom_provider ?= {ACTIVATOR}.create_instance (l_types.item (i - 1))
					end
				end
				if codedom_provider /= Void then
					language_extension := codedom_provider.file_extension
					is_case_sensitive := codedom_provider.language_options /= {SYSTEM_DLL_LANGUAGE_OPTIONS}.Case_insensitive
					analysis_successful := True
				end
			end
		ensure
			codedom_provider_void_if_not_successful: not analysis_successful implies codedom_provider = Void
			language_extension_void_if_not_successful: not analysis_successful implies language_extension = Void
			codedom_provider_if_successful: analysis_successful implies codedom_provider /= Void
			language_extension_if_successful: analysis_successful implies language_extension /= Void
		rescue
			l_retried := True
			retry
		end
		
invariant
	codedom_provider_void_if_not_successful: not analysis_successful implies codedom_provider = Void
	language_extension_void_if_not_successful: not analysis_successful implies language_extension = Void
	codedom_provider_if_successful: analysis_successful implies codedom_provider /= Void
	language_extension_if_successful: analysis_successful implies language_extension /= Void

end -- class TESTER_CODEDOM_ANALYZER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------