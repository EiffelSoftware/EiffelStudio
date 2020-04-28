note

	description:

		"Represents a config file's wrapper clause"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_CONFIG_WRAPPER_CLAUSE

feature {NONE} -- Initialization

	make
		do
		end

feature {ANY} -- Access

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Does `Current' accept `a_type'?
		require
			a_type_not_void: a_type /= Void
		deferred
		end

	accepts_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
			-- Does `Current' accept `a_declaration'?
		require
			a_declaration_not_void: a_declaration /= Void
		deferred
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create an Eiffel wrapper for `a_type' and add it to
			-- `eiffel_wrapper_set' (but only if it is not contained in
			-- this set already). Wrappers for members (if any) are not
			-- created (hence the "shallow" in the name). Because
			-- wrappers can have cyclic dependencies a two step wrapping
			-- process is needed.
		require
			a_type_not_void: a_type /= Void
			accepts_a_type: accepts_type (a_type)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		deferred
		end

	shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
									  a_include_header_file_name: STRING;
									  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create an Eiffel wrapper for `a_declaration' and add it to
			-- `eiffel_wrapper_set' (but only if it is not contained in
			-- this set already). Wrappers for members (if any) are not
			-- created (hence the "shallow" in the name). Because
			-- wrappers can have cyclic dependencies a two step wrapping
			-- process is needed.
		require
			a_declaration_not_void: a_declaration /= Void
			accepts_a_declaration: accepts_declaration (a_declaration)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		deferred
		end


	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
						 a_config_system: EWG_CONFIG_SYSTEM)
			-- Once `shallow_wrap_type' has been called on `a_type',
			-- `deep_wrap_type' can be called to wrap `a_type's members
			-- if any exist.
		require
			a_type_not_void: a_type /= Void
			accepts_a_type: accepts_type (a_type)
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_eiffel_wrapper_set_has_a_type: a_eiffel_wrapper_set.has_wrapper_for_type (a_type.skip_wrapper_irrelevant_types)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_config_system_not_void: a_config_system /= Void
		deferred
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
								  a_config_system: EWG_CONFIG_SYSTEM)
			-- Once `shallow_wrap_declaration' has been called on `a_declaration',
			-- `deep_wrap_declaration' can be called to wrap `a_declaration's members
			-- if any exist.
		require
			a_declaration_not_void: a_declaration /= Void
			a_eiffel_wrapper_set_has_a_declaration: a_eiffel_wrapper_set.has_wrapper_for_declaration (a_declaration)
			accepts_a_declaration: accepts_declaration (a_declaration)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_config_system_not_void: a_config_system /= Void
		deferred
		end

feature {NONE} -- Implementation


	eiffel_identifier_template: detachable STRING
			-- Template that when evaluated yields the name for the
			-- wrapper for the type which is being wrapped.  If `Void'
			-- the default name will be used.

	eiffel_identifier_for_type (a_type: EWG_C_AST_TYPE): STRING
			-- Eiffel identifier name for the wrapper of `a_type'
		require
			a_type_not_void: a_type /= Void
			accepts_a_type: accepts_type (a_type)
		do
			if attached eiffel_identifier_template as l_eiffel_identifier_template  then
				Result := l_eiffel_identifier_template -- TODO: eval variables, etc.
			else
				Result := default_eiffel_identifier_for_type (a_type)
			end
		ensure
			eiffel_identifier_not_void: Result /= Void
			eiffel_identifier_not_empty: Result.count > 0
		end

	eiffel_identifier_for_declaration (a_declaration: EWG_C_AST_DECLARATION): STRING
			-- Eiffel identifier name for the wrapper of `a_declaration'
		require
			a_declaration_not_void: a_declaration /= Void
			accepts_a_declaration: accepts_declaration (a_declaration)
		do
			if attached eiffel_identifier_template as l_eiffel_identifier_template then
				Result := l_eiffel_identifier_template -- TODO: eval variables, etc.
			else
				Result := default_eiffel_identifier_for_declaration (a_declaration)
			end
		ensure
			eiffel_identifier_not_void: Result /= Void
			eiffel_identifier_not_empty: Result.count > 0
		end

	default_eiffel_identifier_for_type (a_type: EWG_C_AST_TYPE): STRING
			-- Default eiffel identifier to be used for the wrapper of `a_type'.
			-- This identifier will be used if the user did not specify a custom
			-- identifier via `eiffel_identifier_template'.
		require
			a_type_not_void: a_type /= Void
			accepts_a_type: accepts_type (a_type)
		deferred
		ensure
			default_eiffel_identifier_not_void: Result /= Void
			default_eiffel_identifier_not_empty: Result.count > 0
		end

	default_eiffel_identifier_for_declaration (a_declaration: EWG_C_AST_DECLARATION): STRING
			-- Default eiffel identifier to be used for the wrapper of `a_declaration'.
			-- This identifier will be used if the user did not specify a custom
			-- identifier via `eiffel_identifier_template'.
		require
			a_declaration_not_void: a_declaration /= Void
			accepts_a_declaration: accepts_declaration (a_declaration)
		deferred
		ensure
			default_eiffel_identifier_not_void: Result /= Void
			default_eiffel_identifier_not_empty: Result.count > 0
		end

invariant

	eiffel_identifier_template_not_void_implies_not_empty: attached eiffel_identifier_template as l_eiffel_identifier_template  implies l_eiffel_identifier_template.count > 0

end



