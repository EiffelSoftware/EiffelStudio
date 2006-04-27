/*
 * Program to transpile C++ code into Eiffel code.
 *
 * This distribution is public domain (not only the PCCTS-BASED C++ part
 * but also the Eiffel-code-generation-part.) ISE Inc. is not responsible
 * for parts that do not work (properly).
 * You may use this whole package in any tool or parser you write as long
 * as you don't claim ownership or authorship of either part of this (below)
 * written class and classes it relies on other than the ones coming from PCCTS.
 * For copyright on PCCTS used classes see comments above.
 *
 * Generating the three classes written (and included) below, took about two / three
 * days of actual work. Therefore, this transpiler might be incomplete and some parts of C++ might
 * not even be supported. Don't blame us for lacking some abilities. This version already
 * automizes a lot of work for you, so in fact it is a good product ;-)
 *
 * Feel free to make improvements to this package in any form, but make sure you
 * write the original authors about your improvements. ISE Inc. can be reached at
 * support@eiffel.com. Improvements to the C++ grammar should be sent to parrt@parr-research.com
 * and possibly to support@eiffel.com. Improvements to PCCTS should only be sent to
 * parrt@parr-research.com. C++-Eiffel-Transpiler improvements should be sent to
 * support@eiffel.com.
 *
 * If you don't feel like improving (and hacking) the code yourself, you can
 * always contact ISE Inc. about the bugs, lacks, leaks, and whatever you may find
 * and we will at least have a look at the e-mail you sent us.
 * We cannot guarantee that bugs will fixed, improvements will be made etc.etc. for
 * this product is public domain and not the main goal of our company.
 */

// Class: Constructor
// Description: Encapsulation of C++ ctor decl or def.
// $Date$
// $Revision$

#ifndef _Constructor_H
#define _Constructor_H

#include "global.h" //*** new
#include <ctype.h>


class Constructor
{
	public:		// Creation and Destruction
		Constructor(char *name, int number)
			{
				int index;

				_name = _strdup(name);
				_array_length = ARRAY_LENGTH;
				_number = number;
				_params = 0;

				_storage_classes = new CPPParser::StorageClass[NB_MAX];
				_type_qualifiers = new CPPParser::TypeQualifier[NB_MAX];
				_type_specifiers = new CPPParser::TypeSpecifier[NB_MAX];
				_pointers = new int[NB_MAX];
				_arrays = new int[NB_MAX];
				_names = new char*[NB_MAX];
				_qualified_types = new char*[NB_MAX];
				for(index = 0; index < NB_MAX; index += 1)
				{
					_pointers[index] = 0;
					_arrays[index] = 0;
					_names[index] = NULL;
					_qualified_types[index] = NULL;
				}
				_comment_action_status = COMMENT_NONE;
			}
		~Constructor()
			{
				int index;

				free(_name);
				delete _storage_classes;
				delete _type_qualifiers;
				delete _type_specifiers;
				delete _pointers;
				delete _arrays;
				for(index = 0; index < _params; index += 1)
				{
					delete _names[index];
					delete _qualified_types[index];
				}
				delete _names;
				delete _qualified_types;
			}

	public:		// Element Change
		void addParameter(CPPParser::StorageClass sc, CPPParser::TypeQualifier tq, CPPParser::TypeSpecifier ts)
			{
				_storage_classes[_params] = sc;
				_type_qualifiers[_params] = tq;
				_type_specifiers[_params] = ts;

				_params += 1;
				if(_params >= _array_length)
				{
					CPPParser::StorageClass *new_sc;
					CPPParser::TypeQualifier *new_tq;
					CPPParser::TypeSpecifier *new_ts;
					char **new_names;
					char **new_qts;
					int index;
					int *new_p;
					int *new_a;

					new_sc = new CPPParser::StorageClass[_array_length + NB_MAX];
					new_tq = new CPPParser::TypeQualifier[_array_length + NB_MAX];
					new_ts = new CPPParser::TypeSpecifier[_array_length + NB_MAX];
					new_names = new char*[_array_length + NB_MAX];
					new_qts = new char*[_array_length + NB_MAX];
					new_p = new int[_array_length + NB_MAX];
					new_a = new int[_array_length + NB_MAX];
					for(index = 0; index < _array_length; index += 1)
					{
						new_sc[index] = _storage_classes[index];
						new_tq[index] = _type_qualifiers[index];
						new_ts[index] = _type_specifiers[index];
						new_names[index] = _names[index];
						new_qts[index] = _qualified_types[index];
						new_p[index] = _pointers[index];
						new_a[index] = _arrays[index];
					}
					for(; index < _array_length + NB_MAX; index += 1)
					{
						new_p[index] = 0;
						new_a[index] = 0;
						new_names[index] = NULL;
						new_qts[index] = NULL;
					}

					// delete _storage_classes;
					// delete _type_qualifiers;
					// delete _type_specifiers;
					for(index = 0; index < _params; index += 1)
					{
						// delete _names[index];
						// delete _qualified_types[index];
					}
					// delete _names;
					// delete _qualified_types;
					// delete _pointers;
					// delete _arrays;

					_storage_classes = new_sc;
					_type_qualifiers = new_tq;
					_type_specifiers = new_ts;
					_names = new_names;
					_qualified_types = new_qts;
					_pointers = new_p;
					_arrays = new_a;
				}
			}
		void add_qualified_type(char *qt)
			{
				_qualified_types[_params] = _strdup(qt);
			}
		void SetAccessSpecifier(int access)
			{
				_access = access;
			}
		int AccessSpecifier()
			{
				return _access;
			}
		void set_pointer_to()
			{
				_pointers[_params - 1] = 1;
			}
		void set_array_to()
			{
				_arrays[_params - 1] = 1;
			}
		void set_argument_name(char *new_name)
			{
				_names[_params - 1] = _strdup(new_name);
			}

