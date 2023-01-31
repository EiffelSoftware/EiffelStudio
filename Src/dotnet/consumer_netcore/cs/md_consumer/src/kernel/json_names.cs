using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    static class JSON_NAMES
    {
        public const string is_dirty = "is_dirty" ;
        public const string assembly = "assembly" ;
        public const string assemblies = "assemblies" ;
        public const string types = "types" ;
        public const string referenced_assemblies = "referenced_assemblies" ;        
        public const string unique_id = "uid"; //"unique_id" ;
        public const string folder_name = "d"; //"folder_name" ;
        public const string name = "n"; //"name" ;
        public const string fullname = "fullname" ;
        public const string version = "v"; //"version" ;
        public const string culture = "c"; //"culture" ;
        public const string key = "k"; //"key" ;
        public const string public_key_token = "k"; //"key" ;
        public const string location = "loc" ; //"location" ;
        public const string gac_path = "gac"; //"gac_path" ;
        public const string is_consumed = "is_consumed" ;
        public const string is_in_gac = "is_in_gac" ;
        public const string has_info_only = "has_info_only" ;
        public const string has_return_value = "has_return_value" ;

        public const string eiffel_names = "eiffel_names" ;
        public const string dotnet_names = "dotnet_names" ;
        public const string flags = "flags" ;
        public const string positions = "positions" ;
        public const string count = "count" ;
        public const string namespaces = "namespaces" ;
        public const string eiffel_name = "en"; //"eiffel_name" ;
        public const string dotnet_name = "dn"; //"dotnet_name" ;
        public const string dotnet_eiffel_name = "den"; //"dotnet_eiffel_name" ;
        public const string parent = "par"; //"parent" ;
        public const string properties = "props"; //"properties" ;
        public const string interfaces = "int"; //"interfaces" ;
        public const string constructors = "cr"; //"constructors" ;
        public const string functions = "fcts"; //"functions" ;
        public const string procedures = "procs"; //"procedures" ;
        public const string arguments = "args"; //"arguments" ;
        public const string fields = "flds"; //"fields" ;
        public const string events = "evts"; //"events" ;
        public const string associated_reference_type = "art"; //"associated_reference_type" ;
        public const string enclosing_type = "enct"; //"enclosing_type" ;
        public const string getter = "get"; //"getter" ;
        public const string setter = "set"; //"setter" ;
        public const string value = "val"; //"value" ;
        public const string adder = "add"; //"adder" ;
        public const string remover = "rem"; //"remover" ;
        public const string raiser = "rai"; //"raiser" ;
        public const string assembly_id = "aid"; //"assembly_id" ;
        public const string type = "t"; //"type" 
        public const string element_type = "et"; //"element_type" ;
        public const string declared_type = "dt"; //"declared_type" ;
        public const string return_type = "rt"; //"return_type" ;
        public const string is_interface = "is_interface" ;
        public const string is_deferred = "is_deferred" ;
        public const string is_frozen = "is_frozen" ;
        public const string is_expanded = "is_expanded" ;
        public const string is_enum = "is_enum" ;
        public const string is_public = "is_public" ;
        public const string is_static = "is_static" ;
        public const string is_literal = "is_literal" ;
        public const string is_init_only = "is_init_only" ;
        public const string is_artificially_added = "is_artificially_added" ;
        public const string is_property_or_event = "is_property_or_event" ;
        public const string is_new_slot = "is_new_slot" ;
        public const string is_virtual = "is_virtual" ;
        public const string is_infix = "is_infix" ;
        public const string is_prefix = "is_prefix" ;
        public const string is_constructor = "is_constructor" ;
        public const string is_attribute_setter = "is_attribute_setter" ;
        public const string is_method = "is_method" ;
        public const string is_field = "is_field" ;
        public const string is_property = "is_property" ;
        public const string is_event = "is_event" ;
        public const string is_constant = "is_constant" ;
        public const string is_attribute = "is_attribute" ;

        public const string multiple_source = "multiple_source" ;

        public const string items = "items" ; // "items"
        public const string flag = "f" ; // "flag"
        public const string position = "p" ; // "position"
        

    }

}