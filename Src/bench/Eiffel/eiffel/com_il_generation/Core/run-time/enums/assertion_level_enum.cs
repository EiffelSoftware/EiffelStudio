/*
indexing
	description: "Enums that stores all possible values for assertion level."
	warning: "Values given here are the one from the ASSERTION_I class ck_* values."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace EiffelSoftware.Runtime.Enums
{

[FlagsAttribute]
[Serializable]
public enum ASSERTION_LEVEL_ENUM
{
	no = 0x0,
	check = 0x4,
	require = 0x1,
	ensure = 0x2,
	loop = 0x8,
	invariant = 0x10
}

} // class ASSERTION_LEVEL_ENUM
