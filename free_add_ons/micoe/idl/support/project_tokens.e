indexing

description: "Special tokens for IDL";
keywords: "tokens", "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PROJECT_TOKENS

feature

    Interface_token : INTEGER is 10
    Struct_token    : INTEGER is 11
    Union_token     : INTEGER is 12
    Typedef_token   : INTEGER is 13
    Module_token    : INTEGER is 14
    Sequence_token  : INTEGER is 15
    Array_token     : INTEGER is 16
    In_token        : INTEGER is 17
    Out_token       : INTEGER is 18
    Inout_token     : INTEGER is 19
    Int_token       : INTEGER is 20 -- All values from here to
    Boolean_token   : INTEGER is 21 -- Void_token _must_ be
    Char_token      : INTEGER is 22 -- consecutive!!!
    Double_token    : INTEGER is 23
    String_token    : INTEGER is 24
    Void_token      : INTEGER is 25
    Unsigned_token  : INTEGER is 26
    Fixed_token     : INTEGER is 27
    Const_token     : INTEGER is 28
    Any_token       : INTEGER is 29
    Object_token    : INTEGER is 30
    Enum_token      : INTEGER is 31
    Case_token      : INTEGER is 32
    Default_token   : INTEGER is 33
    Raises_token    : INTEGER is 34
    Context_token   : INTEGER is 36
    Oneway_token    : INTEGER is 36

    Left_paren    : INTEGER is 37
    Right_paren   : INTEGER is 38
    Left_brack    : INTEGER is 39
    Right_brack   : INTEGER is 40
    Left_brace    : INTEGER is 41
    Right_brace   : INTEGER is 42
    Left_angle    : INTEGER is 46
    Right_angle   : INTEGER is 47
    Comma         : INTEGER is 48
    Colon         : INTEGER is 49
    Equal_token   : INTEGER is 50
    Semicolon     : INTEGER is 51
    Slash         : INTEGER is 52                         
    Crosshatch    : INTEGER is 53
    
    Abstract_token    : INTEGER is 57
    Custom_token      : INTEGER is 58
    Factory_token     : INTEGER is 59
    Readonly_token    : INTEGER is 60
    Attribute_token   : INTEGER is 61
    Switch_token      : INTEGER is 62
    Include_token     : INTEGER is 63
    Private_token     : INTEGER is 64
    Public_token      : INTEGER is 65
    Supports_token    : INTEGER is 66
    Truncatable_token : INTEGER is 67
    Valuebase_token   : INTEGER is 68
    Valuetype_token   : INTEGER is 69

    

    Doublecolon       : INTEGER is 70
    Orop_token        : INTEGER is 71
    Andop_token       : INTEGER is 72
    Xorop_token       : INTEGER is 73
    Shright_token     : INTEGER is 74
    Shleft_token      : INTEGER is 75
    Plus_token        : INTEGER is 76
    Mult_token        : INTEGER is 77
    Div_token         : INTEGER is 78
    Mod_token         : INTEGER is 79
    Not_token         : INTEGER is 80
    Float_token       : INTEGER is 81
    Wchar_token       : INTEGER is 82
    Long_token        : INTEGER is 83
    Octet_token       : INTEGER is 84
    Short_token       : INTEGER is 85
    Wstring_token     : INTEGER is 86
    Exception_token   : INTEGER is 87
    Version_token     : INTEGER is 88


    Wide_character_literal : INTEGER is 89
    Wide_string_literal    : INTEGER is 90
    Native_token           : INTEGER is 91
    Pragma_token           : INTEGER is 92
    Dot_token              : INTEGER is 93

end -- class PROJECT_TOKENS

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