	public:		// Output
		void print_eiffel_arguments(FILE *out_file)
			{
				if(_params > 0)
				{
					int index;

					fprintf(out_file, " (");

					for(index = 0; index < _params; index += 1)
					{
						if(_names[index])
						{
							fprintf(out_file, "%s: ", _to_eiffel_name( _names[index] ));
							if ( strncmp( _names[index] , "operator", strlen("operator")  ) == 0)
								_comment_action_status |= COMMENT_VALID_NAME;
							if ( strstr(  _names[index] , "::" ) != NULL )	
								_comment_action_status |= COMMENT_VALID_NAME;

						}
						else
							fprintf(out_file, "arg%d: ", index);
						_print_eiffel_type(out_file,
									_storage_classes[index],
									_type_qualifiers[index],
									_type_specifiers[index],
									_pointers[index],
									_qualified_types[index]);
						if(index + 1 < _params)
							fprintf(out_file, "; ");
					}

					fprintf(out_file, ")");
				}
			}

		void PrintEiffelCommentAction(FILE *out_file)
			{

				if (_comment_action_status!=COMMENT_NONE)
				{
					fprintf(out_file, "\t\t\t-- PROGRAMMER ACTION%s SUGGESTED:\n%s%s%s",
					
					( (_comment_action_status != COMMENT_NONE) &&
					  (_comment_action_status != COMMENT_VALID_NAME) &&
					  (_comment_action_status != COMMENT_CLASH) &&
					  (_comment_action_status != COMMENT_CREATION) &&
					  (_comment_action_status != COMMENT_TYPE) 
					)?"S":"",

					((_comment_action_status & COMMENT_TYPE)==COMMENT_TYPE)?
						"\t\t\t-- \tReplace above type(s) by valid Eiffel type(s).\n":"",
					((_comment_action_status & COMMENT_VALID_NAME)==COMMENT_VALID_NAME)?
						"\t\t\t-- \tReplace above feature name(s) by valid Eiffel feature name(s).\n":"",
					((_comment_action_status & COMMENT_CLASH)==COMMENT_CLASH)?
						"\t\t\t-- \tOverloaded feature: remove name clash.\n":"",
					((_comment_action_status & COMMENT_CREATION)==COMMENT_CREATION)?
						"\t\t\t-- \tCheck class's actual creation procedures.\n":"" );

				}

				_comment_action_status = COMMENT_NONE;
			}

		void print_external_eiffel_arguments(FILE *out_file)
			{
				if(_params > 0)
				{
					int index;

					fprintf(out_file, " (");

					for(index = 0; index < _params; index += 1)
					{
						if(_names[index])
						{
							fprintf(out_file, "%s: ", _to_eiffel_name( _names[index] ));
							if ( strncmp( _names[index] , "operator", strlen("operator")  ) == 0)
								_comment_action_status |= COMMENT_VALID_NAME;
							if ( strstr(  _names[index] , "::" ) != NULL )	
								_comment_action_status |= COMMENT_VALID_NAME;

						}
						else
							fprintf(out_file, "arg%d: ", index);
						_print_before_runtime_type(out_file,
									_storage_classes[index],
									_type_qualifiers[index],
									_type_specifiers[index],
									_pointers[index],
									_qualified_types[index]);//###
						if(index + 1 < _params)
							fprintf(out_file, "; ");
					}

					fprintf(out_file, ")");
				}
			}
		void print_cpp_parameters(FILE *out_file)
			{
				if(_params > 0)
				{
					int index;

					fprintf(out_file, " (");

					for(index = 0; index < _params; index += 1)
					{
						if(_pointers[index] && (_type_specifiers[index] & tsCHAR || _qualified_types[index]))
							fprintf(out_file, "$any%d", index);
						else if(_names[index])
							fprintf(out_file, "%s", _to_eiffel_name(_names[index]));//###?
						else
							fprintf(out_file, "arg%d", index);
						if(index + 1 < _params)
							fprintf(out_file, ", ");
					}

					fprintf(out_file, ")");
				}
			}
		void print_external_signature(FILE *out_file)
			{
				if(_params > 0)
				{
					int index;

					fprintf(out_file, " (");

					for(index = 0; index < _params; index += 1)
					{
						_print_runtime_type(out_file,
									_storage_classes[index],
									_type_qualifiers[index],
									_type_specifiers[index],
									_pointers[index]);
						if(index + 1 < _params)
							fprintf(out_file, ", ");
					}

					fprintf(out_file, ")");
				}
			}
		int HasPointerArg()
			{
				int i;

				for(i = 0; i < _params; i += 1)
					if(_pointers[i] && (_type_specifiers[i] & tsCHAR || _qualified_types[i]))
						return 1;

				return 0;
			}
		void PrintLocalAny(FILE *out_file) 
			{
				int i, already_seen;

				already_seen = 0;

				for(i = 0; i < _params; i += 1)
				{
					if(_pointers[i] == 1 && (_type_specifiers[i] & tsCHAR || _qualified_types[i]))
					{
						if(i > 0 && already_seen == 1)
							fprintf(out_file, ",\n");
						fprintf(out_file, "\t\t\tany%d: ANY", i);
						already_seen = 1;
					}
				}
				fprintf(out_file, "\n");
			}
		void ConvertArguments(FILE *out_file)
			{
				int i, already_seen;

				already_seen = 0;

				for(i = 0; i < _params; i += 1)
					if(_pointers[i] && (_type_specifiers[i] & tsCHAR || _qualified_types[i]))
					{
						if(i > 0 && already_seen == 1)
							fprintf(out_file, ";\n");
						fprintf(out_file, "\t\t\t");
						if(_qualified_types[i])
							fprintf(out_file, "-- ");
						fprintf(out_file, "any%d := ", i);
						already_seen = 1;
						if(_names[i])
							fprintf(out_file, "%s.to_c", _to_eiffel_name( _names[i]));
						else
							fprintf(out_file, "arg%d.to_c", i);
					}
			}

	private:	// Attributes
		CPPParser::StorageClass *_storage_classes;
		CPPParser::TypeQualifier *_type_qualifiers;
		CPPParser::TypeSpecifier *_type_specifiers;
		char *_name;
		char **_names;
		char **_qualified_types;
		int _access;
		int _array_length;
		int _number;
		int _params;
		int *_pointers;
		int *_arrays;
		int _comment_action_status;

	private:	// Implementation

		void _print_eiffel_type(FILE *out_file, CPPParser::StorageClass,
					CPPParser::TypeQualifier, CPPParser::TypeSpecifier ts,
					int pointer, char *qt)
			{

				if(pointer == 1)
				{
					if(!qt)
					{
						if(ts & tsCHAR)
							fprintf(out_file, "STRING");
						else
							fprintf(out_file, "POINTER");
					}
					else
					if (strcmp( qt, _name)==0 )
						fprintf(out_file,": %s", _to_eiffel_type(qt));
					else
					{
						_comment_action_status |= COMMENT_TYPE;
						fprintf(out_file,"POINTER-ON-%s", qt);
					}

				}
				else if(ts & tsCHAR)
					fprintf(out_file, "CHARACTER");
				else if((ts & tsINT) || (ts == tsSHORT) || (ts == tsLONG) || (ts == tsUNSIGNED))
					fprintf(out_file, "INTEGER");
				else if(ts & tsDOUBLE)
					fprintf(out_file, "DOUBLE");
				else if(ts & tsFLOAT)
					fprintf(out_file, "REAL");
				else if(ts & tsBOOL)
					fprintf(out_file, "BOOLEAN");
// tsVOID .. impossible
				else
				{
					if(!qt)
					{
					fprintf(out_file, "XXX--UNRESOLVED_TYPE");
					_comment_action_status |= COMMENT_TYPE;
					}
					else
					if (strcmp(qt, _name)==0 )
						fprintf(out_file,"%s",_to_eiffel_type(qt));
					else
					{
						_comment_action_status |= COMMENT_TYPE;
						fprintf(out_file,"UNRESOLVED-TYPE-%s" ,qt);
					}

					//_comment_action_status |= COMMENT_TYPE;//###
					//fprintf(out_file, "XXX--UNRESOLVED_TYPE");
				}
			}
		void _print_runtime_type(FILE *out_file, CPPParser::StorageClass,
					CPPParser::TypeQualifier, CPPParser::TypeSpecifier ts,
					int pointer)
			{
				if(pointer == 1)
				{
						fprintf(out_file, "EIF_POINTER");
				}
				else if(ts & tsCHAR)
					fprintf(out_file, "EIF_CHARACTER");
				else if((ts & tsINT) || (ts == tsSHORT) || (ts == tsLONG) || (ts == tsUNSIGNED))
					fprintf(out_file, "EIF_INTEGER");
				else if(ts & tsDOUBLE)
					fprintf(out_file, "EIF_DOUBLE");
				else if(ts & tsFLOAT)
					fprintf(out_file, "EIF_REAL");
				else if(ts & tsBOOL)
					fprintf(out_file, "EIF_BOOLEAN");
				else
					fprintf(out_file, "EIF_POINTER");
			}

		void _print_before_runtime_type(FILE *out_file,
					CPPParser::StorageClass, CPPParser::TypeQualifier,
					CPPParser::TypeSpecifier ts, int pointer , char *qt)
			{
				if (pointer == 1)
				{
					if(!qt)
					{
						if(ts & tsCHAR)
							fprintf(out_file, "POINTER");
						else
							fprintf(out_file, "POINTER");
					}
					else
						if (strcmp( qt, _name)==0 )
							fprintf(out_file,"%s", _to_eiffel_type(qt));
						else
						{
							_comment_action_status |= COMMENT_TYPE;
							fprintf(out_file,"POINTER-ON-%s", qt);
						}
				}
				else if(ts & tsCHAR)
					fprintf(out_file, "CHARACTER");
				else if((ts & tsINT) || (ts == tsSHORT) || (ts == tsLONG) || (ts == tsUNSIGNED))
					fprintf(out_file, "INTEGER");
				else if(ts & tsDOUBLE)
					fprintf(out_file, "DOUBLE");
				else if(ts & tsFLOAT)
					fprintf(out_file, "REAL");
				else if(ts & tsBOOL)
					fprintf(out_file, "BOOLEAN");
				else if (ts & tsVOID)
					;
				else
				{
					if(!qt)
					{
					fprintf(out_file, "xxx--UNRESOLVED_TYPE");
					_comment_action_status |= COMMENT_TYPE;
					}
					else
					if (strcmp(qt, _name)==0 )
						fprintf(out_file,"%s",_to_eiffel_type(qt));
					else
					{
						_comment_action_status |= COMMENT_TYPE;
						fprintf(out_file,"UNRESOLVED-TYPE-%s" ,qt);
					}
				}
			}

		char* _strtol(char *s1)
			{
				char *arg = s1;

				while(*s1)
				{
					*s1 = tolower(*s1);
					s1++;
				}

				return arg;
			}

		
		char* _strdup(char *s1)
			{
				char *result;
				int i, len;

				len = strlen(s1);
				result = new char[len + 1];
				for(i = 0; i < len; i++)
					result[i] = s1[i];
				result[i] = '\0';

				return result;
			}

		// I added this function in order to print correct name for eiffel features.
		char* _to_eiffel_name(char * _name)
			{
				char *result;

				result = _strtol(_strdup(_name));
				if(result[0] == '_')
				{
					char *real_result;
					real_result = new char[11 + strlen(_name)];
					real_result[0] = '\0';
					real_result = strcat(real_result, "underscore");
					real_result = strcat(real_result, result);
					// delete result;
					result = real_result;
				}
				return result;
			}

		char* _to_eiffel_type(char * _name)
			{
				char *result;

				result = _strdup(_name);
				if(result[0] == '_')
				{
					char *real_result;
					real_result = new char[11 + strlen(_name)];
					real_result[0] = '\0';
					real_result = strcat(real_result, "underscore");
					real_result = strcat(real_result, result);
					// delete result;
					result = real_result;
				}
				return result;
			}


};

#endif // _Constructor_H

